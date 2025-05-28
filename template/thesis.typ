#import "../lib.typ": documentclass

#let (cover,) = documentclass(
  // anonymous: true,
  info: (
    author:"爱因斯坦",
    student-id: "11001101010086",
    department: "XX学院",
    major: "XX专业",
    class: "XX班",
    supervisor: ("张三", "教授"),
    submit-date: datetime.today(),
    // submit-date: datetime(year: 2025, month: 1, day: 28)
    )
)

#cover()