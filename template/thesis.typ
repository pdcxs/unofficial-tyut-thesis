#import "../lib.typ": documentclass

#let (doc, cover, decl, abstract, abstract-en, preface, outline-page) = documentclass(
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