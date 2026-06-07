import { readFileSync, writeFileSync, readdirSync, statSync } from 'fs';
import { join, extname, dirname, resolve } from 'path';
import { fileURLToPath } from 'url';

// 递归查找所有 .typ 文件（排除 node_modules 和 .git）
function findTypFiles(dir, fileList = []) {
    const entries = readdirSync(dir, { withFileTypes: true });
    for (const entry of entries) {
        const fullPath = join(dir, entry.name);
        if (entry.isDirectory()) {
            if (entry.name === 'node_modules' || entry.name === '.git') continue;
            findTypFiles(fullPath, fileList);
        } else if (entry.isFile() && extname(entry.name) === '.typ') {
            fileList.push(fullPath);
        }
    }
    return fileList;
}

// 正则匹配 @preview/包名:版本号
const IMPORT_REGEX = /@preview\/([a-zA-Z0-9_-]+):(\d+\.\d+\.\d+)/g;

async function getLatestVersion(packageName) {
    const url = `https://typst.app/universe/package/${packageName}`;
    try {
        const res = await fetch(url);
        if (!res.ok) {
            console.error(`Failed to fetch ${url}: ${res.status}`);
            return null;
        }
        const html = await res.text();
        const versionMatch = html.match(/<span class="version"[^>]*>([^<]+)<\/span>/);
        if (versionMatch) {
            return versionMatch[1].trim();
        }
        console.error(`Could not find version span on page for ${packageName}`);
        return null;
    } catch (err) {
        console.error(`Error fetching latest version for ${packageName}:`, err.message);
        return null;
    }
}

async function main() {
    // 扫描所有 .typ 文件
    const root = resolve('.');
    const files = findTypFiles(root);
    console.log(`Found ${files.length} .typ file(s)`);

    // 收集包名和当前版本
    const packages = new Map(); // 包名 → 当前版本
    const fileContents = new Map(); // 文件路径 → 内容

    for (const file of files) {
        const content = readFileSync(file, 'utf8');
        fileContents.set(file, content);
        let match;
        while ((match = IMPORT_REGEX.exec(content)) !== null) {
            const [, pkgName, currentVersion] = match;
            if (!packages.has(pkgName)) {
                packages.set(pkgName, currentVersion);
            }
        }
    }

    console.log('Packages found:', [...packages.keys()]);

    // 查询每个包的最新版本
    const latestVersions = new Map();
    for (const [pkgName] of packages) {
        const latest = await getLatestVersion(pkgName);
        if (latest) {
            latestVersions.set(pkgName, latest);
            console.log(`${pkgName}: ${packages.get(pkgName)} → ${latest}`);
        }
    }

    // 构建更新列表
    const updates = [];
    for (const [pkgName, latestVersion] of latestVersions) {
        const oldVersion = packages.get(pkgName);
        if (oldVersion !== latestVersion) {
            updates.push(`- ${pkgName}: \`${oldVersion}\` → \`${latestVersion}\``);
        }
    }

    // 如果有更新，替换文件并生成 PR 描述
    if (updates.length > 0) {
        for (const [file, content] of fileContents) {
            let newContent = content;
            for (const [pkgName, latestVersion] of latestVersions) {
                const oldVersion = packages.get(pkgName);
                if (oldVersion !== latestVersion) {
                    const escapedPkg = pkgName.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
                    const escapedOld = oldVersion.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
                    const regex = new RegExp(`(@preview/${escapedPkg}):${escapedOld}`, 'g');
                    newContent = newContent.replace(regex, `$1:${latestVersion}`);
                }
            }
            if (newContent !== content) {
                writeFileSync(file, newContent, 'utf8');
                console.log(`Updated ${file}`);
            }
        }

        const body = `自动更新以下 Typst 预览包：\n\n${updates.join('\n')}`;
        // 确保 .github 目录存在（如果被 .gitignore 忽略通常也存在，但保险起见）
        const ghDir = join(root, '.github');
        if (!statSync(ghDir, { throwIfNoEntry: false })) {
            writeFileSync(join(ghDir, 'update-body.md'), body, 'utf8');
        } else {
            writeFileSync(join(ghDir, 'update-body.md'), body, 'utf8');
        }
        console.log('Update list written to .github/update-body.md');
    } else {
        console.log('All packages are already up to date.');
    }
}

main().catch(err => {
    console.error(err);
    process.exit(1);
});