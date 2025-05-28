#import "pages/cover.typ": cover

#let documentclass(
  info: (:),
  anonymous: false,
) = {
  return (
    cover: (..args) => {
      cover(
        anonymous: anonymous,
        ..args, 
        info: info)
    },
  )
}
