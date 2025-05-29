#import "../lib.typ": documentclass

#let (
  doc,
  cover,
  decl,
  abstract,
  abstract-en,
  preface,
  outline-page,
  mainmatter,
  gloss,
  set-glossary-table) = documentclass(
  // anonymous: true, // 需要匿名可以打开此选项
  // twoside: true, // 打印纸质版时可以打开此选项
  info: (
    title: ("基于 Typst 的太原理工大学论文模板", "——非官方版本"),
    title-en: " A Typst Template for TYUT Thesis - Unofficial Edition",
    author: "爱因斯坦",
    student-id: "11001101010086",
    department: "XX学院",
    major: "XX专业",
    class: "XX班",
    supervisor: ("张三", "教授"),
    submit-date: datetime.today(),
    // submit-date: datetime(year: 2025, month: 1, day: 28)
    // author-sign-date: datetime.today(), // 承诺书作者签名日期
    // supervisor-sign-date: datetime(year: 1997, month: 1, day:1), // 承诺书导师签名日期
  ),
)

#show: doc

// #show: glossary.with((
//   (key: "urllc", short: "URLLC", long: "Ultra-Reliable and Low Latency Communications",
//   description: "超可靠低延迟通信"),
//   (key: "api", short: "API", long: "Application Program Interface", description: "应用程序接口"),
// ))

#cover()

// #decl(
//   author-signature: place(
//     dy: -1em,
//     dx: 1em,
//     image("imgs/author-signature.jpg", height: 2em)),
//   supervisor-signature: place(
//     dy: -1em,
//     dx: 1em,
//     image("imgs/author-signature.jpg", height: 2em)),
//     )
#decl()

#show: preface

#abstract(keywords: ("Typst", "TYUT", "Template", "Thesis", "毕业论文"))[
  本项目是基于 Typst 制作的一款适用于太原理工大学本科毕设论文的模板，注意是非官方模板，因此不被承认的风险，请谨慎使用。

  使用本项目需要具备基本的 Typst 使用知识，学习大概需要1小时，需要阅读#link("https://typst.app/docs/tutorial")[#text(fill: blue)[#underline[官方入门教程]]]。
]

#abstract-en(keywords: ("Typst", "TYUT", "Template", "Thesis"))[
  This project is based on Typst to produce a template for undergraduate BSc thesis of Taiyuan University of Technology, note that it is an unofficial template, so the risk of not being recognized, please use with caution.

  Using this project requires basic knowledge of using Typst, which takes about 1 hour to learn and requires reading #link("https://typst.app/docs/tutorial")[#text(fill: blue)[#underline[Official Getting Started Tutorial]]].
]

#outline-page()


#pagebreak()

#show: mainmatter

= 绪论
== 基本书写

直接输入文字即可。需要注意，如果两行之间没有空行，
像现在这样，会自动合并为一行。如果需要换行，
则需要多打一个空行。

像现在这样。

== 无序列表
可以通过以下方式添加无续列表：

- 表项1
- 表项2
  - 表项3
  - 表项4

== 有序列表

通过以下方式添加有续列表：

+ 表项1
+ 表项2
  + 表项3
  + 表项4
+ 表项5

== 术语

#set-glossary-table((
  (
    key: "urllc",
    short: "URLLC",
    long: "Ultra-Reliable and Low Latency Communications",
    description: "超可靠低延迟通信"
  ),
  (
    key: "api",
    short: "API",
    long: "Application Program Interface",
    description: "应用程序接口"
  ),
));

如果论文中出现缩写，推荐使用 `gloss` 进行管理，先将相关内容放入到 `set-glossary-table` 中，之后再使用，例如，第一次出现#gloss("urllc")时，会写出对应的中文内容、英文全称和缩写，之后再出现
#gloss("urllc")时，则只出现缩写。再举一个例子：#gloss("api")应当是全称，#gloss("api")和#gloss("api")应当只显示缩写。

如果引用了列表中没有出现的术语，则会出现红色警告，例如：#gloss("vanet")

= 数学公式与代码

== 数学公式示例

我们可以利用求根公式来得到一般形式的一元二次方程：$a x^2 + b x + c = 0$ 的解，其具体内容为（如果不希望公式后边段落有缩进，可以加入 `box`）：
#box[$ x_(1,2) = (-b plus.minus sqrt(b^2 - 4 a c)) / (2 a), $ <root-finder>]
其中，$a$，$b$和$c$为原始方程的系数。根据@eqt:root-finder, 可以看到，每个一元二次方程，都有两个解，不过有时候两个根可能相等，有时候可能会出现复数根。

根据相关公式，我们可以得到 $e^x$ 的泰勒展示：

$
  e^x= sum_(i=0)^oo x^i / i!.
$

如果某个公式不需要编号，可以加入 `<->` 标签。如：

$
  integral.cont sqrt(x^2+y^2) dif x dif y.
$ <->

但是后续公式会自动继续编号：

$
  e^(i pi) + 1 = 0.
$

更多数学公式内容，参考#text(fill:blue)[#underline[#link("https://typst.app/docs/reference/math/")[*官方文档*]]]。也可使用#text(fill:blue)[#underline[#link("https://typerino.com/")[*在线公式编辑器*]]]进行公式编辑。

== 代码

=== 原始效果

行内代码块需要包裹在反引号内，如 `http`，块级代码则需要以三个反引号包裹，后面加上语言名称（可选），如：

#figure(
```cpp
#include <vector>
#include <iostream>

using std::cout;
using std::endl;
using std::vector;

int main() {
  vector<int> v{10, 3};
  for (auto i : v) {
    cout << i << endl;
  }
  return 0;
}
```,
caption: [代码块展示]
) <cpp-code>

如果需要引用代码，需要加上`lst`，如这里引用了@lst:cpp-code。

== 添加行号

如果需要添加行号，推荐使用 `@preview/zebraw` 包

#import "@preview/zebraw:0.5.5": zebraw
#show: zebraw

#figure(
  ```haskell
  import Data.List (partition)

  qsort :: Ord a => [a] -> [a] -> [a]
  qsort [] = []
  qsort (x:xs) = qsort ls ++ [x] ++ qsort rs
   where
    (ls, rs) = partition (<x) xs
  ```,
  caption: [Haskell 代码中的快速排序]
)