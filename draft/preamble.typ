// --- 定理環境（ctheorems） ---
#import "@preview/ctheorems:1.1.3": *
#let thm = thmbox("theorem", "定理", base_level: 1, fill: rgb("#f8e8e8"))
#let defi = thmbox("theorem", "定義", base_level: 1, fill: rgb("#caf5ca"))
#let lem = thmbox("theorem", "補題", base_level: 1, fill: rgb("#f8e8e8"))
#let que = thmbox("theorem", "問", base_level: 1, fill: rgb("#f4f8e8"))
#let cor = thmbox("theorem", "系", base_level: 1, fill: rgb("#f8e8e8"))
#let prop = thmbox("theorem", "命題", base_level: 1, fill: rgb("#f8e8e8"))
#let dig = thmbox("theorem", "余談", base_level: 1, fill: rgb("#a6a6a6"))
#let state = thmbox("theorem", "主張", base_level: 1, fill: rgb("#e8e8f8"))
#let exm = thmbox("theorem", "例", base_level: 1, fill: rgb("#e8e8f8"))
#let rem = thmbox("theorem", "注意", base_level: 1, fill: rgb("#e8e8f8"))
#let proof = thmproof("proof", "証明", base_level: 1)
#let restate(lbl) = context {
  let el = query(lbl).at(0) // ラベルで要素を1つ取得
  thm(numbering: none)[
    #strong[@lbl.] #el.body
  ]
}
