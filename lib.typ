#import "pages/cover.typ": cover
#import "pages/decl.typ": decl

#let documentclass(
  info: (:),
  twoside: false,
  anonymous: false,
) = {
  return (
    cover: (..args) => {
      cover(
        anonymous: anonymous,
        ..args, 
        info: info)
    },
    decl: (..args) => decl(
      anonymous: anonymous,
      twoside: twoside,
      ..args,
      info: info,
    ),
  )
}
