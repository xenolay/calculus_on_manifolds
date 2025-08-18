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

- 定理環境を以下のように外部パッケージのコマンドを使って宣言していた
  - thmtools パッケージで宣言されている `\declaretheorem`  https://ctan.org/pkg/thmtools
  - amsthm パッケージで宣言されている `\newtheorem` https://ctan.org/pkg/amsthm

（他の人の LaTeX ソースコードをまじめに読んだことはないけど、定理環境の見た目をそれっぽくしたい人が外部パッケージを何の気なしにいれるというのは珍しくないようにも思う。昔の私とかまさにそれだったわけだし……）

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
- pandoc 側で区別をつけて変換できるようにするか
- pandoc を通したあとの `.typ` を温かみのある手作業で編集するか

のどちらかだが……さすがに後者をやるのは嫌なのでもう少し逃げ道を考える。

ちょい調べたところ、pandoc は input を AST に変換してその AST をもとに対象の言語へのアウトプットを吐くらしい。で、その AST に対して特定の規則で変換をかけることができる。この変換のことを filter というらしい。

[] Pandoc - Pandoc filters
https://pandoc.org/filters.html
```
A “filter” is a program that modifies the AST, between the reader and the writer.

INPUT --reader--> AST --filter--> AST --writer--> OUTPUT
```

ということは pandoc の AST について調べて filter をかけばよさそうな感じに見える。公式ドキュメント曰くは Lua filter と JSON filter の2つがあり、Lua filter がおすすめらしいので Lua filter を頑張って書いてみよう。

とはいえ自分が相手にしている AST の様子がまったくわからないと手を出しにくいので、小さなサイズでとりあえずナマの AST を出力させてみることにする。

```latex
\begin{dig}
ベクトルを細字で書いている理由はなんとなくシンプルでかっこよいのと， \LaTeX で書く量が減るからである．数学の風習に合わせているというタテマエをつけられなくもないが，あくまでタテマエの域を出ない．
\end{dig}
```

これを json format ならびに haskell native format で出力させてみた結果がこちら

```
{
  "t": "Div",
  "c": [
    ["", ["dig"], []],   // Attr: id="", classes=["dig"], attrs=[]
    [                    // 中身([Block])
      { "t": "Para",
        "c": [
          { "t": "Str", "c": "ベクトルを細字で書いている理由はなんとなくシンプルでかっこよいのと，" },
          { "t": "Space" },
          { "t": "Str", "c": "LaTeXで書く量が減るからである．数学の風習に合わせているというタテマエをつけられなくもないが，あくまでタテマエの域を出ない．" }
        ]
      }
    ]
  ]
}
```

```
Div
    ( "" , [ "dig" ] , [] )
    [ Para
        [ Str
            "\12505\12463\12488\12523\12434\32048\23383\12391\26360\12356\12390\12356\12427\29702\30001\12399\12394\12435\12392\12394\12367\12471\12531\12503\12523\12391\12363\12387\12371\12424\12356\12398\12392\65292"
        , Space
        , Str
            "LaTeX\12391\26360\12367\37327\12364\28187\12427\12363\12425\12391\12354\12427\65294\25968\23398\12398\39080\32722\12395\21512\12431\12379\12390\12356\12427\12392\12356\12358\12479\12486\12510\12456\12434\12388\12369\12425\12428\12394\12367\12418\12394\12356\12364\65292\12354\12367\12414\12391\12479\12486\12510\12456\12398\22495\12434\20986\12394\12356\65294"
        ]
    ]
```

よくわからないので更に調べてみた感じ、（Haskell で定義されている）Div というコンストラクタがあって、そいつの引数が Attr と Block のリストだということらしい。

[] Block | 
https://hackage.haskell.org/package/pandoc-types-1.23.1/docs/src/Text.Pandoc.Definition.html#Block
```hs
-- | Block element.
data Block
    -- | Plain text, not a paragraph
    = Plain [Inline]
    -- | Paragraph
    | Para [Inline]
    -- | Multiple non-breaking lines
    | LineBlock [[Inline]]
    -- | Code block (literal) with attributes
    | CodeBlock Attr Text
    -- | Raw block
    | RawBlock Format Text
    -- | Block quote (list of blocks)
    | BlockQuote [Block]
    -- | Ordered list (attributes and a list of items, each a list of
    -- blocks)
    | OrderedList ListAttributes [[Block]]
    -- | Bullet list (list of items, each a list of blocks)
    | BulletList [[Block]]
    -- | Definition list. Each list item is a pair consisting of a
    -- term (a list of inlines) and one or more definitions (each a
    -- list of blocks)
    | DefinitionList [([Inline],[[Block]])]
    -- | Header - level (integer) and text (inlines)
    | Header Int Attr [Inline]
    -- | Horizontal rule
    | HorizontalRule
    -- | Table, with attributes, caption, optional short caption,
    -- column alignments and widths (required), table head, table
    -- bodies, and table foot
    | Table Attr Caption [ColSpec] TableHead [TableBody] TableFoot
    -- | Figure, with attributes, caption, and content (list of blocks)
    | Figure Attr Caption [Block]
    -- | Generic block container with attributes
    | Div Attr [Block]
    deriving (Eq, Ord, Read, Show, Typeable, Data, Generic)
```

[] Attr | 
https://hackage.haskell.org/package/pandoc-types-1.23.1/docs/src/Text.Pandoc.Definition.html#Attr
```
-- | Attributes: identifier, classes, key-value pairs
type Attr = (Text, [Text], [(Text, Text)])
```

まあつまりは AST 上で Div というやつを見かけたらそいつの class を確認して、defi や lem などが入り込んでいたらそれに応じて内容を block ではない別の要素で包み直すということをすれば動きそうである。

実際に不明な定理環境を見かけたときに block に落とし込むかどうかは実装を見ればわかりそうだが、一旦はそこまではしない。

当然 Lua の書き方なんてよく知らないので ChatGPT 5 Thinking に Lua filter を書かせて少し手直ししたものがこちら。

```lua
-- thm2typst.lua
local map = {
  thm="thm",
  defi="defi",
  lem="lem",
  que="que",
  cor="cor",
  prop="prop",
  dig="dig",
  state="state",
  exm="exm",
  rem="rem"
}

local function env_of(classes)
  for _,c in ipairs(classes or {}) do
    if map[c] then return map[c], c end
  end
end

local function esc(s) return s and (s:gsub("\\","\\\\"):gsub('"','\\"')) or s end

-- try to strip "Theorem 1 (Title)." prefix that pandoc injects
local function peel_header(blocks)
  if #blocks == 0 or blocks[1].t ~= "Para" then return nil, blocks end
  local inls = blocks[1].content or blocks[1] -- pandoc 3.x
  if not inls or #inls == 0 then return nil, blocks end

  -- Heuristic: starts with Strong["Theorem"/"Lemma"/...]
  local headword = nil
  if inls[1] and inls[1].t == "Strong" then
    headword = pandoc.utils.stringify(inls[1])
  end
  if not headword then return nil, blocks end

  -- collect title between first (...) after headword; drop until first period after that
  local title, stage, new_inls = {}, "seek_open", {}
  for i=1,#inls do
    local el = inls[i]
    local txt = (el.t == "Str") and el.text or nil
    if stage == "seek_open" then
      if txt == "(" then stage = "in_title" end
    elseif stage == "in_title" then
      if txt == ")" then stage = "seek_period" else table.insert(title, el) end
    elseif stage == "seek_period" then
      if txt == "." then stage = "keep_rest" end
    else -- keep_rest
      table.insert(new_inls, el)
    end
  end
  local t = pandoc.utils.stringify(pandoc.Inlines(title))
  local rest = {}
  if #new_inls > 0 then table.insert(rest, pandoc.Para(new_inls)) end
  for i=2,#blocks do table.insert(rest, blocks[i]) end
  return (t ~= "" and t or nil), rest
end

function Div(el)
  local typ = env_of(el.classes)
  if not typ then return nil end

  local title, body = peel_header(el.content)
  local open
  if title then
    open = string.format('#%s("%s")[', typ, esc(title))
  else
    open = string.format('#%s[', typ)
  end

  local out = { pandoc.RawBlock("typst", open) }
  for _,b in ipairs(body) do table.insert(out, b) end
  table.insert(out, pandoc.RawBlock("typst", "]"))
  return out
end
```

`peel_header` が明らかに不要ないし不適切な処理をしているのが透けて見えるが、とりあえず最低限の動作をするかどうかはこの時点で見ておこう。

動作確認のために以下を `debug.tex` として保存して、

```tex
\newcommand{\Real}{\mathbb{R}}

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

動作確認。動いてそう。

```bash
$ pandoc -f latex -t typst -L thm2typst.lua debug.tex
#defi[
$bb(R)$の$n$つ組からなる集合のことを$bb(R)^n$と書き，$n$次元 Euclid
空間と呼ぶ．すなわち$bb(R)^n$は，$n$個の実数$x^1 \, x^2 \, dots.h \, x^n$を用いて$\( x^1 \, x^2 \, dots.h \, x^n \)$と書かれるようなもの全体のことである．
$bb(R)^n$には次のような仕方で加法とスカラー倍が定まる；
$ \( x^1 \, x^2 \, dots.h \, x^n \) + \( y^1 \, y^2 \, dots.h \, y^n \) & colon.eq \( x^1 + y^1 \, x^2 + y^2 \, dots.h \, x^n + y^n \)\
a dot.op \( x^1 \, x^2 \, dots.h \, x^n \) & colon.eq \( a x^1 \, a x^2 \, dots.h \, a x^n \) $ただし，$a in bb(R)$．

]
通常$bb(R)^n$の元は（行列の計算との都合上）$x^i$たちを縦に並べたものとすることが多い（すなわち$n times 1$行列と同一視することが多い）が，縦ベクトルは紙幅を取るし，かといって逐一転置$zws^top$を書くのも煩雑なので，文脈から分かる場合および縦横の差異が問題にならない場合は横に並べて書いた上で転置の記号を省略する．以下，$x in bb(R)^n$に対して，その第$i$成分を$x^i$と表すことにする．

#dig[
ベクトルを細字で書いている理由はなんとなくシンプルでかっこよいのと，
LaTeXで書く量が減るからである．数学の風習に合わせているというタテマエをつけられなくもないが，あくまでタテマエの域を出ない．

]
$
```
