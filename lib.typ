#import "pages/cover.typ": cover
#import "pages/decl.typ": decl
#import "pages/abstract.typ": abstract
#import "pages/abstract-en.typ": abstract-en
#import "layouts/doc.typ": doc
#import "layouts/preface.typ": preface
#import "pages/outline-page.typ": outline-page

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
  )
}
