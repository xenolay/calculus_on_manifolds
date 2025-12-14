#import "preamble.typ": * // なお import の代わりに include だと同じエラーで動かない
#show: thmrules
#let horizontalrule = line(start: (25%, 0%), end: (75%, 0%))

#show terms: it => {
  it
    .children
    .map(child => [
      #strong[#child.term]
      #block(inset: (left: 1.5em, top: -0.4em))[#child.description]
    ])
    .join()
}

#set table(
  inset: 6pt,
  stroke: none,
)

#show figure.where(
  kind: table,
): set figure.caption(position: top)

#show figure.where(
  kind: image,
): set figure.caption(position: bottom)

#let content-to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(content-to-string).join("")
  } else if content.has("body") {
    content-to-string(content.body)
  } else if content == [ ] {
    " "
  }
}
#let conf(
  title: none,
  subtitle: none,
  authors: (),
  keywords: (),
  date: none,
  abstract: none,
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: ((name: "New Computer Modern Math", covers: "latin-in-cjk"), "TakaoMincho"),
  fontsize: 11pt,
  sectionnumbering: "1.1.",
  pagenumbering: "1",
  doc,
) = {
  set document(
    title: title,
    author: authors.map(author => content-to-string(author.name)),
    keywords: keywords,
  )
  set page(
    paper: paper,
    margin: margin,
    numbering: pagenumbering,
    columns: cols,
  )
  set par(justify: true)
  set text(lang: lang, region: region, font: font, size: fontsize)
  set heading(numbering: sectionnumbering)

  place(top, float: true, scope: "parent", clearance: 4mm)[
    #if title != none {
      align(center)[#block(inset: 2em)[
        #text(weight: "bold", size: 1.5em)[#title]
        #(
          if subtitle != none {
            parbreak()
            text(weight: "bold", size: 1.25em)[#subtitle]
          }
        )
      ]]
    }

    #if authors != none and authors != [] {
      let count = authors.len()
      let ncols = calc.min(count, 3)
      grid(
        columns: (1fr,) * ncols,
        row-gutter: 1.5em,
        ..authors.map(author => align(center)[
          #author.name \
          #author.affiliation \
          #author.email
        ])
      )
    }

    #if date != none {
      align(center)[#block(inset: 1em)[
        #date
      ]]
    }

    #if abstract != none {
      block(inset: 2em)[
        #text(weight: "semibold")[Abstract] #h(1em) #abstract
      ]
    }
  ]

  doc
}
#show: doc => conf(
  title: [多変数の解析学],
  authors: (
    (
      name: [榎田洋介#footnote[このノートはあくまで私的な勉強会の成果物を公開するものなので，私の所属などについては記しません．もし何らかの事情でそれらの情報をお探しの場合は
          http:\/\/ehlfi.niflh.net をご覧ください．];],
      affiliation: "",
      email: "",
    ),
  ),
  pagenumbering: "1",
  cols: 1,
  doc,
)
