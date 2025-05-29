#import "pages/cover.typ": cover
#import "pages/decl.typ": decl
#import "pages/abstract.typ": abstract
#import "pages/abstract-en.typ": abstract-en
#import "layouts/doc.typ": doc
#import "layouts/preface.typ": preface
#import "pages/outline-page.typ": outline-page
#import "layouts/mainmatter.typ": mainmatter
#import "layouts/glossary.typ": gloss, set-glossary-table

#let documentclass(
  info: (:),
  twoside: false,
  anonymous: false,
) = {
  return (
    doc: (..args) => {
      doc(
        ..args,
        info: info + args.named().at("info", default: (:)),
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
      ..args,
    ),
    mainmatter: (..args) => mainmatter(
      twoside: twoside,
      ..args,
    ),
    gloss: gloss,
    set-glossary-table: set-glossary-table,
  )
}
