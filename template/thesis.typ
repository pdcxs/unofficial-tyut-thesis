#import "../lib.typ": documentclass

#let (cover, decl) = documentclass(
  // anonymous: true, // 需要匿名可以打开此选项
  // twoside: true, // 打印纸质版时可以打开此选项
  info: (
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
