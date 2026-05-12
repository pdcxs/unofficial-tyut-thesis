#import "pages/cover.typ": cover
#import "pages/decl.typ": decl
#import "pages/abstract.typ": abstract
#import "pages/abstract-en.typ": abstract-en
#import "layouts/doc.typ": doc
#import "layouts/preface.typ": preface
#import "pages/outline-page.typ": outline-page
#import "layouts/mainmatter.typ": mainmatter
#import "layouts/glossary.typ": gloss, make-glossary-table
#import "pages/acknowledgement.typ": acknowledgement
#import "layouts/appendix.typ": appendix
#import "@preview/gb7714-bilingual:0.2.3": gb7714-bibliography

#let documentclass(
  info: (:),
  twoside: false,
  anonymous: false,
  bib: "",
  font: "SimSun",
  reference-font: ("Times New Roman", "SimSun"),
) = {
  return (
    doc: (..args) => {
      doc(
        ..args,
        info: info + args.named().at("info", default: (:)),
        bib: bib,
      )
    },
    cover: (..args) => {
      cover(
        anonymous: anonymous,
        ..args,
        info: info,
      )
    },
    decl: (..args) => decl(
      anonymous: anonymous,
      twoside: twoside,
      ..args,
      info: info,
    ),
    abstract: (..args) => abstract(
      twoside: twoside,
      info: info,
      font: font,
      ..args,
    ),
    abstract-en: (..args) => abstract-en(
      twoside: twoside,
      info: info,
      ..args,
    ),
    preface: (..args) => preface(
      twoside: twoside,
      ..args,
    ),
    outline-page: (..args) => outline-page(
      twoside: twoside,
      font: font,
      ..args,
    ),
    mainmatter: (..args) => mainmatter(
      twoside: twoside,
      font: font,
      ..args,
    ),
    gloss: gloss,
    make-glossary-table: make-glossary-table,
    bilingual-bibliography: (..args) => {
      gb7714-bibliography(
        full-control: entries => {
          context {
            if entries.len() == 0 {
              return
            }

            let max-width = measure([[#{ entries.len() }]]).width

            let spacing = 0.5em
            let uniform-hanging = max-width + spacing

            for e in entries {
              // let num = [#e.order]
              // par(
              //   hanging-indent: uniform-hanging,
              //   first-line-indent: 0pt,
              // )[#h(max-width - measure([[#num]]).width)[#num]#h(spacing)#e.labeled-rendered]
              let num-content = [[#e.order]] // 带方括号
              let num-width = measure(num-content).width
              par(
                hanging-indent: uniform-hanging,
                first-line-indent: 0pt,
              )[
                #box(width: max-width)[#align(right)[#num-content]]#h(spacing)#e.labeled-rendered
              ]
              v(0.2em)
            }
          }
        },
        ..args,
      )
    },
    acknowledgement: (..args) => {
      acknowledgement(
        anonymous: anonymous,
        twoside: twoside,
        font: font,
        ..args,
      )
    },
    appendix: (..args) => {
      appendix(
        ..args,
      )
    },
    twoside: twoside,
  )
}
