# LaTeX から typst に移行したときのメモ

## 移行対象

https://github.com/xenolay/calculus_on_manifolds

- だいたい4000行くらいの `.tex` ファイル群
- ふつうの数学のノート

## 下準備

- typst のコードをある程度弄る必要があるので執筆環境はあったほうがいい。
  - typst cli がほしければ cargo install で一発
    - https://github.com/typst/typst?tab=readme-ov-file#installation にあるように `cargo install --locked typst-cli` すればいい
  - VSC の拡張機能 tinymist typst がある。
    - https://github.com/Myriad-Dreamin/tinymist
    - preview 機能があり、ホットリロードしてくれる。便利。
      - LaTeX にもホットリロードしてくれるような仕組みはなにかしらあるとは思う。私が LaTeX を使ってた頃は TeXShop とかいうメモ帳を使っていて、毎回手動でコンパイルしていたのでよくわかんないんですが……
    - 

## とりあえず `.typ` ファイルをコンパイルするところまで

- とりあえず pandoc を使って latex のコードを typst に無理くり変換する
  - pandoc は https://github.com/jgm/pandoc/blob/main/INSTALL.md にやりかたがのってる


```bash
# 変換下ごしらえ（叩き台用ディレクトリ）
mkdir -p draft
cd draft
# ルート＆分割ファイルを個別に .typ に変換（失敗しても続行）
pandoc -f latex -t typst -s Calculus_on_Manifolds.tex \
  --resource-path=. -o draft/main.typ
```

こうやってみたところ main.typ に4000行くらいの typ ファイルが生成された。

もともとの Calculus_on_Manifolds.tex は以下のような感じで section 単位で tex ファイルを分割していたのだが、どうも pandoc は include 文の内容をベタに展開して変換する様子。

```tex
\documentclass[uplatex,11pt,a4]{jsarticle}

\include{./preamble.tex}

\begin{document}
\title{多変数の解析学}
\author{}
\date{}
\maketitle

\newpage

\include{./preface.tex}

\include{./acknowledgement.tex}

\newpage

\tableofcontents

\newpage

\include{./section1.tex}

\newpage

\include{./section2.tex}

\newpage

\include{./section3.tex}

\newpage

\include{./section4.tex}

\newpage

\include{./section5.tex}

\newpage

\include{./section6.tex}

\end{document}
```

当然ながらそのままだとあちこちメチャクチャになっており、動かない。ので、LaTeX の section 単位で分割して移行する方針にする。

とりあえず、本文をすべてコメントアウトしてコンパイルが通ることを確認する。→できた。

## pandoc が変換してくれなかったと明示的に申告してきたもの

この時点で pandoc が出した警告も確認しておくと、以下のようなものがたくさんでていた。

```
  unexpected control sequence \set
  expecting "%", "\\label", "\\tag", "\\nonumber", whitespace or "\\allowbreak"
[WARNING] Could not convert TeX math \set{x}, rendering as TeX:
  \set{x}
      ^
```

記憶が正しければ私は braket パッケージで宣言されている `\set` コマンドを使って集合を書いていたはず。 https://www.ctan.org/pkg/braket
さすがに外部パッケージのコマンドまでいい感じに解決はしてくれないか。

## pandoc 任せで全部うまく行ったもの

逆に、自分が定義した preamble であればある程度は pandoc で勝手に解決してくれるように見える。私はあんまり凝ったことを preamble でやっていなかったので苦労せずに済んだのかも。

TeX 側で

```tex
\newcommand{\Real}{\mathbb{R}}
```

のように定義したうえで

```tex
特に，$M$として$\Real$の閉区間$[a,b]$，$\omega$として$[a,b]$上の0-形式（すなわち$C^\infty$級関数）$F$を取り，$F$の導関数を$f$と書くことにすれば，...
```

と書いていたものが、pandoc に通した段階で

```typ
特に，$M$として$bb(R)$の閉区間$\[ a \, b \]$，$omega$として$\[ a \, b \]$上の0-形式（すなわち$C^oo$級関数）$F$を取り，$F$の導関数を$f$と書くことにすれば，...
```

のように翻訳されていた。LaTeX の preamble で勝手に定義した `\Real` が typst の `$bb(R)` に変換されていることに注意。

## pandoc 任せだとちっともうまく行ってる様子がないもの

- 章の番号付けや定理番号
- フォント

がかなりうまく行ってない様子。

latex 
![image](./compare_style_latex.png)

typst
![image](./compare_style_typst.png)

とりあえず定理番号がちゃんとついてフォントがマトモになればそれっぽさが増すと思うのでそこを修復する。

### なんで定理番号がついてないのか

- 定理環境を thmtools パッケージで宣言されている `\declaretheorem` で宣言していた
https://ctan.org/pkg/thmtools

```tex
% preamble の記述
\usepackage{thmtools}

\newtheoremstyle{mythm}% name
{10pt}% Space above
{15pt}% Space below
{\normalfont}% Body font
{}% Indent amount
{\bfseries}% Theorem head font
{.}% Punctuation after theorem head
{5pt plus 1pt minus 1pt}% Space after theorem head
{}% Theorem head spec (can be left empty, meaning ‘normal’)

% thm：定理番号を振る．
% thm*：定理番号を振らない．declaretheorem を使わない．

\theoremstyle{mythm}
\declaretheorem[name=定理,numberwithin=section]{thm}
\declaretheorem[name=定義,numberlike=thm]{defi}
\declaretheorem[name=補題,numberlike=thm]{lem}
\declaretheorem[name=問,numberlike=thm]{que}
\declaretheorem[name=系,numberlike=thm]{cor}
\declaretheorem[name=命題,numberlike=thm]{prop}
\declaretheorem[name=余談,numberlike=thm]{dig}
\declaretheorem[name=主張,numberlike=thm]{state}
\declaretheorem[name=例,numberlike=thm]{exm}
\declaretheorem[name=注意,numberlike=thm]{rem}
\newtheorem*{thm*}{定理}
\newtheorem*{lem*}{補題}
\newtheorem*{defi*}{定義}
\newtheorem*{exm*}{例}
\newtheorem*{cor*}{系}
\newtheorem*{que*}{問}
\newtheorem*{state*}{主張}
\newtheorem*{prop*}{命題}
```

```tex
% 実際の記述
\begin{defi}
$\Real$の$n$つ組からなる集合のことを$\Real^n$と書き，$n$次元 Euclid 空間と呼ぶ．すなわち$\Real^n$は，$n$個の実数$x^1, x^2, \dots, x^n$を用いて$(x^1, x^2, \dots, x^n)$と書かれるようなもの全体のことである．
$\Real^n$には次のような仕方で加法とスカラー倍が定まる；
\begin{align}
(x^1, x^2, \dots, x^n)+(y^1, y^2, \dots, y^n) &\coloneqq (x^1 + y^1, x^2 + y^2, \dots, x^n + y^n) \\
a \cdot (x^1, x^2, \dots, x^n) &\coloneqq (ax^1, ax^2, \dots, ax^n) 
\end{align}ただし，$a \in \Real$．
\end{defi}

通常$\Real^n$の元は（行列の計算との都合上）$x^i$たちを縦に並べたものとすることが多い（すなわち$n \times 1$行列と同一視することが多い）が，縦ベクトルは紙幅を取るし，かといって逐一転置${}^\top$を書くのも煩雑なので，文脈から分かる場合および縦横の差異が問題にならない場合は横に並べて書いた上で転置の記号を省略する．以下，$x \in \Real^n$に対して，その第$i$成分を$x^i$と表すことにする．

\begin{dig}
ベクトルを細字で書いている理由はなんとなくシンプルでかっこよいのと， \LaTeX で書く量が減るからである．数学の風習に合わせているというタテマエをつけられなくもないが，あくまでタテマエの域を出ない．
\end{dig}
```

これが pandoc を通した結果、ぜんぶ block に書き換わっている。定理も定義も補題も全部 `#block` に潰れてしまっている。

```typ
#block[
  $bb(R)$の$n$つ組からなる集合のことを$bb(R)^n$と書き，$n$次元 Euclid
  空間と呼ぶ．すなわち$bb(R)^n$は，$n$個の実数$x^1 \, x^2 \, dots.h \, x^n$を用いて$\( x^1 \, x^2 \, dots.h \, x^n \)$と書かれるようなもの全体のことである．
  $bb(R)^n$には次のような仕方で加法とスカラー倍が定まる；
  $ \( x^1 \, x^2 \, dots.h \, x^n \) + \( y^1 \, y^2 \, dots.h \, y^n \) & colon.eq \( x^1 + y^1 \, x^2 + y^2 \, dots.h \, x^n + y^n \)\
  a dot.op \( x^1 \, x^2 \, dots.h \, x^n \) & colon.eq \( a x^1 \, a x^2 \, dots.h \, a x^n \) $ただし，$a in bb(R)$．

]
通常$bb(R)^n$の元は（行列の計算との都合上）$x^i$たちを縦に並べたものとすることが多い（すなわち$n times 1$行列と同一視することが多い）が，縦ベクトルは紙幅を取るし，かといって逐一転置$zws^top$を書くのも煩雑なので，文脈から分かる場合および縦横の差異が問題にならない場合は横に並べて書いた上で転置の記号を省略する．以下，$x in bb(R)^n$に対して，その第$i$成分を$x^i$と表すことにする．

#block[
  ベクトルを細字で書いている理由はなんとなくシンプルでかっこよいのと，
  LaTeXで書く量が減るからである．数学の風習に合わせているというタテマエをつけられなくもないが，あくまでタテマエの域を出ない．

]
```

ということは、
- pandoc 側で区別をつけて変換できるように `.tex` を編集するか
- pandoc を通したあとの `.typ` を温かみのある手作業で編集するか

のどちらかだが……さすがに後者をやるのは嫌なのでもう少し逃げ道を考える。
