#import "preamble.typ": * // なお import の代わりに include だと同じエラーで動かない。
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
  font: (),
  fontsize: 11pt,
  sectionnumbering: none,
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


#heading(level: 1, numbering: none)[まえがき]
<まえがき>
これは Michael Spivak "Calculus on Manifolds: A Modern Approach to
Classical Theorems of Advanced Calculus" (CRC Press, 1971)
および齋藤正彦による訳書「スピヴァック
多変数の解析学―古典理論への現代的アプローチ」（東京図書,
2007）に沿って，多変数解析学の勉強会をしたときのノートである．大筋としては
Spivak
に沿った進行をしているが，詳細は異なる．記法や用語といった細かな点については勿論のこと，証明も私個人の嗜好を優先して書いたものが多い．特に積分は測度論に基づいており，加藤賢悟「測度論的確率論　講義ノート　2016年版」を参考にしている．

より具体的には，多変数関数の微積分の定義からはじめて，つぎの形の Stokes
の定理およびその周辺の話題までをカバーすることを最終的な目標にしている．

#block[
  #strong[定理 1];.
  #emph[$M$を向きづけられた$k$次元境界つきコンパクト微分可能多様体，$omega$を$M$上定義された微分$k - 1$-形式とするとき，
    $ integral_M d omega = integral_(partial M) omega $がなりたつ．ただし，$partial M$には$M$から誘導される向きを入れるものとする．特に，$M$として$bb(R)$の閉区間$\[ a \, b \]$，$omega$として$\[ a \, b \]$上の0-形式（すなわち$C^oo$級関数）$F$を取り，$F$の導関数を$f$と書くことにすれば，
    $ integral_a^b f \( x \) med d x = F \( b \) - F \( a \) $がなりたつ．]

]
定理の後半のステートメントは「微積分学の基本定理」と呼ばれているものにほかならない．いわゆる現代幾何学の入り口が，実際には初等的な解析で学ぶ概念と地続きになっていることをきちんと理解したいというのがこのノートを書くに至った動機のひとつである．

ノートの論理を追う上で最低限必要な前提知識として，集合と写像の記号に関する初歩的な取り扱い，一変数実関数の微分積分，および行列と行列式の計算（対角化の計算あたりまで）ができることは仮定している（ので，説明なしで用いる）．が，実際のところはもう少しいろいろ知っていたほうが読みやすいだろう．具体的には，（$bb(R)^n$とは限らない）線型空間や線型写像に関する概念，ならびに古典的なベクトル解析をある程度見慣れていることを期待している箇所がある．何をもって「見慣れている」とするかは難しいが，線型写像の定義を知っていたり，「基底を選ぶことで線型写像を行列で表示できる」ことを知っていたり，
Gaußの発散定理を知っていたり，極座標 Laplacian
の計算をしたことがあれば（この全部を知らなくても，一部を知っていれば）充分ではないかと思っている．また，具体的な計算例についてはこのノートではあまり紹介していないが，それは具体的な計算を軽んじているからではなく，単に勉強会の進行の都合，言い換えると具体的な式変形をひたすらするだけの説明を勉強会の中でしないという方針を立てたが故である．勉強会が一通り終わったタイミングで時間があれば，具体的な計算例を足すことはやってもよい（というか，やったほうがよいし，やりたい）と思っている．

本文の議論とは関係ないかもしれないが，コメントしておくに値すると思った事柄を「余談」として設けてある．また，本文中のそこかしこに「問」が載っているが，読者に対して解くことを要求しているというよりは，私が証明や説明を省いた事柄がすべて「問」扱いされている，というほうが正確であろう．なお，省いた理由はだいたいが「私が書くのをめんどくさがった」ないしは「私が答えを知らない，知りたい」のどちらかである．それゆえ，「〜を示せ」という書き方はしていない．そのような立ち位置の「問」ではあるが，解いてもらっても構わないし，いい感じに解けたと思ったらぜひ教えてほしい．また，「問」に
Spivak
の章末問題を引用することはできるだけ避けてあり，私の手元で解けた問題についてはその解答を定理・命題などの形で本文に書くようにした#footnote[のだが，どれが
  Spivak
  の章末問題を解いた結果の命題だったか，ちゃんと記録するのを怠ってしまい，書いた私自身もわからなくなっている．気が向いたら対応付けを調べて明記します．];．

時に，このノートの趣旨から大幅に逸脱した「問」が掲載されていることがある．そのような「問」は星印
(\*) を付した．逸脱度合いがひどいものは二つ星 (\*\*)
にした．これらは私が気になっている（が，ちゃんと勉強したことのない）事柄である．これらの「問」はつっこみが入らない限り勉強会で扱うことは稀であり，読み飛ばしても本文を読む上では問題ないようにしてある（はずである）．特に，私が解答のあらすじを知っているとは限らないこと，本ノートにおける前提知識などを全く踏まえていないことを注意してほしい．これらの「問」に解答をつけるつもりもとりあえずはないが，どこかで勉強したいと思っていることは事実である．

#heading(level: 1, numbering: none)[謝辞]
<謝辞>
このノートは私が主催した勉強会を経て作られた（作られている）ノートである．勉強会の参加者である千葉直也氏，濱田将樹氏，今井雄毅氏，金子亮也氏，三井譲氏，森下真幸氏#footnote[氏名掲載の同意を頂いた方について，名字のアルファベット順に氏名を掲載しています．];からは，大小様々な質問を多数頂き，私の説明の不十分なところを補い，また話題を広げてくださった．勉強会の中で出た質問などに対する回答や議論のいくつかはこのノートに取り込まれた#footnote[取り込むのを後回しにしていることがらも多々あるが，それらもいずれは取り込みたいと思っています．ほんとだよ．];．また，このノートは
GitHub Pages
で公開されているが，その実装は永山涼雅氏による．厚く感謝申し上げる．なお，本文中に存在する誤りや不適切な記述の全ては，筆者である私の責に帰する．

10pt 15pt #strong[] . 5pt plus 1pt minus 1pt

= 準備
<準備>
多変数解析学を本格的に議論するにあたって必要な概念たちを手短に扱う．

== $bb(R)^n$の線型空間としての構造
<mathbbrnの線型空間としての構造>
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
#dig[
  ここで添え字を「上付き」にしていることには後々の議論を踏まえた意味がある．この時点で説明することもできるが，多変数の微積分の範囲に限れば説明の必要はないので，必要になってからやろうと思う．言葉だけだしておくことにすると，「座標変換に対して共変・反変のいずれに振る舞うかを意識して添字の上下を取り替えている」．ちなみにべき乗と記号が衝突しているが，そういうものである．混乱の可能性がある場合は都度注意するつもりである．

]
$bb(R)^n$には次の仕方で内積と呼ばれる概念が定まっている；

#defi[
  $x \, y in bb(R)^n$に対し，
  $ angle.l x \, y angle.r colon.eq sum_(i = 1)^n x^i y^i $を対応させる写像$angle.l dot.op \, dot.op angle.r : bb(R)^n times bb(R)^n arrow.r bb(R)$を$bb(R)^n$の標準内積と呼ぶ．$parallel x parallel colon.eq sqrt(angle.l x \, x angle.r)$を$x$のノルムと呼ぶ．

]
#dig[
  わざわざ「標準」内積という呼び方をすることからわかるように，単に「内積」と呼んだ場合は「標準でない」ものも含めたもう少し広いクラスの概念を指すことも多い．しかし，当面このノートでは標準内積以外の内積が登場しないので，誤解の恐れがない場合は標準内積のことを単に内積と呼ぶ．

  多様体上の Riemann
  計量について議論し始めると標準とは限らない内積がそこかしこに登場することになる．予定は未定だが，このあたりの話を書くことにした場合はその時に詳述しようと思う．

]
行列と行列式の計算ができることだけを前提に据えていることになっているので，線型空間・線型写像の定義もきちんと述べておくことにする．

#defi[
  集合$V$が（実）線型空間であるとは，$V$にふたつの写像

  - 加法 $V times V in.rev \( x \, y \) mapsto x + y in V$

  - スカラー倍$bb(R) times V in.rev \( a \, x \) mapsto a x in V$

  が定まっていて，以下の条件を充たすことをいう．

  + 任意の$x \, y \, z in V$に対して$\( x + y \) + z = x + \( y + z \)$

  + 零ベクトルと呼ばれる特別な元$0_V in V$があり，それは任意の$x in V$に対して$x + 0_V = x$を充たす．

  + 任意の$x in V$に対して，$- x$という元があり，それは$x + \( - x \) = 0_V$を充たす．

  + 任意の$x \, y in V$に対して$x + y = y + x$．

  + 任意の$x \, y in V$および$a in bb(R)$に対して$a \( x + y \) = a x + a y$．

  + 任意の$x in V$および$a \, b in bb(R)$に対して$\( a + b \) x = a x + b x$．

  + 任意の$x in V$および$a \, b in bb(R)$に対して$a \( b x \) = \( a b \) x$．

  + 任意の$x in V$に対して$1 x = x$．

]
$bb(R)^n$は線型空間の例である．実際には他にもいろいろなものが線型空間を成すが，このノートの主題から外れる例が多くなってしまうので，問にしておく；

#que[
  漸化式$a_(n + 2) = 3 a_(n + 1) - a_n$を充たす数列の集合は線型空間をなす．

]
#defi[
  $V \, W$を線型空間とする．$T : V arrow.r W$が線型写像であるとは，

  - 任意の$x \, y in V$に対して$T \( x + y \) = T \( x \) + T \( y \)$

  - 任意の$x in V$および$a in bb(R)$に対して$T \( a x \) = a T \( x \)$

  が成り立つことをいう．$T$が全単射のとき，$T$は線型同型写像と言われる．

]
#que[
  $A$を$m times n$行列とする時，$A$倍写像$bb(R)^n in.rev x mapsto A x in bb(R)^m$は線型写像である．逆に$T : bb(R)^n arrow.r bb(R)^m$を線型写像とすると，ある行列$A$が存在して$T \( x \) = A x$が成り立つ．

]
<線型写像と行列の対応>
#defi[
  $V$を線型空間とする．有限集合\$S = \\set{v\_1, \\dots, v\_n}\$が$V$の基底であるとは，

  - $a^1 \, a^2 \, dots.h \, a^n in bb(R)$に対して$sum_i a^i v_i = 0$ならば$a^1 = a^2 = dots.h = a^n = 0$

  - 任意の$v in V$に対して，適当な$b^1 \, b^2 \, dots.h \, b^n in bb(R)$が存在して$v = sum_i b^i v_i$

  が成り立つことをいう．

]
#dig[
  無限次元線型空間はこのノートの主題ではないので，最初から基底は有限集合だとしてしまっている．なので厳密な読み方をすればこのノート上では「無限次元線型空間は基底を持たない」ことになってしまう（が，もちろん実際にはそんなことはなく，Zorn
  の補題によって任意の線型空間は基底を持つ）．

]
#que[
  $S$および$T$を$V$の基底とするとき，$S$と$T$の濃度は等しい．この濃度のことを次元といい，$dim V$で表す．

]
#que[
  $e_i in bb(R)^n$を，第$i$成分が1，それ以外が0という元とすると，\$\\set{e\_1, \\dots, e\_n}\$は$bb(R)^n$の基底になる．これを$bb(R)^n$の標準基底という．

]
#prop[
  $V \, W$を線型空間とし，\$\\set{v\_1, \\dots, v\_n}\$を$V$の基底とする．$T : V arrow.r W$を線型写像とするとき，$T$は基底での値$T \( v_1 \) \, dots.h \, T \( v_n \)$で特徴づけられる．すなわち，$w_1 \, dots.h \, w_n in W$とする時，$T \( v_i \) = w_i$（$1 lt.eq i lt.eq n$）を充たす線型写像はひとつしかない．

]
#proof[
  任意の$v in V$は\$\\set{v\_1, \\dots, v\_n}\$を用いて$v = sum a^i v_i$とただ一通りに表せる．したがって$T \( v \) = T \( sum a^i v_i \) = sum a_i T \( v_i \) = sum a^i w_i$となる．#footnote[本当はこの証明は少しいい加減ではあると思う．「$T_1$および$T_2$を，命題にあるような条件を充たす線型写像とする．すると写像として$T_1 = T_2$である」のようにやるほうが議論によどみがないと感じる．]

]
#defi[
  $T : bb(R)^m arrow.r bb(R)^n$を線型写像とする．このとき，前命題より$T$は$bb(R)^m$の標準基底での値で特徴づけられる．$T \( e_i \)$は$bb(R)^n$の元なので，これを$bb(R)^n$の標準基底で展開することができる．すなわち$m n$個の実数\$\\set{a\_i^j}\$があって，
  $ T \( e_i \) = sum a_i^j e_j $
  と表せる．$\( j \, i \)$成分に$a_i^j$を並べて得られる行列$(a_i^j)$のことを，$T$の標準基底に関する行列表示と呼ぶ．

]
なお，特に断りがない場合，このノートでは上記の定義のように行列の$\( i \, j \)$成分（$i$行$j$列成分）のことを$a_j^i$と書く．

#dig[
  $a_(i j)$と書かずに$a_j^i$と書いていることにももちろん意味があるが，ベクトルの場合と同様の理由により，この節では説明しない．

]
#que[
  上記の定義は標準基底の性質を使っていないので，より一般化して「一般の基底に関する行列表示」を定義できる．

]
#que[
  「$\( j \, i \)$成分に$(a_i^j)$を並べて」いる理由は，$A$倍写像$bb(R)^n in.rev x mapsto A x in bb(R)^m$の標準基底に関する行列表示が$A$になるようにするためであるので，実際にそうなっている．言い換えると，線型写像$T : bb(R)^m arrow.r bb(R)^n$の行列表示を$A$とするとき，$A$の第$i$列は$T \( e_i \)$に等しい．

]
最後に，線型写像の連続性・有界性について述べておく．

#lem[
  $T : bb(R)^m arrow.r bb(R)^n$を線型写像とする．このとき，ある実数$M$があって，任意の$h in V$に対して$parallel T \( h \) parallel lt.eq M parallel h parallel$が成り立つ．

]
<線型写像の連続性>
#proof[
  問 @線型写像と行列の対応
  の結果より，ある行列$A = (a_j^i)$があって$T \( h \) = A h$であるとしてよい．$M colon.eq max {lr(|a_j^i|)}$とすればよい．

]
#que[
  上掲の問は，
  $ sup_(h eq.not 0) frac(parallel T \( h \) parallel, parallel h parallel) lt.eq M $
  ということを述べている．この左辺に現れた量は$T$の作用素ノルムと呼ばれる．作用素ノルムは
  Euclid
  空間上の線型写像のみならず，（無限次元かもしれない）ノルム空間の線型作用素に対しても定式化される．

]
== $bb(R)^n$の位相とコンパクト性
<mathbbrnの位相とコンパクト性>
$bb(R)$の閉区間
\$\$\[a,b\] \\coloneqq \\set{x \\in \\mathbb{R}| a \\leq x \\leq b}\$\$ならびに開区間
\$\$(a,b) \\coloneqq \\set{x \\in \\mathbb{R}| a \< x \< b}\$\$
は容易に高次元に拡張できる．

#defi[
  $bb(R)^n$の閉方体とは，
  \$\$\[a^1,b^1\] \\times \[a^2, b^2\] \\times \\dots \\times \[a^n, b^n\] \\coloneqq \\set{(x^1, x^2, \\dots, x^n) \\in \\mathbb{R}^n | a^i \\leq x^i \\leq b^i }\$\$なる形の集合のこととする．同様に，$bb(R)^n$の開方体とは
  \$\$(a^1,b^1) \\times (a^2, b^2) \\times \\dots \\times (a^n, b^n) \\coloneqq \\set{(x^1, x^2, \\dots, x^n) \\in \\mathbb{R}^n | a^i \< x^i \< b^i }\$\$なる形の集合のこととする．

]
この定義を使って，より一般に$bb(R)^n$の開集合・閉集合という概念が定義できる；

#defi[
  $U$を$bb(R)^n$の部分集合とする．$U$の各点$x$に対し，$x$を含む開方体$O$であって，$O subset U$を充たすようなものが存在するとき，$U$は$bb(R)^n$の開集合である，あるいは$U$は$bb(R)^n$において開である，という．

]
#defi[
  $U$を$bb(R)^n$の部分集合とする．$U$の補集合$bb(R)^n \\ U$が$bb(R)^n$において開であるとき，$U$は$bb(R)^n$の閉集合である，あるいは$U$は$bb(R)^n$において閉である，という．

]
定義より直ちに分かる以下の性質は，しかしながら極めて重要である．

#thm[
  $U \, V$を$bb(R)^n$の開集合とする．$U sect V$は$bb(R)^n$の開集合である．

]
#proof[
  $x in U sect V$を任意にひとつ取る．$U$は開集合なので，$x in O_U subset U$を充たすような開方体$O_U$がある．$V$も開集合なので，$x in O_V subset V$を充たすような開方体$O_V$がある．したがって$O_U sect O_V$が開方体であることが証明できればよい．$n = 1$のときは場合分けをすればあきらかである#footnote[訳：きちんと書くのがめんどくさい];し，$n gt.eq 2$の場合は各成分ごとに$n = 1$の場合の議論が適用できることから従う．

]
#thm[
  $U$を$bb(R)^n$の開集合とする．$U$は開方体の和集合の形に表せる．

]
#proof[
  開集合の定義より，$U$の各点$x$に対して$x in O_x$を充たすような開方体$O_x subset U$が存在する．$U = union.big_(x in U) O_x$である．

]
#que[
  $bb(R)^n$は$bb(R)^n$において開である．

]
#dig[
  上記3性質は開集合の充たしている性質として「証明」された．しかしながら，この事実を逆手に取り，「上記3条件を充たすような集合の族のことを開集合系と呼び，開集合系が与えられた集合を一般的に考えてどこまで性質が復元できるか考えよう」というやりかたがあり得る．そのような「開集合系が与えられた集合」のことを位相空間と呼ぶ．以下で述べる命題の多くは位相空間でそのまま成り立つのだが，そのようなものはできるだけ「位相空間における命題・証明」としても読めるように書くよう努力したかったので，Spivak
  とは大きく流れを変えて上記の3点を直ちに述べておく構成をとり，証明も
  Spivak のそれとは大きく変えてあるものがある．

]
以下，開集合や閉集合の例をいくつか挙げる．

#que[
  閉方体は閉集合である．これは頑張ればこのタイミングでも証明できそう．

]
#que[
  $bb(R)^n$の部分集合が有限ならばそれは閉集合である．ここで証明できないことはないがめんどくさい．後でやる
  Heine-Borel の定理（の逆）を使うのが一番早いと思う．

]
#que[
  $x in bb(R)^n$，$r in bb(R)$に対し，\$B(x;r) \\coloneqq \\set{y \\in \\mathbb{R}^n | \\|x-y\\| \< r}\$と置いて，$x$を中心とする半径$r$の開球という．開球は開集合であるが，これを示すのはこのタイミングでは相当めんどくさい．関数の連続性を開集合の言葉で言い換える方法を学んだあとの方が圧倒的に早く示せると思う．

]
閉集合の定義は「開集合でないこと」ではない．したがって論理的には「開かつ閉」な集合が存在し得ることになるし，実際存在する．

#que[
  例えば$nothing$や$bb(R)^n$は$bb(R)^n$において開かつ閉である．

]
#dig[
  「開かつ閉」を示す英単語は "clopen" である．

]
コンパクト性の定義に入る．

#defi[
  $A subset bb(R)^n$を部分集合とする．$bb(R)^n$の部分集合の族\$\\mathscr{O} \\coloneqq \\set{U\_\\lambda}\_{\\lambda \\in \\Lambda}\$が$A$を被覆する，あるいは$A$の被覆であるとは，$A subset union.big_(lambda in Lambda) U_lambda$となることをいう．特に$cal(O)$の元がすべて開集合のとき，$cal(O)$は$A$の開被覆であるという．

]
#defi[
  $A subset bb(R)^n$を部分集合とする．$A$がコンパクトであるとは，任意の$A$の開被覆\$\\set{U\_\\lambda}\_{\\lambda \\in \\Lambda}\$に対し，そこから適切な有限個$U_1 \, U_2 \, dots.h \, U_n$を選ぶことで$A$の被覆にできることをいう．

]
#que[
  上記の定義で「任意の」がついていることは重要である．上記の定義を「#strong[ある];$A$の開被覆\$\\set{U\_\\lambda}\_{\\lambda \\in \\Lambda}\$に対し，〜」とした場合，全く意味のない定義になる．

]
#que[
  $\( 0 \, 1 \) subset bb(R)$はコンパクトではない．

]
「コンパクト」という概念は初見だとかなりとっつきづらいのだが，$bb(R)^n$の場合に限って言えば有界閉集合と同値である．このことを順を追って証明していくが，実数$bb(R)$の性質を本質的に使うのはつぎの
Heine-Borel の定理のみである．

#que[
  ということは，以下の議論の大部分は実数$bb(R)$に限らない一般の位相空間に対して拡張できるから，どこまで拡張できるか考えると勉強になるし，位相空間を一通り学んでからこれらの定理群の証明を考えるのも勉強になると思う．私にとっては勉強になった．

]
#thm[
  $bb(R)$の有界閉区間$\[ a \, b \]$はコンパクトである．

]
#proof[
  $\[ a \, b \]$の開被覆$cal(O)$を任意にひとつとって固定し，$A = A_(cal(O)) subset \[ a \, b \]$を，$\[ a \, x \]$が$cal(O)$の有限個の元で覆えるような点$x$の集合とする．あきらかに$a in A$であるので空ではなく，かつ$A$は上に有界である（ひとつの上界として$b$が取れる）．したがって実数の完備性より$sup A$が存在するから，これを$alpha$と置く．$alpha in A$かつ$alpha = b$を示せば良い．

  - $alpha in A$を示す．$alpha in \[ a \, b \]$なので，$cal(O)$の元$U$であって$alpha in U$であるようなものが存在する．このとき，$y lt.eq alpha$なる数$y$であって$y in A$かつ$y in U$なるものがある#footnote[$U$は開集合なので，ある$epsilon > 0$が存在して，$\( alpha - epsilon \, alpha \) subset U$．この開区間の中に$A$の元がなかったとすると$alpha = sup A lt.eq alpha - epsilon$となって$sup A$の定め方に反する．したがってこの開区間の中に$A$の元がひとつ以上あることがわかるから，そのようなものを任意にひとつ取って$y$とすればよい．この議論では$bb(R)$の（完備性ではなく）稠密性を使っている．];．$A$の定め方より$\[ a \, y \]$は有限個の$cal(O)$の元で覆うことができる．更に$\[ y \, alpha \]$は$U$だけで覆えるから，特に有限個の$cal(O)$の元で覆うことができる．したがって$\[ a \, alpha \]$は有限個の$cal(O)$の元で覆うことができるので，$alpha in A$である．

  - $alpha = b$を示すべく，$alpha < b$を仮定する．$\[ a \, alpha \]$は有限個の$cal(O)$の元たちで覆うことができる．更に$alpha in U$となるような開集合$U$をひとつ取ると，充分小さい$epsilon > 0$に対して$\[ alpha \, alpha + epsilon \] subset U$が成り立つ．したがって$\[ a \, alpha + epsilon \]$が有限個の$cal(O)$の元で覆えることになるが，これは$alpha$の定め方に反する．

]
この定理を高次元に拡張していくことにする．

#lem[
  $B subset bb(R)^n$がコンパクトであるとする．$x in bb(R)^m$に対し，\$\\set{x} \\times B \\subset \\mathbb{R}^{m+n}\$はコンパクトである．

]
#proof[
  まず\$\\set{x} \\times B \\subset \\mathbb{R}^{m+n}\$の開被覆は開方体のみからなっているとして一般性を失わないのでそうする#footnote[TODO:この議論はおかしいので手書きメモをもとにして直す！！！\$A \\coloneqq \\set{x}\$と置く．$A times B$の開被覆\$\\set{X\_\\lambda}\$を取る．各$X_lambda$は開集合なので，開方体の和集合で書ける．各開集合を開方体の和集合で表したとき，その表示に現れる開方体を（すべての開集合にわたって）あつめて得られる開被覆を\$\\set{Y\_\\mu}\$とする．\$\\set{Y\_\\mu}\$の有限部分被覆があれば，それは\$\\set{X\_\\lambda}\$の有限部分被覆にもなっている．この証明を検討すればわかるが，この議論は$A$が1点集合でなくても同様に通る．];；\$\\set{U\_a \\times V\_a }\$を\$\\set{x} \\times B\$の開被覆であって，$U_a$が$bb(R)^m$の開方体，$V_a$が$bb(R)^n$の開方体であるようなものとする．$B$がコンパクトなので，\$\\set{V\_a}\$の中から有限個を選べばそれが$B$の被覆になるから，有限部分被覆を選んで\$\\set{V\_{x\_i}}\$とする．\$\\set{U\_{x\_i} \\times V\_{x\_i}}\$は\$\\set{x} \\times B\$の有限部分被覆である．

]
#thm[
  $A subset bb(R)^m$および$B subset bb(R)^n$がそれぞれコンパクトであるならば，$A times B subset bb(R)^(m + n)$はコンパクトである．

]
#proof[
  やはり開被覆は開方体のみからなっているとして一般性を失わないのでそうする；\$\\mathscr{O} \\coloneqq \\set{U\_a \\times V\_a }\$を$A times B$の開被覆であって，$U_a$が$bb(R)^m$の開方体，$V_a$が$bb(R)^n$の開方体であるようなものとする．$x in A$をひとつとって固定する．このとき\$\\set{x} \\times B\$はコンパクトで，$cal(O)$によって被覆されているので，この中から有限個\$\\set{U\_{x\_i} \\times V\_{x\_i} }\$を取り出すことで\$\\set{x} \\times B\$を被覆できる．ところで$U_x colon.eq sect.big U_(x_i)$は$x$を含む開集合になるので，\$\\set{U\_x \\times V\_{x\_i} }\$は\$\\set{x} \\times B\$の開被覆になっている．この操作を各$x in A$に対し繰り返すことで，$x in A$に対して開集合$U_x subset A$とそれに付随する有限個の開集合$V_(x_i) subset B$を作ることができた．ところで$A$はコンパクトで，\$\\set{U\_x}\$は$A$の開被覆なので，有限部分被覆\$\\set{U\_j}\$が存在する．\$\\set{U\_j \\times V\_{j\_i}}\$は$A times B$の有限部分被覆である．

]
#que[
  上記の定理は任意個数の直積まで拡張できる；\$\\set{A\_\\lambda}\$がすべてコンパクトの時，積空間$product A_lambda$もまたコンパクトである（こちらも
  Tychonoff の定理という）．証明には選択公理が必要．

]
#cor[
  $bb(R)^m$の閉方体はコンパクトである．

]
#proof[
  Tychonoff の定理と Heine-Borel の定理を組み合わせて帰納的に従う．

]
#cor[
  $A subset bb(R)^m$が$bb(R)^m$の有界閉集合であるならば，それはコンパクトである．

]
#proof[
  $A$は有界なので，$A$を含む閉方体$B$がある．$A$の開被覆$cal(O)$を任意にひとつ取る．$A$は閉集合なので，その補集合$A^C colon.eq bb(R)^m \\ A$は開集合である．したがって\$\\mathscr{O} \\cup \\set{A^C}\$は開集合の族であり，更に$bb(R)^m$を被覆しているので，特に$B$の開被覆にもなっている．ゆえに\$\\mathscr{O} \\cup \\set{A^C}\$から有限被覆$cal(O)_2$を選んで$B$を被覆できる．$A subset B$なのだから，これは$A$の開被覆にもなっている．したがって\$\\mathscr{O}\_2 \\setminus \\set{A^C}\$
  が$cal(O)$から選んだ$A$の有限部分被覆である．

]
#que[
  上記の証明では，有界閉集合$A$を含むようなより大きなコンパクト集合$B$を取ってきて$A$のコンパクト性を示すということをした．この議論はより一般的な枠組みにおいて通る；$K$をコンパクト位相空間，$F subset K$を閉集合とするとき，$F$はコンパクトである．

]
おしまいに，Heine-Borel
の定理の逆を示しておこう．これで「$bb(R)^m$においてコンパクトであることと有界閉であることは同値」という主張の証明が完結する．

#thm[
  $bb(R)^m$のコンパクト集合は有界閉集合に限られる．

]
#proof[
  この証明では「開球が開集合である」ことは認めて使う#footnote[開球が開集合であることの証明は直接やってもよいし，連続関数を用いた証明をする場合でもこの定理は使わないので，循環論法にはならない．];．$A subset bb(R)^m$をコンパクトとする．このとき，$A$の被覆であって開方体からなるものを取ると，$A$は有限個の開方体で被覆されるので，とくに有界である．$A$が閉であること，すなわち$A^C colon.eq bb(R)^m \\ A$が開であることを示す．$x in A^C$を任意にひとつ取って固定する．$a in A$に対して$epsilon_a colon.eq parallel x - a parallel \/ 4$と定めると，$a eq.not x$なので$epsilon_a > 0$である．\$\\set{B(a; \\varepsilon\_a)}\$は$A$の開被覆なので，$A$のコンパクト性より有限部分被覆\$\\set{B(i; \\varepsilon\_i)}\$が取れる．ところで\$V \\coloneqq B(x; \\min\_i \\set{\\varepsilon\_i})\$は$x$をふくむ開集合であって，$V sect A = nothing$すなわち$V subset A^C$である．$x$は任意だったので，$A^C$は開集合である．

]
#que[
  上掲した Heine-Borel
  の定理の逆の証明は，よくよく検討すれば$bb(R)$の距離空間としての性質しか使っていないことがわかるので，距離空間に一般化できる．また，「コンパクトならば閉」という部分は距離特有の性質も必要なく，本質的に効いているのは
  Hausdorff 性（$x$と$a$を分離する開集合が取れること）である．

]
#que[
  Heine-Borel
  の定理は無限次元では成り立たない．例えば有界数列全体の集合$ell^oo \( bb(N) \)$に対して$d \( a \, b \) = sup_(n in bb(N)) \| a_i - b_i \|$で距離を入れると，この距離に関する位相のもとで単位閉球はコンパクトにならない．もっと強く，ノルム空間$V$の単位閉球がノルム位相に関してコンパクトになることと，$V$が有限次元であることは同値である．

]
#que[
  $V$をノルム空間，$V^(\*)$をその双対空間とするとき，$V^(\*)$の単位閉球は
  weak-\* topology
  についてコンパクトである（Banach-Alaogluの定理）．関数解析において複数の異なる位相を使い分けたくなる気持ちの一端はこのあたりにあるのではないかと思われる．ちなみにこの定理は
  Markov-角谷の定理の証明に使うことしか私は使いみちを知らない．Markov-角谷の不動点定理は角谷の不動点定理の相当な拡張と捉えられているらしく#footnote[私は角谷の不動点定理も，それがどのように経済学で応用されているのかもよく知らない．];，Banach-Tarski-Hausdorff
  の定理#footnote[一般に「Banach-Tarski
    のパラドックス」と呼ばれているもので，大雑把には「$S^2$を2つに分解して再度組み合わせると$S^2$が2つできる」という定理．ちなみにこの分解で得られる集合は
    Lebesgue
    可測ではないので，特に物理的に不可能な分解である．];の類似が$S^1$では起こせないことの証明に使える．

]
コンパクト性は相当に便利な概念であることは事実である．本題には関係ないものもあるが，ありがたみをいくつか列挙しておくことにする．以下しばらく，$K subset bb(R)^n$をコンパクト集合とする．

#que[
  $f : K arrow.r bb(R)$を連続関数とするとき，$f$は最大値と最小値を持つ．したがって最適化が機能する．非コンパクト集合上の関数の最適化に関して言えることは非常に少ない．ちなみにこの事実をここで証明するのはめんどくさい．少なくともコンパクト性が連続関数によって遺伝することを認めたほうが良い…が，このノートでは閉集合の性質についてあまり詳しく議論していないので，それでも面倒かもしれない．

]
#que[
  $f : K arrow.r bb(R)$を連続関数とするとき，$f$は一様連続である．もっと強く
  Lipschitz 連続である．さらに微分可能であると仮定すると
  $L$-平滑である．したがって勾配法による最適化速度に理論的な上界を与えられる．

]
#que[
  \$C(K) \\coloneqq \\set{f \\colon K \\to \\mathbb{R}| f {\\rm は連続関数}}\$と置く．$f \, g in C \( K \)$に対し，$d \( f \, g \) colon.eq sup_(x in K) \| f \( x \) - g \( x \) \|$と置くと，$d$に関して$C \( K \)$は完備距離空間になる．更に，任意の$f in C \( K \)$と$epsilon > 0$に対して，$d \( p \, f \) < epsilon$を充たすような多項式$p$が存在する（Weierstrass
  の多項式近似定理）．これを使えば，連続な周期関数が三角関数の有限和でいくらでも精度良く近似できることが示せる．もう少し議論すれば連続関数に
  Fourier
  変換ができることを数学的に厳密に示せる気がするが，やったことがないし，もしかすると牛刀割鶏かもしれない．

]
#que[
  実際には$K$は$bb(R)^n$の部分集合である必要はなく，コンパクト Hausdorff
  空間であればよい．更に，$C \( K \)$の元を一様に任意精度で近似することができるような関数のクラスは多項式に限られない．このようなクラスを特徴づける定理として
  Stone-Weierstrass
  の定理というものがある；$cal(A) subset C \( K \)$が$K$のあらゆる2点を分離するような部分代数であって，定数関数1を含むならば，$cal(A)$は距離空間$\( C \( K \) \, d \)$において稠密である．

]
#que[
  前々問の設定を引き継ぐ．$M subset C \( K \)$に対して以下は同値である．

  - $M$は$C \( K \)$において（$d$の定める位相に関して）相対コンパクト．

  - $M$は一様有界かつ一様同程度連続．

  この同値性は Ascoli-Arzelà
  の定理として知られており，常微分方程式の解の存在定理の証明や，連続な分布関数を持つ確率変数の族が弱収束する条件の特徴づけなどに用いられる．コンパクト性がなければこのような定理群は当然成り立たない．

]
== $bb(R)^n$上の連続関数
<mathbbrn上の連続関数>
多変数関数に対する連続性の定義は一変数の場合と同様である．一応きちんと定義しておくことにすると，

#defi[
  $A subset bb(R)^m$を部分集合とする．$f : A arrow.r bb(R)^n$が$a in bb(R)^m$において連続であるとは，任意の$epsilon > 0$に対し，適切な$delta > 0$を選べば，「$parallel x - a parallel < delta$ならば$parallel f \( x \) - f \( a \) parallel < epsilon$」が成り立つこと，言い換えれば$lim_(x arrow.r a) f \( x \) = f \( a \)$が成り立つことをいう．$f$が任意の$a in A$において連続であるとき，$f$は単に連続であるという．

]
上記のような，いわゆる$epsilon$-$delta$論法は必要なときは必要である．特に誤差の評価をより具体的にする必要があるなどの場合は上記の定義のほうがよい．他方，実際にはこの定義は（一見すると極限を用いない）別の形に述べ直すことができる．誤差に関する具体的な評価が必要ない場合，たとえば単に連続であることを証明したい場合などは以下に述べる特徴づけのほうが使いやすい．

#thm[
  $A subset bb(R)^m$を部分集合とする．$f : A arrow.r bb(R)^n$に対して以下は同値である．

  - $f$は連続．

  - 任意の開集合$O subset bb(R)^n$に対し，$f^(- 1) \( O \) = V sect A$を充たすような開集合$V subset bb(R)^m$が存在する．

]
<開集合の引き戻しは開集合>
#proof[
  前半から後半を示す．$O subset bb(R)^n$を開集合とする．$a in f^(- 1) \( O \)$を任意に取ると，$f \( a \) in O$である．$O$は開集合なので，充分小さい$epsilon_(f \( a \)) > 0$に対して#footnote[ここは普通であれば添字の$f \( a \)$を省いて記述するところであろうが，ここを省いてしまうと直下の改行した式が意味不明になってしまうので，重たくなるのを承知で添字をつけている．];$B \( f \( a \) ; epsilon_(f \( a \)) \) subset O$である．$f$は$A$上定義された連続関数なので，適当な$delta_(f \( a \)) > 0$に対して$f \( B \( a ; delta_(f \( a \)) \) sect A \) subset B \( f \( a \) ; epsilon_(f \( a \)) \)$すなわち$B \( a ; delta_(f \( a \)) \) sect A subset f^(- 1) \( B \( f \( a \) ; epsilon_a \) \)$が成り立つ．これを$f^(- 1) \( O \)$の各点に対して一斉に考えることで
  $ (union.big_(a in f^(- 1) \( O \)) B \( a ; delta_(f \( a \)) \)) sect A subset f^(- 1) (union.big_(a in f^(- 1) \( O \)) B \( f \( a \) ; epsilon_(f \( a \)) \)) $を得る．右辺は実際には$f^(- 1) \( O \)$に等しいし，$V colon.eq union.big_(a in f^(- 1) \( O \)) B \( a ; delta_f \( a \) \)$は開集合であるから，あとは左辺と右辺が等しいことを示せばよいが，これはあきらかである．

  後半から前半を示す．$a in A$を任意にひとつ取る．$B \( f \( a \) ; epsilon \)$は$bb(R)^n$の開集合なので，仮定より$f^(- 1) \( B \( f \( a \) ; epsilon \) \) = V sect A$を充たすような開集合$V$がある．$V$は$a$を含む開集合なので，適当な$delta$が存在して$B \( a ; delta \) subset V$である．したがって$parallel x - a parallel < delta$ならば$parallel f \( x \) - f \( a \) parallel < epsilon$である．$a$は任意であったから結論を得る．

]
#cor[
  $f : bb(R)^m arrow.r bb(R)^n$に対して以下は同値である．

  - $f$は連続．

  - 任意の開集合$O subset bb(R)^n$に対し，$f^(- 1) \( O \) = V$は開集合である．

]
#proof[
  先ほどの定理において$A = bb(R)^m$とせよ．

]
#que[
  開球は開集合である．このタイミングで示すのが一番早い．

]
#que[
  $M_n \( bb(R) \)$を$n times n$実行列の全体とする．$M_n \( bb(R) \)$は「成分を縦一列に並び替えることで」$bb(R)^(n^2)$と同一視できるので，これを用いて$M_n \( bb(R) \)$に対しても開集合および連続関数の概念が定義できる．
  \$\$\\begin{aligned}
  {\\rm GL}\_n(\\mathbb{R}) &\\coloneqq \\set{A \\in M\_n(\\mathbb{R}) | \\det A \\neq 0}\\\\
  {\\rm SL}\_n(\\mathbb{R}) &\\coloneqq \\set{A \\in M\_n(\\mathbb{R}) | \\det A = 1}
  \\end{aligned}\$\$をそれぞれ実一般線型群，実特殊線型群と呼ぶ．\${\\rm GL}\_n(\\mathbb{R})\$および\${\\rm SL}\_n(\\mathbb{R})\$は$M_n \( bb(R) \)$においてそれぞれ開集合，閉集合である．

]
#dig[
  位相空間に対しても連続写像の定義はできるのだが，位相空間では当然ながら連続性を定義するのに距離やノルムが使えない．その代わりにどうするかというと，上記の「開集合の引き戻しが開集合」という（Euclid
  空間上の関数に対しては「証明」した）性質を，逆に定義に据えてしまうのである．

]
#dig[
  上記の「位相空間に対する連続写像」の定義は，測度論に現れる「可測写像」の定義と酷似している一方，代数で現れる「準同型」の定義とは違う点がある．おそらくは「逆像を取る」という操作が共通部分を取る操作$sect$および和集合を取る操作$union$を保存する一方，「像を取る・写像で送る」という操作はこれらを保存しないからだろうと思っている．

]
#dig[
  中には像の定義よりも逆像の定義のほうが簡単だと主張する人もいる．ある面ではたしかにそうだと思う．

]
#lem[
  $A subset bb(R)^m$をコンパクト集合，$f : A arrow.r bb(R)^n$を連続写像とする．このとき$f \( A \)$はコンパクトである．

]
#proof[
  $f \( A \)$の開被覆\$\\set{U\_\\lambda}\$をとる．$f$は連続なので，各$f^(- 1) \( U_lambda \)$は$bb(R)^m$の開集合である．\$\\set{f^{-1}(U\_\\lambda)}\$は$A$を被覆するから，$A$のコンパクト性よりその中の有限個\$\\set{f^{-1}(U\_i)}\$が$A$を覆う．この有限集合に現れた\$\\set{U\_i}\$が$f \( A \)$の有限被覆になっている．

]
~

10pt 15pt #strong[] . 5pt plus 1pt minus 1pt

= 多変数関数の微分
<多変数関数の微分>
まず「微分とは線型写像によって関数を近似するおこないである」というテーゼに基づいて微分を高次元へと拡張する．この定義は微分可能多様体に対してもほぼそのまま拡張が通るという点で一般性の高い抽象的な定義であるが，他方で実際の計算においては使いづらい．実際には$C^1$級という関数クラスにおいては「各変数に関する偏微分を計算することで微分の情報をすべて取り出せる」ということを見る．これゆえ大抵の場合で微分の計算は偏導関数の計算に帰着する．

続くふたつの話題はいずれも議論の詳細まで追いかけるには骨が折れるが，結果は知るに値すると思う．ひとつ目の話題は$C^oo$級関数と解析関数（$C^omega$級関数）の違いについてである．「無限回微分可能であるが
Taylor
級数がもとの関数に一致しない」という一見病的な対象は，しかしながら後の理論構築で本質的な役割を果たす．ふたつ目の話題は陰関数定理と逆関数定理である．「行列が正則であることと，その行列が定める線型写像が可逆であることは同値」という線型代数で必ず学ぶ事柄を微積分の文脈に拡張して得られる定理であり，理論上の重要性は言うまでもなく，制限付き極値問題をはじめとする応用を持つという点で実用的な定理である．

== 微分の定義と基本的な性質
<微分の定義と基本的な性質>
一変数関数$f : bb(R) arrow.r bb(R)$は，
$ lim_(h arrow.r 0) frac(f \( a + h \) - f \( a \), h) = b $なる数$b$が存在する時，$a$で微分可能であるといった．この定義はもちろん$f$が多変数関数の場合には（たとえ左辺に対して適切にノルムをとったとしても）意味を持たない．

#que[
  たとえば$f : bb(R)^2 arrow.r bb(R)$に対する$a in bb(R)^2$での微分可能性を
  $ lim_(h arrow.r 0) frac(parallel f \( a + h \) - f \( a \) parallel, parallel h parallel) = b $なる数$b$が存在する時だというふうに定義したとしよう．この定義のもとでは，たとえば$f \( x \, y \) = x + 2 y$がいかなる点でも微分可能にならない．

]
しかしながら上記の式を
$ lim_(h arrow.r 0) frac(f \( a + h \) - f \( a \) - b h, h) = 0 $と改めてみる．これは$f \( a + h \)$を$f \( a \) + b h$で近似していると見ることができる．更に進んで，$bb(R) in.rev h mapsto b h in bb(R)$が線型写像であること，すなわち微分の定義は「関数を線型写像で近似している」とみなせることに注目すると高次元化へのひとつの道筋が見えてくる．すなわち，一変数関数$f : bb(R) arrow.r bb(R)$は，
$ lim_(h arrow.r 0) frac(f \( a + h \) - f \( a \) - lambda \( h \), h) = 0 $を充たす線型写像$lambda : bb(R) arrow.r bb(R)$が存在する時，$a$で微分可能である．この定義ならば高次元化は容易である．

#defi[
  関数$f : bb(R)^m arrow.r bb(R)^n$は，次を充たす線型写像$lambda_a : bb(R)^m arrow.r bb(R)^n$が存在する時，$a in bb(R)^m$で微分可能であるといわれる．

  $ lim_(h arrow.r 0) frac(parallel f \( a + h \) - f \( a \) - lambda_a \( h \) parallel, parallel h parallel) = 0 $

]
#prop[
  関数$f : bb(R)^m arrow.r bb(R)^n$が$a in bb(R)^m$で微分可能であるとする．このとき，

  $ lim_(h arrow.r 0) frac(parallel f \( a + h \) - f \( a \) - lambda_a \( h \) parallel, parallel h parallel) = 0 $を充たすような線型写像$lambda_a$は一意的である．

]
#proof[
  上式を充たす線型写像をもう一つ取ってきて$mu_a$とする．$h in bb(R)^m$として，
  $ parallel lambda_a \( h \) - mu_a \( h \) parallel = parallel \( f \( a + h \) - f \( a \) - mu_a \( h \) \) - \( f \( a + h \) - f \( a \) - lambda_a \( h \) \) parallel $の両辺を$parallel h parallel$で割った上で$h arrow.r 0$とする極限を取れば
  $ frac(parallel lambda_a \( h \) - mu_a \( h \) parallel, parallel h parallel) & = frac(parallel \( f \( a + h \) - f \( a \) - mu_a \( h \) \) - \( f \( a + h \) - f \( a \) - lambda_a \( h \) \) parallel, parallel h parallel)\
  & lt.eq frac(parallel \( f \( a + h \) - f \( a \) - mu_a \( h \) \) parallel, parallel h parallel) + frac(parallel \( f \( a + h \) - f \( a \) - lambda_a \( h \) \) parallel, parallel h parallel)\
  & arrow.r 0 $すなわち$lim_(h arrow.r 0) frac(parallel lambda_a \( h \) - mu_a \( h \) parallel, parallel h parallel) = 0$を得る．ところで$mu_a$と$lambda_a$は線型写像なので，これは
  $ lim_(h arrow.r 0) ∥lambda_a (frac(h, parallel h parallel)) - mu_a (frac(h, parallel h parallel))∥ = 0 $を意味する．$h$は任意だったので，実数$t$と標準基底$e_i$に対して$h = t e_i$として$t arrow.r 0$とする極限を取れば$lambda_a \( e_i \) = mu_a \( e_i \)$を得る．基底での値が一致しているので，線型写像としても一致する．

]
#defi[
  $f : bb(R)^m arrow.r bb(R)^n$が$a in bb(R)^m$で微分可能なとき，前命題で言及された一意な線型写像$lambda_a$のことを$d f_a$と書いて，$f$の$a$における微分という．$d f_a$の標準基底に関する行列表示を$f$の$a$における
  Jacobi
  行列といい，$J_f \( a \)$と書くことにする．ただし，$m = n = 1$の場合は$1 times 1$行列$J_f \( a \)$とスカラー倍写像$d f_a$を区別するのが煩雑なので，同一視してどちらも$d f_a$で表すことがある．

]
#defi[
  $A subset bb(R)^m$を開集合とする．$f : A arrow.r bb(R)^n$が$a in A$において微分可能なとき，$f$は$A$上で微分可能であるという．$f : bb(R)^m arrow.r bb(R)^n$が$bb(R)^m$上で微分可能な時，$f$は微分可能であるという．微分可能な関数$f : bb(R)^m arrow.r bb(R)^n$に対し，$a$を$d f_a$に対応させる写像$a mapsto d f_a$のことを$d f$と書いて，$f$の微分という．

]
#dig[
  微分の記号を Spivak
  における$D f \( a \)$から$d f_a$に変えたことには一定の意図があるが，このタイミングではきちんとした説明が難しいので大雑把なことだけを言っておく；$d f$という記号は（正式な定義を知らないにしても）微分形式を思い起こさせるであろうが，実際この微分$d f$は「0-形式$f$の外微分によって得られる1-形式$d f$」ともみなせる（ので，同じ記号を使うことに一定の正当性がある）ということを後で述べるつもりである．

  他方，Jacobi
  行列にあてる記号を$f' \( a \)$から$J_f \( a \)$に変えたことには前者ほどの意味はなく，行列に$f' \( a \)$という記号を割り当てるのがあまり一般的だとは思わなかったから，というだけに過ぎない．文献によっては
  Jacobi
  行列のほうに$D f \( a \)$という記号を割り当てているものもあるが，この流儀を取るのは
  Spivak と併せて読む際に混乱を引き起こすと思ったのでやめた．

  結局のところこのノートでは$J_f \( a \)$倍写像のことを$d f_a$と書くことになった．しかし，とくに局所座標を取ってどうこうという議論をする必要のない今の時点では，無理して記号を変える必要はないかもしれない．

]
#que[
  これは偏微分を見慣れた読者に向けての，やや先回り気味の注意である#footnote[TODO:ここで方向微分の定義を導入して，「微分の高次元化」の可能性は複数あり得るという話をしてもよいと思う．Gâteaux
    微分と Fréchet
    微分に関する余談を入れることも検討する．また，$f : bb(R)^2 arrow.r bb(R)$に対しては微分を考えるのと接平面を考えるのはだいたい一緒という話も（できれば微分の定義の前後に）差し込んでおきたい．もちろん，その「だいたい一緒」という話をより一般的な状況で述べていくのがこの節の主たる話題のひとつなのだが．];；微分可能ならば偏微分可能であることは後で見るが，しかしながらあらゆる変数に関して偏微分可能であったとしても（もっと強く，あらゆる方向に対する方向微分が存在したとしても），ここで定義した意味で微分可能であるとは限らない．次のような例がある；\$\\mathbb{S}^1 \\coloneqq \\set{x \\in \\mathbb{R}^2 | \\|x\\|=1}\$を単位円周とし，$g : bb(S)^1 arrow.r bb(R)$を，$g \( 0 \, 1 \) = g \( 1 \, 0 \) = 0$および$g \( - x \) = - g \( x \)$を充たすような連続関数とする．関数$f : bb(R)^2 arrow.r bb(R)$を，
  \$\$f(x) =   \\begin{dcases\*}
  \\|x\\| \\cdot g\\left( \\frac{x}{\\|x\\|} \\right) & if \$x \\neq 0\$ \\\\
  0 & if \$x=0\$
  \\end{dcases\*}\$\$
  で定める．更に$x in bb(R)^2$に対して$phi_x : bb(R) arrow.r bb(R)$を$phi_x \( t \) colon.eq f \( t x \)$で定める．このとき，

  - $phi_x$は微分可能である．

  - $g eq.not 0$ならば$f$は$\( 0 \, 0 \)$において微分可能ではない．

]
基本的な性質を見ておくことにする．

#prop[
  $f : bb(R)^m arrow.r bb(R)^n$が$a in bb(R)^m$において微分可能で，$g : bb(R)^n arrow.r bb(R)^ell$が$f \( a \) in bb(R)^n$において微分可能であるとする．このとき合成写像$g compose f : bb(R)^m arrow.r bb(R)^ell$は$a in bb(R)^m$において微分可能であり，
  $ d \( g compose f \)_a = d g_(f \( a \)) compose d f_a $が成り立つ．したがって，$f$と$g$がともに微分可能であるならば，$g compose f$は微分可能であり，
  $ d \( g compose f \) = d g compose d f $が成り立つ．

]
#proof[
  示すべきことは，$h arrow.r 0$のもとで
  $ C colon.eq frac(∥g \( f \( a + h \) \) - g \( f \( a \) \) - d g_(f \( a \)) \( d f_a \( h \) \)∥, parallel h parallel) arrow.r 0 $となることである．
  $ C & = frac(∥g \( f \( a + h \) \) - g \( f \( a \) \) - d g_(f \( a \)) \( d f_a \( h \) \)∥, parallel h parallel)\
  & = frac(∥g \( f \( a + h \) \) - g \( f \( a \) \) - d g_(f \( a \)) \( f \( a + h \) - f \( a \) \) + d g_(f \( a \)) \( f \( a + f \) - f \( a \) - d f_a \( h \) \)∥, parallel h parallel)\
  & lt.eq frac(∥g \( f \( a + h \) \) - g \( f \( a \) \) - d g_(f \( a \)) \( f \( a + h \) - f \( a \) \)∥, parallel h parallel) + frac(∥d g_(f \( a \)) \( f \( a + f \) - f \( a \) - d f_a \( h \) \)∥, parallel h parallel)\
  & eq.colon A + B . $$A$と$B$が$h arrow.r 0$で0に収束することを示せればよい．

  @線型写像の連続性
  より，ある実数$M$があって$B lt.eq frac(M ∥f \( a + f \) - f \( a \) - d f_a \( h \) \)∥, parallel h parallel) arrow.r 0$なので$B$はよい．$A$を評価する．$epsilon > 0$を任意に取る．ふたたび@線型写像の連続性
  より，任意の$h in bb(R)^m$に対して$parallel d f_a \( h \) parallel lt.eq N parallel h parallel$となるような実数$N$がある．以下，3つの評価を使う；

  - $g$は$f \( a \)$において微分可能なので，
    $ lim_(y arrow.r f \( a \)) frac(∥g \( y \) - g \( f \( a \) \) - d g_(f \( a \)) \( y - f \( a \) \)∥, parallel y - f \( a \) parallel) = 0 $すなわちある$delta > 0$が存在して$parallel y - f \( a \) parallel < delta$ならば
    $
      ∥g \( y \) - g \( f \( a \) \) - d g_(f \( a \)) \( y - f \( a \) \)∥ < frac(epsilon, 2 N) parallel y - f \( a \) parallel .
    $

  - $f$は$a$において微分可能，とくに連続なので，
    $ lim_(h arrow.r 0) ∥f \( a + h \) - f \( a \)∥ = 0 $すなわちある$gamma_1 > 0$が存在して$parallel h parallel < gamma_1$ならば
    $ parallel f \( a + h \) - f \( a \) parallel < delta . $

  - $f$は$a$において微分可能なので，
    $ lim_(h arrow.r 0) frac(∥f \( a + h \) - f \( a \) - d f_a \( h \)∥, parallel h parallel) = 0 $すなわちある$gamma_2 > 0$が存在して$parallel h parallel < gamma_2$ならば
    $ ∥f \( a + h \) - f \( a \) - d f_a \( h \)∥ < N parallel h parallel . $

  \$\\gamma \\coloneqq \\min \\set{\\gamma\_1, \\gamma\_2}\$とすると，$parallel h parallel < gamma$ならば$parallel f \( a + h \) - f \( a \) parallel < delta$なので，
  $
    ∥g \( f \( a + h \) \) - g \( f \( a \) \) - d g_(f \( a \)) \( f \( a + h \) - f \( a \) \)∥ & < frac(epsilon, 2 N) ∥f \( a + h \) - f \( a \)∥\
    & = frac(epsilon, 2 N) ∥f \( a + h \) - f \( a \) - d f_a \( h \) + d f_a \( h \)∥\
    & lt.eq frac(epsilon, 2 N) ∥f \( a + h \) - f \( a \) - d f_a \( h \)∥ + frac(epsilon, 2 N) ∥d f_a \( h \)∥\
    & < frac(epsilon, 2 N) dot.op N parallel h parallel + frac(epsilon, 2 N) dot.op N ∥h∥\
    & = epsilon parallel h parallel
  $
  すなわち$h arrow.r 0$で$A arrow.r 0$となる．

]
#dig[
  上記証明の$A$の評価は，気分としては以下のようなことをしたいのである#footnote[もっと言えば，最初はこのように証明を書いていて，後で「あっ．間違っている」と気づいて慌てて書き直した．];；
  $ A & = frac(∥g \( f \( a + h \) \) - g \( f \( a \) \) - d g_(f \( a \)) \( f \( a + h \) - f \( a \) \)∥, parallel h parallel)\
  & = frac(∥g \( f \( a + h \) \) - g \( f \( a \) \) - d g_(f \( a \)) \( f \( a + h \) - f \( a \) \)∥, parallel f \( a + h \) - f \( a \) parallel) dot.op frac(parallel f \( a + h \) - f \( a \) parallel, parallel h parallel)\
  & = frac(∥g \( f \( a + h \) \) - g \( f \( a \) \) - d g_(f \( a \)) \( f \( a + h \) - f \( a \) \)∥, parallel f \( a + h \) - f \( a \) parallel) dot.op frac(parallel f \( a + h \) - f \( a \) - d f_a \( h \) + d f_a \( h \) parallel, parallel h parallel)\
  & lt.eq frac(∥g \( f \( a + h \) \) - g \( f \( a \) \) - d g_(f \( a \)) \( f \( a + h \) - f \( a \) \)∥, parallel f \( a + h \) - f \( a \) parallel) dot.op frac(∥f \( a + h \) - f \( a \) - d f_a \( h \)∥ + ∥d f_a \( h \)∥, parallel h parallel)\
  & lt.eq frac(∥g \( f \( a + h \) \) - g \( f \( a \) \) - d g_(f \( a \)) \( f \( a + h \) - f \( a \) \)∥, parallel f \( a + h \) - f \( a \) parallel) dot.op frac(∥f \( a + h \) - f \( a \) - d f_a \( h \)∥ + N ∥h∥, parallel h parallel)\
  & arrow.r 0 dot.op \( 0 + N \) = 0 . $のだが，この議論は$f \( a + h \) = f \( a \)$となった場合に破綻する．1次元であれば「$f \( a \)$の充分近くで常に$f \( a + h \) = f \( a \)$となるかそうでないか」を場合分けすればできるかもしれないが，2次元の場合にそういうことを考えるのはおそらくつらい．なので泣きながら前半のように$epsilon$-$delta$論法に基づいてきちんと評価する必要があるし，多分こちらのほうが最終的には近道な気がしている．

]
#que[
  $f : bb(R)^m arrow.r bb(R)^n$が$a$で微分可能であるならば$a$で連続であることをしれっと使ったが，証明はしていない．

]
#prop[
  + $f : bb(R)^m arrow.r bb(R)^n$が定数関数であるならば，$f$は微分可能であり，任意の$a in bb(R)^m$に対して$d f_a = 0$．ただし右辺の$0$は零写像$0 : bb(R)^m in.rev x mapsto 0 in bb(R)^n$．

  + $f : bb(R)^m arrow.r bb(R)^n$が線型写像であるならば，$f$は微分可能であり，任意の$a in bb(R)^m$に対して$d f_a = f$．

  + $f : bb(R)^m arrow.r bb(R)^n$が微分可能であることと，各成分$f^i : bb(R)^m arrow.r bb(R)$が微分可能であることは同値．このとき，
    $ d f_a \( h \) = \( d f^1_a \( h \) \, dots.h \, d f^n_a \( h \) \)^top $が成り立つ．したがって$J_f \( x \)$の第$i$行は$J_(f^i) \( x \)$に等しい．

  + 関数$s : bb(R)^2 arrow.r bb(R)$を$s \( a^1 \, a^2 \) colon.eq a^1 + a^2$で定めると$s$は微分可能であり，任意の$a in bb(R)^2$に対して$d s_a = s$．

  + 関数$p : bb(R)^2 arrow.r bb(R)$を$p \( a^1 \, a^2 \) colon.eq a^1 a^2$で定めると$p$は微分可能であり，$d p_(\( a^1 \, a^2 \)) \( h^1 \, h^2 \) = h^1 a^2 + h^2 a^1$．

]
<微分の基本性質>
#proof[
  + $lim_(h arrow.r 0) frac(∥f \( x + h \) - f \( x \) - 0∥, parallel h parallel) = lim_(h arrow.r 0) frac(∥0∥, parallel h parallel) = 0 .$

  + $lim_(h arrow.r 0) frac(∥f \( x + h \) - f \( x \) - f \( h \)∥, parallel h parallel) = lim_(h arrow.r 0) frac(∥f \( x \) + f \( h \) - f \( x \) - f \( h \)∥, parallel h parallel) = lim_(h arrow.r 0) frac(∥0∥, parallel h parallel) = 0$．

  + 各$f^i$が微分可能であると仮定する．$lambda_a \( h \) colon.eq \( d f^1_a \( h \) \, dots.h \, d f^n_a \( h \) \)^top$によって線型写像$lambda_a : bb(R)^m arrow.r bb(R)^n$を定めると，
    $ f \( a + h \) - f \( a \) - lambda_a \( h \) = \( f^1 \( a + h \) - f^1 \( a \) - d f^1_a \( h \) \, dots.h \, f^n \( a + h \) - f^n \( a \) - d f^n_a \( h \) \) $となるので，
    $ lim_(h arrow.r 0) frac(∥f \( a + h \) - f \( a \) - lambda_a \( h \)∥, parallel h parallel) lt.eq sum_(i = 1)^n lim_(h arrow.r 0) frac(∥f^i \( a + h \) - f^i \( a \) - d f^i_a \( h \)∥, parallel h parallel) = 0 $より$lambda_a$は$f$の$a$における微分である．逆に$f$が微分可能であると仮定すると，各$f^i$は$f$と座標関数$pi_i : bb(R)^n in.rev x mapsto x^i in bb(R)$の合成$f^i = pi^i compose f$であり，$pi^i$が線型写像であることから$d f^i = d pi_i compose d f = pi_i compose d f$である．したがって$d f_a \( h \) = \( d f^1_a \( h \) \, dots.h \, d f^n_a \( h \) \)^top$を得る．

  + $s$は線型写像であるからよい．

  + $\( h^1 \, h^2 \) mapsto h^1 a^2 + h^2 a^1$が$p$の微分の定義を充たすことをしめせばよい#footnote[上付き添字と冪乗の記号の相性が最悪なことがよくわかる証明だと思う．Spivak
      では$h^1 \, h^2$ではなく$h \, k$を使っていた．];．
    $ frac(∥p \( a + h \) - p \( a \) - h^1 a^2 - h^2 a^1∥, parallel h parallel) = lr(|h^1 h^2|) / sqrt(\( h^1 \)^2 + \( h^2 \)^2) $であるが，\$\\left|h^1h^2\\right| \\leq (\\max\\set{h^1, h^2})^2 \\leq (h^1)^2 + (h^2)^2\$なので，$lr(|h^1 h^2|) \/ sqrt(\( h^1 \)^2 + \( h^2 \)^2) lt.eq sqrt(\( h^1 \)^2 + \( h^2 \)^2) arrow.r 0$となるからよい．

]
#que[
  ここまでの議論で以下のことがわかった；

  - 微分可能な関数$f$および$g$に対して$d \( g compose f \) = d g compose d f$が成り立つ．

  - $upright("id")_(bb(R)^m) : bb(R)^m arrow.r bb(R)^m$を恒等写像とするとき，これは微分可能であって，$d \( upright("id")_(bb(R)^m) \) = upright("id")_(bb(R)^m)$が成り立つ．

  したがって$d$はおそらくどこかの圏からどこかの圏への共変関手である．このことをきちんと述べるにはベクトル束に関する議論が必要になる気がする．しかしこのノートでベクトル束の話まで書くのはやりすぎな気もしている．ちゃんと勉強したことがないので，やってみたくはあるのだが．

]
#cor[
  $f \, g : bb(R)^n arrow.r bb(R)$が$x$で微分可能であるならば，$f + g \, f g$もまた微分可能であって，
  $ d \( f + g \)_x = d f_x + d g_x\
  d \( f g \)_x = g \( x \) dot.op d f_x + f \( x \) dot.op d g_x $が成り立つ．特に$g \( x \) eq.not 0$であるならば，
  $ d \( f \/ g \)_x = frac(g \( x \) dot.op d f_x - f \( x \) dot.op d g_x, \( g \( x \) \)^2) . $

]
#proof[
  $f + g = s compose \( f \, g \)$なので$f + g$は微分可能であり，$d \( f + g \)_x = d \( s compose \( f \, g \) \)_x = d s_(\( f \( x \) \, g \( x \) \)) compose d \( f \, g \)_x = s compose \( d f \, d g \)_x = d f_x + d g_x$となる．

  $f g = p compose \( f \, g \)$なので$f g$は微分可能であり，$d \( f g \)_x = d \( p compose \( f \, g \) \)_x = d p_(\( f \( x \) \, g \( x \) \)) compose d \( f \, g \)_x = d p_(\( f \( x \) \, g \( x \) \)) compose \( d f_x \, d g_x \) = g \( x \) dot.op d f_x + f \( x \) dot.op d g_x$となる．最後の式は多項式の微分を知っていればできると思います．

]
まとめると，各成分が微分可能な関数の加減乗除ないし合成で書ける関数は微分可能であるということがわかった．しかしながらここまでの知識だけで微分を計算するのは煩雑である．煩雑であることを見るためだけに例をひとつだけ扱っておくことにする．

#exm[
  $f : bb(R)^2 arrow.r bb(R)$を，$f \( x \, y \) = x^y$で定める．$f$の微分を計算しよう．指数関数$x mapsto e^x$を$e$と書くことにすれば，$f = e compose \( pi^2 log pi^1 \)$なので，$d f_(\( a \, b \)) = d e_(b log a) compose d \( pi^2 log pi^1 \)_(\( a \, b \)) = e^(b log a) dot.op [\( d pi^2 \)_(\( a \, b \)) log a + b \( d log pi^1 \)_(\( a \, b \))] = a^b dot.op [pi^2 log a + b frac(d pi_(\( a \, b \))^1, a)] = a^b dot.op [pi^2 log a + pi^1 b / a]$を得る．Jacobi
  行列の形で書けば$J_f \( a \, b \) = (a^b b / a \, a^b log a)$となる．

]
（偏微分の計算に慣れている人ならばよくご存知のように，）このやり方で微分を計算することはまずあり得ない．もっと簡単な方法があるので，次項以降でそれを見ていくことにする．

== 偏微分
<偏微分>
多変数関数に対して，ひとつの変数以外を固定してその変数に関して微分するという操作を考える．

#defi[
  $f : bb(R)^n arrow.r bb(R)$と$a in bb(R)^n$に対し，
  $ lim_(h arrow.r 0) frac(f \( a^1 \, dots.h \, a^i + h \, dots.h \, a^n \) - f \( a^1 \, dots.h \, a^i \, dots.h \, a^n \), h) $が存在する時，$f$は第$i$変数に関して（偏）微分可能であるという．このとき，上記の極限の値を$partial_i f \( a \)$と書いて$f$の$a$における第$i$偏微分係数と呼ぶ．任意の$a in bb(R)^n$に対して$partial_i f \( a \)$が定まる時，関数$a mapsto partial_i f \( a \)$が定まるが，これを$partial_i f$と書いて$f$の第$i$偏導関数という．

]
#dig[
  Spivak では $D_i f \( a \)$
  となっていた偏微分の記号を$partial_i f \( a \)$に変えたのはそこまで深い意味はない．$D_i$だとあまり偏微分という感じがしなかったからという程度の理由である．ところで，微分に倣って$\( partial_i f \)_a$のように書かない理由もとくにない．書いたほうが良いかもしれない．あまりちゃんと検討してないからこうなっている，というだけである．

  他方，$f$の引数に充てる記号として$\( x \, y \)$を使うとき，$partial f \/ partial x$という記号で$partial_1 f$のことを指すような書き方はよく採られるし，何なら私もよく使う．しかしこのノートではとりあえず断りなしに使うつもりはない．こちらには一定の理由がある．ひとつは引数に割り当てる記号をいちいち用意しないと厳密な記述ができないことである．他にもあるが，それらはすべて
  Spivak
  にそのまま述べてあり，それを書き写すのが面倒なので気が向いたら書き足します．

]
#defi[
  $f$の第$i$偏導関数が$a$において第$j$変数に関して偏微分可能なとき，すなわち$partial_j \( partial_i f \) \( a \)$が存在する時，これを$partial_(i \, j) f \( a \)$と書く．このような関数たちを2階偏導関数という．高階偏導関数も同様に定義される．$r$階偏導関数がすべて存在してしかも連続であるような関数は$C^r$級関数と呼ばれる．特に任意階数の偏導関数がすべて存在して連続であるような関数は$C^oo$級関数と呼ばれる．

]
一般には$partial_(i \, j) f = partial_(j \, i) f$であるとは限らないが，この等式を保証する充分条件としては次のものが有名である．あとで
Fubini の定理を使って証明するので，ここでは証明しない．

#block[
  thmclairaut<clairaut>
  $f : bb(R)^n arrow.r bb(R)$が$C^2$級関数であるならば，$partial_(i \, j) f = partial_(j \, i) f$である．

]
#dig[
  この定理はいろいろな呼ばれ方をしているらしい．Wikipedia しらべでは Young
  の定理とも Clairaut の定理とも Schwarz の定理ともいうとのこと．

]
#exm[
  $f : bb(R)^2 arrow.r bb(R)$を，$f \( x \, y \) = x^y$で定める．$f$の偏微分係数を計算してみよう．とはいえ1変数関数だと思って微分を計算すればよいので，$partial_1 f \( a \, b \) = a^b b / a$，$partial_2 f \( a \, b \) = a^b log a$である．

]
この例と，さきほどの微分の計算例とを比較すれば，「Jacobi
行列というのは偏導関数を縦横にならべたものに等しいのではないか？」という予想をすることは難しくないだろう．この予想は実際正しい．それゆえ微分可能であることがわかっている場合，微分の計算は偏微分係数の計算に帰着する．

#thm[
  $f : bb(R)^m arrow.r bb(R)^n$が$a$において微分可能であるとする．このとき，$f$は各変数に関して偏微分可能であり，$f$の$a$における
  Jacobi
  行列$J_f \( a \)$の$\( i \, j \)$成分は$partial_j f^i \( a \)$である．

]
<微分可能なら偏微分可能>
#proof[
  @微分の基本性質
  より，結局は各成分関数ごとの考察に帰着するため，$n = 1$の場合を証明すればよい．$h : bb(R) arrow.r bb(R)^m$を，$h \( x \) = \( a^1 \, dots.h \, a^(j - 1) \, x \, a^(j + 1) \, dots.h \, a^m \)$で定めると$f compose h : bb(R) arrow.r bb(R)$は微分可能であるが，導関数$d \( f compose h \)$とは$partial_j f$のことである．更に$J_h \( x \) = e_j$であるから，$J_(f compose h) (a^j) = J_f (h (a^j)) dot.op J_h (a^j) = J_f (a) dot.op e_j$である．つまり$1 times m$行列$J_f (a)$の$j$列目は$partial_j f \( a \)$に等しい．

]
#que[
  上記の証明では合成則を用いて証明したが，合成則なしでも証明できる．$n = 1$としてよいのは同様で，$f$の微分の存在を仮定してよいので，$h = \( 0 \, dots.h \, 0 \, h^i \, 0 \, dots.h \, 0 \)$として
  $ lim_(h^i arrow.r 0) lr(|f \( a + h \) - f \( a \) - d f_a \( h \)|) / lr(|h^i|) = 0 $が成り立つから，ということは
  $ lim_(h^i arrow.r 0) frac(f \( a + h \) - f \( a \) - d f_a \( h \), lr(|h^i|)) = 0 $すなわち
  $ lim_(h^i arrow.r 0) frac(f \( a + h \) - f \( a \), lr(|h^i|)) = lim_(h^i arrow.r 0) frac(d f_a \( h \), lr(|h^i|)) = lim_(h^i arrow.r 0) d f_a \( e_i \) = d f_a \( e_i \) $が成り立つ．ここまで書いたところで，埋める行間がなくなって問の体裁すら保てなくなったことに気づいたのですが，行間を見つけたら埋めてください．

]
この逆は成り立つとは限らない；例えば偏微分可能だからといって微分可能とは限らない例をすでに見た．しかしながら大抵の場合において逆も成り立つので，大抵の場合において微分の計算は（微分可能性の判定まで含めて）偏導関数の計算に帰着すると思ってよい．

#thm[
  $f : bb(R)^m arrow.r bb(R)^n$が$C^1$級であるならば$f$は微分可能である．

]
<C1なら微分可能>
#proof[
  @微分の基本性質
  より，各成分関数の微分可能性を示せば充分であるから，やはり$n = 1$の場合を証明すれば良い．$f \( a + h \) - f \( a \)$を，
  $ f \( a + h \) - f \( a \) & = f \( a^1 + h^1 \, a^2 \, dots.h \, a^n \) - f \( a^1 \, a^2 \, dots.h \, a^n \)\
  & + f \( a^1 + h^1 \, a^2 + h^2 \, dots.h \, a^n \) - f \( a^1 + h^1 \, a^2 \, dots.h \, a^n \)\
  & + dots.h.c\
  & + f \( a^1 + h^1 \, a^2 + h^2 \, dots.h \, a^(n - 1) + h^(n - 1) \, a^n + h^n \) - f \( a^1 + h^1 \, a^2 + h^2 \, dots.h \, a^(n - 1) + h^(n - 1) \, a^n \) $のように表示しておく．$f$は各変数に関して偏微分可能なので，平均値の定理により
  $ f \( a^1 + h^1 \, a^2 \, dots.h \, a^n \) - f \( a^1 \, a^2 \, dots.h \, a^n \) = h^1 partial_1 f \( b^1 \, a^2 \, dots.h \, a^n \) $を充たすような$b^1 in \[ a^1 \, a^1 + h^1 \]$がある．同様の仕方で$b^i in \[ a^i \, a^i + h^i \]$が取れるので取っておくことで，
  $ f \( a + h \) - f \( a \) & = h^1 partial_1 f \( b^1 \, a^2 \, dots.h \, a^n \) \
                            & + h^2 partial_2 f \( a^1 + h^1 \, b^2 \, dots.h \, a^n \) \
                            & + dots.h.c \
                            & + h^n partial_n f \( a^1 + h^1 \, a^2 + h^2 \, dots.h \, a^(n - 1) + h^(n - 1) \, b^n \) $のように表示できる．さて，線型写像$lambda_a : bb(R)^m arrow.r bb(R)$を，
  $ lambda_a \( h^1 \, dots.h \, h^n \) = sum_(i = 1)^n h^i partial_i f \( a \) $で定める．$lambda_a$が$f$の微分になっていることを示す#footnote[突然天から降ってきた式に見えるかもしれないが，「仮に微分可能だったとすると前定理より微分はこの形になるしかない」というのがわかるので，そこから逆算している．];．
  $ frac(parallel f \( a + h \) - f \( a \) - lambda \( h \) parallel, parallel h parallel) & = frac(∥sum h^i partial_i f \( a^1 + h^1 \, dots.h \, b^i \, a^(i + 1) \, dots.h \, a^n \) - sum h^i partial_i f \( a \)∥, parallel h parallel)\
  & lt.eq sum_(i = 1)^n frac(lr(|h^i|), parallel h parallel) ∥partial_i f \( a^1 + h^1 \, dots.h \, a^(i - 1) + h^(i - 1) \, b^i \, a^(i + 1) \, dots.h \, a^n \) - partial_i f \( a \)∥\ $ なので，$partial_i f$の連続性より右辺は$h arrow.r 0$で0に収束する．

]
#que[
  $f : bb(R)^m arrow.r bb(R)^n$が微分可能だが$C^1$級ではない例があるらしい．$m = n = 1$の場合はそれはそうなのだが，そうでない例をまだ検討していない．

]
さて，微分可能性から偏微分係数の存在が合成則なしで示せて，かつ偏微分係数の連続性から微分可能性を言うのに合成則を使っていないので，ここまでの議論で合成則はなくてもよかった．しかしながら合成則は次の形の（特に実用上の計算において）重要な帰結を持つ；

#prop[
  各$1 lt.eq i lt.eq n$に対して$g^i : bb(R)^m arrow.r bb(R)$が$a in bb(R)^m$において$C^1$級であり，$f : bb(R)^n arrow.r bb(R)$が$\( g^1 \( a \) \, g^2 \( a \) \, dots.h \, g^n \( a \) \)$において微分可能であったと仮定する．このとき
  $ F : bb(R)^m in.rev x mapsto f \( g^1 \( x \) \, g^2 \( x \) \, dots.h \, g^m \( x \) \) in bb(R) $
  は$a in bb(R)^m$において微分可能であって，
  $ partial_i F \( a \) = sum_(j = 1)^m partial_j f \( g^1 \( a \) \, g^2 \( a \) \, dots.h \, g^n \( a \) \) dot.op partial_i g^j \( a \) $が成り立つ．

]
<実用的な方の合成則>
#proof[
  $g : bb(R)^m arrow.r bb(R)^n$を$g \( x \) colon.eq \( g^1 \( x \) \, dots.h \, g^n \( x \) \)$で定めると，@C1なら微分可能
  より$g$は微分可能であるので，$F = f compose g$も微分可能である．@微分可能なら偏微分可能
  より$F$の$a$における Jacobi
  行列$J_F \( a \)$は$1 times m$行列であって$\( 1 \, i \)$成分が$partial_i F \( a \)$に等しいことがわかる．したがって$F$の
  Jacobi
  行列を計算すればよいが，合成則より$J_F \( a \) = J_f \( g \( a \) \) dot.op J_g \( a \)$であって，$J_f \( g \( a \) \)$は
  $ (partial_1 f \( g \( a \) \) \, med partial_2 f \( g \( a \) \) \, med dots.h \, med partial_n f \( g \( a \) \)) $という$1 times n$行列，$J_g \( a \)$は$\( j \, i \)$成分が$partial_i g^j \( a \)$であるような$n times m$行列であるから，あとは行列の掛け算をすることで結論を得る．

]
== $C^oo$級関数と解析関数
<cinfty級関数と解析関数>
$C^oo$級関数の概念はすでに述べたが，これと近しい概念として次のものがある；

#defi[
  $C^oo$級関数$f : bb(R) arrow.r bb(R)$が$a in bb(R)$において解析的であるとは，ある$a$を含む開集合$D$が存在して，$D$の各点$x$で
  Taylor 級数
  $ sum_(i = 0)^oo frac(f^(\( n \)) \( a \), n !) \( x - a \)^n colon.eq lim_(N arrow.r oo) sum_(i = 0)^N frac(f^(\( n \)) \( a \), n !) \( x - a \)^n $が$f \( x \)$に収束することをいう．$f$が任意の$a in bb(R)$において解析的なとき，$f$は解析的である，ないしは$C^omega$級関数，解析（的）関数であると言われる．

]
#que[
  たとえば多項式や指数関数は解析的であるし，複素解析的な関数の実軸への制限もそうである．

]
#que[
  実際には多変数関数に対しても解析性の概念は定義できるのだが，多重指数の説明を書くのがいやだったのでやめた．

]
この項の目的は，$C^oo$であるが解析的でない関数を構成することである．この関数はこの時点では「変な例」以上の感想が湧かないと思われるが，実際にはこの関数を1の分割の構成で使う（らしい）．

#block[
  thmadjustedbump<隆起関数の存在>
  $bb(R)$のコンパクト集合$K$と開集合$A$を，$K subset A subset bb(R)$を充たすように取る．このとき，$C^oo$級関数$phi : bb(R) arrow.r \[ 0 \, 1 \]$であって，$K$上では$phi \( x \) = 1$，$A$に含まれるあるコンパクト集合の外では$phi \( x \) = 0$を充たすようなものが存在する．

]
#que[
  この項では隆起関数を具体的に構成する．構成された関数が解析的でないことも見るが，では作り方を工夫すれば解析的になり得るだろうか，という疑問が生じる．実はどのように作ったとしても$phi$は解析的にはなり得ない．それは大まかには次のようにしてわかる；$phi$が解析的であったとして，$K$を含むような$bb(C)$上の適当な開集合まで$phi$を解析接続する．すると一致の定理から$phi$は定数関数1になって矛盾する．

]
#que[
  ところで1の分割は積分の定義とか Riemann
  計量の存在を示すのに使うのだが，作り方から解析的であることが許されない．ということは複素多様体上で類似の概念を作ろうと思ってもうまく行かなそうであるということがわかる．事実，ある複素多様体が与えられたとして，それにどのような計量が入るかというのはそんなに自明な問題ではないらしいし，Kähler
  多様体の定義も（「Kähler
  計量の入った複素多様体」ではなく）「複素多様体であって Kähler
  計量を入れられるもの」として構わないらしい．

]
では隆起関数の構成に入る．大まかな道筋としては，

- まず開集合$\( - 1 \, 1 \)$上で正で，$plus.minus 1$に近づくにつれ0に減衰するような関数を作り，これを各軸ごとに組み合わせることで「ある点を含む開方体の内部だけで値を持ち，境界に近づくにつれ減衰するような関数」を作る．

- 上記の関数を「$K$上の適切な有限箇所に配置することで」$K$上で正，$A$の境界の「十分手前で」0に減衰し切るような関数を作る．この「適切な有限箇所」の選定に$K$のコンパクト性を用いる．

- 上記で作った関数の値をいい感じに調整する．

#lem[
  任意の$k in bb(R)$に対して$lim_(h arrow.r 0) h^(- k) exp \( - h^(- 1) \) = 0$．

]
<指数関数は多項式に優越する>
#proof[
  $ log (h^(- k) exp \( - h^(- 1) \)) = - k log h - h^(- 1) = - frac(1 + k h log h, h) $であり，$lim_(h arrow.r 0) h log h = lim_(h arrow.r 0) log h \/ \( h^(- 1) \) = lim_(h arrow.r 0) \( 1 \/ h \) \/ \( - h^(- 2) \) = lim_(h arrow.r 0) - h = 0$なので結局$lim_(h arrow.r 0) log (h^(- k) exp \( - h^(- 1) \)) = - oo$すなわち$lim_(h arrow.r 0) h^(- k) exp \( - h^(- 1) \) = 0$を得る．

]
#prop[
  関数$f : bb(R) arrow.r bb(R)$を， \$\$f(x) =   \\begin{dcases\*}
  \\exp\\left(-\\frac{1}{x^2}\\right) & if \$x \\neq 0\$ \\\\
  0 & if \$x=0\$
  \\end{dcases\*}\$\$
  で定めると，$f$は$C^oo$級である．更に任意の非負整数$i$に対して$f^(\( i \)) \( 0 \) = 0$が成り立つので，$f$は解析的ではない．ただし$f^(\( i \))$は$f$の$i$階導関数であり，$f^(\( 0 \)) = f$と理解する．

]
#proof[
  $f$は原点以外で$C^oo$級であるのは明らかなので，非自明な点は任意階数の導関数が原点で0になり，かつ連続になることである．これを$i$に関する帰納法によって示す．まず
  $ f^(\( 1 \)) \( 0 \) = lim_(h arrow.r 0) frac(f \( h \) - f \( 0 \), h) = lim_(h arrow.r 0) h^(- 1) exp \( - h^(- 2) \) = 0 $なので$f^(\( 1 \))$は$bb(R)$上定義されているとわかる．更に$x eq.not 0$において$f^(\( 1 \)) \( x \) = 2 x^(- 3) e^(- x^(- 2))$なので，@指数関数は多項式に優越する
  によって$lim_(x arrow.r 0) f^(\( 1 \)) \( x \) = 0$であるから$f^(\( 1 \))$は連続関数である．$i gt.eq 0$に対して帰納法の仮定より
  $ f^(\( i + 1 \)) \( 0 \) colon.eq lim_(h arrow.r 0) frac(f^(\( i \)) \( h \) - f^(\( i \)) \( 0 \), h) = lim_(h arrow.r 0) frac(f^(\( i \)) \( h \), h) $を得る．$f^(\( i \))$は帰納法の仮定より微分可能であり，$lim_(h arrow.r 0) f^(\( i \)) \( h \) = lim_(h arrow.r 0) h = 0$であるから
  l'Hôpital の定理が使えて，
  $ lim_(h arrow.r 0) frac(f^(\( i \)) \( h \), h) = lim_(h arrow.r 0) frac(f^(\( i + 1 \)) \( h \), 1) $を得るので，この時点で$f^(\( i + 1 \))$が原点で定義されていればそれは連続であるとわかる．更に帰納的に議論を繰り返すことで，
  $ f^(\( i + 1 \)) \( 0 \) colon.eq lim_(h arrow.r 0) frac(f^(\( i \)) \( h \), h) = lim_(h arrow.r 0) frac(f^(\( i - 1 \)) \( h \), h^2) = dots.h = lim_(h arrow.r 0) frac(f^(\( 1 \)) \( h \), h^i) $がわかるが，ふたたび@指数関数は多項式に優越する
  によってこれは0である．

]
#prop[
  関数$psi : bb(R) arrow.r bb(R)$を， \$\$\\psi(x) =   \\begin{dcases\*}
  \\exp\\left(-\\frac{1}{(x-1)^2}\\right) \\cdot \\exp\\left(-\\frac{1}{(x+1)^2}\\right)  & if \$x \\in (-1,1)\$ \\\\
  0 & if \$x \\notin (-1,1)\$
  \\end{dcases\*}\$\$
  で定めると，$psi$は$C^oo$級であり，$\( - 1 \, 1 \)$においては正であってそれ以外では0である．$a in bb(R)^n$および$epsilon > 0$に対して関数$g_(a \, epsilon) : bb(R)^n arrow.r bb(R)$を，
  $ g_(a \, epsilon) \( x \) colon.eq product_(i = 1)^n psi (frac(x^i - a^i, epsilon)) $で定めると，$g_(a \, epsilon)$は開方体$\( a^1 - epsilon \, a^1 + epsilon \) times \( a^2 - epsilon \, a^2 + epsilon \) times dots.h times \( a^n - epsilon \, a^n + epsilon \)$においては正であってそれ以外では0である．

]
<開方体上の隆起関数>
#proof[
  前半の主張は明らか．後半は$\( x^i - a^i \) \/ epsilon in \( - 1 \, 1 \) arrow.l.r.double x^i in \( a^i - epsilon \, a^i + epsilon \)$なのでよい．

]
ここまでで部品として使う関数の構成が終わった．ここからは上記の関数を配置する「$K$上の適切な有限箇所」の選定・構成に移る．

ところでここまで書いたところで，このノートでは$bb(R)^n$の集合の境界などについてろくに議論していなかったことに思い至ったので，一旦議論しておくことにする．

#defi[
  $A subset bb(R)^n$を部分集合とする．$x in bb(R)^n$は以下の3条件のうちいずれか1つのみを充たす．

  + ある$epsilon > 0$に対して$B \( x ; epsilon \) subset A$．

  + ある$epsilon > 0$に対して$B \( x ; epsilon \) subset A^C$．

  + 任意の$epsilon > 0$に対して$B \( x ; epsilon \) sect A eq.not nothing$および$B \( x ; epsilon \) sect A^C eq.not nothing$の両方を充たす．

  \1. を充たす点の集合を$A$の内部といい，$A^compose$で表す．2.
  を充たす点の集合を$A$の外部という．3.
  を充たす点の集合を$A$の境界といい，$partial A$で表す．$overline(A) colon.eq A union partial A$を$A$の閉包という．

]
定義より$A^compose subset A$および$\( A^C \)^compose subset A^C$は直ちに分かるし，$A$の外部とは$\( A^C \)^compose$のことにほかならない．もっと強く次のことがわかる．

#que[
  $A^compose$は$A$を含むような開集合のうちで最大のものである．$partial A$は閉集合である．$overline(A)$は$A$を含むような閉集合の中で最小のものである．

]
#que[
  このあたりの話は「当たり前の話をくどくどとやっているようにしか見えず，実際にはもっとかんたんに議論が済むのではないか？」と思うかもしれない．その疑念をある意味で強める，ある意味ではこの疑念に割り切りをつける助けとなる定理として
  Jordan
  の閉曲線定理というものがある；$C subset bb(R)^2$を単純閉曲線とする．このとき$bb(R)^2 \\ C$は2つの連結成分からなり，ひとつは有界でひとつは非有界である．

  この定理は「平面に輪っかを描くと平面はその内側と外側に分かれる」という極めて当たり前のことを述べただけの定理に思えるが，その主張の素朴さに反して，証明は大変であるらしい．少なくとも私は証明を読んだことがなく，調べるたびに「読む気しないな…」と思ってそっ閉じしている．

]
#defi[
  部分集合$A \, B subset bb(R)^n$に対し，\$d(A,B) \\coloneqq \\inf\\set{\\|x-y\\||x \\in A, y \\in B}\$と定める．ただし\$A = \\set{x}\$（1点集合）の場合は（いちいち波括弧を書くのが煩雑なので）$d \( A \, B \)$のことを$d \( x \, B \)$とも書く．$B$が1点集合の場合も同様の記法を用いる．

]
#prop[
  $C subset bb(R)^n$を閉集合，$K subset bb(R)^n$をコンパクト集合とする．このとき，$C sect K = nothing$であるならば$d \( C \, K \) > 0$．

]
<閉集合とコンパクト集合は充分離れる>
#proof[
  $C sect K = nothing$なので，$K$の各点$x$に対して$d \( x \, C \) eq.colon epsilon_x > 0$である．\$\\set{B(x;\\varepsilon\_x/2)}\_{x \\in K}\$は$K$の開被覆であるから，$K$のコンパクト性によりこの開被覆から有限個を選んだ\$\\set{B(x\_i;\\varepsilon\_{x\_i} /2)}\_{i=1}^n\$がすでに$K$を被覆する．$epsilon_x$の定め方より，$y in B \( x_i ; epsilon_(x_i) \/ 2 \)$であるならば，$d \( y \, C \) gt.eq epsilon_(x_i) \/ 2 > 0$である．従って，任意の$y in K$に対して\$d(y,C) \\geq \\min\_i \\set{\\varepsilon\_{x\_i}/2} \>0\$となる．

]
#que[
  @閉集合とコンパクト集合は充分離れる
  において，$K$のコンパクト性は本質的である．すなわち$C sect K = nothing$を充たす閉集合$C \, K subset bb(R)^n$であって$d \( C \, K \) = 0$となるようなものがある．

]
#block[
  propnonadjustedbump<未調整な隆起関数>
  $K subset A subset bb(R)^n$とし，更に$K$をコンパクト，$A$を開集合とする．このとき，$K subset L subset A$を充たすコンパクト集合$L$であって，$L$の内部に$K$を含むようなものがある．更に$C^oo$級関数$h : bb(R)^n arrow.r bb(R)$であって，$K$上では正，$L$の外部では0であるようなものがある．

]
#proof[
  この証明において，$a in bb(R)^n$を中心とする幅$2 epsilon$の開方体$product_(i = 1)^n \( a^i - epsilon \, a^i + epsilon \)$のことを$R \( a ; epsilon \)$と書くことにする．

  $x in K$を任意に取ると，\$\\set{x}\$はコンパクトで，$A^C colon.eq bb(R)^n \\ A$は閉集合なので，@閉集合とコンパクト集合は充分離れる
  によって$epsilon_x > 0$があり$d (x \, A^C) = 2 epsilon_x$となる．このとき$R \( x ; epsilon_x \) subset A$であり，特に$d (R \( x ; epsilon_x \) \, A^C) = epsilon_x$である．これをすべての$x in K$に対して考えることで，$K$の開被覆\$\\set{ R(x,\\varepsilon\_x) }\_{x \\in K}\$を得る．$K$のコンパクト性により，ここから$K$の有限部分被覆\$\\set{ R(x\_i, \\varepsilon\_i) }\_{i=1}^n\$を取ることができるから取る．$M colon.eq union.big_(i = 1)^n R \( x_i ; epsilon_i \)$と置き，$L colon.eq overline(M)$とする．$L$は有界閉集合なのでコンパクトで，明らかにその内部$M$が$K$を含み，かつ$L subset A$である．

  @開方体上の隆起関数
  に即して関数$g_(x_i \, epsilon_i)$を作り，$h colon.eq sum_(i = 1)^n g_(x_i \, epsilon_i)$と定めると，これは$M$上で正なので$K$上でも正であり，$L$の外部で0である．

]
ここまでで関数の概形の構成が済んだので，あとは値を調整すれば良い．

#lem[
  $C^oo$級関数$k_epsilon : bb(R) arrow.r bb(R)$であって，$x gt.eq epsilon$ならば$k_epsilon \( x \) = 1$，$x lt.eq 0$ならば$k_epsilon \( x \) = 0$を充たすものがある．

]
#proof[
  $ k_epsilon \( x \) colon.eq frac(integral_0^x g_(epsilon \/ 2 \, epsilon \/ 2) \( t \) d t, integral_0^oo g_(epsilon \/ 2 \, epsilon \/ 2) \( t \) d t) $とせよ#footnote[要するに$g_(epsilon \/ 2 \, epsilon \/ 2)$を確率密度関数に持つような確率分布関数を作るのを真似ればよい，と言っている．];．

]
ここまで来れば@隆起関数の存在 を示すのは難しくない．

#proof[
  $h : bb(R)^n arrow.r bb(R)$を，@未調整な隆起関数
  で構成した関数とすると，$h$の$K$への制限は正値であり，かつ$K$はコンパクトなので$h$は$K$上最小値を持つからそれを$epsilon > 0$とする．$k_epsilon compose h$がそのような関数である．

]
== 逆関数定理
<逆関数定理>
我々は一変数の解析学において次のことを学んでいる；

#prop[
  $C^1$級関数$f : bb(R) arrow.r bb(R)$が$a in bb(R)$において$f' \( a \) eq.not 0$を充たしているならば，
  ある$a$を含む開集合$U$があり，$f$は$U$上で単射であって，$f \( U \)$上定義される$f$の逆写像$g : f \( U \) arrow.r U$は$C^1$級である．

]
#proof[
  $f$は$C^1$級すなわち$f'$が連続であり，$f' \( a \) eq.not 0$なので，$a$を含む開集合$U$が存在して，$x in U$ならば$f' \( x \) eq.not 0$である．一般性を失わず$f' \( a \) > 0$と仮定してよい（$f' \( a \) < 0$ならば$- f$に対して同様の考察をすれば良い）ので，特に$x in U$ならば$f' \( x \) > 0$であるとしてよい．微分の定義より$f$は$U$上で狭義単調増加であるとわかるから，$f$の$V$への制限$f \|_U : U arrow.r f \( U \)$は単射であるので，逆写像$g : f \( U \) arrow.r U$がある．

  $g$が$f \( U \)$の各点で微分可能であることを示すため，$f \( U \)$の二点$w \, w + h in f \( U \)$をとる．するとある$v \, v + k in U$があって$w = f \( v \)$，$w + h = f \( v + k \)$である．したがって
  $ lim_(h arrow.r 0) frac(g \( w + h \) - g \( w \), h) = lim_(h arrow.r 0) frac(g \( f \( v + k \) \) - g \( f \( v \) \), h) = lim_(h arrow.r 0) frac(v + k - v, f \( v + k \) - f \( v \)) = lim_(h arrow.r 0) frac(k, f \( v + k \) - f \( v \)) $を得る．$f$の連続性より$h arrow.r 0$と$k arrow.r 0$は同値なので，この極限は結局$1 \/ f' \( v \)$に等しい．$g$が$C^1$級であることはこのことから直ちに従う．

]
#defi[
  $f : A arrow.r B$が$C^r$級微分同相であるとは，$f$が$C^r$級であり，$f$の逆写像$g : B arrow.r A$が存在して更に$C^r$級であることをいう．この言葉を用いれば，上述の定理の主張は「$C^1$級関数$f$の微分が$a$において0でないならば，$f$は$a$の充分近くで$C^1$級微分同相となる」とまとめることができる．

]
この証明のあらましは，$C^1$級関数の微分がある点で0でないならば，その点の充分近くでもやはり0ではなく，したがって値が常に変化し続けるから，局所的に逆写像を持つ，というように述べることができよう．この「値が常に変化し続ける」とは，「微分が非零の微小変動を零につぶさない」と述べることができる．これはすなわち微分を線型写像として見た時に，それが可逆であるということである．この観察を高次元の場合に拡張して得られるのが，逆関数定理である．

#thm[
  $f : bb(R)^n arrow.r bb(R)^n$が$a in bb(R)^n$において$C^1$級であるとし，更に$det J_f \( a \) eq.not 0$であると仮定する．このとき，$a$を含む開集合$U subset bb(R)^n$があり，$f \|_U : U arrow.r f \( U \)$は$C^1$級微分同相である．

]
<逆関数定理>
証明にはいくつかの方法がある．ここでは Spivak とはやり方を変えて，
Banach
の縮小写像の原理に依る証明を与えることにする．やり方を変える強い理由があるわけではないが，単に本と違ったことをやってみたいというだけである．まず
Banach の縮小写像の原理を述べる．

#defi[
  $f : bb(R)^n arrow.r bb(R)^n$が縮小的である，あるいは縮小写像であるとは，ある$0 lt.eq mu < 1$が存在して，任意の$x \, y in bb(R)^n$に対して$parallel f \( x \) - f \( y \) parallel lt.eq mu parallel x - y parallel$が成り立つことをいう．

]
#que[
  $f$は連続写像である．

]
#thm[
  $D subset bb(R)^n$を閉集合とし，$f : D arrow.r D$を縮小写像とする．このとき，$D$に$f$の不動点がただひとつ存在する．すなわち，$f \( y \) = y$を充たす$x in D$がただひとつ存在する．更に，任意の$x in D$に対し，$lim_(k arrow.r oo) f^k \( x \) = y$が成り立つ．ただし自然数$k$に対して，$f^1 \( x \) colon.eq f \( x \)$，$f^k \( x \) colon.eq f \( f^(k - 1) \( x \) \)$によって帰納的に定める．

]
#proof[
  $f$は縮小的なので，ある$0 lt.eq mu < 1$が存在して，任意の$x \, y in bb(R)^n$に対して$parallel f \( x \) - f \( y \) parallel lt.eq mu parallel x - y parallel$が成り立つ．

  $y_0 in D$を任意に取り，点列\$\\set{y\_i}\_{i=1}^\\infty\$を$y_i colon.eq f^i \( y_0 \)$によって定める．すると任意の$k in bb(N)$に対して$parallel y_(k + 1) - y_k parallel lt.eq mu^k parallel y_1 - y_0 parallel$が成り立つから，$m > n$を充たすような$m \, n in bb(N)$に対して
  $ parallel y_m - y_n parallel & lt.eq parallel y_m - y_(m - 1) parallel + parallel y_(m - 1) - y_(m - 2) parallel + dots.h + parallel y_(n + 1) - y_n parallel\
  & lt.eq \( mu^(m - 1) + mu^(m - 2) + dots.h mu^n \) parallel y_1 - y_0 parallel = mu^n frac(1 - mu^(m - n), 1 - mu) parallel y_1 - y_0 parallel . $最右辺は$m \, n arrow.r oo$で0に収束するので，\$\\set{y\_i}\$は$bb(R)^n$の
  Cauchy
  列である．したがって収束先$y colon.eq lim_(i arrow.r oo) y_i$が$bb(R)^n$に存在するが，$D$は閉であって\$\\set{y\_i}\$は$D$の点列なので，$y in D$である．更に$f$の連続性より$y = lim_(i arrow.r oo) y_i = lim_(i arrow.r oo) f \( y_(i - 1) \) = f \( lim_(i arrow.r oo) y_i \) = f \( y \)$であるから$y$は$f$の不動点になっている．更に$z$も$f$の不動点であったとすると，$parallel y - z parallel = parallel f \( y \) - f \( z \) parallel lt.eq mu parallel y - z parallel$を得るが，$mu < 1$なので$parallel y - z parallel = 0$すなわち$y = z$である．

]
#que[
  $bb(R)$の Cauchy
  列が収束列であることは実数の完備性（の同値な言い換えのひとつ）である．$bb(R)^n$の
  Cauchy
  列が収束列であることは，実数の完備性および「$bb(R)^n$の点列が収束することと，各成分が$bb(R)$の点列として収束することは同値」という事実から従う．

]
#que[
  $D subset bb(R)^n$が閉で，$D$内の点列\$\\set{y\_i}\$が収束するならばその収束先は$D$に属する．

]
次いで証明に入る前にひとつ補題を用意しておく．微分は関数の線型近似であることはすでに述べたが，その近似についてより定量的な評価を与えておく必要がある．

#lem[
  $D subset bb(R)^n$を開集合とし，$f : bb(R)^n arrow.r bb(R)^n$が$D$で微分可能であると仮定する．更に任意の$a in D$に対して$J_f \( a \)$の各成分の絶対値は$M$を超えないと仮定する．このとき，任意の$a \, a + h in D$に対して$parallel f \( a + h \) - f \( a \) parallel lt.eq n^2 M parallel h parallel$が成り立つ．

]
<微分の定量評価>
#proof[
  各成分関数$f^i$に対して，$f^i \( a + h \) - f^i \( a \)$を，
  $ f^i \( a + h \) - f^i \( a \) & = f^i \( a^1 + h^1 \, a^2 \, dots.h \, a^n \) - f^i \( a^1 \, a^2 \, dots.h \, a^n \)\
  & + f^i \( a^1 + h^1 \, a^2 + h^2 \, dots.h \, a^n \) - f^i \( a^1 + h^1 \, a^2 \, dots.h \, a^n \)\
  & + dots.h.c\
  & + f^i \( a^1 + h^1 \, a^2 + h^2 \, dots.h \, a^(n - 1) + h^(n - 1) \, a^n + h^n \) - f^i \( a^1 + h^1 \, a^2 + h^2 \, dots.h \, a^(n - 1) + h^(n - 1) \, a^n \) $のように表示しておく．$f^i$は各変数に関して偏微分可能なので，平均値の定理により
  $ \| f^i \( a^1 + h^1 \, a^2 \, dots.h \, a^n \) - f^i \( a^1 \, a^2 \, dots.h \, a^n \) \| lt.eq h^1 M $が成り立つ．したがって
  $ \| f^i \( a + h \) - f^i \( a \) \| lt.eq \( h^1 + h^2 + dots.h + h^n \) M lt.eq n parallel h parallel M $である．ふたたびノルムの三角不等式より$parallel f \( a + h \) - f \( a \) parallel lt.eq sum \| f^i \( a + h \) - f^i \( a \) \|$が得られるから結論が従う．

]
以上で逆関数定理を示す準備が整った．

#proof[
  まず座標軸を平行移動することで$a = 0$および$f \( a \) = 0$と仮定して構わない．更に$lambda : bb(R)^n arrow.r bb(R)^n$を可逆線型写像とするとき，$lambda^(- 1) compose f$に関して逆関数定理が成り立てばあきらかに$f$に対しても成り立つとわかる上，仮定より$d f_a$は可逆なので，必要ならば$\( d f_a \)^(- 1)$倍した写像を考えることで$d f_a = upright(i d)_(bb(R)^n)$すなわち$J_f \( a \) = I_n$と仮定してもやはり一般性を失わない．ただし$I_n$は$n times n$単位行列．なのでこれらの仮定を置いて証明を進める．

  $f$は$C^1$級なので，ある半径$delta$の閉球$D = overline(B \( 0\; delta \))$が存在して，任意の$x in D$および$1 lt.eq i \, j lt.eq n$に対して$parallel partial_j f^i \( x \) - partial_j f^i \( 0 \) parallel lt.eq 1 \/ 2 n^2$となるようにできる．このとき，関数$w : D arrow.r D$を$w \( x \) colon.eq f \( x \) - x$によって定めると，$J_w \( x \) = J_f \( x \) - I_n = \( partial_j f^i \( x \) - partial_j f^i \( 0 \) \)$なので，@微分の定量評価
  によって$parallel w \( x + h \) - w \( x \) parallel lt.eq parallel h parallel \/ 2$すなわち$parallel f \( x + h \) - f \( x \) - h parallel lt.eq parallel h parallel \/ 2$を得る．

  $f \( a \) = 0$を含む開集合として$V = B \( 0 ; delta \/ 2 \)$を取る．ここで，任意の$y in V$に対して$f \( x \) = y$を充たす$x in D$が一意的に存在すること，すなわち単射$g : V arrow.r D$であって$f compose g = upright(i d)$となるものが存在することを示したい．これが示せれば$f$の$g \( V \)$への制限が可逆であるとわかる．$g$は次のようにして構成する；関数$u_y : D arrow.r bb(R)^n$を$u_y \( x \) = x + \( y - f \( x \) \)$によって定め，$u_y$の値域が実際には$D$であること，および$u_y : D arrow.r D$が縮小的であることを示せば，Banach
  の縮小写像の原理によって$u_y$は唯一の不動点を持つとわかるので，それを$g \( y \)$とすればよい．

  $u_y$の値域が$D$であることは，先程得た評価$parallel f \( x + h \) - f \( x \) - h parallel lt.eq parallel h parallel \/ 2$において$x = 0$とすることで$parallel f \( h \) - h parallel lt.eq parallel h parallel \/ 2 lt.eq delta \/ 2$が従うので，$parallel u_y \( x \) parallel lt.eq parallel y parallel + parallel x - f \( x \) parallel < delta \/ 2 + delta \/ 2 = delta$となるからよい．$parallel u_y \( x + h \) - u_y \( x \) parallel = parallel h - f \( x + h \) - f \( x \) parallel lt.eq parallel h parallel \/ 2$となるから縮小的であることもわかる．更にこの時点で$u_y$の値域は実際には$D^compose$であるとわかったので，開集合$U colon.eq g \( V \) = D^compose$へ$f$を制限したものは可逆であることが従う．

  $g$の連続性を示すため，相異なる$y \, y + k in V$を取ると，$f \( x \) = y$および$f \( x + h \) = y + k$を充たすような$x \, x + h in D^compose$が一意的に存在する．したがって$parallel k - h parallel lt.eq parallel y + k - y - h parallel lt.eq parallel h parallel \/ 2$を得るが，$parallel h parallel - parallel k parallel lt.eq parallel k - h parallel$であるから結局$parallel h parallel lt.eq 2 parallel k parallel$を得る．したがって$g$は連続である．

  $g$の微分可能性を示す．$x \, x + h in D^compose$および$y \, y + k in V$を連続性の議論において用いた点たちとし，$f \( x + h \) - f \( x \) - J_f \( x \) h$を考える．この量は$y + k - y - J_f \( x \) \( g \( y + k \) - g \( y \) \) = k - J_f \( x \) \( g \( y + k \) - g \( y \) \)$と書き直せる．線型写像$h mapsto \( J_f \( x \) - I_n \) h$に対して@微分の定量評価
  を適用することで$parallel J_f \( x \) h - h parallel lt.eq parallel h parallel \/ 2$を得るので，特に$parallel h parallel - parallel J_f \( x \) h parallel lt.eq parallel h parallel \/ 2$すなわち$parallel J_f \( x \) h parallel gt.eq parallel h parallel \/ 2$を得るから$J_f \( x \)$は正則行列である．したがって適当な実数$M > 0$があって
  $ frac(parallel g \( y + k \) - g \( y \) - J_f \( x \)^(- 1) k parallel, parallel k parallel) & = frac(parallel g \( y + k \) - g \( y \) - J_f \( x \)^(- 1) k parallel, parallel h parallel) frac(parallel h parallel, parallel k parallel)\
  & lt.eq 2 frac(parallel g \( y + k \) - g \( y \) - J_f \( x \)^(- 1) k parallel, parallel h parallel)\
  & = 2 frac(parallel h - J_f \( x \)^(- 1) \( f \( x + h \) - f \( x \) \) parallel, parallel h parallel)\
  & lt.eq 2 M frac(parallel J_f \( x \) h - f \( x + h \) - f \( x \) parallel, parallel h parallel) $を得るが，最右辺は$h arrow.r 0$で0に収束するし，$g$の連続性より$h arrow.r 0$と$k arrow.r 0$は同値であるから$g$は微分可能である．

  ここまでの議論で$J_g \( f \( x \) \) = J_f \( x \)^(- 1)$がわかっているので，Cramer
  の公式より$g$は$C^1$級である．

]
#que[
  逆関数定理の主張は Banach
  空間までほぼそのまま拡張できるらしく，証明もここに挙げたように縮小写像の原理に依ればよいらしい．無限次元に一般化する場合，逆作用素の存在がデリケートな問題になるらしい．

]
#que[
  Spivak
  では逆写像の構成にあたってまず$v_y \( x \) colon.eq parallel y - f \( x \) parallel^2$という関数を考えている．これはコンパクト集合$D$上で最小値を持つ上，実際には$D$の内部で最小値をとることがわかる．それゆえ最小値を実現する点で微分が消えているはずなので$y = f \( x \)$を充たすような$x$の存在が言える，という議論をしている．一意性は$g$の連続性において現れた議論をすこし変形することで示している．これはこれで味があってよいと思う反面，$D$がコンパクトという性質，すなわち有限次元であることをクリティカルに使っている．

]
#que[
  それゆえ，Spivak の方針そのままでは Banach
  空間への拡張はつらいと思われる．Banach 空間での逆関数定理の定式化には
  Fréchet
  微分が現れる以上，ノルム位相を避けて通ることはできないが，ノルム位相に関して閉球は一般にコンパクトにならない．しかしながら閉球がコンパクトになるような弱い位相を併せて考えることで示せたりしないだろうか？

]
#que[
  証明にあらわれた$u_y : D arrow.r D$が不動点を持つこと自体は Brouwer
  の不動点定理からも従う．Brouwer
  の不動点定理では不動点の一意性までは示せないが，Spivak
  での一意性の証明と同じようなやり方が通ると思う（のだが，検証はしていない）．

]
#que[
  ちなみに Brouwer
  の不動点定理の証明はいくつか方法があるらしいが，多分縮小写像の原理を示すよりは手間だと思うのでやめた．すくなくともこのためだけにホモロジー群を導入するのは大変なのでやる気がしない．組合せ論的に示す方法もあるらしく，しかも比較的初等的に示せるという話を聞いたことはあるが，私はちゃんと勉強したことはない．他にも不動点定理とよばれるものはたくさんあるし，応用もまたたくさんあるらしい．

]
#que[
  ところで逆関数定理の応用はあるのかということが気になる．ので，探してみたのだが，この時点で書けるようなよい例が見つからなかった．いい応用を見つけたらその話について勉強して書きたいのでおしえてください．

]
#que[
  この証明においては$f$が$C^1$級であることをクリティカルに使った．ところが，Terrence
  Tao
  氏がブログに書いている#footnote[#link("https://terrytao.wordpress.com/2011/09/12/the-inverse-function-theorem-for-everywhere-differentiable-maps/");];ところによると，この仮定は落とせる（すなわち，$f$がある点$a$で微分可能かつ微分が可逆であるならば，$f \( a \)$のまわりで定義された微分可能な逆写像が存在する）らしい．

]
== 陰関数定理と未定乗数法
<陰関数定理と未定乗数法>
逆関数定理の兄弟分とでも言うべき定理が陰関数定理である．言葉による大雑把な説明をすると，いくつかの変数によって陰的に表される束縛条件があるときに，その束縛条件を書き表す陽的な方程式ないしは関数の存在を主張する定理である．

#exm[
  $f : bb(R)^2 arrow.r bb(R)$を$f \( x \, y \) colon.eq x^2 + y^2$で定め，単位円周\$S^1 \\coloneqq \\set{(x,y) \\in \\mathbb{R}^2 | f(x,y) = 1}\$を考える．このとき，任意の$\( x \, y \) in S^1$に対して$y = g \( x \)$を充たすような関数$g : bb(R) arrow.r bb(R)$は存在しない．しかしながら「ある点の充分近くで考えれば」このような関数を見つけることができる場合がある．例えば$y > 0$を充たすような$\( x \, y \) in S^1$に対しては$y = sqrt(1 - x^2)$と書ける．

]
この現象を高次元の場合も含めて記述することが，本項の目的である．

#thm[
  $m \, n$を自然数とし，$f : bb(R)^(m + n) arrow.r bb(R)^n$を$C^1$級関数とする．ある$a in bb(R)^m$および$b in bb(R)^n$に対して$f \( a \, b \) = 0$であり，$n times n$行列$M colon.eq \( partial_(m + j) f^i \( a \, b \) \)$が正則であると仮定する．このとき，$a$を含む開集合$A subset bb(R)^m$および$b$を含む開集合$B subset bb(R)^n$ならびに$C^1$級関数$g : A arrow.r B$があり，$A$上で$f \( x \, g \( x \) \) = 0$を充たす．更に$g$は次の意味で一意的である；任意の$x in A$に対して$f \( x \, h \( x \) \) = 0$を充たす関数$h : A arrow.r B$があれば，$A$上で$g = h$．

]
#proof[
  関数$F : bb(R)^(m + n) arrow.r bb(R)^(m + n)$を，$x in bb(R)^m$および$y in bb(R)^n$に対して$F \( x \, y \) colon.eq \( x \, f \( x \, y \) \)$によって定めるとこれは$C^1 級$である．更に$F$の$\( a \, b \) in bb(R)^(m + n)$における
  Jacobi
  行列は（左上の$m times m$ブロックが単位行列に，右上の$m times n$ブロックがゼロ行列に，右下の$n times n$ブロックが$M$に一致するので）正則である．したがって逆関数定理より$\( a \, f \( a \, b \) \)$を含む開集合$A' times B subset bb(R)^m times bb(R)^n$上定義された関数$G : A' times B arrow.r bb(R)^(m + n)$があり，$F compose G = upright(i d)$である．$F$の関数の形から，関数$k : bb(R)^(m + n) arrow.r bb(R)^n$があって$G \( x \, y \) = \( x \, k \( x \, y \) \)$と書ける．関数$pi$を$pi : bb(R)^m times bb(R)^n in.rev \( x \, y \) mapsto y in bb(R)^n$で定めると，$f = pi compose F$が成り立つ．したがって，$x in A'$かつ$k \( x \, y \) in B$ならば
  $ f \( x \, k \( x \, y \) \) = \( f compose G \) \( x \, y \) = \( pi compose F compose G \) \( x \, y \) = pi \( x \, y \) = y $である．関数$g : A' arrow.r bb(R)^n$を$g \( x \) colon.eq k \( x \, 0 \)$で定めれば，$\( a \, b \) = G \( a \, 0 \) = \( a \, k \( a \, 0 \) \) = \( a \, g \( a \) \)$すなわち$g \( a \) = b$なので，充分小さな開集合$A subset A'$をとることで$g \( A \) subset B$とできる．このとき$x in A$ならば$g \( x \) in B$なので，特に$f \( x \, g \( x \) \) = 0$である．$k = pi compose G$から$k$が$C^1$級であるとわかるので$g$もそうである．

  $h : A arrow.r B$が任意の$x in A$に対して$f \( x \, h \( x \) \) = 0$を充たすと仮定する．このとき，$F \( x \, h \( x \) \) = \( x \, f \( x \, h \( x \) \) \) = \( x \, 0 \) = \( x \, f \( x \, g \( x \) \) \) = F \( x \, g \( x \) \)$となるが，$F$は$A times B$において単射なので$g \( x \) = h \( x \)$である．

]
陰関数定理は次のように述べ直すこともできる．

#thm[
  $n \, p$を$p lt.eq n$を充たすような自然数とし，$a in bb(R)^n$とする．$f : bb(R)^n arrow.r bb(R)^p$が$C^1$級であって，更に$f \( a \) = 0$かつ$f$の$a in bb(R)^n$における
  Jacobi
  行列の階数は$p$であったと仮定する．このとき，$a$を含む開集合$U$上の$C^1$級微分同相$F : U arrow.r bb(R)^n$であって，$f compose F^(- 1) \( x^1 \, dots.h \, x^n \) = \( x^(n - p + 1) \, dots.h \, x^n \)$を充たすものがある．

]
<陰関数定理の言い換え>
#proof[
  $f : bb(R)^n arrow.r bb(R)^p$を$f : bb(R)^(n - p) times bb(R)^p arrow.r bb(R)^p$と考える．$p times p$行列$\( partial_(n - p + j) f^i \( a \) \)$の階数が$p$ならば，逆関数定理より$F : bb(R)^(n - p) times bb(R)^p in.rev \( x \, y \) mapsto \( x \, f \( x \, y \) \) in bb(R)^n$は$a$を含む開集合$U$上で$C^1$級微分同相である．更に$F$の逆写像を$G : F \( U \) arrow.r U$と書けば，$f compose G \( x^1 \, x^2 \, dots.h \, x^(n - p) \, x^(n - p + 1) \, dots.h \, x^n \) = \( x^(n - p + 1) \, dots.h \, x^n \)$である．

  $p times p$行列$\( partial_(n - p + j) f^i \( a \) \)$の階数が$p$未満であるときも，$1 lt.eq j_1 < j_2 < dots.h < j_p lt.eq n$を適切に選べば$\( partial_(j_i) f^i \( a \) \)$の階数は$p$になる．$g : bb(R)^n arrow.r bb(R)^n$を，「$x^(j_i)$たちが右側にまとまるように並べ替える」写像とすると，$f compose g$に対しては前段の議論が使えて，$a$を含む開集合$U$上の$C^1$級微分同相$k : U arrow.r bb(R)^n$があって$f compose g compose k^(- 1) \( x^1 \, x^2 \, dots.h \, x^(n - p) \, x^(n - p + 1) \, dots.h \, x^n \) = \( x^(n - p + 1) \, dots.h \, x^n \)$となる．$F colon.eq k compose g^(- 1)$とすればよい．

]
この述べかえは，のちのち微分可能多様体の判定法として使えることが明らかになるが，直ちに分かる応用をひとつ紹介しておこう；制限付き極値問題である．

#prop[
  $n \, p$を$p lt.eq n$を充たすような自然数，$A subset bb(R)^n$を開集合，$g : A arrow.r bb(R)^p$を$C^1$級関数とし，任意の$a in A$に対して$J_g \( a \)$の階数は$p$であったとする．更に$f : g^(- 1) \( 0 \) arrow.r bb(R)$を微分可能な関数とし，$a in bb(R)^n$において$f$は極値を取ると仮定する．このとき，$p$個の実数$lambda_1 \, dots.h \, lambda_p$が存在して，$1 lt.eq j lt.eq n$に対して
  $ partial_j f \( a \) = sum_(i = 1)^p lambda_i partial_j g^i \( a \) $を充たす．

]
#proof[
  証明を2段階に分割する．まず$g \( x \) = \( x^(n - p + 1) \, dots.h \, x^n \)$のときを考える．このとき，$i \, = 1 \, 2 \, dots.h \, p$および$j = 1 \, 2 \, dots.h \, n$に対して
  \$\$\\partial\_j g^i(a) = \\begin{dcases\*}
  1 & if \$j = n-p+i\$ \\\\
  0 & otherwise
  \\end{dcases\*}\$\$ である．
  $f$を$g^(- 1) \( 0 \)$に制限するというのは$x^(n - p + 1) = x^(n - p + 2) = x^n = 0$に固定して$n - p$変数の関数だと見なすことと同値である．したがって$f$が$a in bb(R)^n$において極値を取るならば，$partial_1 f \( a \) = partial_2 f \( a \) = dots.h partial_(n - p) f \( a \) = 0$である．したがって$lambda_i = partial_(n - p + i) f \( a \)$とすれば命題の主張が成り立つ．一般の$g$に対しては，陰関数定理によって$a$を含む開集合$U$で定義された$C^1$級微分同相$F$があって$g compose F^(- 1) = \( x^(n - p + 1) \, dots.h \, x^n \)$となるから，$F$の逆写像を$G$と書けば，前段の議論により実数$lambda_1 \, dots.h \, lambda_p$があって
  $ partial_j \( f compose G \) \( F \( a \) \) = sum_(i = 1)^p lambda_i partial_j \( g compose G \)^i \( F \( a \) \) = sum_(i = 1)^p lambda_i partial_j \( g^i compose G \) \( F \( a \) \) $となる．@実用的な方の合成則
  より
  $
    partial_j \( f compose G \) \( F \( a \) \) = sum_(k = 1)^n partial_k f \( G \( F \( a \) \) \) dot.op partial_j G^k \( F \( a \) \) = sum_(k = 1)^n partial_k f \( a \) dot.op partial_j G^k \( F \( a \) \) \,
  $
  $ sum_(i = 1)^p lambda_i partial_j \( g^i compose G \) \( F \( a \) \) = sum_(i = 1)^p lambda_i sum_(k = 1)^n partial_k g^i \( G \( F \( a \) \) \) dot.op partial_j G^k \( F \( a \) \) = sum_(i = 1)^p lambda_i sum_(k = 1)^n partial_k g^i \( a \) dot.op partial_j G^k \( F \( a \) \) $を得るから，
  $ sum_(k = 1)^n partial_k f \( a \) dot.op partial_j G^k \( F \( a \) \) = sum_(i = 1)^p lambda_i sum_(k = 1)^n partial_k g^i \( a \) dot.op partial_j G^k \( F \( a \) \) $が従う．この式を行列演算の形で書いた上で$partial_j G^k \( F \( a \) \)$の逆行列を掛ければ結論を得る（$G$が微分同相なので，$partial_j G^k \( F \( a \) \)$は正則行列である）．

]
以下しばらく$p = 1$とし，$nabla f colon.eq \( partial_1 f \, dots.h \, partial_n f \)$と置く．Lagrange
の未定乗数法の主張は，$f$を$g = 0$に制限した関数の臨界点は$nabla \( f - lambda g \) = 0$を充たす，ということを主張している．したがって$partial_i \( f - lambda g \) = 0$および$g = 0$という$n + 1$本の連立方程式が立つので，$x^1 \, x^2 dots.h \, x^n \, lambda$に関して解くことができるから，実際にやればよい．ということでいくつか例を見てみることにしよう．

#exm[
  ここでは$bb(R)^n$の座標として$p^1 \, p^2 \, dots.h \, p^n$を使うことにする．
  \$\$\\Delta\_n \\coloneqq \\set{ p \\in \\mathbb{R}^n | \\sum\_{i=1}^n p^i = 1, p^1, p^2, \\dots, p^n \\geq 0 }\$\$
  を標準$n$-単体という．$p in Delta_n$に対して$H \( p \) colon.eq - sum_(i = 1)^n p^i log p^i$を$p$のエントロピーと呼ぶ．ただし$0 log 0 = 0$と定める．いくつかの状況について，エントロピーを最大化する$p in bb(R)^n$を求めてみよう．エントロピーは凹関数なので，極値を達成する点があればその点で最大値を達成することに注意しておく．

  - $p in Delta_n$以外に特に制約のない場合．$L \( p \, lambda \) colon.eq H \( p \) - lambda \( sum_(i = 1)^n p^i - 1 \)$を$p^i$で微分して0と置いた式$partial_i L \( p \, lambda \) = 0$を考えることで，$p^i = exp \( - lambda + 1 \)$を得る．すなわち$p^1 = p^2 = dots.h = p^n = 1 \/ n$である．

  - $k = 1 \, 2 \, dots.h \, m$に対し，\$f\_k \\colon \\set{1,\\dots,n} \\to \\mathbb{R}\$を関数とする．$sum_(i = 1)^n f_k \( i \) p^i$を，$f_k$の$p in Delta_n$における期待値という．ここでは，$f_k$たちの期待値に制約がついている状況を考える．すなわち，$U_1 \, U_2 \, dots.h \, U_m$を実数として，$sum_(i = 1)^n f_k \( i \) p^i = U_k$という制約のもとでエントロピーを最大化する$p in Delta_n$を求めることを考える．もちろん$f_k$たちの具体的な形がわからないので，解析解の計算はできないが，$f_k$たちの具体形に依らないところまでは計算を進めてみることにしよう．
    $ L \( p \, lambda^0 \, lambda^1 \, dots.h \, lambda^m \) colon.eq H \( p \) - \( lambda^0 - 1 \) (sum_(i = 1)^n p^i - 1) - sum_(k = 1)^m lambda^k (sum_(i = 1)^n f_k \( i \) p^i - U_k) $と置く（$lambda^0$を定数シフトして定義しているのは，後のノーテーションをきれいにするためだけの便宜である）．これを$p^i$で微分して0と置いた式は
    $ partial_i L \( p \, lambda \) = - log p_i - 1 - \( lambda^0 - 1 \) - sum_(k = 1)^m lambda^k f_k \( i \) = 0 $すなわち
    $ p_i = exp (- lambda^0 - sum_(k = 1)^m lambda^k f_k \( i \)) $を得る．他の制約式にこの表式を代入してみる#footnote[未定乗数法でなにか問題を解く時に一番難しい，ないし時間がかかるのはここから先ではないだろうか？未定乗数ならびにもともとの引数に関する何本かの方程式を具体的に与えられて，それに対してどのように変形すればよいかがよくわからない，ということが私はよくある．このような状況に対して一般論ができることは殆どなく，ここから先で物を言うのは高校数学や算数の計算をちゃんと遂行できる腕力だと思う．「理論は落ち着いて考えればわかることしか書いてない」という言葉を聞いたことがあるが，言い得て妙だと思う（と同時に，学部生のときの私にこの言葉を聞かせても聞く耳を持たなかっただろう）．];．まず
    $ 1 = sum_(i = 1)^n p^i = e^(- lambda^0) sum_(i = 1)^n exp (- sum_(k = 1)^m lambda^k f_k \( i \)) $を得る．ここに現れた
    $ Z \( lambda \) = Z \( lambda^1 \, lambda^2 \, dots.h \, dots.h \, lambda^m \) colon.eq sum_(i = 1)^n exp (- sum_(k = 1)^m lambda^k f_k \( i \)) $を分配関数と呼ぶ．$lambda^0 = log Z \( lambda \)$なので，$lambda^0$の計算は分配計算の計算に帰着する．分配関数を計算するために期待値に対する制約式を検討すると，
    $ U_k = sum_(i = 1)^n f_k \( i \) p^i = sum_(i = 1)^n f_k \( i \) p^i = sum_(i = 1)^n f_k \( i \) frac(e^(- sum_k lambda^k f_k \( i \)), Z \( lambda \)) = - frac(partial_i Z \( lambda \), Z \( lambda \)) = - partial_i log Z \( lambda \) $を得る．これは$lambda^k$たちに関する$m$本の方程式になるので，（実際の計算の面倒具合はともかくとして，また$f_k$たちが互いに相異なるなど，いくつか付加的な条件は必要であると思われるが）$lambda^k$たちを決定するに充分な本数の方程式である．

]
#dig[
  $p in Delta_n$は，実際には有限標本空間上の確率分布というほうが普通であるが，そのことを知らないふりをして書いてある．次節は測度論に基づいて積分を定義するが，気が向いたら，例として確率分布や確率測度の話を入れてもいいかもしれない．

]
#exm[
  やや脱線となるが，前例で現れたエントロピーに対する考察を続けよう．前例の議論を反芻すると，関数$f_k$たちの期待値が取る値を$U_1 \, dots.h \, U_m$に制約すれば，Lagrange
  の未定乗数法によって制約下でのエントロピーの最大値が求められた．これは，
  $ S \( U \) = S \( U_1 \, U_2 \, dots.h \, U_n \) colon.eq max_p H \( p \) = max_(p \, lambda^0 \, lambda) [H \( p \) - \( lambda^0 - 1 \) (sum_(i = 1)^n p^i - 1) - sum_(k = 1)^m lambda^k (sum_(i = 1)^n f_k \( i \) p^i - U_k)] $なる関数$S$がある，と言い換えることができる．ただし$max$は$p in Delta_n$ならびに期待値に関する制約を満たすような範囲で取る．最大値を達成する点では$p_i = exp (- lambda^0 - sum_(k = 1)^m lambda^k f_k \( i \))$であることがわかっているので，これを代入して計算を続けると
  $ S \( U \) & = max_(p \, lambda^0 \, lambda) H \( p \) \
            & = max_(p \, lambda^0 \, lambda) [- sum_(i = 1)^n p^i (- lambda^0 - sum_(k = 1)^m lambda^k f_k \( i \))] \
            & = max_(p \, lambda^0 \, lambda) [lambda^0 + sum_(k = 1)^m lambda^k sum_(i = 1)^n f_k \( i \) p^i] \
            & = max_lambda [log Z \( lambda \) + sum_(k = 1)^m lambda^k U_k] $を得る．一般に，凸関数$f : bb(R)^n arrow.r bb(R)$に対して$f^(\*) \( p \) colon.eq max_x [angle.l x \, p angle.r - f \( x \)]$を$f$の
  Legendre
  変換という．この言葉を用いれば，「$S$は分配関数$- log Z \( lambda \)$の
  Legendre
  変換である」と言い換えることができる．この$S$は熱力学的エントロピーと呼ばれる．

  さて，$S$の表式には$lambda^k$たちが現れているが，実際には$S$は$U_k$の関数なので，$H \( p \)$の制約付き極値における$lambda^k$は$U_k$の関数として書ける#footnote[本当は記号を分けて$lambda_(\*)^k \( U_1 \, dots.h \, U_n \)$などと書くべきだろうが，記号を分けないほうが一般的であるように思う．];．ここでは更に$lambda^k$たちが$U_k$に関して微分可能であると仮定してしまうことにする．すると@実用的な方の合成則
  によって
  $ partial_i S \( U \) = sum_(k = 1)^m [partial_k log Z \( lambda \( U \) \) dot.op partial_i lambda^k \( U \)] + sum_(k = 1)^m [U_k partial_i lambda^k \( U \)] + lambda^k \( U \) = lambda^k \( U \) $を得る．したがって未定乗数は熱力学的エントロピーの導関数として現れることがわかった．いくつかの物理学的設定のもとでは，$lambda^k$は「示量変数$U_k$に共役な示強変数」と呼ばれる．また物理学においては熱力学的エントロピー$S$の引数に「エネルギー」と呼ばれる引数$U$を含むように要請することが多い．この$U$に共役な示強変数には「逆温度」という名前がついている；もちろん，適切な設定ならびに考察のもとで，この量と我々が見知っている温度との間に深い関わりを見いだせるだろうが，このノートで書くのはここまでにしておく．

]
#que[
  ここでは$lambda^k$たちが$U_k$に関して微分可能であると仮定してしまったが，この仮定はどれくらい本質的なのだろうか．本質的であるとして，それを正当化する物理的考察はどのようになされるか．正当化を許さない物理的状況は（もし存在するならば）どのようなものか．このいずれについても，私は答えを知らない．

]
#que[
  Legendre
  変換が顔を出す物理学的な分野といえば解析力学が挙げられるだろう．解析力学を多変数の微積分の延長上に捉えることはできるだろうか．シンプレクティック幾何というものがあるということだけを聞きかじっているが，勉強したことはない．

]
#que[
  ここまでは，制約が$p^i$たちの線型結合で表されるものだけを考えてきた．しかし
  Lagrange
  の未定乗数法は，線型結合に限らない$C^1$級関数$g$について，$g \( p \) = 0$に制限したもとでの$f$の極値を求める方法を与えている．ということはここまでの議論がある程度は同様に通り，より一般化された状況での
  Legendre
  変換$max [lambda g - f]$が見いだされるはずである．この拡張された
  Legendre
  変換はどこまでよく振る舞い，拡張に伴ってどのように振る舞いを変えるのだろうか．微分可能多様体にも通るような定義に拡張できるだろうか．拡張することではじめて得られるありがたみは何で，どのような応用があるのだろうか．ちなみに
  Legendre
  変換のひとつの一般化として，接触変換というものがあるらしく，これがひとつの答えになっているのではないかと期待しているが，一方この概念はどのような文脈で現れるのだろうか．

]
10pt 15pt #strong[] . 5pt plus 1pt minus 1pt

= 測度論
<測度論>
積分の扱いに入る．このノートでは Spivak
から大きく構成を変えて，測度論に基づいて積分を定義する．理由は大小含めていくつかあるが，主要な理由の第一としては積分と極限の順序交換ができる条件を見通しよく述べたかったからである#footnote[いくらか個人的な理由たちとしては，Spivak
  自身が測度0集合の性質に関してそれなりに丁寧に議論しており，測度論の枠組みに片足を突っ込んでしまっていること，私が測度論で出てくる「骨の折れる証明」に対して手を動かしてみたことがなかったので，手を動かして理解したいと思っていたこと，などがある．];．

多変数の積分を本格的に取り扱うのは次節になる．また，あくまで本稿は多変数の解析学のノートなので，測度論の一般論に深く立ち入ることはしない．

#dig[
  ちなみに Spivak
  では測度0の定義はしているが，測度の定義はしていない．数学においては赤ニシンは単なるニシンでも単なる赤でもないという原則を反映していると言える．

]
#que[
  ところで，可算無限と非可算無限の違いだけは把握していないとこの節は読めないかもしれない．これは余談ではなくて，本当に「問」うておかないとこのあとを読むのに支障がでるから設置した，このノートにおいてはめずらしく「問」の体裁をなした問である．

]
#dig[
  いっぽう，それ以上の集合に関する操作，たとえば順序数に関する一般論は一切必要としない（はず）．

]
#defi[
  単調増加な集合の族$A_1 subset A_2 subset dots.h.c$が$A = union.big_(i = 1)^oo A_i$を充たすことを$A_i arrow.t A$と書く．単調減少な集合の族$B_1 supset B_2 supset dots.h.c$が$B = sect.big_(i = 1)^oo B_i$を充たすことを$B_i arrow.b B$と書く．

]
== 測度空間と Lebesgue 測度
<測度空間と-lebesgue-測度>
本項の目的は，Lebesgue
測度を定義すること，およびそのために必要な測度論の結果を最低限カバーすることである．我々は高校までの数学で面積や体積といった概念に慣れ親しんできた．これらの概念を厳密に捉え，積分に関する理論構成を見通しよくしつつ，一般の集合に対して拡張できるようにしたものが測度である．実際のところ，面積や体積に対して我々がまず疑念を抱かないような点のみを抽象化したと言っても過言ではない；測度とは，大雑把にいえば次の条件を充たす写像として定式化される．

- 空集合は測度0．

- 排反な集合たちの測度の和は，それらの和集合の測度にひとしい．

大雑把にはこれだけなのだが，実際には注意を必要とする点がある．

#que[
  たとえば，「長さ」に関するわれわれの素朴な直感を定式化して$bb(R)$上の測度$mu$を作ることを考えよう．\$\\set{x} \\subset \\mathbb{R}\$を1点集合とするとき，\$\\mu(\\set{x}) = 0\$と定めるのが自然に思える．他方で，$mu \( \[ 0 \, 1 \] \) = 1$と定めたいとも思える．ところで，先程の「排反な集合の測度は，それらの和集合の測度にひとしい」という言明を何も考えずに数式に落とし込むと，\$\\mu(\[0,1\]) = \\sum\_{x \\in \[0,1\]} \\mu(\\set{x}) = \\sum\_{x \\in \[0,1\]} \\mu(\\set{x}) = \\sum\_{x \\in \[0,1\]} 0\$を得る．最右辺の値が定義されるならば，それは0であろうが，そうすると結局は矛盾$1 = 0$を得てしまうので嬉しくない．細かいことを言えば，非可算個の項に対する総和の定義はそんなに自明ではない．可算個の総和というのはいわゆる無限級数なのでがんばれば扱えるのだが，非可算個の項からなる総和を考えることはあまりない．原因はおそらく次の命題にある；\$\\set{a\_\\lambda}\_{\\lambda \\in \\Lambda}\$を添字付けられた正の実数の集合とする．このとき，適切な定義のもとでその総和$sum a_lambda$が定義できるが，その総和が有限の値を取るならば，$Lambda$の濃度は高々可算である．

]
上記の観察を踏まえると，種々の操作ができるだけ可算無限程度で閉じていることを求めたくなる．その結果，ある集合$X$が与えられた時，$X$の任意の部分集合に対して（要求したい性質と両立するように）測度の値を定めることは難しくなる．のだが，殆どの状況において「任意の」部分集合に対する測度の値が欲しくなることはなく，例えば開集合や閉集合といった「ある程度常識的な」集合の測度を測れれば充分であることも多い．このような実用上・理論上の要請をすり合わせることが
Lebesgue 測度を含む測度の定式化には必要となる．

以下しばらく，$X$を非空集合とする．

#defi[
  $cal(A) subset 2^X$が（$X$上の）$sigma$-加法族であるとは，次の3条件を全て充たすことをいう．

  - $nothing in cal(A)$．

  - $A in cal(A)$ならば，$X \\ A in cal(A)$．

  - 任意の自然数$i$に対して$A_i in cal(A)$ならば，$union.big_(i = 1)^oo A_i in cal(A)$．

  $X$とその上の$sigma$-加法族の組$\( X \, cal(A) \)$のことを可測空間といい，$cal(A)$の元のことを（$cal(A)$-）可測集合という．

]
#defi[
  あまり無限大や拡張実数について構成を厳密にやっても得るものがなさそうなのでここはいい加減にやる；\$\[0,\\infty\] \\coloneqq \\set{x \\in \\mathbb{R}| x \\geq 0} \\cup \\set{\\infty}\$を片側拡張実数，\$\\overline{\\mathbb{R}} \\coloneqq \[-\\infty, \\infty\] \\coloneqq \\mathbb{R}\\cup \\set{\\infty} \\cup \\set{-\\infty}\$を（両側）拡張実数という．任意の実数$a in bb(R)$に対して$- oo lt.eq a lt.eq oo$が成り立つものとする．$overline(bb(R))$上の演算は，

  - 任意の$x in bb(R)$に対して$x plus.minus oo = plus.minus oo + x = plus.minus oo$

  - 任意の正の実数$x$に対して$x dot.op plus.minus oo = plus.minus oo dot.op x = plus.minus oo$

  - 任意の負の実数$x$に対して$x dot.op plus.minus oo = plus.minus oo dot.op x = minus.plus oo$

  - $oo + oo = oo$，$- oo - oo = - oo$，$0 dot.op oo = oo dot.op 0 = 0$

  を充たすように$bb(R)$の演算を拡張することで定める．ただし$oo - oo$は定義しない．

]
#dig[
  $0 dot.op oo = 0$と定めるのは積分を定義する際の便宜のためである．たぶんアルゴリズムの分野などでこの定義をするのは目くじらを立てられる可能性がありそう．

]
#defi[
  $\( X \, cal(A) \)$を可測空間とする．$mu : cal(A) arrow.r \[ 0 \, oo \]$が測度であるとは，次の2条件を充たすことをいう．

  - $mu \( nothing \) = 0$．

  - （可算加法性）高々可算個の$cal(A)$の元からなる族\$\\set{A\_i}\_{i=1}^\\infty\$が互いに排反であるならば，$mu (union.big_(i = 1)^oo A_i) = sum_(i = 1)^oo mu \( A_i \)$．

  3つ組$\( X \, cal(A) \, mu \)$を測度空間という．$mu \( X \) < oo$のとき，$mu$は有限測度であるといわれる．$mu \( A_i \) < oo$ならびに$A_i arrow.t X$を充たす集合列\$\\set{A\_i}\$が存在する時，$mu$は$sigma$-有限測度であるといわれる．

]
#prop[
  $\( X \, cal(A) \, mu \)$を測度空間とする．

  + （単調性）$A \, B in cal(A)$が$A subset B$を充たすならば，$mu \( A \) lt.eq mu \( B \)$．

  + （可算劣加法性）\$\\set{A\_i}\_{i=1}^\\infty \\subset \\mathcal{A}\$に対して，$mu (union.big_(i = 1)^oo A_n) lt.eq sum_(i = 1)^oo mu \( A_i \)$．

  + （連続性）\$\\set{A\_i}\_{i=1}^\\infty \\subset \\mathcal{A}\$に対して$A_i arrow.t A$ならば$lim_(i arrow.r oo) mu \( A_i \) = mu \( A \)$．

  + （連続性）\$\\set{A\_i}\_{i=1}^\\infty \\subset \\mathcal{A}\$に対して$A_i arrow.b A$かつ$mu \( A_1 \) < oo$ならば$lim_(i arrow.r oo) mu \( A_i \) = mu \( A \)$．

]
#proof[
  + $B \\ A in cal(A)$なので測度の可算加法性より$mu \( B \) = mu \( A \) + mu \( B \\ A \) gt.eq mu \( A \)$．

  + $B_1 colon.eq A_1$，$B_i colon.eq (union.big_(k = 1)^i A_k) \\ B_(i - 1) = A_i \\ B_(i - 1)$によって帰納的に$B_i$を定めれば，\$\\set{B\_i}\_{i=1}^n\$は互いに排反で，$union.big_(i = 1)^oo B_i = union.big_(i = 1)^oo A_i$ならびに$B_i subset A_i$を充たす．したがって$mu (union.big_(i = 1)^oo A_i) = mu (union.big_(i = 1)^oo B_i) = sum_(i = 1)^oo mu \( B_i \) lt.eq sum_(i = 1)^oo mu \( A_i \)$．

  + $B_1 colon.eq A_1$，$B_i colon.eq A_i \\ A_(i - 1)$によって帰納的に$B_i$を定めれば，\$\\set{B\_i}\_{i=1}^n\$は互いに排反で，$A_i = union.big_(k = 1)^i B_k$ならびに$A = union.big_(k = 1)^oo B_k$を充たす．従って$mu \( A_i \) = mu (union.big_(k = 1)^i B_k) = sum_(k = 1)^i mu \( B_k \)$であるから，$mu \( A \) = mu (union.big_(k = 1)^oo B_k) = sum_(k = 1)^oo mu \( B_k \) = lim_(i arrow.r oo) mu \( A_i \)$．

  + $A_1 \\ A_i arrow.t A_1 \\ A$なので，(iii)
    の結果より$lim_(i arrow.r oo) mu \( A_1 \\ A_i \) = mu \( A_1 \\ A \)$．$mu \( A_1 \) < oo$なので$mu \( A_1 \) - lim_(i arrow.r oo) mu \( A_i \) = mu \( A_1 \) - mu \( A \)$すなわち$lim_(i arrow.r oo) mu \( A_i \) = mu \( A \)$．

]
#exm[
  簡単な測度の例をいくつか挙げておくことにしよう；

  - $x in X$をひとつ固定する．$cal(A) = 2^X$として，$mu : cal(A) arrow.r \[ 0 \, 1 \]$を
    \$\$\\mu(A) \\coloneqq \\delta\_x(A) \\coloneqq \\begin{dcases\*}
    1 & if \$x \\in A\$ \\\\
    0 & if \$x \\notin A\$
    \\end{dcases\*}\$\$と定めると，$mu$は$cal(A)$上の測度になる．このような測度を
    Dirac 測度という．

  - $X$の点列\$\\set{x\_n}\_{n=1}^\\infty\$に対して$mu colon.eq sum_(n = 1)^oo delta_(x_n)$で定めると，$mu$は$2^X$上の測度になる．この測度を\$\\set{x\_n}\$上の数え上げ測度，あるいは計数測度という．特に$X = bb(N)$として，$mu \( A \) colon.eq sum_(i = n)^oo delta_n \( A \)$というのは「$A$に含まれる元の数」を返す写像のことである．

  - $cal(A) = 2^X$として，$mu : cal(A) arrow.r \[ 0 \, oo \]$を
    \$\$\\mu(A) \\coloneqq \\begin{dcases\*}
    |A| & if \$|A| \< \\infty\$ \\\\
    \\infty & otherwise
    \\end{dcases\*}\$\$と定めると，$mu$は$cal(A)$上の測度になる．$X$が高々可算である場合を除いて，この測度は$sigma$-有限ではない．

]
これらの測度は直接定義を与えることが比較的簡単にできるが，これは例外的な状況である．たいていの場合に$sigma$-加法族は非常に大きな集合となり，それらの各元に対して測度の値を直接割り当てることは非常に困難である．それゆえ，測度を定義する際は，より小さな集合族の上で測度の概形を構成しておいて，「拡張定理」と呼ばれる定理によってそれを測度に拡張する，という戦略を取ることが多い．Lebesgue
測度もまたそのような戦略に則って構成される．

#defi[
  $cal(A) subset 2^X$が（$X$上の）有限加法族であるとは，次の3条件を全て充たすことをいう．

  - $nothing in cal(A)$．

  - $A in cal(A)$ならば，$X \\ A in cal(A)$．

  - $A_1 \, A_2 \, dots.h \, A_n in cal(A)$ならば，$union.big_(i = 1)^n A_i in cal(A)$．

]
#defi[
  $cal(A)$を$X$上の有限加法族とする．$mu : cal(A) arrow.r \[ 0 \, oo \]$が有限加法的測度であるとは，次の2条件を充たすことをいう．

  - $mu \( nothing \) = 0$．

  - 高々有限個の$cal(A)$の元からなる族\$\\set{A\_i}\_{i=1}^N\$が互いに排反であるならば，$mu (union.big_(i = 1)^N A_i) = sum_(i = 1)^N mu \( A_i \)$．

  $mu \( A_i \) < oo$ならびに$A_i arrow.t X$を充たす集合列\$\\set{A\_i}\$が存在する時，$mu$は$cal(A)$上で$sigma$-有限であるといわれる．

]
#que[
  有限加法的測度は単調性と劣加法性を充たす．証明は（ちゃんと書き下してないけど，多分）測度の場合と同様（だと思う）．

]
#dig[
  後に見るが，左半開区間$\( a \, b \]$に対して$mu \( \( a \, b \] \) colon.eq b - a$と定め，これを$overline(cal(H))$上の有限加法的測度に拡張すれば
  Lebesgue 測度の「概形」が得られる．この有限加法的測度のことを Jordan
  測度ということもある．きちんと確かめていないが，Spivak
  における「容量0」概念は Jordan 測度0のことを指している可能性が高い．

]
#prop[
  $cal(C) subset 2^X$を部分集合の族とする．この時，$cal(C)$を含む$sigma$-加法族の中で（集合の包含関係に関して）最小のものが一意的に存在する．これを$cal(C)$の生成する$sigma$-加法族といい，$sigma \( cal(C) \)$と書く．

]
#proof[
  $sigma$-加法族は集合の共通部分を取る操作について閉じている；すなわち\$\\set{\\mathcal{A}\_\\lambda }\_{\\lambda \\in \\Lambda}\$が$sigma$-加法族からなる族であるならば，$sect.big_(lambda in Lambda) cal(A)_lambda$もまた$sigma$-加法族である．したがって$cal(C)$を含む$sigma$-加法族全体の集合を\$D \\coloneqq \\set{\\mathcal{A} | \\text{\$\\mathcal{A}\$ は \$\\mathcal{C}\$ を含む \$\\sigma\$-加法族}}\$として，$sigma \( cal(C) \) colon.eq sect.big_(cal(A) in D) cal(A)$とおけばよい．

]
#que[
  ちゃんと確かめていないが，$cal(C)$を含む$sigma$-加法族全体はおそらく集合になるので上記の証明で問題ないと思う．たぶん濃度を$lr(|2^(2^X)|)$で抑えられる気がする．「この性質を充たすものぜんぶとってきて！」という無邪気なことをするとたまに集合でないものができあがるので気をつけないといけない．

]
#block[
  thmcaratheodory<拡張定理>
  $cal(A)$を有限加法族，$mu : cal(A) arrow.r \[ 0 \, oo \]$を有限加法的測度とする．更に$mu$は次の意味で$cal(A)$上可算加法的であると仮定する；高々可算個の$cal(A)$の元からなる族\$\\set{A\_i}\_{i=1}^\\infty\$が互いに排反であり，かつ$union.big_(i = 1)^oo A_i in cal(A)$であるならば，$mu (union.big_(i = 1)^oo A_i) = sum_(i = 1)^oo mu \( A_i \)$．このとき，$mu$は$sigma \( cal(A) \)$上の測度に拡張できる．更に，$mu$が$cal(A)$上で$sigma$-有限ならば，この拡張は一意的である．

]
拡張定理の証明はこの時点でできるのだが，Lebesgue
測度をできるだけはやく定義したいので，証明は後回しにする．ただし，拡張の一意性の証明に用いる$pi$-$lambda$定理については，拡張定理以外にも使い所があるので，この時点でステートメントだけは紹介しておくことにする．

#defi[
  $cal(P) subset 2^X$が
  $pi$-システムであるとは，次の2条件を充たすことをいう．(i)
  $cal(P) eq.not nothing$，(ii)
  $A \, B in cal(P)$ならば$A sect B in cal(P)$．

  $cal(L) subset 2^X$が
  $lambda$-システムであるとは，次の3条件を充たすことをいう．(i)
  $X in cal(L)$，(ii)
  $A \, B in cal(L)$かつ$A subset B$ならば$B \\ A in cal(L)$，(iii)
  $A_i arrow.t A$かつ任意の$i in bb(N)$に対して$A_i in cal(L)$であるならば，$A in cal(L)$．

]
#que[
  有限加法族は$pi$-システムである．$sigma$-加法族は$pi$-システムであり$lambda$-システムでもある．

]
#block[
  thmpilambda<Dynkin族定理> $cal(P) subset 2^X$を
  $pi$-システム，$cal(L) subset 2^X$を$lambda$-システムとし，更に$cal(P) subset cal(L)$であると仮定する．このとき$sigma \( cal(P) \) subset cal(L)$．すなわち$sigma \( cal(P) \)$は$cal(P)$を含む$lambda$-システムの中で最小のものである．

]
#prop[
  $bb(R)$の左半開区間をすべて集めた集合\$\\mathcal{H} \\coloneqq \\set{ (a,b\] | - \\infty \\leq a \< b \< \\infty } \\cup \\set{ (a, \\infty) | - \\infty \\leq a \< \\infty } \\cup \\set{\\emptyset}\$は有限加法族ではないが，
  $ overline(cal(H)) colon.eq {union.big_(i = 1)^N A_i med mid(bar.v) med A_i in cal(H) \, A_i upright("は排反")} $は有限加法族である．更に$sigma \( cal(H) \) = sigma (overline(cal(H)))$である．

]
#proof[
  左半開区間2つの和集合は排反な左半開区間2つになるか，ひとつの左半開区間になる．また左半開区間の補集合は（高々2つの）左半開区間の和で表せる．従って$overline(cal(H))$は有限加法族である．$sigma \( cal(H) \) subset sigma (overline(cal(H)))$はよく，$sigma$-加法族の定義から$overline(cal(H)) subset sigma \( cal(H) \)$なので$pi$-$lambda$定理によって$sigma \( cal(H) \) supset sigma (overline(cal(H)))$を得る．

]
#prop[
  測度$lambda : cal(sigma) \( cal(H) \) arrow.r \[ 0 \, oo \]$であって，以下の3条件を充たすものが一意的に存在する．この測度$lambda$を$bb(R)$上の
  Lebesgue 測度と呼ぶ．

  - 任意の$\( a \, b \] in cal(H)$に対して$lambda \( \( a \, b \] \) = b - a$．

  - 任意の$\( a \, oo \) in cal(H)$に対して$lambda \( \( a \, oo \) \) = oo$．

  - $lambda \( nothing \) = 0$．

]
#proof[
  $mu : cal(H) arrow.r \[ 0 \, oo \]$を，$\( a \, b \] in cal(H)$に対して$mu \( \( a \, b \] \) colon.eq b - a$，$\( a \, oo \) in cal(H)$に対して$mu \( \( a \, oo \) \) colon.eq oo$，$mu \( nothing \) colon.eq 0$と定める．更に，排反な$A_1 \, A_2 \, dots.h \, A_n in cal(H)$に対して$mu (union.big_(i = 1)^n A_i) colon.eq sum_(i = 1)^n mu \( A_i \)$と定めることで$mu$を$overline(cal(H))$上の有限加法的測度に拡張できたとする．その上で$overline(cal(H))$上で可算加法的であることが示せれば，$mu$は$overline(cal(H))$上$sigma$-有限なので
  Carathéodory
  の拡張定理によって結論を得る．以下，これらのことを示していく．

  まず$mu$が$overline(cal(H))$上の有限加法的測度に拡張できること，すなわち上記の拡張が
  well-defined
  であることを示す．$A in overline(cal(H))$をとると，$A$は排反な集合族$A_1 \, A_2 \, dots.h \, A_m in cal(H)$を用いて$A = union.big_(i = 1)^m A_i$と表されている．ここで，別の排反な集合族$B_1 \, B_2 \, dots.h \, B_n in cal(H)$を用いて$A = union.big_(j = 1)^n B_j$とも表されていたとする．このとき$1 lt.eq i lt.eq m$ならびに$1 lt.eq j lt.eq n$に対して$C_(i j) colon.eq A_i sect B_j$と置くと，\$\\set{C\_{ij}}\$は排反な$overline(cal(H))$の集合族であって，$union.big_(i = 1)^m C_(i j) = B_j$および$union.big_(j = 1)^n C_(i j) = A_i$を充たす．したがって$mu (union.big_(i = 1)^n A_i) = mu (union.big_(i = 1)^n union.big_(j = 1)^m C_(i j)) = mu (union.big_(j = 1)^m B_j)$を得るから$mu$は
  well-defined である．

  続いて$mu$の$cal(H)$上での可算加法性，すなわち$A in cal(H)$が排反な区間の族\$\\set{(a\_i,b\_i\]}\_{i=1}^\\infty\$を用いて$A = union.big_(i = 1)^oo \( a_i \, b_i \]$と表されていたときに$mu \( A \) = sum_(i = 1)^oo mu \( \( a_i \, b_i \] \)$となることを示す．

  - $- oo < a < b < oo$を用いて$A = \( a \, b \]$と表せる場合．まず任意の$n > 0$に対して$union.big_(i = 1)^n \( a_i \, b_i \] subset \( a \, b \]$なので$mu (union.big_(i = 1)^n \( a_i \, b_i \]) lt.eq mu \( \( a \, b \] \)$である．更に$\( a_i \, b_i \]$たちの排反性より$mu (union.big_(i = 1)^n \( a_i \, b_i \]) = sum_(i = 1)^n mu \( \( a_i \, b_i \] \)$である．結局$sum_(i = 1)^n mu \( \( a_i \, b_i \] \) lt.eq mu \( \( a \, b \] \)$を得るので，$n arrow.r oo$として$sum_(i = 1)^oo mu \( \( a_i \, b_i \] \) lt.eq mu \( \( a \, b \] \)$である．逆向きの不等式を示す．$epsilon > 0$を任意に固定し，$eta_m colon.eq epsilon \/ 2^m$と置く．このとき\$\\set{(a\_i,b\_i+\\eta\_i)}\$は$\[ a + epsilon \, b \]$の開被覆なので，Heine-Borel
    の定理よりある$n in bb(N)$が存在して，$\( a + epsilon \, b \] subset \[ a + epsilon \, b \] subset union.big_(i = 1)^n \( a_i \, b_i + eta_i \) subset union.big_(i = 1)^n \( a_i \, b_i + eta_i \]$である．以上の結果より，
    $ mu \( \( a \, b \] \) & lt.eq mu (\( a \, a + epsilon \] union union.big_(i = 1)^n \( a_i \, b_i + eta_i \]) \
                          & lt.eq epsilon + mu (union.big_(i = 1)^n \( a_i \, b_i + eta_i \]) \
                          & lt.eq epsilon + sum_(i = 1)^n (mu (\( a_i \, b_i \]) + eta_i) \
                          & lt.eq 2 epsilon + sum_(i = 1)^n (mu (\( a_i \, b_i \])) \
                          & lt.eq 2 epsilon + sum_(i = 1)^oo (mu (\( a_i \, b_i \])) $を得る．$epsilon > 0$は任意だったので$mu \( \( a \, b \] \) lt.eq sum_(i = 1)^oo mu \( \( a_i \, b_i \] \)$である．

  - $b in bb(R)$を用いて$A = \( - oo \, b \]$と書ける場合．$mu \( A \) = oo$なので$mu \( A \) gt.eq sum_(i = 1)^oo mu \( \( a_i \, b_i \] \)$はよい．$c in bb(R)$に対して$\( c \, b \] = union.big_(i = 1)^oo \( \( c \, b \] sect \( a_i \, b_i \] \)$なので，前段の結果と併せて$mu \( \( c \, b \] \) = union.big_(i = 1)^oo mu \( \( c \, b \] sect \( a_i \, b_i \] \) lt.eq union.big_(i = 1)^oo mu \( \( a_i \, b_i \] \)$を得るから$c arrow.r oo$として$mu \( A \) lt.eq sum_(i = 1)^oo mu \( \( a_i \, b_i \] \)$を得る．$A = \( a \, oo \)$ならびに$A = bb(R)$の場合も同様である．

  最後に，$mu$が$overline(cal(H))$上で可算加法的であることを示す．排反な$overline(cal(H))$の元の族\$\\set{A\_i}\_{i=1}^\\infty\$に対して$A colon.eq union.big_(i = 1)^oo A_i in overline(cal(H))$であったと仮定する．$A in overline(cal(H))$なので，$A = union.big_(j = 1)^m B_j$を充たす排反な$B_1 \, B_2 \, dots.h \, B_m in cal(H)$がある．同様に$A_i in overline(cal(H))$なので，$A_i = union.big_(k = 1)^(n_i) C_(i k)$を充たす排反な$C_(i 1) \, C_(i 2) \, dots.h \, C_(i n_i) in cal(H)$がある．$B_j sect C_(i k)$が互いに排反であることに気をつけて，
  $ mu \( A \) & = sum_(j = 1)^m mu \( B_j \) \
             & = sum_(j = 1)^m mu (union.big_(i = 1)^oo union.big_(k = 1)^(n_i) B_j sect C_(i k)) \
             & = sum_(j = 1)^m sum_(i = 1)^oo sum_(k = 1)^(n_i) mu (B_j sect C_(i k)) \
             & = sum_(i = 1)^oo sum_(j = 1)^m sum_(k = 1)^(n_i) mu (B_j sect C_(i k)) \
             & = sum_(i = 1)^oo mu (A_i) $となる．

]
#que[
  ここでは$lambda \( \( a \, b \] \) = b - a$と定めたが，実際には非減少かつ右連続な関数$F : bb(R) arrow.r bb(R)$に対して$lambda \( \( a \, b \] \) colon.eq F \( b \) - F \( a \)$と定めた場合でも上記の証明がほぼ同様に通り，$sigma \( cal(H) \)$上の測度が得られる．これは$F$から定まる
  Lebesgue-Stieltjes 測度と呼ばれる．

]
ここまで，$overline(cal(H))$という左半開区間の和集合からなる集合を考えてきたが，これは$overline(cal(H))$が補集合を取る操作に関して閉じているという技術的事情による．例えば開集合や閉集合が全て含まれているのか，ということが気になると思うが，実際にはその点を心配する必要はなく，$sigma (overline(cal(H)))$は多くの集合を含む；

#defi[
  $bb(R)$の開集合をすべて含む最小の$sigma$-加法族を$bb(R)$の Borel
  $sigma$-加法族といい，$cal(B)$であらわす．すなわち，$bb(R)$の開集合をすべて集めた集合を$cal(O)$と書くとき，$cal(B) colon.eq sigma \( cal(O) \)$と定める．

]
#que[
  $bb(R)$の開集合は$bb(R)$の開区間の可算合併で書けるので，実際には\$\\mathcal{B} = \\sigma(\\set{(a,b) | -\\infty \< a \< b \< \\infty })\$である．

]
#dig[
  実際には位相空間に対して Borel
  $sigma$-加法族という言葉を定義できる；位相空間$X$に対し，その開集合全体が生成する$sigma$-加法族のことを$X$の
  Borel $sigma$-加法族という．

]
#prop[
  $cal(B) = sigma \( cal(H) \)$．

]
#proof[
  $\( a \, b \] in cal(H)$を任意に取ると，$\( a \, b \] = sect.big_(n = 1)^oo \( a \, b + 1 \/ n \)$と表せるので，$cal(H) subset cal(B)$すなわち$sigma \( cal(H) \) subset cal(B)$である．逆に$\( a \, b \) in cal(B)$を任意に取ると$\( a \, b \) = union.big_(n = 1)^oo \( a \, b - 1 \/ n \]$と表せるので$cal(B) subset sigma \( cal(H) \)$であるから$sigma \( cal(B) \) subset sigma \( cal(H) \)$を得る．

]
== 可測関数
<可測関数>
1変数関数の Riemann
積分がどのような関数に対して定義できたわけではないのと同様に，測度に関する積分もまた，任意の関数に定義できるわけではない．測度に関する積分が定義できる関数のクラスが可測写像と呼ばれるものである．本節では可測写像の定義ならびに基本的な性質を見ていく．それと並行して，拡張実数や$bb(R)^n$の
Borel
$sigma$-加法族の構造についても調べる．とりあえず抑えておくべきことがあるとするならば，（Euclid
空間における）可測写像は連続写像よりもより広いクラスになるということ，可測性は（連続性や微分可能性とは異なって）極限操作に関して保存されるということの2点であろう．

以下しばらく，$\( X \, cal(A) \)$ならびに$\( X_i \, cal(A)_i \)$（$i = 1 \, 2 \, 3 \, dots.h$）を可測空間とする．

#defi[
  写像$f : X_1 arrow.r X_2$が（$cal(A)_1 \/ cal(A)_2$-）可測であるとは，任意の$A in cal(A)_2$に対して$f^(- 1) \( A \) in cal(A)_1$となることをいう．

]
#dig[
  この定義は「開集合の逆像が開集合」という連続写像の特徴づけと併置して考えるのがよいと思っている．開集合という位相的な構造を壊さない写像のことが連続写像であったのを真似るように，可測空間の構造を壊さない写像のことを可測写像として定義している．

]
$sigma$-加法族が一般に複雑であるという話をした手前，各可測集合の逆像がどうなっているかを確かめるのは煩雑に思えるかも知れない．が，実際にはそのような手間を踏む必要はないことのほうが多い；

#lem[
  $cal(A)_2$が$cal(C) subset 2^(X_2)$によって生成されている時，すなわち$cal(A)_2 = sigma \( cal(C) \)$のとき，$f : X_1 arrow.r X_2$が可測であることと，任意の$C in cal(C)$に対して$f^(- 1) \( C \) in cal(A)_1$であることは同値である．

]
#proof[
  充分性は明らか．\$\\mathcal{D} \\coloneqq \\set{ A \\in \\mathcal{A}\_2 | f^{-1}(A) \\in \\mathcal{A}\_1}\$と置くと，逆像は補集合・共通部分・和集合を取る操作を保存することから$cal(D)$は$sigma$-加法族であり，かつ$cal(C) subset cal(D)$．したがって$sigma \( cal(C) \) subset cal(D)$なのでよい．

]
#lem[
  $f : X arrow.r bb(R)$に対して以下はすべて同値である．

  + $f$は可測．

  + 任意の$a in bb(R)$に対して$f^(- 1) \( \( - oo \, a \) \) in cal(A)$．

  + 任意の$a in bb(R)$に対して$f^(- 1) \( \( - oo \, a \] \) in cal(A)$．

  + 任意の$a in bb(R)$に対して$f^(- 1) \( \( a \, oo \) \) in cal(A)$．

  + 任意の$a in bb(R)$に対して$f^(- 1) \( \[ a \, oo \) \) in cal(A)$．

]
#proof[
  議論はほぼ同様なので，(i) と (ii)
  の同値性のみ示す．\$\\mathcal{B} = \\sigma(\\set{(-\\infty,a) | a \\in \\mathbb{R}})\$を示せばよい．任意の$a in bb(R)$に対して$\( - oo \, a \) in cal(B)$なので\$\\mathcal{B} \\supset \\sigma(\\set{(-\\infty,a) | a \\in \\mathbb{R}})\$はよい．任意の$n in bb(N)$ならびに開区間$\( a \, b \)$に対して$\( a \, b \) = sect.big_(n = 1)^oo (\( - oo \, b \) sect \( - oo \, a + 1 \/ n \)^c)$なので\$(a,b) \\in \\sigma(\\set{(-\\infty,a) | a \\in \\mathbb{R}})\$となるから\$\\mathcal{B} \\subset \\sigma(\\set{(-\\infty,a) | a \\in \\mathbb{R}})\$である．

]
実数に値を持つ関数が主たる関心である場合でも，積分や極限に関する種々の操作をする中で拡張実数値関数を考えたほうがいい場合がある．たとえば実数値関数の族\$\\set{f\_n}\_{n=1}^\\infty\$があるときに$sup_n f_n \( x \)$が有限であるとは限らないし，$f : bb(R)^2 arrow.r bb(R)$に対して$y mapsto integral f \( x \, y \) med "" #h(-1em) d x$という関数は（適当な意味で積分が定義できるとはして）$f$の形状いかんでは有限にならないことがある．

#dig[
  このノートの範囲に限れば，前者が問題になることはないと思う．なので拡張実数値関数のことを（測度の定義を除いて）陽に取り扱う必要はなさそうに見えていた．のだが，後者の問題を捨て置くわけにはいかないことに後で気づいた．というのも，この形の関数が
  Fubini の定理の主張に直接的に現れるのである．

]
というわけで拡張実数$overline(bb(R))$の Borel
$sigma$-加法族について考えることになるのだが，そもそも$overline(bb(R))$の開集合の話をしていなかったので，そこから話をしよう．とはいえこのノートでは位相の一般論をわざと表に出さないので，以下の議論はややアドホックではある．

#defi[
  $overline(bb(R))$の開集合は以下のルールによって帰納的に定める．

  - $bb(R)$の開集合は$overline(bb(R))$の開集合である．

  - $a in bb(R)$に対して，$\[ - oo \, a \)$および$\( a \, oo \]$は$overline(bb(R))$において開集合である．

  - $U \, V$が$overline(bb(R))$において開集合であるならば，$U sect V$も$overline(bb(R))$において開集合である．

  - \$\\set{U\_\\lambda}\_{\\lambda \\in \\Lambda}\$が$overline(bb(R))$における開集合の族であるならば，$union.big_(lambda in Lambda) U_lambda$は$overline(bb(R))$において開集合である．

  - $overline(bb(R))$の開集合は上記で定まるものに限る．

  $overline(bb(R))$の開集合を全て含む最小の
  $sigma$-加法族を$overline(bb(R))$の Borel
  $sigma$-加法族といい，$cal(B)^(\*)$と書く．

]
#que[
  すでに白状したとおり，このように位相を指定するのは一般的ではないとも思う（その位相の定め方は恣意的ではないか？という疑問に答えられない）．実際には次のようにしたほうが多少は行儀がよいだろう；逆正接関数$upright(a r c t a n) : bb(R) arrow.r \( - 1 \, 1 \)$を，$upright(a r c t a n) \( - oo \) = - pi \/ 2$および$upright(a r c t a n) \( oo \) = pi \/ 2$と定めることで$upright(a r c t a n) : overline(bb(R)) arrow.r \[ - pi \/ 2 \, pi \/ 2 \]$に拡張し，この写像による誘導位相を\$\\overline \\mathbb{R}\$に入れる．ということで\$\\overline \\mathbb{R}\$は$\[ - pi \/ 2 \, pi \/ 2 \]$と同相なので，距離化可能なコンパクト位相空間である．

]
#que[
  とはいえこれ以外に$overline(bb(R))$に定める位相構造はありえないのか？というのはよくわからない（なんとなく自然なものはない気がするが，証明が思いついているわけではない）．少なくとも$overline(bb(R))$が$bb(R)$に定める相対位相と，$bb(R)$の通常の位相が一致してほしいとは思う（そうでなければ，$bb(R)$-値関数を$overline(bb(R))$-値関数だと思う際に位相ならびに可測性に関する議論が煩雑になる）が，この点は充たしているし，$upright(a r c t a n)$を連続拡張する位相になっているので自然ではあると思う（個人の感想です）．$overline(bb(R))$に完備距離化可能な位相を入れる限り可測構造はいやでも一意に決まるので（後述する
  Kuratowski
  の定理による），可測構造だけを気にするのであれば特に何も考えなくてもよいのかもしれませんが…

]
拡張実数値関数に対しても，実数値関数の場合と同様に次の事実がある．証明は実数値関数の場合とほとんど同じなので省きます．

#que[
  $f : X arrow.r overline(bb(R))$に対して以下はすべて同値である．

  + $f$は可測．

  + 任意の$a in bb(R)$に対して$f^(- 1) \( \[ - oo \, a \) \) in cal(A)$．

  + 任意の$a in bb(R)$に対して$f^(- 1) \( \[ - oo \, a \] \) in cal(A)$．

  + 任意の$a in bb(R)$に対して$f^(- 1) \( \( a \, oo \] \) in cal(A)$．

  + 任意の$a in bb(R)$に対して$f^(- 1) \( \[ a \, oo \] \) in cal(A)$．

]
拡張実数に次いで，$bb(R)^n$の可測空間としての構造を考える．$bb(R)$を真似て
Borel
$sigma$-加法族を与えることも勿論できる．が，一般的に，ふたつの可測空間の直積に対して可測空間の構造を作ることができるので，まずその話から始めよう；

#defi[
  $\( X_1 \, cal(A)_1 \)$ならびに$\( X_2 \, cal(A)_2 \)$を可測空間とする．$X_1 times X_2$上の$sigma$-加法族
  \$\$\\mathcal{A}\_1 \\otimes \\mathcal{A}\_2 \\coloneqq \\sigma\\left( \\set{A\_1 \\times A\_2 | A\_1 \\in \\mathcal{A}\_1, A\_2 \\in \\mathcal{A}\_2} \\right)\$\$を$cal(A)_1$と$cal(A)_2$の直積$sigma$-加法族という．$n$個の可測空間に対する直積$sigma$-加法族$cal(A)_1 times.circle dots.h times.circle cal(A)_n$も同様に定める．特に$cal(A)_1 = cal(A)_2 = dots.h = cal(A)_n eq.colon cal(A)$のとき，$cal(A)_1 times.circle dots.h times.circle cal(A)_n$を$cal(A)^n$と書く．

]
#dig[
  直積$sigma$-加法族のことを$cal(A)_1 times cal(A)_2$と書く文献も多い．これは直積集合と紛らわしい気もするが，$sigma$-加法族の直積集合を考えることはあまりないからか，一般的な記法である．他方，$cal(A)_1 times.circle cal(A)_2$は（後に現れる）テンソル積と記号が衝突しているけれども，この記号衝突が混乱を引き起こすこともないと思う．個人的な所感としてはどっちもどっちなので，気分で$times.circle$を使うことにしたが，$cal(A)^n$を$cal(A)^(times.circle n)$とは書いていないので，お行儀が悪いと感じる人もいるかもしれない．

]
この時点で，$bb(R)^n$には2つの$sigma$-加法族の入れ方があり得るとわかる．すなわち，直積$sigma$-加法族$cal(B)^n$ならびに$bb(R)^n$の開集合から生成される$sigma$-加法族$cal(B) \( bb(R)^n \)$である．あり得る構造が2つもあると話が煩雑になりそうな予感がするが，実際にはこの2つは同じものなのでやはり心配する必要はない；

#prop[
  $cal(B)^n = cal(B) \( bb(R)^n \)$．

]
#proof[
  $n = 2$の場合を示す．
  \$\\set{A | A \\times \\mathbb{R}\\in \\mathcal{B}(\\mathbb{R}^2)}\$は$bb(R)$の開集合をすべて含む$sigma$-加法族なので，$cal(B)$を含む．従って任意の$A in cal(B)$に対して$A times bb(R) in cal(B) \( bb(R)^2 \)$が成り立つ．同様に任意の$B in cal(B)$に対して$bb(R) times B in cal(B) \( bb(R)^2 \)$が成り立つ．ゆえに任意の$A \, B in cal(B)$に対して$A times B = \( A times bb(R) \) sect \( bb(R) times B \) in cal(B) \( bb(R)^2 \)$を得るので，$cal(B)^2 subset cal(B) \( bb(R)^2 \)$．逆の包含を示すには\$\\mathcal{B} = \\sigma(\\set{(a\_1, b\_1) \\times (a\_2,b\_2)| -\\infty\<a\_i \< b\_i \< \\infty, i=1,2})\$を示せばよいが，これは$bb(R)^2$の開集合が開方体の可算和で書けることから従う．$n > 2$の場合の証明もほぼ同様である．

]
#que[
  $bb(R)^2$の開集合は開方体の可算和で書ける．これは位相の言葉を陽に使って書くと，$bb(R)^2$は可算開基を持つ，ということにほかならない．可算開基を持つ位相空間は第二可算空間と呼ばれる．距離空間に限れば，第二可算性と可分性（可算な稠密部分集合を持つこと）は同値である．

]
#que[
  この議論は可分位相空間にほとんどそのまま一般化できる．可分でない位相空間においては，ここで考えた2つの$sigma$-加法族は一致するとは限らない（一般には直積位相に関する$sigma$-加法族のほうが大きくなる）．これが原因で，可分でない空間に対しては「連続ならば（Borel
  $sigma$-加法族に関して）可測」という，$bb(R)^n$の場合に成り立ってくれる性質が成り立たない可能性が現れる．可分でない空間を考えなければよさそうにも見えるし，個人的にはそうしたいのだが，実際にはノンパラメトリック推定などの文脈で関数空間に値を取る確率変数を考えはじめるとそういうわけにもいかない．

]
ここまでの議論をもとに，写像が可測になる状況のいくつかを挙げることができる．主張を見ればわかるように，極限操作を含む様々な操作に対して可測性は頑健である．

#prop[
  + $f : bb(R)^m arrow.r bb(R)^n$が連続であるならば，それは$cal(B)^m \/ cal(B)^n$-可測である．

  + $f^1 \, f^2 \, dots.h \, f^n : X_1 arrow.r bb(R)$が可測であることと，$f = \( f^1 \, f^2 \, dots.h \, f^n \) : X_1 arrow.r bb(R)^n$が可測であることは同値である．

  + $f : X_1 arrow.r X_2$ならびに$g : X_2 arrow.r X_3$がそれぞれ可測であるならば，合成写像$g compose f : X_1 arrow.r X_3$も可測である．

  + $g : bb(R)^n arrow.r bb(R)$ならびに$f^1 \, f^2 \, dots.h \, f^n : X arrow.r bb(R)$がすべて可測であるならば，$X_1 in.rev x mapsto g \( f^1 \( x \) \, f^2 \( x \) \, dots.h \, f^n \( x \) \) in bb(R)$は可測である．従って$f \, g : X arrow.r bb(R)$が可測であれば，$f + g$，$f g$などは全て可測である．

  + $f_1 \, f_2 \, dots.h : X arrow.r overline(bb(R))$が可測であるとする．$sup_n f_n$，$inf_n f_n$，$limsup_n f_n$，$liminf_n f_n$は可測である．したがって任意の$x in X$に対して$lim_n f_n \( x \)$が$plus.minus oo$を含めて存在するならば，$f : X in.rev x mapsto lim_n f_n \( x \) in bb(R)$は可測である．

]
#proof[
  + 任意の開集合$O subset bb(R)^n$に対して$f^(- 1) \( O \) in cal(B)^m$なので，開集合全体が$cal(B)^n$を生成することと前補題から結論が従う．

  + $n = 2$の場合のみ示す．任意の$A \, B in cal(B)$に対して，$f^(- 1) \( A times B \) in cal(A)_1$は$(f^1)^(- 1) \( A \) sect (f^2)^(- 1) \( B \) in cal(A)_1$と同値であることに注意する．このことから$f^1 \, f^2$が可測ならば$f$が可測であるとわかる．逆に$f$が可測であると仮定すると，特に$B = bb(R)$とすることで$(f^1)^(- 1) \( A \) in cal(A)_1$を得るから$f^1$は可測である．$f^2$の可測性も同様である．

  + $A in cal(A)_3$を任意にとってくると，$\( g compose f \)^(- 1) \( A \) = f^(- 1) \( g^(- 1) \( A \) \)$であり，$g$の可測性から$g^(- 1) \( A \) in cal(A)_2$を得るから，$f$の可測性より$\( g compose f \)^(- 1) \( A \) in cal(A)_1$．

  + (ii) ならびに (iii) から出る．

  + $\( inf_n f_n \)^(- 1) \( \( - oo \, a \) \) = sect.big_n \( f_n \)^(- 1) \( \( - oo \, a \) \) in cal(A)$なので$inf_n f_n$は可測である．$sup_n f_n$も同様．$liminf_n f_n = sup_n inf_(m gt.eq n) f_m$なので$liminf_n f_n$の可測性もよい．ほかも同様である．

]
#que[
  ということでたいていの場合に写像は可測になるという話をしてきたが，だからといって任意の関数が可測になるわけではない．このノートの範囲で可測性が問題になることはおそらくないので，証明まで含めて説明することはしないが，以下のような例がある；

  + $x \, y in \[ 0 \, 1 \)$上の二項関係$tilde.op$を$x tilde.op y arrow.l.r.double x - y in bb(Q)$で定めると，これは同値関係である．この同値関係に関する代表元をあつめた集合$V$を
    Vitali
    集合という．$V in.not cal(B)$である．したがって，その指示関数$1_V : bb(R) arrow.r bb(R)$は$cal(B) \/ cal(B)$-可測ではない．

  + \$\\set{f\_\\lambda \\colon X \\to \\mathbb{R}}\_{\\lambda \\in \\Lambda}\$を$bb(R)$-値可測関数の族とするとき，$Lambda$が非可算であるならば，$sup_(lambda in Lambda) f_lambda \( x \)$は可測とは限らない．例えば$Lambda$として$V$を取り，\$\\set{1\_x}\_{x \\in V}\$を考えればよい．

]
ところで，ここまでで$bb(R)^n$上の$sigma$-加法族に関する理解は深まった気がする一方，それ以外の$sigma$-加法族については相変わらずわからないままである．そもそも可測構造というのはどれくらいいろいろなものがあるのだろうか，というのは自然な疑問の一つだと思う．このノートでは証明まで踏み込むことはしないものの，かなり面白い（と個人的には思っている）一般論があるので述べておくことにしよう．ちなみにこの話は私は聞きかじっただけでちゃんと勉強したことがあるわけではない．

#defi[
  $\( X_1 \, cal(A)_1 \)$と$\( X_2 \, cal(A)_2 \)$が（可測空間として）同型であるとは，全単射な$cal(A)_1 \/ cal(A)_2$-可測写像$f : X_1 arrow.r X_2$があり，その逆写像が$cal(A)_2 \/ cal(A)_1$-可測であることをいう．可測空間$\( X \, cal(A) \)$が標準
  Borel 空間であるとは，ある完備距離空間ならびにその Borel
  $sigma$-加法族によって定まる可測空間と同型であることをいう．

]
#que[
  $\( X \, cal(A) \)$を標準 Borel 空間とする．

  - $\| X \| = n$であれば$\( X \, cal(A) \)$は\$(\\set{1, 2, \\dots, n}, 2^{\\set{1, 2, \\dots, n}})\$と同型である．

  - $X$が可算無限であれば$\( X \, cal(A) \)$は$\( bb(N) \, 2^(bb(N)) \)$と同型である．

  - (i), (ii)
    のいずれも当てはまらないならば，$\( X \, cal(A) \)$は$\( bb(R) \, cal(B) \)$と同型である．

]
というわけで，少なくとも完備距離空間くらいに限れば，可測構造というのは随分種類が少ないらしい．

== 積分と各種の収束定理
<積分と各種の収束定理>
$\( X \, cal(A) \, mu \)$を測度空間とする．可測写像$f : X arrow.r overline(bb(R))$に対し，その積分を定義する．一旦全て定義を述べてしまい，論理の飛躍は後で埋める．

#defi[
  $A in cal(A)$に対して， \$\$1\_A(x) \\coloneqq \\begin{dcases\*}
  1 & if \$x \\in A\$ \\\\
  0 & if \$x \\notin A\$
  \\end{dcases\*}\$\$で定まる関数$1_A : X arrow.r bb(R)$を$A$の指示関数という．$f : X arrow.r bb(R)$が単関数であるとは，$a_1 \, a_2 \, dots.h \, a_n in bb(R)$ならびに$A_1 \, A_2 dots.h \, A_n in cal(A)$を用いて$f = sum_(i = 1)^n a_i 1_(A_i)$と表せることをいう．

]
#defi[
  - （非負単関数の場合）非負単関数$f = sum_(i = 1)^n a_i 1_(A_i)$に対して$integral f "" #h(-1em) d mu colon.eq sum_(i = 1)^n a_i mu \( A_i \)$と定める．well-defined
    であることは非自明だが，後で証明する．

  - （非負可測関数の場合）可測関数$f : X arrow.r \[ 0 \, oo \]$に対して，
    $ integral f "" #h(-1em) d mu colon.eq sup {integral g "" #h(-1em) d mu med mid(bar.v) med 0 lt.eq g lt.eq f \, g は 単 関 数} $で定める．

  - （一般の場合）可測関数$f : X arrow.r overline(bb(R))$に対して，\$f^+ \\coloneqq \\max\\set{f,0}\$，\$f^- \\coloneqq - \\min\\set{f,0}\$と定めると，この2つは非負可測関数であって，$f = f^(+) - f^(-)$である．$integral f^(+) "" #h(-1em) d mu$ならびに$integral f^(-) "" #h(-1em) d mu$の少なくとも片方が有限であるとき，$f$の積分が定義できるといい，
    $ integral f "" #h(-1em) d mu colon.eq integral f^(+) "" #h(-1em) d mu - integral f^(-) "" #h(-1em) d mu $で定める．両方が無限大になった場合の積分は定義しない．

  - 積分が定義できる関数$f : X arrow.r bb(R)$ならびに$A in cal(A)$に対して，$f$の$A$上での積分を
    $ integral_A f "" #h(-1em) d mu colon.eq integral f 1_A "" #h(-1em) d mu $で定める．$f$の積分が定義できるならば$integral_A f "" #h(-1em) d mu$も定まるが，このことは後で示す．

  関数$f : X in.rev x mapsto f \( x \) in overline(bb(R))$の積分について取り扱う際，$f$の引数の記号として$x$を用いていることを明示したい場合は，$integral f "" #h(-1em) d mu$のことを$integral f \( x \) "" #h(-1em) d mu \( x \)$や$integral f \( x \) thin mu \( d x \)$のように書く．

]
#defi[
  可測関数$f : X arrow.r bb(R)$は，$\| f \|$の積分が有限の値を取るとき，すなわち$integral f^(+) "" #h(-1em) d mu + integral f^(-) "" #h(-1em) d mu < oo$のとき，（絶対）可積分であるという．絶対可積分ならば$f$の積分が定義でき，それは有限の値になる．自然数$p$に対し$\| f \|^p$の積分が有限の値を取るような関数は$p$乗可積分であると言われる．

  $\( X \, cal(A) \, mu \)$上の$p$乗可積分関数全体の集合を$L^p \( X \, cal(A) \, mu \)$と書く．前後の文脈から明らかな場合や誤解の恐れがない場合は$L^p \( mu \)$あるいは$L^p$と書く場合もある．

]
#exm[
  具体的な測度に関する積分をいくつか述べる．

  - $mu = delta_x$（$x in X$上の Dirac
    測度）の場合，$integral f "" #h(-1em) d mu = f \( x \)$．

  - $mu = sum_(n = 1)^oo delta_(x_n)$（計数測度）の場合，$integral "" #h(-1em) d mu = sum_(n = 1)^oo f \( x_n \)$．特に無限級数$sum_(n = 1)^oo a_n$とは，数列$a : bb(N) arrow.r bb(R)$を自然数上の数え上げ測度$sum_(n in bb(N)) delta_n$に関して積分したものにほかならない．

  - $cal(B) \/ cal(B)^(\*)$-可測関数$f : bb(R) arrow.r overline(bb(R))$が閉区間$\[ a \, b \]$上で
    Riemann
    積分可能であるならば，$integral_(\[ a \, b \]) f "" #h(-1em) d lambda = integral_a^b f \( x \) "" #h(-1em) d x$が成り立つ（左辺は
    Lebesgue 測度に関する積分，右辺は Riemann 積分）．それを踏まえて今後は
    Riemann 積分可能な関数の Lebesgue
    測度に関する積分$integral f \( x \) "" #h(-1em) d lambda \( x \)$のことも$integral f \( x \) "" #h(-1em) d x$と書いてよいとわかる．なお，実際にはもっと強いことが言えるので，（積分が定義できる前提で）$integral f \( x \) "" #h(-1em) d lambda \( x \)$のことを$integral f \( x \) "" #h(-1em) d x$と書いてよいからそうする；次の問を参照せよ#footnote[TODO:
      この問は特に，できればちゃんと証明をつけて本文に組み込んでしまいたい．];．

]
#que[
  $\( X \, cal(A) \)$を可測空間とする．

  + 測度$mu : cal(A) arrow.r \[ 0 \, oo \]$が完備であるとは，$mu \( N \) = 0$かつ$M subset N$ならば$M in cal(A)$が成り立つことをいう．言葉で述べれば，測度が0となるような可測集合の部分集合が必ず可測となるとき，その測度は完備であると言われる．
    このノートにおける Lebesgue 測度は完備ではない．

  + 一般に，完備とは限らない測度$mu : cal(A) arrow.r \[ 0 \, oo \]$が与えられたとき，$cal(A) subset cal(A)^(\*)$を充たす$sigma$-加法族ならびにその上の完備な測度$mu^(\*) : cal(A)^(\*) arrow.r \[ 0 \, oo \]$であって，$cal(A)$上で$mu$に一致するものが存在する．このような$mu^(\*)$の作り方の一つに「完備化」というものがある．$lambda$の完備化によって得られる$sigma$-加法族を$cal(L)$と書き，$cal(L)$の元を
    Lebesgue 可測集合という．また，文献によってはこのノートにおける
    Lebesgue 測度の完備化を単に Lebesgue 測度と呼ぶものもある．

  + Riemann
    積分可能な関数$f : \[ a \, b \] arrow.r bb(R)$は，一般には$cal(B) \/ cal(B)^(\*)$-可測であるとは限らない．が，$cal(L) \/ cal(B)^(\*)$-可測にはなる．更に$integral_(\[ a \, b \]) f "" #h(-1em) d lambda = integral_a^b f \( x \) "" #h(-1em) d x$が成り立つ（左辺は
    Lebesgue 測度の完備化に関する積分，右辺は Riemann
    積分）．完備化まで考えれば，Lebesgue 測度に関する積分は Riemann
    積分を包括していると言える．

  + 他方，広義 Riemann
    積分まで含めて考えると事情はやや複雑である．$f : \[ 0 \, oo \) arrow.r overline(bb(R))$が非負であるか$f in L^1$であるならば，$integral_(\( 0 \, oo \)) f "" #h(-1em) d lambda = integral_0^oo f "" #h(-1em) d x$が成り立つ（右辺は広義
    Riemann
    積分として$integral_0^oo f "" #h(-1em) d x colon.eq lim_(R arrow.r oo) integral_0^R f "" #h(-1em) d x$を考えているが，他の形の極限であったとしても本質的には同様に議論できると思う）．一方，$f \( x \) = frac(sin x, x)$は広義
    Riemann
    積分としては有限確定値$integral_0^oo f "" #h(-1em) d x = pi / 2$を持つが，$f$は絶対可積分ではないので$integral_(\( 0 \, oo \)) f "" #h(-1em) d lambda = oo$である．この例は優収束定理が使えない例としても捉えることができると思う．

]
#dig[
  実際には Riemann
  積分可能とは限らない関数も積分できる場合がある（たとえば$1_(bb(Q))$がそう）．なので
  Lebesgue 測度に関する積分は Riemann 積分の一般化と言える…が，個人的には
  $1_(bb(Q))$が積分できるようになったからといって特にありがたい気はしない．測度論の主たるありがたみはそこではないと思っているので，Riemann
  積分の限界だの一般化だのという文脈に沿って測度論を展開するのは好きになれない（勿論，測度に関する積分の具体例の中で
  Riemann
  積分は致命的に重要であるとも思うが）#footnote[昔の私は「測度論というのは
    Riemann 積分の拡張としての Lebesgue
    積分論のことで，それをキチンと理解していないと測度論的確率論はわからないのではないか」と思っていたのだが，実際にはこの認識は誤りであった．また測度論に対しても苦手意識があったのだが，確率論を勉強する際に抽象的な形で測度論を勉強したところわかりやすく，むしろ
    Riemann
    積分の拡張という歴史的経緯を重視した論理展開に理解を阻害されていた（と，あとになって気づいた）．もちろん歴史的には測度論の走りは
    Riemann
    積分の拡張にあったのだろうとは思うが，論理構成の上では歴史的経緯を踏まえることは必ずしも必要ない（どころか，場合によっては遠回りにすらなり得る）と思う．更に個人的な事情としては，私はとくに多変数の
    Riemann
    積分を真面目に勉強したことがなく，他の概念を理解するための中継地として
    Riemann
    積分が機能しづらかったというのもあるかもしれない．];．少なくとも計算機に載せようとするときは
  Riemann
  積分の定義に沿ってやったほうが簡単なのではないかと思っているが，そうでもないのだろうか？

]
#prop[
  上記の単関数に対する積分の定義は well-defined である．

]
#proof[
  単関数$f$が$a_i \, b_j in bb(R)$ならびに$A_i \, B_j in cal(A)$（ただし$1 lt.eq i lt.eq n$および$1 lt.eq j lt.eq m$）を用いて$f = sum_(i = 1)^n a_i 1_(A_i) = sum_(j = 1)^m b_j 1_(B_j)$と2通りに表示できていたとする．このとき$C_(i j) colon.eq A_i sect B_j$と置けば$C_(i j) in cal(A)$であり，かつ$C_(i j)$上で$a_i = b_j$なので，
  $ sum_(i = 1)^n a_i mu \( A_i \) = sum_(i = 1)^n sum_(j = 1)^m a_i mu \( C_(i j) \) = sum_(i = 1)^n sum_(j = 1)^m b_j mu \( C_(i j) \) = sum_(j = 1)^m b_j mu \( B_j \) $となる．

]
さて，実際の積分の計算では，積分の評価しやすい関数列$f_n$であって被積分関数$f$に何らかの意味で収束するものを取ってきて，$lim_(n arrow.r oo) integral f_n "" #h(-1em) d mu$を計算する戦略を取ることが多々ある．が，これが$integral f "" #h(-1em) d mu$に一致するには，言い換えれば積分と極限の順序交換ができるには一定の条件が必要である．この問題に対する（個人的には
Riemann 積分の場合よりも遥かに単純だと思う）充分条件を以下に述べていく．

#defi[
  関数$f : X arrow.r bb(R)$と$g : X arrow.r bb(R)$が任意の$x in X$に対して$f \( x \) lt.eq g \( x \)$を充たすとき，$f lt.eq g$と書く．$f_1 lt.eq f_2 lt.eq dots.h.c$を充たす関数の族\$\\set{f\_n}\_{n=1}^\\infty\$が，任意の$x in X$に対して$lim_(n arrow.r oo) f_n \( x \) = f \( x \)$を充たすとき$f_n arrow.t f$と書く．

]
#lem[
  単関数に対する積分は単調性ならびに線型性を充たす．すなわち，$f \, g : X arrow.r \[ 0 \, oo \]$を非負単関数，$a \, b in bb(R)$とするとき，

  - $f lt.eq g$を充たすならば$integral f "" #h(-1em) d mu lt.eq integral g "" #h(-1em) d mu$．

  - $integral \( a f + b g \) "" #h(-1em) d mu = a integral f "" #h(-1em) d mu + b integral g "" #h(-1em) d mu$．

  したがって特に$A in cal(A)$とするとき，$f^plus.minus 1_A lt.eq f^plus.minus$なので，$f$の積分が定義できるならば$integral_A f "" #h(-1em) d mu$も定義される．

]
#proof[
  $f = sum_(i = 1)^m a_i 1_(A_i)$，$g = sum_(j = 1)^n b_j 1_(B_j)$と表示し，更に$C_(i j) colon.eq A_i sect B_j$と置く．このとき$f + g = sum_(i = 1)^m sum_(j = 1)^n \( a_i + b_j \) 1_(C_(i j))$が成り立つので，
  $ integral \( f + g \) "" #h(-1em) d mu & = sum_(i = 1)^m sum_(j = 1)^n \( a_i + b_j \) mu \( C_(i j) \)\
  & = sum_(i = 1)^m sum_(j = 1)^n a_i mu \( C_(i j) \) + sum_(i = 1)^m sum_(j = 1)^n b_j mu \( C_(i j) \)\
  & = sum_(i = 1)^m a_i mu \( A_i \) + sum_(j = 1)^n b_j mu \( B_j \)\
  & = integral f "" #h(-1em) d mu + integral g "" #h(-1em) d mu $を得る．定数倍が積分記号と交換できることは積分の定義から直ちに従う．

  $f \, g$が$f lt.eq g$を充たす非負単関数ならば$g - f gt.eq 0$すなわち$integral \( g - f \) "" #h(-1em) d mu gt.eq 0$なので，積分の線型性より$integral g "" #h(-1em) d mu gt.eq integral f "" #h(-1em) d mu$である（単関数は決して$plus.minus oo$を取らないので，この議論の過程で$oo - oo$は起こらない）．

]
#dig[
  積分の線型性は「何を当たり前な…」と思うかも知れないが，非負可測関数に対する積分の線型性を証明するには単調収束定理（の特別な場合）が必要になるので，あまり自明ではないと思う．ところで
  Riemann 積分に対する積分の線型性をどうやって示すのか，私は忘れました．

]
#lem[
  $f : X arrow.r bb(R)$を非負可測関数とするとき，非負単関数からなる列\$\\set{f\_n}\_{n=1}^\\infty\$であって，$f_n arrow.t f$を充たすようなものがある．

]
<非負単関数の列>
#proof[
  $n in bb(N)$ならびに$i = 1 \, 2 \, dots.h \, n 2^n$に対して$B_n colon.eq f^(- 1) \( \[ n \, oo \) \)$，$A_(n \, i) colon.eq f^(- 1) (lr([frac(i - 1, 2^n) \, i / 2^n)))$と定めた上で，
  $ f_n colon.eq n 1_(B_n) + sum_(i = 1)^(n 2^n) frac(i - 1, 2^n) 1_(A_(n \, i)) $とすれば，$0 lt.eq f_n lt.eq f$である．自然数$N$が充分大きければ$\| f \( x \) - f_N \( x \) \| < 2^(- N)$なので，$lim_(n arrow.r oo) f_n \( x \) = f \( x \)$もよい．$n$に関する単調性は以下の考察から分かる#footnote[ここ，もっと簡単にならないか？];．

  - $x in B_(n + 1)$の場合．$n = f_n \( x \) < f_(n + 1) \( x \) = n + 1$．

  - $x in B_n \\ B_(n + 1)$の場合．$f_n \( x \) = n$はよい．$f_(n + 1) \( x \) < n$であったとすると，$i \/ 2^(n + 1) lt.eq n$を充たすある$i$について$x in \[ \( i - 1 \) \/ 2^(n + 1) \, i \/ 2^(n + 1) \)$であることになるが，これは$x in.not B_n$を含意するので矛盾である．

  - $x in.not B_n$の場合．ある$i$について$x in A_(n \, i)$であるが，$A_(n \, i) = A_(n + 1 \, 2 i - 1) union A_(n + 1 \, 2 i)$と分解でき，$f_n \|_(A_(n \, i)) = \( i - 1 \) \/ 2^n = f_(n + 1) \|_(A_(n + 1 \, 2 i - 1)) lt.eq f_(n + 1) \|_(A_(n + 1 \, 2 i))$なのでよい．

]
#dig[
  上記の補題は証明とその気持ちがかなり離れた証明のひとつだと思う．気分としては$f_n$は「$f$の値が$n$未満の部分はちゃんと近似する気があるが，それ以上は$n$につぶす」という関数である．その上で$f_n$が$f$に各点収束してほしいので，近似する範囲が$O \( n \)$で増えていくことを踏まえてそれ以上に細かい分割（たとえば$O \( 2^n \)$で増える分割）を取ることで，近似する範囲の近似精度を高めようとしている．実際には$O \( 2^n \)$で増える分割を採らずとも，$O \( n^2 \)$で増える分割でも間に合うのかも知れない．収束は遅くなりそうだが，収束さえしてくれればとりあえずの使い勝手は困らない，ような気がする．

]
#thm[
  $f : X arrow.r \[ 0 \, oo \]$ならびに$f_n : X arrow.r \[ 0 \, oo \]$（$n in bb(N)$）を可測関数とする．$f_n arrow.t f$ならば$lim_(n arrow.r oo) integral f_n "" #h(-1em) d mu = integral f "" #h(-1em) d mu$．

]
#proof[
  証明を二段階に分割する．まず$f_n$が非負単関数の列であった場合を考えると，$integral f_n "" #h(-1em) d mu$は$n$に関して非減少なので，$c colon.eq lim_(n arrow.r oo) integral f_n "" #h(-1em) d mu$が$\[ 0 \, oo \]$の範囲に存在する．更に非負可測関数に対する積分の定義より，$c lt.eq integral f "" #h(-1em) d mu$が成り立つ．$g : X arrow.r \[ 0 \, oo \]$を，$g lt.eq f$を充たすような任意の非負単関数とするとき，$integral g "" #h(-1em) d mu lt.eq c$を示せばよい．$g = sum_(i = 1)^m a_i 1_(A_i)$と表示する．非負単関数に対する積分の線型性より，各$1 lt.eq i lt.eq m$に対して$a_i mu \( A_i \) lt.eq lim_(n arrow.r oo) integral f_n 1_(A_i) "" #h(-1em) d mu$を示せば充分なのでそうする．$epsilon in \( 0 \, 1 \)$を任意に固定し，\$B\_{n,i} \\coloneqq \\set{x \\in X | f\_n(x) 1\_{A\_i} \> (1-\\varepsilon) a\_i }\$と置くと，$B_(n \, i) arrow.t A_i$．更に$integral f_n 1_(A_i) "" #h(-1em) d mu gt.eq integral f_n 1_(B_(n \, i)) "" #h(-1em) d mu gt.eq \( 1 - epsilon \) mu \( B_(n \, i) \)$であるから，$n arrow.r oo$の極限をとって$lim_(n arrow.r oo) integral f_n 1_(A_i) "" #h(-1em) d mu gt.eq \( 1 - epsilon \) a_i mu \( A_i \)$であり，$epsilon arrow.r 0$の極限を取ることで結論を得る．

  次に$f_n$が非負可測関数の列であった場合を考える．補題@非負単関数の列
  より非負単関数の列\$\\set{g\_{n,i}}\_{i=1}^\\infty\$であって$g_(n \, i) arrow.t f_n$であるようなものがある．\$h\_m \\coloneqq \\max\\set{ g\_{m,1}, g\_{m,2},\\dots, g\_{m,m} }\$と置けば\$\\set{h\_m}\_{m=1}^\\infty\$は単関数であって，$h_m lt.eq f_m$ならびに$h_m arrow.t f$を充たす．積分の単調性より$integral h_m "" #h(-1em) d mu lt.eq integral f_m "" #h(-1em) d mu lt.eq integral f "" #h(-1em) d mu$であり，前段の結果より$lim_(m arrow.r oo) integral h_m "" #h(-1em) d mu = integral f "" #h(-1em) d mu$なので，はさみうちの原理より$lim_(n arrow.r oo) integral f_n "" #h(-1em) d mu = integral f "" #h(-1em) d mu$である．

]
#thm[
  $f_n : X arrow.r \[ 0 \, oo \]$（$n in bb(N)$）を可測関数の族とする．このとき$integral liminf_(n arrow.r oo) f_n "" #h(-1em) d mu lt.eq liminf_(n arrow.r oo) integral f_n "" #h(-1em) d mu$．

]
#proof[
  $g_n colon.eq inf_(m gt.eq n) f_m$と置くと，$g_n arrow.t sup_n g_n = liminf_(n arrow.r oo) f_n$なので，単調収束定理より$lim_(n arrow.r oo) integral g_n "" #h(-1em) d mu = integral liminf_(n arrow.r oo) f_n "" #h(-1em) d mu$．また$g_n lt.eq f_n$なので$integral g_n "" #h(-1em) d mu lt.eq integral f_n "" #h(-1em) d mu$すなわち$liminf_(n arrow.r oo) integral g_n "" #h(-1em) d mu lt.eq liminf_(n arrow.r oo) integral f_n "" #h(-1em) d mu$である．以上より$integral liminf_(n arrow.r oo) f_n "" #h(-1em) d mu = lim_(n arrow.r oo) integral g_n "" #h(-1em) d mu = liminf_(n arrow.r oo) integral g_n "" #h(-1em) d mu lt.eq liminf_(n arrow.r oo) integral f_n "" #h(-1em) d mu$を得る．

]
#thm[
  $f_n in L^1$（$n in bb(N)$）がある関数$f : X arrow.r bb(R)$に各点収束していた，すなわち任意の$x in X$に対して$lim_(n arrow.r oo) f_n \( x \) = f \( x \)$であったと仮定する．このとき，ある$g in L^1$に対して$\| f_n \| lt.eq g$であるならば，$f in L^1$であり，$lim_(n arrow.r oo) integral f_n "" #h(-1em) d mu = integral f "" #h(-1em) d mu$．

]
#proof[
  $\| f \| lt.eq \| g \|$なので$f in L^1$はよい．$g + f_n gt.eq 0$なので
  Fatou
  の補題が使えて，$integral lim_(n arrow.r oo) \( g + f_n \) "" #h(-1em) d mu lt.eq liminf_(n arrow.r oo) integral \( g + f_n \) "" #h(-1em) d mu$すなわち$integral lim_(n arrow.r oo) f_n "" #h(-1em) d mu lt.eq liminf_(n arrow.r oo) integral f_n "" #h(-1em) d mu$である．同様に$g - f_n gt.eq 0$なので再び
  Fatou
  の補題により$integral lim_(n arrow.r oo) \( g - f_n \) "" #h(-1em) d mu lt.eq liminf_(n arrow.r oo) integral \( g - f_n \) "" #h(-1em) d mu$つまり$limsup_(n arrow.r oo) integral f_n "" #h(-1em) d mu lt.eq integral lim_(n arrow.r oo) f_n "" #h(-1em) d mu$である．あとははさみうちの原理によればよい．

]
収束定理たちの応用や，積分にまつわる具体例たちを見ていくことにしよう．

#cor[
  可測関数$f \, g : X arrow.r overline(bb(R))$が非負であるか，または$f \, g in L^1$であるならば，任意の$a \, b in bb(R)$に対して$integral \( a f + b g \) "" #h(-1em) d mu = a integral f "" #h(-1em) d mu + b integral g "" #h(-1em) d mu$．

]
#proof[
  $f \, g$が非負ならば，非負単関数の列\$\\set{f\_n}\$ならびに\$\\set{g\_n}\$であって$f_n arrow.t f$，$g_n arrow.t g$を充たすものをとった上で単調収束定理を繰り返し使うと$a integral f "" #h(-1em) d mu + b integral g "" #h(-1em) d mu = a integral lim_(n arrow.r oo) f_n "" #h(-1em) d mu + b integral lim_(n arrow.r oo) g_n "" #h(-1em) d mu = lim_(n arrow.r oo) a integral f_n "" #h(-1em) d mu + b integral g_n "" #h(-1em) d mu = lim_(n arrow.r oo) integral \( a f_n + b g_n \) "" #h(-1em) d mu = integral \( f + g \) "" #h(-1em) d mu$．$f \, g in L^1$の場合は正部分と負部分に分けて非負可測関数に対する積分の線型性を適用すればよい．

]
#thm[
  非負可測関数$f_n : X arrow.r \[ 0 \, oo \]$（$n in bb(N)$）に対して，$sum_(n = 1)^oo (integral f_n "" #h(-1em) d mu) = integral (sum_(n = 1)^oo f_n) "" #h(-1em) d mu$．すなわち非負可測関数に関する限り，積分と級数は自由に交換できる．

]
#proof[
  $g_N colon.eq sum_(n = 1)^N f_n$と置けば$g_N arrow.t sum_(n = 1)^oo f_n$なので，積分の線型性と単調収束定理より$lim_(N arrow.r oo) sum_(n = 1)^N (integral f_n "" #h(-1em) d mu) = lim_(N arrow.r oo) integral g_N "" #h(-1em) d mu = integral lim_(N arrow.r oo) g_N "" #h(-1em) d mu = integral (sum_(n = 1)^oo f_n) "" #h(-1em) d mu$．

]
#dig[
  （書くのを忘れていなければ）後に見るが，上記は Fubini
  の定理を用いても証明できる（はず）．

]
#exm[
  $n in bb(N)$に対して$f_n colon.eq 1_(\[ n \, n + 1 \))$と置くと，任意の$n in bb(N)$に対して$integral f_n "" #h(-1em) d mu = 1$であるが，$f_n arrow.r 0$なので$integral lim_(n arrow.r oo) f_n "" #h(-1em) d mu = 0$．従って特に$integral lim_(n arrow.r oo) f_n "" #h(-1em) d mu < lim_(n arrow.r oo) integral f_n "" #h(-1em) d mu$である．

]
#thm[
  $f : X times \( a \, b \) arrow.r bb(R)$を，次の3条件を充たす関数とする．

  - 任意の$t in \( a \, b \)$に対して$\( x mapsto f \( x \, t \) \) in L^1$．

  - 任意の$x in X$に対して，$g_x : \( a \, b \) in.rev t mapsto f \( x \, t \) in bb(R)$は$\( a \, b \)$において微分可能．

  - ある$h in L^1$が存在して，任意の$x in X$ならびに$t_0 in \( a \, b \)$に対して$lr(|d g_x \/ d t \( t_0 \)|) lt.eq h \( x \)$．

  このとき，$g : \( a \, b \) in.rev t mapsto integral f \( x \, t \) "" #h(-1em) d mu \( x \) in bb(R)$は$\( a \, b \)$において微分可能であって，任意の$t_0 in \( a \, b \)$に対して
  $ frac(d g, d t) \( t_0 \) = integral frac(d g_x, d t) \( t_0 \) "" #h(-1em) d mu \( x \) $が成り立つ．人口に膾炙した記号を用いてより象徴的に書けば，
  $ frac(d, d t) #scale(x: 240%, y: 240%)[\|] _(t = t_0) integral f \( x \, t \) "" #h(-1em) d mu \( x \) = integral frac(partial f, partial t) \( t_0 \, x \) "" #h(-1em) d mu \( x \) $が任意の$t_0 in \( a \, b \)$に対して成り立つ．

]
<微分と積分の交換>
#proof[
  $t_0 in \( a \, b \)$を任意にひとつ固定する．$bb(R)$の点列\$\\set{\\delta\_n}\_{n=1}^\\infty\$を，$delta_1 < b - t_0$ならびに$delta_n arrow.b 0$を充たすように取る．平均値の定理より，任意の$x in X$ならびに$n in bb(N)$に対してある$theta_(t_0 \, x \, n) in \[ 0 \, 1 \]$が存在して
  $ frac(f \( x \, t_0 + delta_n \) - f \( x \, t_0 \), delta_n) = frac(d g_x, d t) \( x \, t_0 + theta_(t_0 \, x \, n) delta_n \) $が成り立つ．従って任意の$t_0 in \( a \, b \)$，$x in X$ならびに$n in bb(N)$に対して$lr(|frac(f \( x \, t_0 + delta_n \) - f \( x \, t_0 \), delta_n)|) lt.eq h \( x \)$が成り立つから，優収束定理より
  $ lim_(n arrow.r oo) frac(integral f \( x \, t_0 + delta_n \) "" #h(-1em) d mu \( x \) - integral f \( x \, t_0 \) "" #h(-1em) d mu \( x \), delta_n) = integral lim_(n arrow.r oo) frac(f \( x \, t_0 + delta_n \) - f \( x \, t_0 \), delta_n) "" #h(-1em) d mu \( x \) $を得るので結論が従う．

]
#cor[
  $f_n : \( a \, b \) in.rev t mapsto f_n \( t \) in bb(R)$を微分可能な関数とし，任意の$t in \( a \, b \)$に対して$sum_(n = 1)^oo \| f_n \( t \) \| < oo$であったと仮定する．このとき，任意の$t in \( a \, b \)$に対して
  $sum_(n = 1)^oo frac(d, d t) f_n \( t \) < oo$であるならば，任意の$t_0 in \( a \, b \)$に対して
  $ frac(d, d t) sum_(n = 1)^oo f_n \( t_0 \) = sum_(n = 1)^oo frac(d, d t) f_n \( t_0 \) . $

]
#proof[
  前定理において$mu$を$bb(N)$上の計数測度に取れ．

]
#prop[
  以下，$f : \[ a \, b \] times \[ c \, d \] arrow.r bb(R)$を連続関数とし，更に$partial_2 f$が存在して連続であるとする．

  + $F \( x \, y \) colon.eq integral_a^x f \( t \, y \) "" #h(-1em) d t$と定めると，$partial_1 F = f$および$partial_2 F \( x \, y \) = integral_a^x partial_2 f \( t \, y \) "" #h(-1em) d t$が成り立つ．

  + $g : bb(R) arrow.r \( a \, b \)$を微分可能な関数とし，$G \( x \) colon.eq integral_a^(g \( x \)) f \( t \, x \) "" #h(-1em) d t$と置くと，$G' \( x \) = f \( g \( x \) \, x \) dot.op g' \( x \) + integral_a^(g \( x \)) partial_2 f \( t \, x \) "" #h(-1em) d t$が成り立つ．特に$g \( x \) = x$のとき，$G' \( x \) = f \( x \, x \) + integral_a^x partial_2 f \( t \, x \) "" #h(-1em) d t$である．

]
#proof[
  + $partial_1 F = f$は微積分学の基本定理である．$f$は@微分と積分の交換
    の前件をすべて充たすので，積分と微分を入れ替えてよいから後半も従う．

  + 合成関数$x mapsto \( g \( x \) \, x \) mapsto F \( g \( x \) \, x \)$に合成則と
    (i) の結果を使え．

]
#que[
  @微分と積分の交換 の前件を検討すれば，Leibniz
  の積分公式において$f$に課した条件はより弱められることがわかる．ところでこの公式は名前がついているくらいだし，いろいろなところで使われると思うのだが，私は使いみちをよく知りません．

]
以下，やや寄り道となるが，$L^p$たちの包含関係について議論する．$parallel f parallel_p colon.eq (integral \| f \|^p "" #h(-1em) d mu)^(1 \/ p)$と定める．

#que[
  $f in L^p$と$parallel f parallel_p < oo$は同値である．$parallel f parallel_p$のことを$L^p$ノルムと呼びたいのだが，実際には$f = g med mu$-a.eでさえあれば（$f = g$ではなかったとしても）$integral f "" #h(-1em) d mu = integral g "" #h(-1em) d mu$となるので，ノルムの同一律を充たさない．なので「測度零集合での違いを除いて一致する」事に関する同値関係を入れ，その同値類の集合を考えないとノルムにはならない．文献によっては，同値関係で割る前の集合のことを$cal(L)^p$と書き，割ったあとの集合のことを$L^p$と書いているものもある．

]
#thm[
  $a \, b$を非負実数，$p \, q$を$p^(- 1) + q^(- 1) = 1$を充たす自然数とするとき，$a b lt.eq \( a^p \/ p \) + \( b^q \/ q \)$．

]
#proof[
  $a = 0$または$b = 0$の場合はあきらか．そうでないとすると，対数関数の凸性より$log \( \( a^p \/ p \) + \( b^q \/ q \) \) gt.eq log a + log b$を得るので，両辺の指数を取って結論を得る．

]
#thm[
  可測関数$f \, g : X arrow.r overline(bb(R))$および$1 \/ p + 1 \/ q = 1$を充たす自然数$p \, q$に対して$integral \| f g \| "" #h(-1em) d mu lt.eq parallel f parallel_p parallel g parallel_q$が成り立つ．$p = q = 2$の場合を
  Cauchy-Schwarz の不等式という．

]
#proof[
  $parallel f parallel_p = 0$ないしは$parallel g parallel_q = 0$であるならば$mu$-a.eに$f = 0$または$mu$-a.eに$g = 0$なので，不等式の両辺とも0である．従って$parallel f parallel_p > 0$かつ$parallel g parallel_q > 0$と仮定してよい．更に積分の線型性より$f$を$f \/ parallel f parallel_p$に，$g$を$g \/ parallel g parallel_q$に置き換えて証明すれば良いことがわかるので，最初から$parallel f parallel_p = 1$かつ$parallel g parallel_q = 1$であるとして示して良い．Youngの不等式より各$x in X$に対して$\| f \( x \) g \( x \) \| lt.eq \( \| f \( x \) \|^p \/ p \) + \( \| f \( x \) \|^q \/ q \)$を得るので，両辺を積分して$integral \| f g \| "" #h(-1em) d mu lt.eq \( parallel f parallel_p \/ p \) + \( parallel f \( x \) parallel^q \/ q \) = \( 1 \/ p \) + \( 1 \/ q \) = 1$となる．

]
#prop[
  $mu \( X \) < oo$，すなわち$mu$が有限測度であるとする．このとき$p gt.eq q$ならば$L^p \( mu \) subset L^q \( mu \)$である．

]
#proof[
  $f in L^p$を任意に取る．$r colon.eq p \/ q$，$s = p \/ \( p - q \)$として
  Hölder の不等式を使えば
  $ integral \| f \|^q "" #h(-1em) d mu lt.eq parallel \| f \|^q parallel_r parallel 1 parallel_s = mu \( X \)^(\( p - q \) \/ p) (integral \| f \|^p "" #h(-1em) d mu)^(q \/ p) $を得る．$integral \| f \|^p "" #h(-1em) d mu < oo$ならびに$mu \( X \) < oo$なので$parallel f parallel_q < oo$，すなわち$f in L^q$である．

]
上記の包含関係が成り立つ上で$mu$の有限性は本質的である．

#exm[
  $f : bb(R) arrow.r bb(R)$を，$f \( x \) colon.eq 1 / x 1_(\[ 1 \, oo \)) \( x \)$で定める．$f$のLebesgue測度に関する積分を考えると，$integral f "" #h(-1em) d lambda = integral_1^oo frac("" #h(-1em) d x, x) = [log x]_(x = 1)^(x = oo) = oo$なので$f in.not L^1$．ところが任意の$p gt.eq 2$に対して$integral f^p "" #h(-1em) d lambda = integral_1^oo frac("" #h(-1em) d x, x^p) = [frac(1, - p + 1) x^(- p + 1)]_(x = 1)^(x = oo) = frac(1, - p + 1) < oo$なので$f in L^p$である．他方$g : bb(R) arrow.r bb(R)$を$g \( x \) colon.eq 1_(\( 0 \, 1 \]) \( x \) 1 / sqrt(x)$で定めると，$integral g "" #h(-1em) d lambda = integral_0^1 frac("" #h(-1em) d x, sqrt(x)) = [2 sqrt(x)]_(x = 0)^(x = 1) = 2$なので$g in L^1$である．他方，$integral g^2 "" #h(-1em) d lambda = integral_0^1 frac("" #h(-1em) d x, x) = [log x]_(x = 0)^(x = 1) = - oo$なので$g in.not L^2$．したがって，この場合は$L^1 subset L^2$でも$L^2 subset L^1$でもない．

]
#exm[
  ここでは$\( bb(N) \, 2^(bb(N)) \)$上の計数測度を考える．この測度に関する$L^p$空間のことを$ell^p$と書くことにする；すなわち，\$\\ell^p \\coloneqq \\set{ \\set{x\_i} \\in \\mathbb{R}^\\mathbb{N}| \\sum\_{i=1}^\\infty |x\_i|^p \< \\infty }\$．この設定のもとでは，$p lt.eq q$ならば$ell^p subset.neq ell^q$が成り立つ．それを見るために$x in ell^p$を取ると，ある適当な$N in bb(N)$が存在して，$i gt.eq N$ならば$x_i < 1$である．従って$sum_(i = N)^oo \| x_i \|^q lt.eq sum_(i = N)^oo \| x_i \|^p < oo$だから$f in ell^q$．また，$y_i colon.eq 1 \/ i$によって数列\$\\set{y\_i}\$を定めると，例えば$sum_(i = 1)^oo \( y_i \)^2 = pi^2 \/ 6 < oo$であるが，$sum_(i = 1)^oo y_i = oo$なので$ell^1 subset.neq ell^2$である．

]
== 拡張定理の証明
<拡張定理の証明>
後回しにしていた，拡張定理（@拡張定理）の証明を与える．存在と一意性のそれぞれに証明を分割する．

#proof[
  $mu^(\*) : 2^X arrow.r \[ 0 \, oo \]$を，
  $ mu^(\*) \( E \) colon.eq inf {sum_(i = 1)^oo mu \( A_i \) med mid(bar.v) med E subset union.big_(i = 1)^oo A_i med upright("and") med A_1 \, A_2 \, dots.h in cal(A)} $によって定める．$E in cal(A)$であるならば，集合列$A_i$を$A_1 = E \, A_2 = nothing \, A_3 = nothing \, dots.h$のように取って考えることで$mu^(\*) \( E \) lt.eq mu \( E \)$がわかる．逆向きの不等式を示せば$mu^(\*)$は写像として$mu$の拡張になっていることがわかるが，このノートではまだサボっている（ここに$mu$の$cal(A)$上での可算加法性を使う）．したがって$mu^(\*)$が$sigma \( cal(A) \)$上の測度であることを示せばよい．以下，一般に実数の部分集合が$A subset B$を充たすならば$inf B lt.eq inf A$であることに注意する．

  まず$mu^(\*)$の単調性，すなわち$E \, F in 2^X$が$E subset F$を充たすならば$mu^(\*) \( E \) lt.eq mu^(\*) \( F \)$となることを示す．
  \$\$\\left\\{ \\set{A\_i} \\subset \\mathcal{A}  \\ \\middle| \\ F \\subset \\bigcup\_{i=1}^\\infty A\_i \\right\\}
  \\subset
  \\left\\{ \\set{A\_i}  \\subset \\mathcal{A} \\ \\middle| \\ E \\subset \\bigcup\_{i=1}^\\infty A\_i \\right\\}\$\$であるから，
  $ {sum_(i = 1)^oo mu \( A_i \) med mid(bar.v) med F subset union.big_(i = 1)^oo A_i med upright("and") med A_1 \, A_2 \, dots.h in cal(A)} subset {sum_(i = 1)^oo mu \( A_i \) med mid(bar.v) med E subset union.big_(i = 1)^oo A_i med upright("and") med A_1 \, A_2 \, dots.h in cal(A)} $すなわち$mu^(\*) \( E \) lt.eq mu^(\*) \( F \)$を得る．

  つづいて$mu^(\*)$の可算劣加法性，すなわち$E_1 \, E_2 \, dots.h in 2^X$に対して$mu^(\*) (union.big_(n = 1)^oo E_n) lt.eq sum_(n = 1)^oo mu^(\*) \( E_n \)$となることを示す．$epsilon > 0$を任意にひとつ取って固定する．各$n = 1 \, 2 \, dots.h$に対して，$cal(A)$の元の族\$\\set{A\_{n,i}}\_{i=1}^\\infty\$を$E_n subset union.big_(i = 1)^oo A_(n \, i)$ならびに$sum_(i = 1)^oo mu \( A_(n \, i) \) < mu^(\*) \( E_n \) + epsilon / 2^n$を充たすように取れるので取る．このとき$union.big_(n = 1)^oo E_n subset union.big_(i \, n = 1)^oo A_(n \, i)$なので，
  $ mu^(\*) (union.big_(n = 1)^oo E_n) lt.eq sum_(i \, n = 1)^oo mu \( A_(n \, i) \) < epsilon + sum_(n = 1)^oo mu^(\*) \( E_n \) $を得る．$epsilon > 0$は任意だったので可算劣加法性が従う．

  更に，次の性質を充たすような集合族$cal(C)$が$cal(A)$を含む$sigma$-加法族であることを示す；$A in cal(C)$であるならば，任意の$E in 2^X$に対して，$mu^(\*) \( E \) = mu^(\*) \( E sect A \) + mu^(\*) \( E \\ A \)$．まず$A in cal(A)$を任意に取る．すると$E subset union.big_(i = 1)^oo A_i$ならば$E sect A subset union.big_(i = 1)^oo \( A_i sect A \)$なので，
  \$\$\\left\\{ \\set{A\_i \\cap A} \\subset \\mathcal{A} \\ \\middle| \\  E \\subset \\bigcup\_{i=1}^\\infty A\_i \\right\\} \\subset
  \\left\\{ \\set{B\_i} \\subset \\mathcal{A} \\ \\middle| \\  E \\cap A \\subset \\bigcup\_{i=1}^\\infty B\_i \\right\\}\$\$すなわち
  $ mu^(\*) \( E sect A \) lt.eq inf {sum_(i = 1)^oo mu \( A_i sect A \) med mid(bar.v) med E subset union.big_(i = 1)^oo A_i} $を得る．同様にして
  $ mu^(\*) \( E \\ A \) lt.eq inf {sum_(i = 1)^oo mu \( A_i \\ A \) med mid(bar.v) med E subset union.big_(i = 1)^oo A_i} $も従う．ゆえに
  $ mu^(\*) \( E sect A \) + mu^(\*) \( E \\ A \) & lt.eq inf {sum_(i = 1)^oo mu \( A_i \\ A \) med mid(bar.v) med E subset union.big_(i = 1)^oo A_i} + inf {sum_(i = 1)^oo mu \( A_i sect A \) med mid(bar.v) med E subset union.big_(i = 1)^oo A_i}\
  & lt.eq inf {sum_(i = 1)^oo mu \( A_i \\ A \) + sum_(i = 1)^oo mu \( A_i sect A \) med mid(bar.v) med E subset union.big_(i = 1)^oo A_i}\
  & = mu^(\*) \( E \) $を得る（最後の等式は測度の非負性，ならびに正項級数は項の順番を並べ替えても値が変わらないことから出る）．逆向きの不等式は可算劣加法性から従う．したがって$cal(A) subset cal(C)$．$X in cal(C)$ならびに$A in cal(C) arrow.r.double X \\ A in cal(C)$はよいので，$A_1 \, A_2 \, dots.h in cal(C)$のときに$union.big_(i = 1)^oo A_i in cal(C)$となること，すなわち$mu^(\*) \( E \) gt.eq mu^(\*) \( E sect union.big_(i = 1)^oo A_i \) + mu^(\*) \( E \\ union.big_(i = 1)^oo A_i \)$となることを示す（逆向きの不等式はやはり可算劣加法性から従うのでよい）．$A_1 \, A_2 in cal(C)$に対して
  $ mu^(\*) \( E \) & = mu^(\*) \( E sect A_1 \) + mu^(\*) \( E \\ A_1 \)\
  & = mu^(\*) \( E sect A_1 \) + mu^(\*) \( \( E \\ A_1 \) sect A_2 \) + mu^(\*) \( \( E \\ A_1 \)\
  & = mu^(\*) \( E sect A_1 \) + mu^(\*) \( \( E \\ A_1 \) sect A_2 \) + mu^(\*) \( \( E \\ A_1 \) \\ A_2 \)\
  & = mu^(\*) (E sect union.big_(i = 1)^2 A_i sect A_1) + mu^(\*) ((E sect union.big_(i = 1)^2 A_i) \\ A_1) + mu^(\*) (E \\ union.big_(i = 1)^2 A_i)\ $を得るので，$B_1 = A_1 \, B_i = A_i \\ B_(i - 1)$と定めて帰納的に議論を繰り返すことで
  $ mu^(\*) \( E \) = mu^(\*) (E \\ union.big_(i = 1)^n A_i) + sum_(i = 1)^n mu^(\*) (E sect B_i) $を得る．なので
  $ mu^(\*) \( E \) gt.eq mu^(\*) (E \\ union.big_(i = 1)^oo A_i) + sum_(i = 1)^n mu^(\*) (E sect B_i) $となるから，第二項に対して$n arrow.r oo$とした上で可算劣加法性を使うことで結論が従う．以上より特に任意の$A in sigma \( cal(A) \)$ならびに$E in 2^X$に対して，$mu^(\*) \( E \) = mu^(\*) \( E sect A \) + mu^(\*) \( E \\ A \)$であるとわかった．

  最後に，$mu^(\*)$が$sigma \( cal(A) \)$上で可算加法的であることを示す．\$\\set{A\_i}\_{i=1}^\\infty\$を排反な$sigma \( cal(A) \)$の元の族とする．やはり可算劣加法性により$mu^(\*) (union.big_(i = 1)^oo A_i) gt.eq sum_(i = 1)^oo mu^(\*) \( A_i \)$を示せば充分なので，そうする．$mu^(\*) (union.big_(i = 1)^oo A_i) = oo$ならばやることはないので，以下$mu^(\*) (union.big_(i = 1)^oo A_i) < oo$とする．先程示した性質によって$mu^(\*) (union.big_(i = 1)^oo A_i) = mu^(\*) (union.big_(i = 1)^n A_i) + mu^(\*) (union.big_(i = n + 1)^oo A_i)$を得るので，特に$mu^(\*) (union.big_(i = 1)^oo A_i) - mu^(\*) (union.big_(i = 1)^n A_i) = mu^(\*) (union.big_(i = n + 1)^oo A_i) gt.eq 0$すなわち$mu^(\*) (union.big_(i = 1)^oo A_i) gt.eq sum_(i = 1)^n mu^(\*) (A_i)$となるから，$n arrow.r oo$とすることで定理の主張を得る．

]
#dig[
  証明の中に現れた$mu^(\*)$は$mu$の外測度と呼ばれる．

  ところで，「任意の$E in 2^X$に対して，$mu^(\*) \( E \) = mu^(\*) \( E sect A \) + mu^(\*) \( E \\ A \)$」という性質を充たす$A$に対して，「$A$は
  Carathéodory
  可測」という言い方もする．証明をよくよく検討すればわかるように，Carathéodory
  可測な集合の全体$cal(C)$は$sigma \( cal(A) \)$よりも大きくなることがあり，かつ$cal(C)$まで測度を拡張することも（証明はほぼそのままに）できる．そうしなかった理由は，あくまで拡張定理を便利な道具扱いにとどめて使い倒そうという観点からすれば，$bb(R)$の測度は$sigma (cal(H))$まで拡張できれば実用上そんなに問題なく，それ以上に測度を作り込んでも仕方がないと判断したからである#footnote[数学に
    YAGNI
    原則を持ち込んでもしょうがないような気もするが，個人の好みということで大目に見てください．];．

]
#que[
  内測度という概念が（外測度と同様に）定義でき，外測度と内測度が一致する時に可測，とすることもある．そのようにして測度を構成した場合，その測度は自動的に完備になる．その際の可測集合の全体は$cal(C)$に一致するような気もするのだが，確かめてみたことはない．

]
一意性の証明にうつる．$pi$-$lambda$定理の証明もここで行う．

#proof[
  $lambda$-システムは$sigma$-加法族と同様に共通部分をとる操作について閉じている；\$\\set{\\mathcal{L}\_\\mu}\_{\\mu \\in M}\$が$lambda$-システムの族であるならば，$sect.big_(mu in M) cal(L)_mu$もまた$lambda$-システムである．そこで，\$L \\coloneqq \\set{ \\mathcal{L} | \\mathcal{L} \\text{は} \\mathcal{P} \\text{を含む}\\ \\lambda\\text{-システム} }\$として，$cal(L)^(\*) colon.eq sect.big_(cal(L) in L) cal(L)$が$sigma$-加法族であることを示せば証明が完結するからそうする．

  「$nothing in cal(L)^(\*)$」および「$A in cal(L)^(\*)$ならば$X \\ A in cal(L)^(\*)$」は$cal(L)^(\*)$の定め方からわかる．$cal(L)^(\*)$が$pi$-システムであることを示せば，$A \, B in cal(L)^(\*)$に対して$A union B = X \\ \( A^C sect B^C \) in cal(L)^(\*)$がわかる．このことから$cal(L)^(\*)$の族\$\\set{A\_i}\_{i=1}^\\infty\$に対して$union.big_(i = 1)^n A_i in cal(L)^(\*)$が従うので，$cal(L)^(\*)$が$lambda$-システムであることと併せて$union.big_(i = 1)^n A_i arrow.t union.big_(i = 1)^oo A_i in cal(L)^(\*)$を得る．

  以下，$cal(L)^(\*)$が$pi$-システムであることを示す．$A in cal(P)$を任意に固定し，\$\\mathcal{D}\_A \\coloneqq \\set{ B \\in \\mathcal{L}^\* | A \\cap B \\in \\mathcal{L}^\* }\$と置く．$cal(D)_A$が$cal(P)$を含む$lambda$-システムであることを示せば，$cal(L)^(\*) = cal(D)_A$がわかるので，$A$の任意性と併せて次のことが言える；任意の$A in cal(P)$および$B in cal(L)^(\*)$に対して$A sect B in cal(L)^(\*)$．その上で今度は$B in cal(L)^(\*)$を任意に固定し，\$\\mathcal{E}\_B \\coloneqq \\set{A \\in \\mathcal{L}^\* | A \\cap B \\in \\mathcal {L}^\*}\$と置いて，$cal(E)_B$が$cal(P)$を含む$lambda$-システムであることを示せば，$cal(L)^(\*) = cal(E)_B$がわかるので，$B$の任意性と併せて$cal(L)^(\*)$が$pi$-システムであることが従う．

  議論は同様なので$cal(D)_A$が$cal(P)$を含む$lambda$-システムであることだけを示す．$cal(P)$は$pi$-システムなので$cal(P) subset cal(D)_A$である．$A in cal(L)^(\*)$だから$X in cal(D)_A$もよい．$B \, C in cal(D)_A$を$B subset C$を充たすようにとれば，$A sect \( C \\ B \) = \( A sect C \) \\ \( A sect B \) in cal(L)^(\*)$となるので$C \\ B in cal(D)_A$である．集合の増大列\$\\set{B\_i}\$，$B_i in cal(D)_A$を取ると，$A sect union.big_(i = 1)^n B_i in cal(L)^(\*)$なので$A sect union.big_(i = 1)^n B_i arrow.t A sect union.big_(i = 1)^oo B_i in cal(L)^(\*)$であるから$union.big_(i = 1)^oo B_i in cal(D)_A$である．

]
#proof[
  $nu_1 \, nu_2$を$mu$の拡張とし，$A in cal(A)$を$mu \( A \) < oo$を充たすように任意に1つ取って固定する．その上で，
  \$\$\\mathcal{L}\_A \\coloneqq \\set{ B \\in \\sigma(\\mathcal{A}) | \\nu\_1(A \\cap B) = \\nu\_2(A \\cap B)}\$\$と置く．$cal(L)_A$が$cal(A)$を含む$lambda$-システムであることが示せたとすると，$pi$-$lambda$定理によって$sigma \( cal(A) \) = cal(L)_A$を得る．$A$は$mu \( A \) < oo$を満たせば任意だったので，$mu \( A \) < oo$を充たす任意の$A in cal(A)$ならびに任意の$B in sigma \( cal(A) \)$に対して$nu_1 \( A sect B \) = nu_2 \( A sect B \)$を得る．$mu$は$cal(A)$上$sigma$-有限なので，$mu \( A_i \) < oo$を充たす集合の増大列$A_i$があり$union.big_(i = 1)^oo A_i = X$である．したがって任意の$B in sigma \( cal(A) \)$に対して$B sect A_i arrow.t B$であるから，$nu_1 \( B \) = lim_(i arrow.r oo) nu_1 \( B sect A_i \) lim_(i arrow.r oo) nu_2 \( B sect A_i \) = nu_2 \( B \)$すなわち$nu_1 = nu_2$を得る．

  あとは$cal(L)_A$が$cal(A)$を含む$lambda$-システムであることを示せば良い．$cal(A)$上$nu_1 = nu_2$で，かつ$cal(A)$は$pi$-システムなので$cal(A) subset cal(L)_A$である．したがって$X in cal(L)_A$もよい．$B_1 \, B_2 in cal(L)_A$が$B_1 subset B_2$を充たすならば，$nu_1 \( A sect \( B_2 \\ B_1 \) \) = nu_1 \( \( A sect B_2 \) \\ \( A sect B_1 \) \) = nu_1 \( A sect B_2 \) - nu_1 \( A sect B_1 \) = nu_2 \( A sect B_2 \) - nu_2 \( A sect B_1 \) = nu_2 \( \( A sect B_2 \) \\ \( A sect B_1 \) \) = nu_2 \( A sect \( B_2 \\ B_1 \) \)$なので$B_2 \\ B_1 in cal(L)_A$である（ここで$nu_1 \( A \) = nu_2 \( A \) < oo$を使っている）．$B_i arrow.t B$なる\$\\set{B\_i} \\subset \\mathcal{L}\_A\$に対して$nu_1 \( A sect B \) = lim_(i arrow.r oo) nu_1 \( A sect B_i \) = lim_(i arrow.r oo) nu_2 \( A sect B_i \) = nu_2 \( A sect B \)$であるので，$B in cal(L)_A$である．

]
10pt 15pt #strong[] . 5pt plus 1pt minus 1pt

= 多変数関数の積分
<多変数関数の積分>
前節に引き続き，積分の議論を続ける．第一の話題である Fubini
の定理は，いわゆる多変数関数の重積分を各変数に関する逐次積分で置き換えてよい充分条件を与える．この定理を
Riemann
積分の範囲内で厳密に記述するとやや複雑となる．この複雑さを排し，よりシンプルな形で述べたい，というのが測度論を導入した所以のひとつである．

この章の目標のもう一つは重積分の変数変換公式である．その証明の過程で「1の分割」と呼ばれる概念を導入する．1の分割は，局所的な考察を張り合わせて大域的な結果を得るために使う．後の章でも，例えば
Riemann 計量の存在証明に用いられる．

== 直積測度と Fubini の定理
<直積測度と-fubini-の定理>
重積分を定義するために Lebesgue
測度を$bb(R)^n$に拡張する．より一般に，2つ以上の測度空間が与えられているときに，その可測空間の直積に直積測度と呼ばれる測度をつくることができる．$bb(R)^n$上の
Lebesgue 測度は直積測度の一例として捉えられる．

以下暫く，$\( X_1 \, cal(A)_1 \, mu_1 \)$および$\( X_2 \, cal(A)_2 \, mu_2 \)$を$sigma$-有限な測度空間とする．\$\\mathcal{A} \\coloneqq \\set{A\_1 \\times A\_2 | A\_1 \\in \\mathcal{A}\_1, A\_2 \\in \\mathcal{A}\_2}\$と置く．すでに定義したように，$cal(A)_1 times.circle cal(A)_2 = sigma \( cal(A) \)$である．

#thm[
  $mu : cal(A) arrow.r \[ 0 \, oo \]$を$mu \( A_1 times A_2 \) colon.eq mu_1 \( A_1 \) mu_2 \( A_2 \)$で定める．このとき，$mu$は$cal(A)_1 times.circle cal(A)_2$上の測度に一意的に拡張できる．

]
#proof[
  $mu$が$cal(A)$上で可算加法的であることが示せたとすると，あとの議論は
  Lebesgue 測度の構成と同様にして進められる．すなわち$cal(A)$を
  $ overline(cal(A)) colon.eq {union.big_(i = 1)^N A_i med mid(bar.v) med A_i in cal(A) \, A_i upright("は排反")} $と有限加法族に拡張する．排反な$A_1 \, A_2 \, dots.h.c \, A_n in cal(A)$に対して$mu (union.big_(i = 1)^n A_i) colon.eq sum_(i = 1)^n mu \( A_i \)$と定めることで$mu$を$overline(cal(A))$上の有限加法的測度に拡張すると，これは
  well-defined であって$overline(cal(A))$上可算加法的であることが Lebesgue
  測度の構成のときと同様にして示せるから，$sigma \( cal(A) \) = sigma (overline(cal(A)))$と併せて
  Carathéodory の拡張定理によって主張が従う．

  以下，$mu$が$cal(A)$上で可算加法的であることを示す．すなわち排反な$cal(A)$の元の族\$\\set{A\_i}\_{i=1}^\\infty\$に対して$union.big_(i = 1)^oo A_i eq.colon A in cal(A)$であったと仮定して$mu \( A \) = sum_(i = 1)^oo mu \( A_i \)$を示す．$A_i in cal(A)$なので，$B_i in cal(A)_1$ならびに$C_i in cal(A)_2$を用いて$A_i = B_i times C_i$と書ける．$A in cal(A)$についても同様に$A = B times C$を充たす$B in cal(A)_1$ならびに$C in cal(A)_2$がある．$A_i$たちの排反性から，$1_B 1_C = 1_(B times C) = sum_(i = 1)^oo 1_(B_i times C_i) = sum_(i = 1)^oo 1_(B_i) 1_(C_i)$である．両辺を$mu_1$に関して積分すると$mu_1 \( B \) 1_C = sum_(i = 1)^oo mu_1 \( B_i \) 1_(C_i)$である（ここで級数と積分が交換できることを使った）．同様に$mu_2$に関しても積分することで$mu_1 \( B \) mu_2 \( C \) = sum_(i = 1)^oo mu_1 \( B_i \) mu_2 \( C_i \)$すなわち$mu \( A \) = sum_(i = 1)^oo mu \( A_i \)$を得る．

]
#defi[
  上記で得られた$cal(A)_1 times.circle cal(A)_2$上の測度を$mu_1$と$mu_2$の直積測度といい，$mu_1 times mu_2$と書く．また，上記の構成を帰納的に繰り返すことで，$n$個の$sigma$-有限測度空間$\( X_1 \, cal(A)_1 \, mu_1 \) \, \( X_2 \, cal(A)_2 \, mu_2 \) \, dots.h.c \, \( X_n \, cal(A)_n \, mu_n \)$に対して$mu_i$たちの直積測度$mu_1 times dots.h.c times mu_n : cal(A)_1 times.circle dots.h.c times.circle cal(A)_n arrow.r \[ 0 \, oo \]$を，$mu_1 times dots.h.c times mu_n \( A_1 times dots.h.c times A_n \) = product_(i = 1)^oo mu_i \( A_i \)$を充たすように一意に定めることができる．特に$\( X_1 \, cal(A)_1 \, mu_1 \) = \( X_2 \, cal(A)_2 \, mu_2 \) = \( X_n \, cal(A)_n \, mu_n \) = \( bb(R) \, cal(B) \, lambda \)$のとき，$\( bb(R)^n \, cal(B)^n \)$上の直積測度$lambda^n colon.eq lambda times dots.h.c times lambda$のことを$n$次元
  Lebesgue 測度という．

]
Fubini の定理に話題を移そう．Fubini の定理を厳密に述べるには「a.e.
に定義された関数」の概念を定式化した上で，積分の定義を拡張する必要があるので，まずその話からはじめる．いつものように$\( X \, cal(A) \, mu \)$を測度空間とする．

#defi[
  $mu \( N \) = 0$を充たすような$N in cal(A)$のことを$mu$-零集合という．$mu$が文脈から明らかな場合は単に零集合とか測度零集合という場合もある．

  $x in X$に関する命題が（$mu$-）a.e.
  に成り立つとは，$mu$-零集合$N$が存在して，その命題がすべての$x in X \\ N$に対して成り立つことをいう．

]
#dig[
  「零集合」のことを「0集合」と綴る例は見たことがないが，「測度零集合」は「測度0集合」と綴ってもそんなに違和感を感じない．

]
#defi[
  $N$を$mu$-零集合とし，$f : X \\ N arrow.r overline(bb(R))$を写像とする．任意の$B in cal(B)^(\*)$に対して$f^(- 1) \( B \) in cal(A)$となるとき，$f$は$mu$-a.e.
  に定義された可測関数であると言われる．

  $mu$-a.e.
  に定義された可測関数$f : X \\ N arrow.r overline(bb(R))$に対して，関数$tilde(f) : X arrow.r overline(bb(R))$を
  \$\$\\tilde f(x) \\coloneqq \\begin{dcases\*}
  f(x) & if \$x \\in X \\setminus N\$ \\\\
  0 & if \$x \\in N\$
  \\end{dcases\*}\$\$と定めれば，$tilde(f) : X arrow.r bb(R)$は可測である．このもとで，$integral f "" #h(-1em) d mu colon.eq integral tilde(f) "" #h(-1em) d mu$と定める．

]
#thm[
  + 非負可測関数$f : X_1 times X_2 arrow.r \[ 0 \, oo \]$に対して，以下が成り立つ．

    + 任意の$x^2 in X_2$に対し$x^1 mapsto f \( x^1 \, x^2 \)$は$cal(A)_1 \/ cal(B)$可測であり，

    + $x^2 mapsto integral f \( x^1 \, x^2 \) "" #h(-1em) d mu_1 \( x^1 \)$は$cal(A)_2 \/ cal(B)$可測である．従って$integral.double f \( x^1 \, x^2 \) "" #h(-1em) d mu_1 \( x^1 \) "" #h(-1em) d mu_2 \( x^2 \)$が定義でき，

    + $integral f "" #h(-1em) d \( mu_1 times mu_2 \) = integral.double f \( x^1 \, x^2 \) "" #h(-1em) d mu_1 \( x^1 \) "" #h(-1em) d mu_2 \( x^2 \)$．

  + $f in L^1 \( X_1 times X_2 \, cal(A)_1 times.circle cal(A)_2 \, mu_1 times mu_2 \)$に対して，以下が成り立つ．

    + 任意の$x^2 in X_2$に対し$x^1 mapsto f \( x^1 \, x^2 \)$は$cal(A)_1 \/ cal(B)$可測であり，

    + $x^2 mapsto integral f \( x^1 \, x^2 \) "" #h(-1em) d mu_1 \( x^1 \)$は$mu_2$-a.e.
      に定義された$cal(A)_2 \/ cal(B)$可測関数である．従って$integral.double f \( x^1 \, x^2 \) "" #h(-1em) d mu_1 \( x^1 \) "" #h(-1em) d mu_2 \( x^2 \)$が定義でき，

    + $integral f "" #h(-1em) d \( mu_1 times mu_2 \) = integral.double f \( x^1 \, x^2 \) "" #h(-1em) d mu_1 \( x^1 \) "" #h(-1em) d mu_2 \( x^2 \)$．

]
#proof[
  + $cal(A)_1 times.circle cal(A)_2$の元の指示関数に対して示せたならば，単調収束定理と補題
    @非負単関数の列
    を用いることで一般の非負可測関数に対しても結論が従うので，以下では$f$が指示関数の場合を示す．
    \$\$\\mathcal{C} \\coloneqq \\set{ A \\in \\mathcal{A}\_1 \\otimes \\mathcal{A}\_2 | 1\_A \\text{に対して (i-a), (i-b), (i-c) が成り立つ} }\$\$と置いて，$cal(C) supset cal(A)_1 times.circle cal(A)_2$を示す．$pi$-$lambda$定理を踏まえれば，次の3点を示せば充分である．
    ($alpha$) $cal(A) subset cal(C)$．($beta$)
    $cal(A)$は$pi$-システムである．($gamma$)
    $cal(C)$は$lambda$-システムである．このうち ($alpha$), ($beta$)
    はすぐわかるので ($gamma$) を確認する．

    - まず$X_1 times X_2 in cal(A)$なので$X_1 times X_2 in cal(C)$である．

    - $E \, F in cal(C)$かつ$E subset F$ならば$F \\ E in cal(C)$となることを確認する．まず$mu \( X \) \, mu \( Y \) < oo$となる場合を見よう．$1_(F \\ E) = 1_F - 1_E$なので
      (i-a)
      はよい．任意の$x^2 in X_2$に対して$integral 1_(F \\ E) \( x^1 \, x^2 \) "" #h(-1em) d mu_1 \( x^1 \) = integral 1_F \( x^1 \, x^2 \) "" #h(-1em) d mu_1 \( x^1 \) - integral 1_E \( x^1 \, x^2 \) "" #h(-1em) d mu_1 \( x^1 \)$なので
      (ii-b)
      もよい（ここで$mu \( X \) < oo$なので右辺は必ず定義される）．最後に$integral 1_(F \\ E) "" #h(-1em) d \( mu_1 times mu_2 \) = integral 1_F "" #h(-1em) d \( mu_1 times mu_2 \) - integral 1_E "" #h(-1em) d \( mu_1 times mu_2 \) = integral 1_F "" #h(-1em) d mu_1 "" #h(-1em) d mu_2 - integral 1_E "" #h(-1em) d mu_1 "" #h(-1em) d mu_2 = integral 1_(F \\ E) "" #h(-1em) d mu_1 "" #h(-1em) d mu_2$なので
      (i-c)
      も従う（ここで$mu \( Y \) < oo$なのでやはりこの過程で未定義な値は現れない）．$mu \( X \) = oo$ないしは$mu \( Y \) = oo$の場合は，$X$と$Y$の$sigma$-有限性より$A_i arrow.t X$および$B_i arrow.t Y$となる測度有限な集合の可算列\$\\set{A\_i}\$および\$\\set{B\_i}\$がとれる．$E$，$F$をそれぞれ$E sect A_i times B_i$，$F sect A_i times B_i$に置き換えれば上記の考察がそのまま適用できるので，適用した上で単調収束定理を用いればよい．

    - $E_n in cal(C)$かつ$E_n arrow.t E$のときに$E in cal(C)$を示す．$lim_(n arrow.r oo) 1_(E_n) = 1_E$なので
      (i-a)
      はよい．また単調収束定理より任意の$x^2 in X_2$に対して$integral 1_(E_n) \( x^1 \, x^2 \) "" #h(-1em) d mu_1 \( x^1 \) arrow.t integral 1_E \( x^1 \, x^2 \) "" #h(-1em) d mu_1 \( x^1 \)$なので
      (i-b)
      もよい．$integral 1_(E_n) "" #h(-1em) d mu_1 "" #h(-1em) d mu_2 = integral 1_(E_n) "" #h(-1em) d \( mu_1 times mu_2 \)$の両辺に単調収束定理を適用することで$integral 1_E "" #h(-1em) d mu_1 "" #h(-1em) d mu_2 = integral 1_E "" #h(-1em) d \( mu_1 times mu_2 \)$すなわち
      (i-c) を得る．

  + $f = f^(+) - f^(-)$と分解すれば，$f^(+)$および$f^(-)$は非負可測なので
    (i-a), (i-b), (i-c) が成り立つ．従って (ii-a)
    はよい．続いて，$x^2 mapsto integral f^(+) "" #h(-1em) d mu_1 \( x^1 \)$は$mu_2$-a.e.
    に有限な関数である（そうでないとすると，$f in L^1$，とくに$f^(+) in L^1$であることに矛盾する）．同様に$x^2 mapsto integral f^(-) "" #h(-1em) d mu_1 \( x^1 \)$も$mu_2$-a.e.
    に有限である．従って$x^2 mapsto integral f "" #h(-1em) d mu_1 = integral f^(+) - f^(-) "" #h(-1em) d mu_1$は$mu_2$-a.e.
    に定義された$cal(A)_2 \/ cal(B)$-可測関数である#footnote[主に私自身の備忘のため，この部分についてもう少し述べておこう．$x^2 mapsto integral f^(+) "" #h(-1em) d mu_1 \( x^1 \)$が有限値を取らない$x^2$の集合を$N_(+)$，$x^2 mapsto integral f^(-) "" #h(-1em) d mu_1 \( x^1 \)$が有限値を取らない$x^2$の集合を$N_(-)$と置く．$x^2 in N_(+) sect N_(-)$である場合$x^2 mapsto integral f \( x^1 \, x^2 \) "" #h(-1em) d mu \( x^1 \)$は定義できないが，$mu_1 \( N_(+) \) = mu_1 \( N_(-) \) = 0$であるので，特に$mu \( N_(+) sect N_(-) \) = 0$である．従って$x mapsto integral f \( x^1 \, x^2 \) "" #h(-1em) d mu \( x^1 \)$は$mu_2$-a.e.
      に定義されている．];．なので (ii-c) もよい．

]
#dig[
  $sigma$-有限性を用いて有限測度の場合に考察を帰着する部分について，より簡潔に「$mu_1 \, mu_2$の$sigma$-有限性より，$mu_1 \( X_1 \) < oo \, mu_2 \( X_2 \) < oo$の場合を証明すれば充分である」とだけ書いてある文献もある．手の内を一通り見たあとであれば，このように書いてしまうほうが簡潔でよいだろう．

]
#dig[
  Spivak を見てもらうとわかるが，被積分関数の連続性まで課してしまえば
  Riemann
  積分の場合でも主張はすっきりするけれども，そうでない場合までカバーしようとすると途端に主張がごたついて見える．積分の順序を入れ替えてよい充分条件をシンプルに記述するというのは実用上の重要性を持つと思う．一方，可測関数というものがずいぶんいろいろな関数を含んでいて，そこに難しさを押し付けているだけでは？といわれると返す言葉もないですが…

]
Fubini
の定理の応用は数多いと思われる．ここではそのごく一部を紹介する．手始めに，以前証明を保留した
Clairaut の定理（@clairaut）に証明をつけることにする．

#proof[
  必要ならば変数を並べ替え，更に他の変数をすべて止めて考えることで，最初から$f : bb(R)^2 arrow.r bb(R)$，$i = 1$，$j = 2$であるとして証明して構わないのでそうする．対称性より，ある点$p in bb(R)^2$において$partial_(1 \, 2) f \( p \) - partial_(2 \, 1) f \( p \) > 0$であると仮定して矛盾を導けばよい．$f$が$C^2$級なので，$partial_(1 \, 2) f$ならびに$partial_(2 \, 1) f$はいずれも連続関数である．従って$p$を含む適当な閉方体$A = \[ a \, b \] times \[ c \, d \]$が存在して，$q in A$ならば$partial_(1 \, 2) f \( q \) - partial_(2 \, 1) f \( q \) > 0$である．このことより$integral_A \( partial_(1 \, 2) f - partial_(2 \, 1) f \) "" #h(-1em) d lambda^2 > 0$を得る．$partial_(1 \, 2) f - partial_(2 \, 1) f$は連続関数なので，コンパクト集合$A$上で最大値と最小値を持つから特に絶対可積分である．従って
  Fubini
  の定理より$integral_A \( partial_(1 \, 2) f - partial_(2 \, 1) f \) "" #h(-1em) d lambda^2 = integral_(\[ c \, d \]) integral_(\[ a \, b \]) \( partial_(1 \, 2) f \( x \, y \) - partial_(2 \, 1) f \( x \, y \) \) "" #h(-1em) d lambda \( x \) "" #h(-1em) d lambda \( y \) = integral_(\[ c \, d \]) integral_(\[ a \, b \]) partial_(1 \, 2) f \( x \, y \) "" #h(-1em) d lambda \( x \) "" #h(-1em) d lambda \( y \) - integral_(\[ a \, b \]) integral_(\[ c \, d \]) partial_(2 \, 1) f \( x \, y \) "" #h(-1em) d lambda \( y \) "" #h(-1em) d lambda \( x \)$である．微積分学の基本定理を2回使うと$integral_(\[ c \, d \]) integral_(\[ a \, b \]) partial_(1 \, 2) f \( x \, y \) "" #h(-1em) d lambda \( x \) "" #h(-1em) d lambda \( y \) = integral_(\[ a \, b \]) integral_(\[ c \, d \]) partial_(2 \, 1) f \( x \, y \) "" #h(-1em) d lambda \( y \) "" #h(-1em) d lambda \( x \)$を得るが，これは$integral_A \( partial_(1 \, 2) f - partial_(2 \, 1) f \) "" #h(-1em) d lambda^2 = 0$を含意するので矛盾である．

]
#prop[
  $A \, B in cal(B)^3$とする．$c in bb(R)$に対して\$A\_c \\coloneqq \\set{(x,y) \\in \\mathbb{R}^2 | (x,y,c) \\in A }\$，\$B\_c \\coloneqq \\set{(x,y) \\in \\mathbb{R}^2 | (x,y,c) \\in B }\$と定める．任意の$c in bb(R)$に対して$lambda^2 \( A_c \) = lambda^2 \( B_c \)$であるならば，$lambda^3 \( A \) = lambda^3 \( B \)$である．

]
#proof[
  指示関数の非負性と Fubini より
  $integral 1_A "" #h(-1em) d lambda^3 = integral (integral 1_(A_c) "" #h(-1em) d lambda^2) "" #h(-1em) d lambda \( c \) = integral (integral 1_(B_c) "" #h(-1em) d lambda^2) "" #h(-1em) d lambda \( c \) = integral 1_B "" #h(-1em) d lambda^3$．

]
== 1の分割
<の分割>
この項の目標は次の定理の証明である．

#thm[
  $A subset bb(R)^n$を部分集合，$cal(O)$を$A$の開被覆とする．このとき，次の4条件を充たすような$C^oo$級関数の可算族$Phi$が存在する．

  + 任意の$phi in Phi$と$x in A$に対して$0 lt.eq phi \( x \) lt.eq 1$．

  + 任意の$x in A$に対し，次の条件を充たすような開集合$V$が存在する：$x in V$であり，「$V$上で恒等的に0」でないような$phi in Phi$は有限個．

  + 任意の$x in A$に対して$sum_(phi in Phi) phi \( x \) = 1$．ここで，条件
    (ii)
    より，$x$で非零の値を持つような$phi in Phi$は有限個しかないから，左辺が意味を持つことに注意する．

  + 任意の$phi in Phi$に対し，次の条件を充たす$U_phi in cal(O)$が存在する：$U_phi$に含まれるコンパクト集合$K_phi$があり，$phi$は$K_phi$の外で0である．特に，\$\\mathop{\\mathrm{supp}}\\varphi \\coloneqq \\overline{\\set{ x | \\varphi(x) \\neq 0 }} \\subset U\_{\\varphi}\$が成り立っている．

  条件 (i)-(iii)
  を充たすような$Phi$を，$A$上の1の（$C^oo$級）分割という．$A$上の1の分割が更に
  (iv) を充たすとき，$Phi$は$cal(O)$に従属している，といわれる．

]
証明には隆起関数の存在を含めたいくつかの命題を使う．この証明で使う命題たちを再掲する．

#proof[
  証明を4段階に分割する．

  + $A$がコンパクトの場合．$cal(O)$から有限個を選んだ\$\\set{U\_1, \\dots, U\_m}\$が$A$の被覆になっている．\$\\set{U\_1 ,\\dots, U\_m}\$に従属する$A$上の1の分割を構成すればよい．以下，$K_i subset U_i$を充たすようなコンパクト集合$K_i$であって，$K_i$たちの内部が$A$の被覆になるものが存在した，すなわち\$\\set{{K\_1}^\\circ,\\dots, {K\_m}^\\circ}\$が$A$の被覆になっているようなものが取れたとする．このとき@未調整な隆起関数
    によって，$K_i subset L_i subset U_i$を充たすコンパクト集合$L_i$ならびに$C^oo$級関数$psi_i : bb(R)^n arrow.r bb(R)$であって，$K_i$上で正で，$L_i$の外部で0になっているようなものが存在する．このとき，ある開集合$U supset union.big_i K_i^compose$が存在して，$U$上で$sum_(j = 1)^m psi_j > 0$である．
    \$\$\\varphi\_i(x) \\coloneqq
    \\begin{dcases\*}
    \\frac{\\psi\_i(x)}{\\sum\_{j=1}^m \\psi\_j(x)} & if \$x \\in U\$, \\\\
    0 & otherwise,
    \\end{dcases\*}\$\$によって関数$phi_i$を定める．また，@隆起関数の存在
    より，$C^oo$級関数$f : bb(R)^n arrow.r bb(R)$であって，$A$上で1，$U$に含まれるコンパクト集合の外で0であるようなものが存在する．\$\\Phi \\coloneqq \\set{f \\cdot \\varphi\_i}\_{i=1}^m\$とすればよい#footnote[「$f dot.op phi_i : bb(R)^n arrow.r bb(R)$が$C^oo$級である」ことは非自明だと思うので，この点について補っておく；$f dot.op phi_i$が$U$において$C^oo$級であることはよい．$f dot.op phi_i$は$U$に含まれるコンパクト集合の外で0なので，$partial U$の近傍および$U$の外部において$f dot.op phi_i$は恒等的に0である．];．

    あとは$K_i subset U_i$を充たすようなコンパクト集合$K_i$であって，$K_i$たちの内部が$A$の被覆になるものが存在することを示せばよい．$m$に関する帰納法により，\$\\set{{K\_1}^\\circ,\\dots, {K\_i}^\\circ, U\_{i+1}, \\dots, {U\_m}}\$が$A$の被覆になっていたとする．$M_(i + 1) colon.eq A \\ \( K_1^compose union K_2^compose union dots.h union K_i^compose union U_(i + 2) union dots.h U_m \)$と置くと，これは有界閉集合なのでコンパクトであり，作り方より$M_(i + 1) subset U_(i + 1)$を充たす．したがって@未調整な隆起関数
    によって$M_(i + 1) subset K_(i + 1) subset U_(i + 1)$を充たすコンパクト集合$K_(i + 1)$があり，$M_(i + 1) subset K_(i + 1)^compose$を充たす．従って\$\\set{{K\_1}^\\circ,\\dots, {K\_{i+1}}^\\circ, U\_{i+2}, \\dots, {U\_m}}\$が$A$の被覆になるから帰納法が進む．

  + $A$がコンパクト集合による充填をもつ，即ちコンパクト集合の列$K_1 subset K_2 subset dots.h$であって，$K_i subset K_(i + 1)^compose$ならびに$K_i arrow.t A$を充たすようなものがある場合．$L_i colon.eq K_i \\ K_(i - 1)^compose$と置くと，$L_i$はコンパクトで，\$\\mathscr{O}\_i \\coloneqq \\set{ O \\cap (K\_{i+1}^\\circ \\setminus K\_{i-2} ) |  O \\in \\mathscr{O}}\$は$L_i$の開被覆である．従って$cal(O)_i$に従属した（すなわち$cal(O)$にも従属した）$L_i$上の1の分割$Phi_i$が取れる．$sigma \( x \) colon.eq sum_(i = 1)^oo sum_(phi in Phi_i) phi \( x \)$と定めると，$sigma$は各点で有限和なので実数値$C^oo$級関数になり，$overline(A)$を含む開集合$U$上で正である．@隆起関数の存在
    を用いて$f : bb(R)^n arrow.r bb(R)$であって$A$上で1，$U$に含まれるコンパクト集合の外で0であるようなものを取った上で，\$\\Phi \\coloneqq \\set{ f \\cdot  (\\varphi / \\sigma) | \\varphi \\in \\bigcup\_i \\Phi\_i }\$と置けば，これが求める1の分割である．

  + $A$が開集合の場合．\$K\_i \\coloneqq \\set{ x \\in A | \\|x\\| \\leq i, d(x, \\partial A) \\leq 1/i }\$とすれば\$\\set{K\_i}\$が$A$のコンパクト集合による充填になるので，前段に帰着する．

  + $A$が一般の集合の場合．$cal(O)$に属する開集合すべての和集合を$U$とすると，$U$は開集合なので，前段により$U$上の1の分割$Phi$であって$cal(O)$に従属するものが取れる．$Phi$は$A$上の1の分割でもある．

]
#dig[
  このノートでは1の分割を変数変換公式の証明で使いたいので，このタイミングで証明した．Spivak
  でも変数変換公式の証明は1の分割に拠っているが，それ以外にも Darboux
  積分を非有界関数に拡張するのに1の分割を用いている．このノートでは測度論に基づいて積分を定義したので，積分の定義には1の分割は特に必要なくなっている．

]
#que[
  1の分割の（このノートの主目標からは外れる）応用としては
  Riesz-Markov-Kakutani の表現定理がある．$S$を局所コンパクト Hausdorff
  空間とし，$C \( S \)$を$S$上の実数値連続関数からなる線型空間とする．線型形式$L : C \( S \) arrow.r bb(R)$が次の意味で非負であったとする；$f gt.eq 0$ならば$L \( f \) gt.eq 0$．このとき，$S$上の有限
  Borel
  測度$mu$が一意的に存在して$L \( f \) = integral f "" #h(-1em) d mu$が成り立つ．この表現定理は
  Prohorov
  の定理の証明に用いる；完備可分距離空間$S$上の確率測度の集合を$P \( S \)$とするとき，$Pi subset P \( S \)$が一様緊密であることと（弱位相，即ち分布収束を距離化する位相に関して）相対コンパクトであることは同値である．

]
== 変数変換公式
<変数変換公式>
いわゆる重積分の変数変換公式を証明する．証明の本質的な流れは Spivak
にあるそれとほぼ変わらないが，測度論の議論で片付けられる部分は（折角なので）最大限そのようにして進めることにする．

手始めに，測度に関する積分の変数変換公式から始める．$\( X_1 \, cal(A)_1 \)$ならびに$\( X_2 \, cal(A)_2 \)$をそれぞれ可測空間とする．

#defi[
  $mu$を$cal(A)_1$上の測度，$phi : X_1 arrow.r X_2$を可測写像とする．このとき，$phi_(\*) mu : cal(A)_2 arrow.r \[ 0 \, oo \]$を$phi_(\*) mu \( A \) colon.eq mu \( phi^(- 1) \( A \) \)$によって定めれば，$phi_(\*) mu$は$cal(A)_2$上の測度になる．$phi_(\*) mu$を$mu$の$phi$による像測度，ないしは押し出しという．

]
#thm[
  $phi : X_1 arrow.r X_2$ならびに$f : X_2 arrow.r bb(R)$を可測関数とする．$integral f "" #h(-1em) d (phi_(\*) mu)$と$integral f compose phi med "" #h(-1em) d mu$のどちらかが定義されるならば，もう片方も定義され，両者は同じ値を取る．

]
#proof[
  まず$A in cal(A)_2$に対して$f = 1_A$である場合を考える．このときは$integral f "" #h(-1em) d \( phi_(\*) mu \) = phi_(\*) mu \( A \) = mu \( phi^(- 1) \( A \) \) = integral 1_(phi^(- 1) \( A \)) "" #h(-1em) d mu = integral 1_A compose phi "" #h(-1em) d mu$なのでよい．積分の線型性より任意の単関数に対しても主張が成り立つから，非負可測関数についても正しい．一般の可積分関数に対しては正部分と負部分に分けてここまでの議論を適用すればよい．

]
#dig[
  $A in cal(A)_2$に対して$f = 1_A$である場合を除いては，積分の構成をなぞれば成り立つことが示せた．このことを以て，「積分の構成の仕方より，$A in cal(A)_2$に対して$f = 1_A$である場合を示せば充分である」と初手で言ってしまっても証明としては正しいとわかる．とはいえ，いきなりそう言われると「ほんとか？」と思ってしまうので，やや冗長に感じられるのを承知の上で書き下してみることにした．

]
#thm[
  $A subset bb(R)^n$を開集合，$f : bb(R)^n arrow.r overline(bb(R))$を非負可測または$f in L^1 \( bb(R)^n \, cal(B)^n \, lambda^n \)$とし，$phi : A arrow.r phi \( A \)$を$C^1$級微分同相とする．このとき，
  $
    integral_(phi \( A \)) f \( y \) "" #h(-1em) d lambda^n \( y \) = integral_A f compose phi \( x \) dot.op \| det J_phi \( x \) \| "" #h(-1em) d lambda^n \( x \) .
  $

]
<変数変換公式の弱い形>
#proof[
  $A$全体ではなく，各$a in A$に対して$a$を含む開集合$U_a subset A$上で定理が成り立つことを証明すればよいことが次のようにわかる；各$U_a$上で証明できたとして，$phi \( A \)$の開被覆\$\\mathscr{O}\\coloneqq \\set{\\varphi(U\_a) | x \\in A}\$に従属した$phi \( A \)$上の1の分割$Psi$を取る．1の分割の定義より$psi in Psi$はある$phi \( U \) subset phi \( A \)$の外で0なので，
  $ integral_(phi \( A \)) \( psi dot.op f \) \( y \) "" #h(-1em) d lambda^n \( y \) & = integral_(phi \( U \)) \( psi dot.op f \) \( y \) "" #h(-1em) d lambda^n \( y \)\
  & = integral_U \( psi dot.op f \) compose phi \( x \) dot.op \| det J_phi \( x \) \| "" #h(-1em) d lambda^n \( x \)\
  & = integral_A \( psi dot.op f \) compose phi \( x \) dot.op \| det J_phi \( x \) \| "" #h(-1em) d lambda^n \( x \) $が成り立つ．双方を$psi$に関して和をとれば
  $ sum_(psi in Psi) integral_(phi \( A \)) \( psi dot.op f \) \( y \) "" #h(-1em) d lambda^n \( y \) & = sum_(psi in Psi) integral_A \( psi dot.op f \) compose phi \( x \) dot.op \| det J_phi \( x \) \| "" #h(-1em) d lambda^n \( x \) $となり，単調収束定理より総和と極限を入れ替えて定理の結論を得る．

  また，写像$x mapsto \| det J_phi \( x \) \|$は可測なので，$mu_phi \( U \) colon.eq integral_U \| det J_phi \( x \) \| "" #h(-1em) d lambda^n \( x \)$は$A$上の測度を定め，更に
  $
    integral_U f compose phi \( x \) dot.op \| det J_phi \( x \) \| "" #h(-1em) d lambda^n \( x \) = integral_U f compose phi \( x \) "" #h(-1em) d mu_phi \( x \)
  $
  が成り立つ．測度の変数変換公式より
  $
    integral_U f compose phi \( x \) "" #h(-1em) d mu_phi \( x \) = integral_(phi \( U \)) f \( y \) "" #h(-1em) d \( phi_(\*) mu_phi \) \( y \)
  $
  であるから，定理の主張は$integral_(phi \( U \)) f \( y \) "" #h(-1em) d lambda^n \( y \) = integral_(phi \( U \)) f \( y \) "" #h(-1em) d \( phi_(\*) mu_phi \) \( y \)$と同値である（すなわち，この等式を示せばよい）．積分の構成より，$f = 1$の場合を証明すればよく，更に$integral_(phi \( U \)) "" #h(-1em) d \( phi_(\*) mu_phi \) = mu_phi \( phi^(- 1) \( phi \( U \) \) \) = mu_phi \( U \) = integral_U \| det J_phi \( x \) \| "" #h(-1em) d lambda^n \( x \)$である．

  結局，各$x in A$に対して$x$を含む開集合$U subset A$が存在し，$integral_U \| det J_phi \( x \) \| "" #h(-1em) d lambda^n \( x \) = integral_(phi \( U \)) "" #h(-1em) d lambda^n$が成り立つことをいえばよいとわかった．証明をいくつかのステップに分割する．

  - 主張が合成に関して閉じていることを言う．即ち，ふたつの微分同相$phi_1 : A_1 arrow.r phi_1 \( A_1 \)$，$phi_2 : A_2 arrow.r phi_2 \( A_2 \)$が$phi_1 \( A_1 \) subset A_2$を充たしており，更に$\( phi_1 \)_(\*) mu_(phi_1) = lambda^n$かつ$\( phi_2 \)_(\*) mu_(phi_2) = lambda^n$であるならば，$\( phi_2 compose phi_1 \)_(\*) mu_(phi_2 compose phi_1) = lambda^n$が成り立つことを示す．
    $ \( phi_2 compose phi_1 \)_(\*) mu_(phi_2 compose phi_1) \( U \) & = mu_(phi_2 compose phi_1) \( phi_1^(- 1) \( phi_2^(- 1) \( U \) \) \)\
    & = integral_(phi_1^(- 1) phi_2^(- 1) \( U \)) \| det J_(phi_2 compose phi_1) \( x \) \| "" #h(-1em) d lambda^n \( x \)\
    & = integral_(phi_1^(- 1) phi_2^(- 1) \( U \)) \| det J_(phi_2) \( phi_1 \( x \) \) \| dot.op \| det J_(phi_1) \( x \) \| "" #h(-1em) d lambda^n \( x \)\
    & = integral_(phi_1^(- 1) phi_2^(- 1) \( U \)) \| det J_(phi_2) \( phi_1 \( x \) \) \| "" #h(-1em) d mu_(phi_1) \( x \)\
    & = integral_(phi_2^(- 1) \( U \)) \| det J_(phi_2) \( y \) \| "" #h(-1em) d \( phi_1 \)_(\*) mu_(phi_1) \( y \)\
    & = integral_(phi_2^(- 1) \( U \)) \| det J_(phi_2) \( y \) \| "" #h(-1em) d lambda^n \( y \) = lambda^n \( U \) $なのでよい．

  - $phi$が正則な線型変換の場合．

    - 実数$m$と，ある$i$に対して$phi \( e_i \) = m e_i$，$phi \( e_j \) = e_j$（$j eq.not i$）の場合．Fubini
      の定理と1変数関数に対する置換積分よりよい．

    - ある$i \, j$に対して$phi \( e_i \) = e_i + e_j$，$phi \( e_k \) = e_k$（$k eq.not i \, j$）の場合．Fubini
      の定理と1次元 Lebesgue 測度の並進不変性から従う．

    - ある$i \, j$に対して$phi \( e_i \) = e_j$，$phi \( e_j \) = e_i$，$phi \( e_k \) = e_k$（$k eq.not i \, j$）の場合．Fubini
      の定理で示せる．

    - 一般の線型変換は上3つの線型変換の合成で書けるので，並びに前段で示した「主張が合成に関して閉じていること」と併せて結果を得る．

  - 一般の$phi$の場合．$J_phi \( a \)^(- 1) compose phi$に対して主張を示せば$phi$に対しても結果が従うので，最初から$J_phi \( a \) = I_n$（単位行列）だと仮定して証明してよい．次元$n$に関する帰納法に依る．$phi_1 \( x \) colon.eq \( phi^1 \( x \) \, phi^2 \( x \) \, dots.h \, phi^(n - 1) \( x \) \, x^n \)$と定めれば$J_(phi_1) \( a \) = I_n$なので，逆関数定理より$phi_1$は$a$の近傍$V'$で定義された微分同相である．したがって$phi_2 \( x \) colon.eq \( x^1 \, x^2 \, dots.h \, x^(n - 1) \, phi^n \( phi_1^(- 1) \( x \) \) \)$が定義でき，$phi = phi_2 compose phi_1$が成り立つ．したがって$phi_2$は$phi_1 \( a \)$の近傍で定義された微分同相である．主張が合成に関して閉じていることから，$phi_1$および$phi_2$の双方に対して主張を示せばよい．議論は同様なので$phi_1$に対してのみ示す．$a$を含む開方体$V subset V'$を取る．$V$は$W subset bb(R)^(n - 1)$並びに$a^n \, b^n in bb(R)$を用いて$V = W times \( a^n \, b^n \)$と書ける．Fubini
    の定理より
    $ integral_V \| det J_(phi_1) \( x \) \| "" #h(-1em) d lambda^n \( x \) = integral_(\( a^n \, b^n \)) integral_W \| det J_(phi_1) \( x \) \| "" #h(-1em) d lambda^(n - 1) \( x^1 \, dots.h \, x^(n - 1) \) "" #h(-1em) d x^n $である．関数$xi_(x^n) : W arrow.r bb(R)^(n - 1)$を$xi_(x^n) \( x^1 \, dots.h \, x^(n - 1) \) colon.eq \( \( phi_1 \)^1 \( x \) \, \( phi_1 \)^2 \( x \) \, dots.h \, \( phi_1 \)^(n - 1) \( x \) \)$で定めれば，$det J_(phi_1) \( x \) = det J_(xi_(x^n)) \( x^1 \, dots.h \, x^(n - 1) \)$が成り立つ．したがって
    $ integral_(\( a^n \, b^n \)) integral_W \| det J_(phi_1) \( x \) \| "" #h(-1em) d lambda^(n - 1) \( x^1 \, dots.h \, x^(n - 1) \) "" #h(-1em) d x^n = integral_(\( a^n \, b^n \)) integral_W \| det J_(xi_(x^n)) \( x^1 \, dots.h \, x^(n - 1) \) \| "" #h(-1em) d lambda^(n - 1) \( x^1 \, dots.h \, x^(n - 1) \) "" #h(-1em) d x^n $である．\$\\xi\_{x^n}(W) = \\varphi\_1(W \\times \\set{x^n})\$および帰納法の仮定と併せて
    \$\$\\begin{aligned}
    \\int\_{(a^n,b^n)} \\int\_W  |\\det J\_{\\xi\_{x^n}}(x^1,\\dots,x^{n-1})| \\mathop{}\\!d\\lambda^{n-1}(x^1, \\dots, x^{n-1}) \\mathop{}\\!dx^n &= \\int\_{(a^n,b^n)} \\int\_{\\varphi\_1(W\\times \\set{x^n})} \\mathop{}\\!d\\lambda^{n-1}(x^1, \\dots, x^{n-1}) \\mathop{}\\!dx^n \\\\
    &= \\int\_V \\mathop{}\\!d\\lambda^n(x)
    \\end{aligned}\$\$を得る．

]
#que[
  $\( X \, cal(A) \, mu \)$を測度空間，$f : X arrow.r bb(R)$を可測写像とするとき，$nu \( A \) colon.eq integral_A f "" #h(-1em) d mu$は$X$上の測度を定める．更に可測写像$g : X arrow.r bb(R)$に対して，$integral g f "" #h(-1em) d mu$または$integral g "" #h(-1em) d nu$の片方が定義されるならば，もう片方も定義され，両者は同じ値を取る．

]
#que[
  このノートでは Spivak
  にならって1の分割を使い，局所的に変数変換公式を証明してそれを大域的につなぎ合わせるということをした．それ以外に，被積分関数をよりかんたんな関数で近似して結論を得る，という証明の戦略もある．この方針に基づく証明は
  Jost "Postmodern Analysis" にある．

]
極座標変換を用いた Gauss 積分を例として扱おう．

#exm[
  $P colon.eq \( 0 \, oo \) times \( 0 \, 2 pi \)$と置いて，関数$phi : P arrow.r bb(R)^2$を$phi \( r \, theta \) = \( r cos theta \, r sin theta \)$によって定める．$phi$は単射であり，Jacobi
  行列は$J_phi \( r \, theta \) = mat(delim: "(", cos theta, - r sin theta; sin theta, r cos theta)$なので，特に$det J_phi \( r \, theta \) = r$がわかるから，逆関数定理より$phi$を$phi \( P \)$への写像とみなすと$C^1$級微分同相である．ところで\$A \\coloneqq \\set{(x,0) \\in \\mathbb{R}^2 | x \\geq 0}\$と置くとこれは閉集合で，$phi \( P \) = bb(R)^2 \\ A$なので，@変数変換公式の弱い形
  より，$f : bb(R)^2 arrow.r overline(bb(R))$が非負可測であるか$f in L^1 \( bb(R)^2 \)$であるならば
  $ integral_(phi \( P \)) f \( x \, y \) "" #h(-1em) d lambda^2 \( x \, y \) = integral_P \( f compose phi \) \( r \, theta \) dot.op \| det J_phi \( r \, theta \) \| "" #h(-1em) d lambda^2 \( r \, theta \) $すなわち
  $ integral_(bb(R)^2 \\ A) f \( x \, y \) "" #h(-1em) d lambda^2 \( x \, y \) = integral_P \( f compose phi \) \( r \, theta \) med r "" #h(-1em) d lambda^2 \( r \, theta \) $を得る．$A$が測度0なので，左辺は$bb(R)^2$全域での積分に置き換えることができる．また右辺に対して
  Fubini の定理を適用することで，
  $ integral f \( x \, y \) "" #h(-1em) d x "" #h(-1em) d y = integral_0^oo integral_0^(2 pi) \( f compose phi \) \( r \, theta \) med r "" #h(-1em) d theta "" #h(-1em) d r $を得る．

]
#exm[
  $integral_(bb(R)) e^(- x^2) "" #h(-1em) d x = sqrt(pi)$を証明してみよう．そのためには，$integral_(bb(R)^2) e^(- x^2 - y^2) "" #h(-1em) d x "" #h(-1em) d y = pi$を示せばよい．これが示せれば
  Fubini
  の定理より$(integral e^(- x^2) "" #h(-1em) d x) (integral e^(- y^2) "" #h(-1em) d y) = pi$となって結論が得られるからである．極座標変換をすると，求める積分は
  $ integral_0^oo integral_0^(2 pi) e^(- r^2) med r "" #h(-1em) d theta "" #h(-1em) d r = 2 pi integral_0^oo r e^(- r^2) "" #h(-1em) d r $となる．$r e^(- r^2)$は$\( 0 \, oo \)$上非負なので，広義
  Riemann 積分として計算してよいから，値は$pi$である．

]
ところで，変数変換公式の「$phi$が$C^1$級微分同相」という仮定は弱めることができる．その正当化に一役買うのが
Sard の定理である．

#thm[
  $A subset bb(R)^n$を開集合，$phi : A arrow.r bb(R)^n$を$C^1$級写像とする．このとき，\$B \\coloneqq \\set{x \\in A | \\det J\_\\varphi(x) = 0}\$と置くと，$lambda^n \( phi \( B \) \) = 0$が成り立つ．

]
#proof[
  有理点$q in A$を任意に取ると，各辺の長さがすべて等しい有界閉方体$U_q$であって，$q in U_q subset A$を充たすものがある．\$\\set{U\_q}\_{q \\in A}\$は$A$の可算被覆であるから，各$U_q$に対して$lambda^n \( phi \( U_q sect B \) \) = 0$を示せば，$union.big_(q in A) phi \( U_q sect B \) = phi \( union.big_(q in A) U_q sect B \) = phi \( B \)$と併せて結論を得るのでそうする．以降，$U_q$の添字を省いて単に$U$と書く．

  $U$の各辺の長さを$ell$と置く．$epsilon > 0$を任意に一つ取って固定する．$phi$は$C^1$級なので，$partial_i phi^j$はすべて$U$上で一様連続である．したがって「$parallel x - y parallel < delta$ならば任意の$i \, j$に対して$parallel partial_i phi^j \( x \) - partial_i phi^j \( y \) parallel < epsilon \/ n^2$」となるような$delta > 0$がある．$U$の各辺を$N$等分することで，各辺の長さが$ell \/ N$の閉方体が$N^n$個できるが，その中で$B$と共通部分を持つものを任意にとって$S$とする．$N$を充分大きく取っておくことで，「$x \, y in S$ならば$parallel partial_i phi^j \( x \) - partial_i phi^j \( y \) parallel < epsilon \/ n^2$」が成り立つようにできるので，そのように$N$は取っておく．

  $x in S sect B$を取ると，$det J_phi \( x \) = 0$なので，$d phi_x$は正則ではない．したがって\$\\set{ d\\varphi\_x (y-x) | y \\in S }\$はある$n - 1$次元部分空間$V subset.neq bb(R)^n$に含まれる．更に$y in S$に対して$f \( y \) colon.eq d phi_x \( y \) - phi \( y \)$と定めると，$parallel phi_i f^j \( y \) parallel = parallel partial_i phi^j \( x \) - partial_i phi^j \( y \) parallel < epsilon \/ n^2$なので，@微分の定量評価
  より$parallel d phi_x \( y - x \) - phi \( y \) + phi \( x \) parallel = parallel f \( y \) - f \( x \) parallel < epsilon parallel y - x parallel lt.eq epsilon ell sqrt(n) \/ N$である．言い換えると，$d \( V + phi \( x \) \, phi \( y \) \) < epsilon ell sqrt(n) \/ N$である．また$phi$の$S$上での一様連続性より$parallel phi \( y \) - phi \( x \) parallel < M parallel y - x parallel lt.eq M ell sqrt(n) \/ N$となるような$M > 0$がある．したがって（$epsilon \, N$の何れにも依存しない）定数$A > 0$があって\$\\lambda^n( \\set{\\varphi(y) | y \\in S}) \< A (M \\ell \\sqrt{n} / N)^{n-1} \\cdot \\varepsilon \\ell \\sqrt{n} / N = AM^{n-1} \\varepsilon (\\ell \\sqrt{n}/N)^n\$が成り立つ．$S$は$S sect B = nothing$を充たすように$N^n$個の小閉方体から任意に選んできたものだったので，結局\$\\lambda^n( \\set{\\varphi(y) | y \\in U \\cap S}) \< AM^{n-1} \\varepsilon (\\ell \\sqrt{n})^n\$が成り立つ．$epsilon$は任意だったので，$lambda^n \( U sect B \) = 0$である．

]
#dig[
  上記の Sard
  の定理の証明は（自分で書いておいて何なのだが）あまりわかりやすいとは思わない．アイデアとしては$U sect B$の測度を$O \( epsilon \)$で抑えるために$epsilon$に依存する項を出すところ，言い換えると「$phi \( S sect B \)$は$V$の法線方向には$O \( epsilon \)$程度しか伸びないこと」が本質的である．定理の仮定が効くのはこの部分であり，それ以外の議論はこの部分を見越して逆算している部分も多い．

  個人的には「一通り論理は追えるがどうしてこんな証明をしないといけないのかよくわからない」という感想が強かった．上記のポイントが見えて少し証明が読みやすくなったという経験があったので，それを上手く証明に取り込めないかと思ったのだが，あまりにインフォーマルな書きぶりになってしまいそうだったので，このように余談として述べるに留めることとなった．

]
#thm[
  $A subset bb(R)^n$を開集合，$f in L^1 \( bb(R)^n \, cal(B)^n \, lambda^n \)$とし，$phi : A arrow.r phi \( A \)$を単射な$C^1$級写像とする．このとき，
  $
    integral_(phi \( A \)) f \( y \) "" #h(-1em) d lambda^n \( y \) = integral_A f compose phi \( x \) dot.op \| det J_phi \( x \) \| "" #h(-1em) d lambda^n \( x \) .
  $

]
#proof[
  \$B \\coloneqq \\set{x \\in A | \\det J\_\\varphi(x) = 0}\$と置き，連続写像$x mapsto det J_phi \( x \)$を$h$と書くことにすると，\$h^{-1}(\\set{0}) = B\$なので$B$は閉集合である．したがって$A \\ B$は開集合であるから，$bb(R)^n$における変数変換公式より
  $ integral_(phi \( A \\ B \)) f \( y \) "" #h(-1em) d lambda^n \( y \) = integral_(A \\ B) f compose phi \( x \) dot.op \| det J_phi \( x \) \| "" #h(-1em) d lambda^n \( x \) $を得る．Sard
  の定理より$phi \( B \)$は零集合であるから，$integral_(phi \( B \)) f \( y \) "" #h(-1em) d lambda^n \( y \) = 0$である．また仮定より$integral_B f compose phi \( x \) dot.op \| det J_phi \( x \) \| "" #h(-1em) d lambda^n \( x \) = 0$である．以上より
  $ integral_(phi \( A \\ B \)) f \( y \) "" #h(-1em) d lambda^n \( y \) + integral_(phi \( B \)) f \( y \) "" #h(-1em) d lambda^n \( y \) = integral_(A \\ B) f compose phi \( x \) dot.op \| det J_phi \( x \) \| "" #h(-1em) d lambda^n \( x \) + integral_B f compose phi \( x \) dot.op \| det J_phi \( x \) \| "" #h(-1em) d lambda^n \( x \) $となって定理が得られる．

]
#que[
  ここで扱った Sard
  の定理は，実際には微分可能多様体に対して拡張できる．また，Sard
  の定理の応用として挙がるのが写像度の概念である．写像度の応用先として有名なものは私の知る限り2つある；代数学の基本定理と，つむじ頭定理である．

]
#que[
  実際には変数変換公式の仮定は更に弱めることができるらしい．例えば単射性を落とすといった拡張の仕方があり得るらしい．ところで極座標変換くらいだったら微分同相という仮定のついたバージョンからでも出せた．仮定を弱めたくなる実用的な例はいくらでもあると思うのだが，とりあえず思いついていない．

]
10pt 15pt #strong[] . 5pt plus 1pt minus 1pt

= 鎖体上の微分形式とその積分
<鎖体上の微分形式とその積分>
本節では微分形式を定義して Stokes の定理を定式化する．Spivak
にも述べてあるように，適切な諸概念を準備した上であれば，Stokes
の定理の証明は特に難しくない．裏返せば，証明が当たり前になるように諸概念を用意することが本節の目標である．

== 微分形式の定義に向けて
<微分形式の定義に向けて>
微分形式の定義には種々の代数的な概念が必要になる．のだが，なぜそれらの概念が必要なのかすぐには了解し難いと思われるので，厳密性を抜きにした発見的考察を紹介する．以下の考察は古田幹雄「微分形式と
Stokes
の定理」（別冊・数理科学「多様体の広がり」，サイエンス社，2008）を参考にした．

このノートの目標が微分可能多様体に対する Stokes
の定理であること，この定理が微積分学の基本定理を抽象化したものであることをまえがきで述べた．ところで微分可能多様体とは，大雑把に言えば曲線や曲面の抽象化である．ということで
Stokes
の定理を理解するということは，曲線や曲面の上で微積分をどう展開するかを理解することと不可分であると言ってよいだろう．

ところで，このノートにおいて積分を定義し，その性質について調べてきた．積分の定義を思い出してみる；単関数$f = sum a_i 1_(A_i)$の積分は$integral f "" #h(-1em) d mu = sum a_i mu \( A_i \)$で与えられていた．非負可測関数$f : X arrow.r \[ 0 \, oo \]$に対しては，
$ integral f "" #h(-1em) d mu colon.eq sup {integral g "" #h(-1em) d mu med mid(bar.v) med 0 lt.eq g lt.eq f \, g は 単 関 数} $によって定義した．即ち，可測関数を単関数によって下から近似することで求めた．単関数によって下から近似するとは，おおらかに言えば，空間$X$をいくつかの可測集合\$\\set{A\_i}\$に分割し，各集合$A_i$における近似値$a_i$を定めることであった．直感的には，$X$の分割$A_i$が何かしらの意味で細かくなればなるほど近似の精度が良くなっていくと思われるし，実際に@非負単関数の列
の証明では，$X$の分割を細かくしていくことで，所与の可測関数に収束する単関数の列を作った．ということで，大雑把で感覚的な物言いをすると，$X$の「とても細かい分割」\$\\set{A\_i}\$が与えられているとき，$a_i in A_i$を任意に取れば
$ integral f "" #h(-1em) d mu approx sum_(A_i) f \( a_i \) mu \( A_i \) $という近似式が成り立つ，ということができよう．

さて，このような積分の概念を，一般の「曲面」に一般化することを考えよう．一般的な「曲面」の定義を考えるのも骨が折れそうなので，いったん具体的に，$bb(R)^3$内の単位球面
\$\$\\mathbb{S}^2 \\coloneqq \\set{ (x^1, x^2, x^3) \\in \\mathbb{R}^3 | (x^1)^2 + (x^2)^2 + (x^3)^2 = 1}\$\$を例にして考えることにしたい．もっと即物的に言えば$bb(S)^2$を宇宙$bb(R)^3$の中にある地球表面のモデルだと思ってもよい#footnote[ある時刻での宇宙が$bb(R)^3$でモデリングできるかどうかはここでは問題にしない．];．$f : bb(S)^2 arrow.r bb(R)$の「積分」を定義するための道筋を考えることがここでの目標である．$f$に具体的なイメージがほしければ，地表における何かしらの物質の密度分布が与えられていると思って，その「地球での全質量」を求めようとしていると思えばよい．

#que[
  もちろん積分を定義したいだけであれば$bb(S)^2$上の「Lebesgue
  測度から標準的に定まる」測度が作れればよい．この測度は表面測度と呼ばれる．表面測度の構成だけを目的にするならばこのような発見的考察をしなくとも済むことが知られている．のだが，そのように議論すると微分形式と表面測度の繋がりがわからないままになると思う．

]
測度空間における（あるいは，Lebesgue
測度に関する）積分のやり方に則れば，適当な部分集合$A subset bb(S)^2$に対してその「大きさ」$mu \( A \)$が定まればよさそうだとわかる．いの一番に考えつくのは，（さながら地図に緯線と経線を引くが如く）$A$に適当な座標軸を引いて$bb(R)^2$の部分集合と同一視し，$A$に2次元
Lebesgue
測度を入れてしまうことである．のだが，このやり方には2つの問題がある．

- 測度が座標軸のとり方に依存して定まっているが，現実世界で考えると，長さの基準を決めるのは地図帳の出版社ではなくて光速である．$bb(S)^2$上に適当に入れた座標に依存することがあってはならない．

- 紙に印刷された世界地図は，実際には長さや面積の情報を正確に反映できていない．そこから類推するに，いきなり大域的な考察をすると何かしらの「歪み」に突き当たりそうなので，考察は局所的にしたほうが安全そうである．

ということで，任意の部分集合$A subset bb(S)^2$を考えるのはやめて，考察を局所的にする．すなわち，ある点$m in bb(S)^2$のまわりに広がった「うんと小さい領域」$M subset bb(S)^2$を考えて，$M$上だけで測度を作ろうとすることで，曲面の大域的な歪みを無視できるようにする．また，$M$には座標軸を入れず，ある程度小さなベクトルだけを考えることにして，$m$を原点とする2次元線型空間とみなしてみる．$M$上には（例えば光速から計算された）長さや面積の情報がアプリオリに決まっていると考えて，$m$に足を持つような2つの小さいベクトル$v_m \, w_m in M$の張る平行四辺形の面積を$omega_m \( v_m \, w_m \)$と書く．やや天下りなのだが，$omega_m$に見出せそうな性質を列挙しておく；

- $v \, w$は充分小さいので，$omega_m$は各引数ごとに線型であることにする．

- 同じ方向を向いた2本のベクトルが張る平行四辺形の面積は0だと思うので，$omega_m \( v_m \, v_m \) = 0$とする．

- ベクトルが右手系なのか左手系なのかを込めて，符号つきで面積を測ることにして，$omega_m \( v_m \, w_m \) = - omega_m \( w_m \, v_m \)$とする．

そのように局所的に作った$omega_m$という量を，いろいろなところで一斉に考えて，関数との値と掛け合わせて足し上げることで，積分の定義が得られるかもしれない．すなわち，いい感じに$bb(S)^2$を細かな領域に分割した上で
$ integral f omega approx sum_(M subset bb(S)^2) f \( m \) dot.op omega_m \( v_m \, w_m \) . $として「$f omega$の積分」を定義しようと試みるのである．実際にはこの方針に基づいた試みは（もちろん適切な，決して短いとは言い難い準備と修正が必要になるものの）驚くことにうまく行ってしまう．特にこの$omega_m$を適切に定式化することで，曲面における測度の「もと」が得られることがわかっている．この節は$omega_m$ならびに関係する概念たちをきちんと捉えるまでの道筋を整備することに割かれると言っても過言ではない．

ここまで出てきた概念がどのように厳密化されるのかを列挙して，この項のむすびとする．

- 「$m$の周りに広がったうんと小さい領域$M$」は，「$m$における接ベクトル空間$T_m bb(S)^2$」となる．$v_m \, w_m$は実際には$T_m bb(S)^2$の元と考えることができる．$T_m bb(S)^2$の元を接ベクトルという．

- 上にあらわれた$omega_m$を，$m$に関する写像だとみなしたもの$m mapsto omega_m$を微分形式という．即ち，接ベクトルをいくつか受け取れる交代的多重線型写像が曲面の各点で定まっているとき，それを微分形式と呼ぶ．ここでの発見的考察に拠って得ようとした「積分」とは，微分形式の積分にほかならない．

- 「長さや面積の情報がアプリオリに決まっている」という言葉を厳密に述べれば，「多様体$bb(S)^2$上に
  Riemann
  計量が与えられている」となる．「光速から計算された」という文面は，「包含写像$bb(S)^2 arrow.r.hook bb(R)^3$から定まる誘導計量が与えられた」と言い換えることで表現できる．

- ここで「曲面」と呼ばれているものは，数学的には微分可能多様体と呼ばれるものの一例である．

== 双対空間とテンソル積
<双対空間とテンソル積>
微分形式を定義するのに必要な線型代数の事項として，双対空間とテンソル積，ならびに関連した話題について述べる．以下しばらく，$V$ならびに$W$は線型空間とする．

#defi[
  \$V^\* \\coloneqq \\set{f \\colon V \\to \\mathbb{R}| f は線型写像 }\$を$V$の双対空間という．

]
#que[
  $V^(\*)$は線型空間の構造を持つ．やるだけでめんどくさいので証明を省いてます．

]
#defi[
  \$\\set{v\_1, \\dots, v\_n}\$を$V$の基底とする．各$v_i$（$1 lt.eq i lt.eq n$）に対し，線型写像$w^i : V arrow.r bb(R)$を，$w^i \( v_j \) = delta_j^i$で定める．但し，右辺は
  Kronecker
  のデルタ．このとき，\$\\set{w^1, \\dots, w^n}\$は$V^(\*)$の基底となる．この基底を\$\\set{v\_1, \\dots, v\_n}\$の双対基底という．\$\\set{v\_1, \\dots, v\_n}\$の双対基底を\$\\set{v\_1^\*, \\dots, v\_n^\*}\$のように書くことも多い．

]
#que[
  $bb(R)^n$が「縦ベクトルからなる空間」だとすれば$\( bb(R)^n \)^(\*)$は「横ベクトルからなる空間」であると捉えられないこともない，ということを下支えするのが以下の命題である；$x in bb(R)^n$に対し，$phi_x in \( bb(R)^n \)^(\*)$を$phi_x \( y \) colon.eq angle.l x \, y angle.r$で定める．写像$T : bb(R)^n in.rev x mapsto phi_x in \( bb(R)^n \)^(\*)$は線型同型写像である．ちなみにこの同型写像は標準内積に依存しているので，特に基底に依存して定まる同型写像である．その意味で「自然ではない」という言い方がされることがあるが，私は自然性のことをすべて忘れました．

]
<双対空間は縦ベクトル>
#que[
  ちなみにこの直感は無限次元だと破壊されるので，程々にしておくのが良いらしい…が，私は平気な顔して横ベクトルのことだと思っているフシがある．参考までに，広く知られている以下2点の事実を列挙しておく．ちなみに私は証明を読んだことはない．

  + $H$を Hilbert
    空間とする．$x in H$に対し，$phi_x in H^(\*)$を$phi_x \( y \) colon.eq angle.l x \, y angle.r$で定める．写像$T : H in.rev x mapsto phi_x in H^(\*)$は線型同型写像である（Riesz
    の表現定理）．

  + Riesz の表現定理は，Banach
    空間に対しては必ずしも成り立つとは限らない；$V$を Banach
    空間とする．写像$Phi : V arrow.r \( V^(\*) \)^(\*)$を，$phi in V^(\*)$に対して$Phi \( x \) \( phi \) colon.eq phi \( x \)$で定めると，これは単射な線型写像である．これが同型となるような
    Banach
    空間は反射的であると言われる．ということは世の中には反射的でない
    Banach 空間が存在する．

]
#defi[
  $V$を線型空間とする．$S : V^k arrow.r bb(R)$が多重線型写像，または$V$上の$k$階テンソルであるとは，各変数に関して$S$が線型写像であること，即ち任意の$1 lt.eq i lt.eq k$に対して

  - 任意の$v_1 \, v_2 \, dots.h \, v_k \, v_(i') in V$に対して$S \( v_1 \, dots.h \, v_i \, dots.h \, v_k \) + S \( v_1 \, dots.h \, v_(i') \, dots.h \, v_k \) = S \( v_1 \, dots.h \, v_i + v_(i') \, dots.h \, v_k \)$

  - 任意の$v_1 \, v_2 \, dots.h \, v_k in V$ならびに$a in bb(R)$に対して$S \( v_1 \, dots.h \, a v_i \, dots.h \, v_k \) = a S \( v_1 \, dots.h \, v_i \, dots.h \, v_k \)$

  が成り立つことをいう．$V$上の$k$階テンソル全体の集合を$cal(T)^k \( V^(\*) \)$と書く．$cal(T)^1 \( V^(\*) \)$は$V$の双対空間のことである．

]
#que[
  $cal(T)^k \( V^(\*) \)$は線型空間の構造を持つ．やるだけでめんどくさいので証明を省いてます．

]
#dig[
  このノートでは Spivak
  にならって線型空間としてのテンソル積を構成することはせず，多重線型写像としてしか扱わない．実際にはふたつの線型空間$V \, W$のテンソル積と呼ばれる線型空間$V times.circle W$を定義して，その空間の元をテンソルと呼ぶのが行儀良いやり方である．のだが，テンソル積は構成がめんどくさいのに加えて，構成よりも普遍性のほうが大事だと言われている（し，私もそう思う）．それにこのノートの範囲で普遍性の話を出してもあんまり得るものがなさそうな気がした上，Spivak
  のとおりにやっても Riemann
  計量や微分形式の定義には困らない．なので，Spivak
  のやり方にならうことにした．ちなみに$V times.circle V$のことは$cal(T)^2 \( V \)$とも書く．このノートで$cal(T)^k \( V \)$が出てこないのはそういうわけである．

]
#defi[
  $S in cal(T)^k \( V^(\*) \)$および$T in cal(T)^ell \( V^(\*) \)$に対して，そのテンソル積$S times.circle T in cal(T)^(k + ell) \( V^(\*) \)$を，
  $ S times.circle T \( v_1 \, dots.h \, v_k \, v_(k + 1) \, dots.h \, v_(k + ell) \) colon.eq S \( v_1 \, dots.h \, v_k \) dot.op T \( v_(k + 1) \, dots.h \, v_(k + ell) \) $で定める．

]
#que[
  $times.circle$は双線型かつ結合的である．すなわち，$S \, S_1 \, S_2 in cal(T)^k \( V^(\*) \)$および$T \, T_1 \, T_2 in cal(T)^ell \( V^(\*) \)$，$U in cal(T)^m \( V^(\*) \)$，$a in bb(R)$に対して，

  - $\( S_1 + S_2 \) times.circle T = S_1 times.circle T + S_2 times.circle T$

  - $S times.circle \( T_1 + T_2 \) = S times.circle T_1 + S times.circle T_2$

  - $\( a S \) times.circle T = S times.circle \( a T \) = a \( S times.circle T \)$

  - $S times.circle \( T times.circle U \) = \( S times.circle T \) times.circle U$

  が成り立つ．やるだけでめんどくさいので証明を省いてます．

]
#prop[
  \$\\set{v\_1, \\dots, v\_n}\$を$V$の基底，\$\\set{w^1, \\dots, w^n}\$をその双対基底とする．このとき，
  \$\$\\set{ w^{i\_1} \\otimes \\dots \\otimes w^{i\_k} | 1 \\leq i\_1, \\dots i\_k \\leq n }\$\$は$cal(T)^k \( V^(\*) \)$の基底である．したがって$cal(T)^k \( V^(\*) \)$は$n^k$次元である．

]
#proof[
  $w^(i_1) times.circle dots.h times.circle w^(i_k)$たちが一次独立であることと$cal(T)^k \( V^(\*) \)$の生成系であることを示せばよい．まず一次独立性を示す．
  $ sum_(1 lt.eq j_1 \, dots.h \, j_k lt.eq n) a_(j_1 \, dots.h \, j_k) w^(j_1) times.circle dots.h times.circle w^(j_k) = 0 $が成り立っていたと仮定する．このとき左辺の線型写像を$\( v_(i_1) \, dots.h \, v_(i_k) \)$（$1 lt.eq i_1 \, dots.h \, i_k lt.eq n$）に作用させれば$a_(i_1 \, dots.h \, i_k) = 0$が出るので，一次独立性がわかる．

  $cal(T)^k \( V^(\*) \)$の生成系になっていることを示すために，$T in cal(T)^k \( V^(\*) \)$を任意に一つ取る．$u_1 \, dots.h \, u_n in V$を任意に取り，それを基底\$\\set{v\_1, \\dots, v\_n}\$で展開した係数を$a_i^j$のように書く；$u_i eq.colon sum_j a_i^j v_j$．このとき，
  $ T \( u_1 \, dots.h \, u_n \) & = T (sum_(j_1) a_1^(j_1) v_(j_1) \, dots.h \, sum_(j_n) a_1^(j_n) v_(j_n))\
  & = sum_(j_1) a_1^(j_1) T (v_(j_1) \, sum_(j_2) a_2^(j_2) v_(j_2) \, dots.h \, sum_(j_n) a_n^(j_n) v_(j_n))\
  & = dots.h.c\
  & = sum_(j_1) a_1^(j_1) a_2^(j_2) dots.h a_n^(j_n) T (v_(j_1) \, dots.h \, v_(j_n))\
  & = sum_(j_1) a_1^(j_1) a_2^(j_2) dots.h a_n^(j_n) w^(j_1) times.circle dots.h times.circle w^(j_n) $となるので，$w^(i_1) times.circle dots.h times.circle w^(i_k)$たちは$cal(T)^k \( V^(\*) \)$の生成系である．

]
#defi[
  $f : V arrow.r W$を線型写像とする．このとき，$f^(\*) : cal(T)^k \( W \) arrow.r cal(T)^k \( V^(\*) \)$を，$T in cal(T)^k \( W \)$ならびに$v_1 \, dots.h \, v_k in V$に対して$\( f^(\*) T \) \( v_1 \, dots.h \, v_k \) colon.eq T \( f \( v_1 \) \, dots.h \, f \( v_n \) \)$と定める．$f^(\*) T$を$f$による$T$の引き戻しという．

]
#dig[
  $f^(\*)$を何と呼ぶかはやや迷った．多様体上の微分形式に対しては「引き戻し」という言い方をするのが非常に一般的である．のだが，ただの多重線型写像に対して「引き戻し」という言葉遣いをする例はあまり聞かない気がする．とはいえ呼んで悪いことはないだろう．$f^(\*)$を「$f$が引き起こす写像」とか「$f$によって引き起こされた写像」ということも多い．ちなみに$k = 1$の場合は$f^(\*)$を$f$の双対写像というのだが，$k > 1$の場合まで双対写像と呼んでいる人は見たことがない．見たことがないだけで，いるかも知れない．

]
#exm[
  手頃な，そして重要なテンソルの例は内積と行列式である．

  - $bb(R)^n$の標準内積$angle.l dot.op \, dot.op angle.r : bb(R)^n times bb(R)^n arrow.r bb(R)$は$cal(T)^2 \( \( bb(R)^n \)^(\*) \)$の元である．ところで，内積は単にテンソルであるというだけではなくて引数入れ替えに関して対称という性質がある．

  - 行列式$A mapsto det A$を，ベクトルを$n$個受け取る多重線型写像$det : bb(R)^n times bb(R)^n dots.h times bb(R)^n arrow.r bb(R)$とみなせば，$det in cal(T)^n \( \( bb(R)^n \)^(\*) \)$である．ところで，行列式は単にテンソルであるというだけではなくて引数入れ替えをすると一定のルールのもとで符号が入れ替わるという性質がある．

]
直前の例で，それぞれは単にテンソルであるだけではないということを述べた．これらの「追加的に充たされている」性質を抽出して定義されるのが対称テンソルや交代テンソルの概念である．

#defi[
  - $T in cal(T)^2 \( V^(\*) \)$が非退化であるとは，任意の$v in V$に対して$T \( v \, v \) eq.not 0$であることをいう．$T in cal(T)^2 \( V^(\*) \)$が正定値であるとは，任意の$0_V eq.not v in V$に対して$T \( v \, v \) > 0$となることをいう．

  - $S in cal(T)^k \( V^(\*) \)$が対称テンソルであるとは，任意の$v_1 \, dots.h \, v_k in V$ならびに$i eq.not j$に対して，
    $
      S \( v_1 \, dots.h \, v_i \, dots.h \, v_j \, dots.h \, v_k \) = S \( v_1 \, dots.h \, v_j \, dots.h \, v_i \, dots.h \, v_k \)
    $
    が成り立つことをいう．$V$上の正定値対称2階テンソルのことを$V$の内積という#footnote[内積は正定値なので，自動的に2階テンソルになるから「2階」は余計なのだが，別に書いて損することもないと思ったので明示的に書いた．];．

  - $omega in cal(T)^k \( V^(\*) \)$が交代テンソルであるとは，任意の$v_1 \, dots.h \, v_k in V$ならびに$i eq.not j$に対して，
    $
      omega \( v_1 \, dots.h \, v_i \, dots.h \, v_j \, dots.h \, v_k \) = - omega \( v_1 \, dots.h \, v_j \, dots.h \, v_i \, dots.h \, v_k \)
    $
    が成り立つことをいう．$V$上の$k$階交代テンソル全体の集合を$and.big^k \( V^(\*) \)$で表す．これは$cal(T)^k \( V^(\*) \)$の部分空間である．ただし，$k = 1$の場合は$and.big^1 \( V^(\*) \) = cal(T)^1 \( V^(\*) \)$である#footnote[$i eq.not j$となるような$i \, j$が取れないため，交代テンソルが充たすべき条件は常に空虚に真である．];．

]
#dig[
  Spivak
  だと交代テンソル全体の記号として$Omega^k \( V \)$を使っていたが，このノートでは微分可能多様体$M$上の微分$k$-形式の集合に$Omega^k \( M \)$を充てたいので，記号を変えることにした．$and.big^k \( V^(\*) \)$という記号も一般的なものだと思う．$and.big^k \( V \)$が出てこない理由は，$cal(T)^k \( V \)$が出てこない理由と同様である．

]
#lem[
  $T in cal(T)^2 \( V^(\*) \)$を$V$の内積とする．このとき，$V$上の基底\$\\set{v\_1, \\dots, v\_n}\$であって，
  \$\$T(v\_i, v\_j) = \\begin{dcases\*}
  1 & if \$i=j\$ \\\\
  0 & otherwise
  \\end{dcases\*}\$\$
  を充たすようなものが存在する．このような\$\\set{v\_1, \\dots, v\_n}\$を$T$に関する正規直交基底という．

]
#proof[
  $bb(R)^n$の場合と同様に Gram-Schmidt の正規直交法によれ．

]
#dig[
  Kronecker
  のデルタを使って$T \( v_i \, v_j \) = delta_(i j)$と書こうかとも思ったのだが，やめた．第1節で述べたとおり，このノートでは意図して添字の上下を書き分けている箇所が多々ある．それを踏まえると，特に何も考えずに下付きの添字を書いたとしても，意図があって下付きになっていると読まれそうな気がしたからである．ここに限った話ではないが，用語や記法は難しさをおぼえることが少なくないと感じる．

]
特に交代テンソルは微分形式の定義に直結するので，この項で基本的性質を調べておくことにする．それに先立ち，線型代数で行列式を学んだ際に触れたであろう次の事実を思い出しておこう；

#prop[
  $F : M_n \( bb(R) \) arrow.r bb(R)$を，$bb(R)^n$の元を$n$個受け取る写像とみなす；$F : bb(R)^n times dots.h times bb(R)^n arrow.r bb(R)$．$F$が交代的な多重線型写像であるならば，ある定数$c in bb(R)$が存在して$F = c dot.op det$が成り立つ．

]
<行列式の特徴づけ>
この事実を言い換えると，$F in and.big^n \( bb(R)^n \)$ならば，$F$は$det$の定数倍になっているということである．これをさらに言い換えれば，$F$は線型空間として1次元である（基底として$det$が取れる）ということになる．ここでは，より一般的な状況を調べておく；$n$次元線型空間$V$に対して$and.big^k \( V^(\*) \)$の基底を列挙することで，その次元が$""_n C_k = frac(n !, k ! \( n - k \) !)$であることを示す．そのためには外積と呼ばれる操作が必要になる．

#defi[
  - $T in cal(T)^k \( V^(\*) \)$に対して，$"Alt" \( T \) in cal(T)^k \( V^(\*) \)$を
    $ "Alt" \( T \) \( v_1 \, dots.h \, v_k \) colon.eq frac(1, k !) sum_(sigma in frak(S)_k) \( "sgn" sigma \) T \( v_(sigma \( 1 \)) \, dots.h \, v_(sigma \( k \)) \) $で定める．但し，$frak(S)_k$は$k$次対称群#footnote[\$\[k\] \\coloneqq \\set{1, \\cdots, k}\$と置いて，\$\\mathfrak{S}\_k \\coloneqq \\set{ \\sigma \\colon \[k\] \\to \[k\] | \\sigma は全単射}\$を$k$次対称群という．「群」という文字を見たことがあるかどうかはともかくとして，この概念自体は行列式の定義で見かけていると思う．];．$"Alt" : cal(T)^k \( V^(\*) \) arrow.r cal(T)^k \( V^(\*) \)$は線型写像である．すぐ後に見るが，$"Alt" \( T \) in and.big^k \( V^(\*) \)$となることがわかるので，それを踏まえて$"Alt" : cal(T)^k \( V^(\*) \) arrow.r and.big^k \( V^(\*) \)$を交代化作用素という．頭についている係数のいわれは後でわかる．

  - $omega in and.big^k \( V^(\*) \)$，$eta in and.big^ell \( V^(\*) \)$に対して，その外積$omega and eta in and.big^(k + ell) \( V^(\*) \)$を，
    $ omega and eta colon.eq frac(\( k + ell \) !, k ! ell !) "Alt" \( omega times.circle eta \) $で定める．こちらも頭についている係数の所以は後で説明する．

]
#que[
  $omega in and.big^k \( V^(\*) \)$，$eta in and.big^ell \( V^(\*) \)$に対して，$omega times.circle eta in and.big^(k + ell) \( V^(\*) \)$とは限らない．

]
#que[
  交代化作用素と外積の定義を天下りに与えたくない気持ちがあるのだが，あまり良い説明を思いつかない．確かにテンソルを交代テンソルに化かすためには（定数倍を除いて）交代化作用素以上に簡単な方法はないとも思うし，交代性を保つような演算として外積より簡単なものを持ってこいと言われても（定数倍の差はともかく）（少なくとも私は）困るしかない．そんなわけで，「これは自然に思いつく」と言われたとしても，渋い顔をしながら「そうかもしれないですね」と言う以外にないのが正直なところである．ちなみに外冪の函手性を使うのはこのノートの範囲では禁じ手だと思うのでやらない．言い換えると，函手性という概念を知らない人が外冪の函手性に気づけるような筋書きが私の探している「良い説明」である．

]
#prop[
  + $omega in and.big^k \( V^(\*) \)$，$sigma in frak(S)_k$ならびに$v_1 \, dots.h \, v_k in V$に対して$omega \( v_(sigma \( 1 \)) \, dots.h \, v_(sigma \( k \)) \) = \( "sgn" sigma \) dot.op omega \( v_1 \, dots.h \, v_k \)$．

  + $T in cal(T)^k \( V^(\*) \)$に対して，$"Alt" \( T \) in and.big^k \( V^(\*) \)$．

  + $omega in and.big^k \( V^(\*) \)$に対して，$"Alt" \( omega \) = omega$．

  + $T in cal(T)^k \( V^(\*) \)$に対して，$"Alt" \( "Alt" \( T \) \) = "Alt" \( T \)$．

]
<交代化作用素の基本性質>
#proof[
  + $sigma$が互換の場合は交代テンソルの定義そのものである．一般の置換は互換の積に分解できることからよい．

  + $i$と$j$のみを動かしその他を動かさない互換を$\( i med j \)$と書くことにして，$sigma in frak(S)_k$に対し$sigma' colon.eq sigma compose \( i med j \)$と置く．写像$sigma mapsto sigma'$は単射であることに注意すると，$v_1 \, dots.h \, v_k in V$に対して，
    $ "Alt" \( T \) \( v_1 \, dots.h \, v_j \, dots.h \, v_i \, dots.h \, v_k \) & = frac(1, k !) sum_(sigma in frak(S)_k) \( "sgn" sigma \) T \( v_(sigma \( 1 \)) \, dots.h \, v_(sigma \( j \)) \, dots.h \, v_(sigma \( i \)) \, dots.h \, v_(sigma \( k \)) \)\
    & = frac(1, k !) sum_(sigma in frak(S)_k) \( "sgn" sigma \) T \( v_(sigma' \( 1 \)) \, dots.h \, v_(sigma' \( i \)) \, dots.h \, v_(sigma' \( j \)) \, dots.h \, v_(sigma' \( k \)) \)\
    & = frac(1, k !) sum_(sigma in frak(S)_k) - \( "sgn" sigma' \) T \( v_(sigma' \( 1 \)) \, dots.h \, v_(sigma' \( i \)) \, dots.h \, v_(sigma' \( j \)) \, dots.h \, v_(sigma' \( k \)) \)\
    & = frac(1, k !) sum_(sigma' in frak(S)_k) - \( "sgn" sigma' \) T \( v_(sigma' \( 1 \)) \, dots.h \, v_(sigma' \( i \)) \, dots.h \, v_(sigma' \( j \)) \, dots.h \, v_(sigma' \( k \)) \)\
    & = - "Alt" \( T \) \( v_1 \, dots.h \, v_i \, dots.h \, v_j \, dots.h \, v_k \) $となるからよい．

  + (i) の結果より
    $
      "Alt" \( omega \) \( v_1 \, dots.h \, v_k \) & = frac(1, k !) sum_(sigma in frak(S)_k) \( "sgn" sigma \) omega \( v_(sigma \( 1 \)) \, dots.h \, v_(sigma \( k \)) \)\
      & = frac(1, k !) sum_(sigma in frak(S)_k) \( "sgn" sigma \) \( "sgn" sigma \) omega \( v_1 \, dots.h \, v_k \)\
      & = frac(1, k !) sum_(sigma in frak(S)_k) omega \( v_1 \, dots.h \, v_k \)\
      & = omega \( v_1 \, dots.h \, v_k \) .
    $

  + (ii) と (iii) よりよい．

]
#dig[
  証明をよく見ればわかるように，交代化作用素に係数$frac(1, k !)$がついているのは$omega in and.big^k \( V^(\*) \)$に対して$"Alt" \( omega \) = omega$を成り立たせるため，別の言い方をすれば$"Alt"$が射影作用素としてはたらく，冪等になる（$"Alt"^2 = "Alt"$が成り立つ）ようにするためである．

]
#prop[
  + 外積を取る操作は双線型である．即ち，$omega \, omega_1 \, omega_2 in and.big^k \( V^(\*) \)$ならびに$eta \, eta_1 \, eta_2 in and.big^ell \( V^(\*) \)$，$a in bb(R)$を任意に取れば，

    - $omega and \( eta_1 + eta_2 \) = omega and eta_1 + omega and eta_2$

    - $\( omega_1 + omega_2 \) and eta = omega_1 and eta + omega_2 and eta_2$

    - $a \( omega and eta \) = \( a omega \) and eta = omega and \( a eta \)$

    が成り立つ．

  + 外積を取る操作は次の意味で引き戻しと可換である；$omega in and.big^k \( V^(\*) \)$ならびに$eta in and.big^ell \( V^(\*) \)$として，$f : V arrow.r W$を線型写像とするとき，$f^(\*) \( omega and eta \) = f^(\*) \( omega \) and f^(\*) \( eta \)$．

  + 外積を取る操作は次の意味で交代的である；$omega in and.big^k \( V^(\*) \)$ならびに$eta in and.big^ell \( V^(\*) \)$に対して$omega and eta = \( - 1 \)^(k ell) eta and omega$．

  + 外積を取る操作は結合的である．特に，$omega in and.big^k \( V^(\*) \)$，$eta in and.big^ell \( V^(\*) \)$，$theta in and.big^m \( V^(\*) \)$に対して，$\( omega and eta \) and theta = omega and \( eta and theta \) = frac(\( k + ell + m \) !, k ! ell ! m !) "Alt" \( omega times.circle eta times.circle theta \)$が成り立つ．

]
#proof[
  + $"Alt"$の線型性と$times.circle$の双線型性よりよい．細かいことはめんどくさいのでさぼりました．

  + めんどくさいのでさぼりました．直接計算すれば (i)
    よりも簡単に証明できるはず．

  + $tau in frak(S)_(k + ell)$を，
    $ tau colon.eq mat(delim: "(", 1, 2, dots.h.c, ell, ell + 1, dots.h.c, ell + k; k + 1, k + 2, dots.h.c, k + ell, 1, dots.h.c, k) $で定めると，$"sgn" tau = \( - 1 \)^(k ell)$である#footnote[いわゆる「あみだくじ」を書いて符号を計算するのが一番簡単だと思う．];．@交代化作用素の基本性質
    (i) を繰り返し使うと，
    $
      \( omega and eta \) \( v_1 \, dots.h \, v_(k + ell) \) & = frac(1, \( k + ell \) !) sum_(sigma in frak(S)_(k + ell)) \( "sgn" sigma \) omega \( v_(sigma \( 1 \)) \, dots.h \, v_(sigma \( k \)) \) eta \( v_(sigma \( k + 1 \)) \, dots.h \, v_(sigma \( k + ell \)) \)\
      & = frac(1, \( k + ell \) !) sum_(sigma in frak(S)_(k + ell)) \( "sgn" sigma \)^3 omega \( v_1 \, dots.h \, v_k \) eta \( v_(k + 1) \, dots.h \, v_(k + ell) \)\
      & = frac(1, \( k + ell \) !) sum_(sigma in frak(S)_(k + ell)) \( "sgn" sigma \) omega \( v_1 \, dots.h \, v_k \) eta \( v_(k + 1) \, dots.h \, v_(k + ell) \)\
      & = frac(1, \( k + ell \) !) sum_(sigma in frak(S)_(k + ell)) \( "sgn" sigma \) omega \( v_(tau \( ell + 1 \)) \, dots.h \, v_(tau \( ell + k \)) \) eta \( v_(tau \( 1 \)) \, dots.h \, v_(tau \( ell \)) \)\
      & = frac(1, \( k + ell \) !) sum_(sigma in frak(S)_(k + ell)) \( "sgn" sigma \) \( "sgn" tau \) omega \( v_(ell + 1) \, dots.h \, v_(ell + k) \) eta \( v_1 \, dots.h \, v_ell \)\
      & = frac(\( - 1 \)^(k ell), \( k + ell \) !) sum_(sigma in frak(S)_(k + ell)) \( "sgn" sigma \) eta \( v_1 \, dots.h \, v_ell \) omega \( v_(ell + 1) \, dots.h \, v_(ell + k) \)\
      & = \( - 1 \)^(k ell) \( eta and omega \) \( v_1 \, dots.h \, v_(k + ell) \) .
    $

  + 証明を3段階に分割する．

    + $S in cal(T)^k \( V^(\*) \)$並びに$T in cal(T)^ell \( V^(\*) \)$に対して$"Alt" \( S \) = 0$または$"Alt" \( T \) = 0$ならば$"Alt" \( S times.circle T \) = 0$となることを示す．議論は同様なので$"Alt" \( S \) = 0$の場合のみ証明する．ここでは$frak(S)_k$を（$sigma in frak(S)_k$は$k + 1 \, dots.h \, k + ell$を動かさないような$frak(S)_(k + ell)$の元だとみなすことで）$frak(S)_(k + ell)$の部分集合とみなす．
      $
        sum_(sigma in frak(S)_k) S \( v_(sigma \( 1 \)) \, dots.h \, v_(sigma \( k \)) \) T \( v_(sigma \( k + 1 \)) \, dots.h \, v_(sigma \( k + ell \)) \) & = sum_(sigma in frak(S)_k) S \( v_(sigma \( 1 \)) \, dots.h \, v_(sigma \( k \)) \) T \( v_(k + 1) \, dots.h \, v_(k + ell) \)\
        & = (sum_(sigma in frak(S)_k) S \( v_(sigma \( 1 \)) \, dots.h \, v_(sigma \( k \)) \)) T \( v_(k + 1) \, dots.h \, v_(k + ell) \)\
        & = 0 .
      $
      次いで，$tau in frak(S)_(k + ell) \\ frak(S)_k$を任意に取る#footnote[ここから先の議論は群の剰余類の考え方を知っていれば見通しがよいと思う．要するに$frak(S)_(k + ell)$を部分群$frak(S)_k$の定める右剰余類に分解し，各剰余類において和が0だから全体の和も0であるということを（群の言葉を一切出さずに）議論しているに過ぎない．];．\$\\mathfrak{S}\_k \\tau \\coloneqq \\set{\\sigma \\tau | \\sigma \\in \\mathfrak{S}\_k}\$と置くと，
      $ sum_(sigma in frak(S)_k tau) S \( v_(sigma \( 1 \)) \, dots.h \, v_(sigma \( k \)) \) T \( v_(sigma \( k + 1 \)) \, dots.h \, v_(sigma \( k + ell \)) \) & = sum_(sigma' in frak(S)_k) S \( v_(sigma' tau \( 1 \)) \, dots.h \, v_(sigma' tau \( k \)) \) T \( v_(tau \( k + 1 \)) \, dots.h \, v_(tau \( k + ell \)) \)\
      & = (sum_(sigma' in frak(S)_k) S \( v_(sigma' tau \( 1 \)) \, dots.h \, v_(sigma' tau \( k \)) \)) T \( v_(tau \( k + 1 \)) \, dots.h \, v_(tau \( k + ell \)) \)\
      & = (sum_(sigma' in frak(S)_k) S \( v_(sigma' \( 1 \)) \, dots.h \, v_(sigma' \( k \)) \)) T \( v_(tau \( k + 1 \)) \, dots.h \, v_(tau \( k + ell \)) \)\
      & = 0 . $ここで，$frak(S)_k sect frak(S)_k tau = nothing$が次のようにしてわかる．そうでないとして，$sigma_0 in frak(S)_k sect frak(S)_k tau$を取ると，$sigma_0 = sigma_1 tau$となるような$sigma_1 in frak(S)_k$がある．したがって$tau = \( sigma_1 \)^(- 1) sigma_0 in frak(S)_k$となるが，これは$tau$の定め方に反する．同様に，相異なる$tau_1 \, tau_2 in frak(S)_(k + ell) \\ frak(S)_k$を取ると$frak(S)_k tau_1 sect frak(S)_k tau_2 = nothing$であることもわかる．以上より，総和$sum_(sigma in frak(S)_(k + ell))$は$sum_(sigma in frak(S)_k) + sum_(tau in frak(S)_(k + ell) \\ frak(S)_k) sum_(sigma in frak(S)_k tau)$の形に分解できる．分解した各々の項が0であることはすでに見たので，全体の総和も0である．

    + $S in cal(T)^k \( V^(\*) \) \, T in cal(T)^ell \( V^(\*) \) \, U in cal(T)^m \( V^(\*) \)$に対して$"Alt" \( S times.circle T times.circle U \) = "Alt" \( "Alt" \( S times.circle T \) times.circle U \) = "Alt" \( S times.circle "Alt" \( T times.circle U \) \)$となることを示す．$"Alt"$は冪等なので，$"Alt" \( "Alt" \( S times.circle T \) - S times.circle T \) = 0$であるから，前段の結果より$"Alt" \( "Alt" \( S times.circle T \) times.circle U - S times.circle T times.circle U \) = 0$を得る．他の等式も同様である．

    + 命題を証明する．
      $ \( omega and eta \) and theta & = frac(\( k + ell \) !, k ! ell !) "Alt" \( omega times.circle eta \) and theta\
      & = frac(\( k + ell \) !, k ! ell !) frac(\( k + ell + m \) !, \( k + ell \) ! m !) "Alt" \( "Alt" \( omega times.circle eta \) times.circle theta \)\
      & = frac(\( k + ell + m \) !, k ! ell ! m !) "Alt" \( omega times.circle eta times.circle theta \)\ $となる．もう一つの等式も同様にすればよい．

]
外積が結合的であることを踏まえて，これ以降は3つ以上の交代テンソルの外積は括弧を省いて$omega and eta and theta$のように書く．

#dig[
  交代テンソルに当てる記号として$omega \, eta \, theta$と進めるのは Spivak
  にならってのことなのだが，どのような規則性に依るものなのか，何ならどれくらい一般的に使われているのか，私はよく知らない．たぶんそれっぽくてかっこいいギリシャ文字を使っているだけなのではなかろうか．

]
さて，$and.big^k \( V^(\*) \)$の次元を決定する準備を兼ねて，外積の係数のいわれを解き明かしておくことにする．

#lem[
  \$\\set{v\_1, \\dots, v\_n}\$を$V$の基底，\$\\set{w^1, \\dots, w^n}\$をその双対基底とする．このとき，$1 lt.eq i_1 < i_2 < dots.h < i_k lt.eq n$ならば
  $ w^(i_1) and dots.h and w^(i_k) \( v_(i_1) \, dots.h \, v_(i_k) \) = 1 $が成り立つ．

]
#proof[
  $ w^(i_1) and dots.h and w^(i_k) & = k ! "Alt" \( w^(i_1) times.circle dots.h times.circle w^(i_k) \)\
  & = sum_(sigma in frak(S)_k) \( "sgn" sigma \) w^(sigma \( i_1 \)) times.circle dots.h times.circle w^(sigma \( i_k \)) $であり，$sigma eq.not upright(i d)$であるならば$\( "sgn" sigma \) w^(sigma \( i_1 \)) times.circle dots.h times.circle w^(sigma \( i_k \)) \( v_(i_1) \, dots.h \, v_(i_k) \) = 0$であるからよい．

]
#dig[
  というわけで，外積の頭の係数はこの式（を含むいろいろな式）の見た目をきれいにするためである．直感的には$v_1^(\*) and v_2^(\*) \( v_1 \, v_2 \)$が$v_1$と$v_2$のなす平行四辺形の面積をはかっていると思える．ここまで実用性のある理由がないように見えなくもないが，いちおうこのあとに出てくる（と思われる）テンソルの成分計算をする際に楽になるという実用上のご利益があると思う．

]
#que[
  いっぽう，定数倍の差が理論に本質的な影響を与えるかというと，（少なくともこのノートの範囲では）与えないと思う．実際，$omega and eta colon.eq "Alt" \( omega times.circle eta \)$と定義する流儀もある．このようにした場合，直感的には$v_1^(\*) and v_2^(\*) \( v_1 \, v_2 \)$が$v_1$と$v_2$のなす単体の面積をはかっていると思える．森田茂之「微分形式の幾何学」曰くは特性類の一般論を述べるときなどはこちらの係数のほうが都合が良いらしい．たぶん適当な意味での自然性も充たすのだと思う．

  他にも$omega and eta colon.eq sqrt(frac(\( k + ell \) !, k ! ell !)) "Alt" \( omega times.circle eta \)$と定義しても結合則は保たれる．これにも何かしらの幾何学的な意味付けを考えることができるのだと思う．

]
#thm[
  \$\\set{v\_1, \\dots, v\_n}\$を$V$の基底，\$\\set{w^1, \\dots, w^n}\$をその双対基底とするとき，
  \$\$\\set{w^{i\_1} \\wedge \\dots \\wedge w^{i\_k} | 1 \\leq i\_1 \< \\dots \< i\_k \\leq n}\$\$は$and.big^k \( V^(\*) \)$の基底である．したがって$dim and.big^k \( V^(\*) \) = frac(n !, k ! \( n - k \) !)$．

]
#proof[
  一次独立性と生成系になっていることを証明すればよい．

  一次独立性を示すために，
  $ sum_(1 lt.eq j_1 < dots.h < j_k lt.eq n) a_(j_1 \, dots.h \, i_k) w^(j_1) and dots.h and w^(j_k) = 0 $であったと仮定する．$1 lt.eq j_1 < dots.h j_k lt.eq n$となるような整数の組$\( j_1 \, dots.h \, j_k \)$を取った上で両辺に$\( v_(j_1) \, dots.h \, v_(j_k) \)$を作用させれば$a_(j_1 \, dots.h \, j_k) = 0$がわかる．

  $omega in and.big^k \( V^(\*) \)$を任意に取れば$omega in cal(T)^k \( V^(\*) \)$なので，
  $ omega eq.colon sum_(i_1 \, dots.h \, i_k) a_(i_1 \, dots.h \, i_k) w^(i_1) times.circle dots.h times.circle w^(i_k) $と展開できる．両辺に交代化作用素を施すことで，
  $ "Alt" \( omega \) = omega & = sum_(i_1 \, dots.h \, i_k) a_(i_1 \, dots.h \, i_k) "Alt" \( w^(i_1) times.circle dots.h times.circle w^(i_k) \)\
  & = frac(1, k !) sum_(i_1 \, dots.h \, i_k) a_(i_1 \, dots.h \, i_k) w^(i_1) and dots.h and w^(i_k) $となるので，生成系であることがわかる．

]
したがって特に，$V$が（$bb(R)^n$でなかったとしても）$n$次元線型空間であるならば，$dim and.big^n \( V^(\*) \) = 1$であるとわかる．

#lem[
  \$\\set{v\_1, \\dots, v\_n}\$を$V$の基底とし，$omega in and.big^n \( V^(\*) \)$を任意に取る．更に，$w_1 \, dots.h \, w_n in V$を任意にとり$w_i eq.colon sum a_i^j v_j$と置く．このとき，
  $ omega \( w_1 \, dots.h \, w_n \) = det (a_i^j) omega \( v_1 \, dots.h \, v_n \) . $

]
<最高次交代テンソルの変換則>
#proof[
  $eta in cal(T)^n \( bb(R)^n \)$を次のように定める；$b_i = \( b_i^1 \, dots.h \, b_i^n \) in bb(R)^n$（$1 lt.eq i lt.eq n$）に対して，
  $ eta \( b_1 \, dots.h \, b_n \) colon.eq omega (sum_i b_1^i v_i \, dots.h \, sum_i b_n^i v_i) . $$omega in and.big^n \( V^(\*) \)$であることから，$eta in and.big^n \( bb(R)^n \)$がわかるので，ある定数$c in bb(R)$があり，$eta = c dot.op det$である．$b_i = e_i$（$bb(R)^n$の標準基底）の場合を考えることで，$c = omega \( v_1 \, dots.h \, v_n \)$がわかるから，$omega \( w_1 \, dots.h \, w_n \) = eta \( a_1 \, dots.h \, a_n \) = det (a_i^j) omega \( v_1 \, dots.h \, v_n \)$を得る．

]
== ベクトル場
<ベクトル場>
$bb(R)^n$におけるベクトル場，ならびにベクトル場に沿った微分を定義する．Stokes
の定理までの最短ルートを採るならばベクトル場に沿った微分はやらなくても済むのだが，やらないのも微妙な気がするし，話のネタにもなると思うので，書いてみることにする．なお，これ以降，本ノートの終わりまで，$C^oo$級たりえるすべてのものは断りなく$C^oo$級と仮定することがある．

#que[
  …というおまじないをかけたが，正直このおまじないがどこでどのように効いてくるのかいまいちよくわかっていない．関数が何回微分されたか等をいちいち気にするのが煩わしいので，それを気にしないで済ませるため，というのはあるのだが，もう少し本質的に効いてくるポイントもあるような気もしている．ひとつには，のちに外微分を局所座標を用いつつ定義するのだが，そこで
  well-defined
  なことを証明するのに微分形式が$C^2$級であることが本質的に効く．それ以外にもあるかもしれない．

]
#defi[
  $p in bb(R)^n$に対して，\$T\_p \\mathbb{R}^n \\coloneqq \\set{(p,v)| v \\in \\mathbb{R}^n}\$を$p$における接ベクトル空間，あるいは接空間という．$T_p bb(R)^n$は以下のように加法とスカラー倍を入れることで線型空間の構造を持つ；

  - $\( p \, v \) + \( p \, v' \) = \( p \, v + v' \)$

  - $a \( p \, v \) = \( p \, a v \)$

  $\( p \, v \) in T_p bb(R)^n$のことを$"Tan"_p \( v \)$とも書く．また，$T_p bb(R)^n$上の標準内積$angle.l dot.op \, dot.op angle.r_p$を，$angle.l "Tan"_p \( v \) \, "Tan"_p \( v \) angle.r_p colon.eq angle.l v \, w angle.r$によって定める．$\[ "Tan"_p \( e_1 \) \, dots.h \, "Tan"_p \( e_n \) \]$を$T_p bb(R)^n$の自然な向きと呼ぶ．

]
気分としては，$T_p bb(R)^n$は「$p in bb(R)^n$に足を持つベクトルの集合」である．ところで，古典ベクトル解析でベクトル場というものを見たことがあるかもしれない．ベクトル場はしばしば，$bb(R)^n$の各点にベクトルが生えているかのような図示がなされるが，その数学的な定式化のために接空間を持ち出した．すなわち，ベクトル場とは，各点$p$に対して$p$に足を持つようなベクトルを対応させる写像のこととする；

#dig[
  接空間の定義だけ見ても「接して」いる感じが全くしないかもしれないが，それは
  Euclid
  空間が平らだからである．この「接空間」は，曲面のある点における接平面を抽象化したようなものである．のだが，その「曲面」が真っ平らだと「接して」いる感じはしない．

  今後も何度か Euclid
  空間の性質の良さに文句を言う「余談」が出てくることになるだろう．不思議なものだが，このあたりの概念は
  Euclid
  空間の場合を考えるとかえってわかりにくい，といったケースが頻発するように思う．

]
#defi[
  $T bb(R)^n colon.eq union.big_(p in bb(R)^n) T_p bb(R)^n$を$bb(R)^n$の接ベクトル束，あるいは接束という．$U subset bb(R)^n$を開集合とするとき，写像$X : U arrow.r T bb(R)^n$が$U$上のベクトル場であるとは，任意の$p in bb(R)^n$に対して$X \( p \) in T_p bb(R)^n$であることをいう．定義域が問題にならない場合は「$U$上の」を省略する．

  ベクトル場$X$に対して，$X \( p \)$のことを$X_p$とも書く．また，$X_p = "Tan"_p \( v \)$であるような$v$のことを$"Vect" \( X_p \)$であらわす．$X \, Y$をベクトル場とするとき，これらの和，関数倍，標準内積を，$\( X + Y \)_p colon.eq X_p + Y_p$，$\( f X \)_p colon.eq f \( p \) X_p$，$angle.l X \, Y angle.r \( p \) colon.eq angle.l X_p \, Y_p angle.r_p$によって定める．

]
#defi[
  ベクトル場$bb(R)^n in.rev p mapsto "Tan"_p \( e_i \) in T_p bb(R)^n$のことを$E_i$と書くことにする．

]
#dig[
  $"Tan"_p \( v \)$や$"Vect" \( X_p \)$などという記号を採用したのはかなりの苦し紛れであり，おそらくこのノート以外では使われていない記号だと思う．当初はこのノートでは
  Spivak
  にならって$\( p \, v \) in T_p bb(R)^n$のことを$v_p$と書こうと思っていた．一方，ベクトル場$X$の$p$における値も$X_p$と書いている（この記法もかなり一般的である）．そうすると$""_p$という記号が二通りに使われる．結果，$e_i$というのが$bb(R)^n$の標準基底なのか，各点に標準基底を対応させるようなベクトル場なのかがわからなかったり，「ベクトル場$X$」と書くだけで，各点にベクトル$X in bb(R)^n$を対応させる定ベクトル場に見えたりするようになった．さすがに無理があると判断して$v_p$という記号をやめて$"Tan"$という記号を導入した．いっぽう$X_p$の第2成分が取れないのも不便なので$"Vect"$を導入した．接空間を微分作用素の空間として定義すればこのような悩みを抱えずに済んだような気もするが，この定義は最初に見たときにとっつきにくかったので，使いたくなかった．といった紆余曲折の結果がこれである．

  また，ベクトル場の終域をちゃんと明示するためにベクトル束という言葉だけを出した．けれども，このノートではそれ以上のことをするつもりはないので，接空間の和集合，以上のことはいったん考えないつもりである．本当はそうではないらしいのだけど，なにかに困らない限りそのあたりの話に踏み込む予定は（今のところ）ない．

]
ベクトル場を考える一つのモチベーションは，ベクトル場に沿った微分操作（方向微分）の概念が作れることである．$bb(R)^n$の場合だけを考えるのであれば，ベクトル場に沿った微分を定義すること自体はそんなに大変ではない．$f : bb(R)^n arrow.r bb(R)$を微分可能な関数として，ベクトル場$E_i$に沿った$f$の微分を
$ \( E_i f \) \( p \) colon.eq lim_(t arrow.r 0) frac(f \( p + t e_i \) - f \( p \), t) = partial_i f \( p \) $と定めて，一般のベクトル場に沿った微分はこの定義を適切に拡張して定めればよい．

ここで定義を終わりにすることもできなくはないが，まだ考察の余地があるのも事実である；数学的には，上記の定義は微分可能多様体に対して拡張が通らない．物理的にも，ベクトル場はなにかの物理現象のモデリングが主たる用途のひとつなので，特定の座標系に本質的に依存するべきではなく，別の座標系で表現されてよいし，座標変換の際は適切な変換を受けるべきである．これらのことを踏まえて，後々を見越して定義を述べ直し，座標変換にともなうベクトル場の変換則についても述べる．

というわけでここからは，ベクトル場ならびにベクトル場に沿った微分の「座標系によらない実体」を掴むことを当座の目標にする．記号$M$を$M colon.eq bb(R)^n$で定める．数学的には$M$は単なる$bb(R)^n$のコピーなので，標準基底から定まる座標軸がなかば自動で引けてしまうのだが，気持ちとしてはまだ座標軸を一切引いていない空間，という気持ちで読んでほしい．逆に$M$ではなく$bb(R)^n$と書いたら，標準基底から定まる座標軸を引いたあとの空間を想定している．

#dig[
  もちろん，$M$と$bb(R)^n$が同じものならわざわざ記号を分けなくても数学的には同じものが出てくるはずなので，これ以降の記述は一部に迂遠な部分が現れる．のだが，のちに出てくる「座標軸が自動では引けない状況」（一般の微分可能多様体における議論）への着地をソフトにするために$bb(R)^n$の場合を見て慣れておく，という意図で遠回りなまま書くことにした．この「座標軸が自動で引けるとは限らないので，自分で都合よく座標軸を引いて考えて，座標軸の引き方に依存しないことを後追いで確かめる」という考え方は微分可能多様体上の考察においてよく用いるのだが，その考えを適用するのがいちばん難しい（勝手に座標軸が引かれてしまう）のが，一番簡単な微分可能多様体であるはずの$bb(R)^n$である，というのは難しいところと見るべきか，それとも私の考えすぎか．

]
#defi[
  $X$を$M$上のベクトル場とし，$f : M arrow.r bb(R)$を微分可能な関数とする．このとき，$f$の$X_p$による微分$X_p f in bb(R)$を，
  $ X_p f colon.eq lim_(t arrow.r 0) frac(f \( p + t "Vect" \( X_p \) \) - f \( p \), t) $
  によって定める．$f$の$X$に沿った微分$X f : M arrow.r bb(R)$を$\( X f \) \( p \) colon.eq X_p f$によって定める．

]
#defi[
  $U subset M$を開集合とする．$y : U arrow.r y \( U \) subset bb(R)^n$が（$C^r$級）微分同相写像のとき，$y = \( y^1 \, dots.h \, y^n \)$を$U$上の$bb(R)^n$の（$C^r$級）座標系という．

]
#dig[
  ここで，$y$が「微分」同相写像であることを仮定しているが，ここはずるいことをしたと言える．というのも，$y$の微分可能性について議論するためには$M$の実体が
  Euclid
  空間であることを使わざるを得ないのであるが，それは$M$に標準座標を入れているのではないかと言われると返す言葉がない．

  とはいえ，ここで$y$が微分同相ではなく単に同相であるとだけ仮定してしまうと，このあとの議論に支障が出る．微分可能な関数$f : M arrow.r bb(R)$に対して$partial_i \( f compose y^(- 1) \)$といった関数の微分を考えることで座標軸に沿ったベクトル場の定義をするのだが，$y$が微分同相でないとこのような微分がそもそも考えられなくなってしまう．折り目正しくやるなら，微分可能多様体の教科書よろしく位相空間の話からした上で微分構造の定義をきちんとやり，関数の微分可能性も定義し直すことになるような気がする．が，それらをきちんとやるのは気が遠くなるし，何より私は微分構造まわりの話に興味がない．なのでここでズルをやるのも許してほしい．おそらくここ以外でこの手のズルはしていないような気がするが，していたら教えて下さい．

]
#exm[
  - $p = sum_i p^i e_i in M$に対して$p^i$を対応させる座標関数$pi^i : M in.rev p mapsto p^i in bb(R)$を並べて得られる$\( pi^1 \, dots.h \, pi^n \)$は座標系である．この座標系を標準座標系といい，今後$x = \( x^1 \, dots.h \, x^n \)$とも書くことにする#footnote[行儀が悪い記号の書き換えなのは自分でもわかっているのだが，$partial \/ partial pi^1$とか$d pi^1$といった記法を採る選択肢はないため，この書き換えを実行することにした．これを踏まえてノートの前半の記号を全部取り替えるべきな気もする．しかしめんどくさいな…];．と仰々しく書いているが，モノとしては$x = "id"_(bb(R)^n)$である．

  - $M = bb(R)^2$とする．2次元極座標変換$bb(R)^2 supset \( 0 \, oo \) times \( 0 \, 2 pi \) in.rev \( r \, theta \) mapsto \( r cos theta \, r sin theta \) in M$の逆写像は座標系である．この座標系を極座標系という．

]
ある座標系$y$を選んで考えるときに，しばしば「$M$に座標系$y$を入れる」というような言い方をする．気分としては，座標系を用いて座標軸のない
Euclid
空間$M$（の部分集合）を座標軸のある$bb(R)^n$にうつしている．座標系は微分同相なので，その逆写像を用いて座標軸を$M$に書き込んでいると思ってもよい（砕けた言い方だが，こちらのほうがイメージは湧きやすいだろう）．極座標変換の場合の絵をここに入れるのが絶対によいと思うが，図を入れるのを面倒に感じているので，気が向いたら入れる．勉強会では絵を書いて説明する予定．

#que[
  ということで，2次元極座標変換の場合に絵を書いて，上の段落に書いてあることの気持ちを察してください．原点から放射状に引かれる軸と，原点を中心とする円のような軸が描かれるはず．

]
さて，このようにして描いた座標軸があるときに，座標軸に沿った方向微分を考えることがよくある．この「座標軸に沿った方向微分」は，「座標系から定まるベクトル場に沿った微分」と言い換えることで厳密化できるのだが，厳密な定義の前に，定義を作るための動機づけとなるような具体例を幾つか述べよう．$M = bb(R)^2$として，$f : M arrow.r bb(R)$を微分可能な関数とするときに，

- $M$に標準座標系を入れる（要するに通常の Descartes
  座標）．$f$の$x^1$軸#footnote[「$x^1$軸」「$x^2$軸」はそれぞれ「$x$軸」「$y$軸」というのが普通だとは思うが，このノートでは一般の座標系に記号$y$を充ててしまったので，あえて普通でない言い方のままにした．];に沿った方向微分は（厳密な定義を知らなくても）$partial_1 f$のことになってほしいと思うだろう．その直感を尊重するように「ベクトル場$frac(partial, partial x^1)$に沿った$f$の微分が$partial_1 f$に一致する」ような$frac(partial, partial x^1)$を定義したい．同様に$frac(partial, partial x^2)$も定義したい．

- $M$に極座標系を入れる．$f$の動径$r$方向の方向微分や偏角$theta$方向の方向微分を考えることが実用上は多々ある．このような方向微分をするベクトル場$frac(partial, partial r)$ならびに$frac(partial, partial theta)$を定義したい．

これらを含むような一般的な形で，座標系から定まるベクトル場を定義する．

#prop[
  $y = \( y^1 \, dots.h \, y^n \)$を$U subset M$上の座標系とする．このとき，$U$上のベクトル場$frac(partial, partial y^i)$であって，任意の$p in U$ならびに微分可能な関数$f : U arrow.r bb(R)$に対して
  $ (frac(partial, partial y^i) f) \( p \) = (partial_i \( f compose y^(- 1) \)) \( y \( p \) \) $を充たすようなものが唯一つ存在する．更に，${(frac(partial, partial y^i))_p \, dots.h \, (frac(partial, partial y^i))_p}$は$T_p M$の基底をなす．$frac(partial, partial y^i)$を座標系$y$が定めるベクトル場という．$frac(partial, partial y^i) f$のことを$frac(partial f, partial y^i)$とも書く．

]
<Euclid空間での座標系から定まるベクトル場>
#proof[
  $y$が標準座標系$x$の場合は$partial \/ partial x^i colon.eq E_i$と定めればよい．それ以外の場合は，$F = f compose x^(- 1)$，$G = x compose y^(- 1)$と置いて$(partial_i \( f compose y^(- 1) \)) \( y \( p \) \) = (partial_i \( f compose x^(- 1) compose x compose y^(- 1) \)) \( y \( p \) \) = (partial_i \( F compose G \)) \( y \( p \) \)$に対して@実用的な方の合成則
  を適用すると，
  $ (partial_i \( F compose G \)) \( y \( p \) \) & = sum_j \( partial_j F \) \( G \( y \( p \) \) \) dot.op \( partial_i G^j \) \( y \( p \) \)\
  & = sum_j \( partial_j \( f compose x^(- 1) \) \) \( p \) dot.op \( partial_i G^j \) \( y \( p \) \)\
  & = sum_j \( partial_i G^j \) \( y \( p \) \) dot.op (frac(partial, partial x^i) f) \( p \)\ $が成り立つので，
  $ frac(partial, partial y^i) colon.eq sum_j \( partial_i G^j \) \( y \( p \) \) dot.op frac(partial, partial x^i) $と定めればよい．これらが各点$p$で$T_p M$の基底をなすことは，標準座標系の場合は明らかだし，一般の座標系の場合は$\( partial_i G^j \) \( y \( p \) \)$が正則行列であることから従う（正則行列でないとすると，$G = x compose y^(- 1)$が微分同相であることに反する）．

]
#dig[
  $partial_1 f$はしばしば$frac(partial f, partial x^1)$とも書かれることがある（というか，こう書くことのほうが一般的である）．極座標に沿った微分もそれぞれ$frac(partial f, partial r)$とか$frac(partial f, partial theta)$などと書かれることが多い．しかし，このノートではあくまでこれらの記法はベクトル場$frac(partial, partial x^1)$に沿った$f$の微分$frac(partial, partial x^1) f$のように理解する．このノートでこれらの記法をここまで避けてきた理由のひとつはここにもある#footnote[…と言えば聞こえはいいかもしれないが，そのほうが説明の都合がよいと後で気づいたのが正直なところである．];．Euclid
  空間上の関数しか考えないのであれば，この記法をとりわけ避ける必要はなかった．しかし多様体上の関数をベクトル場に沿って微分する際に$frac(partial, partial x^1) f$という記号が使えないのは非常に厳しい反面，この微分は
  Euclid
  空間上の関数に対する偏微分とは異なる概念である．なので，偏微分に$frac(partial, partial x^1) f$という記号を充てるのを避けた．Euclid
  空間に標準座標系を入れた場合は一致するとはいえ，それは特別な場合に過ぎない，という考えである．

  ただ，ベクトル場を表示するのに$frac(partial, partial x^1)$などという表記を充て続けて他の記号を使わないのは，この歴史的表記を受けてのことであることは間違いないだろう．

]
また，上記の証明の過程で行った計算を少し修正することで，ベクトル場の座標変換則を得ることができる；

#prop[
  $y = \( y^1 \, dots.h \, y^n \)$ならびに$z = \( z^1 \, dots.h \, z^n \)$を$U subset M$上の座標系とする．このとき，
  $ (frac(partial, partial z^i))_p = sum_j (frac(partial, partial z^i) y^j) \( p \) dot.op (frac(partial, partial y^j))_p $が成り立つ．したがって，ベクトル場の変換則は
  $ frac(partial, partial z^i) = sum_j frac(partial y^j, partial z^i) frac(partial, partial y^j) $と書ける．

]
#exm[
  具体例として，$bb(R)^2$の場合に標準座標系から極座標系へ変換する公式を導いてみる．極座標系を$P : M in.rev p mapsto \( r \( p \) \, theta \( p \) \) in bb(R)^2$と書き，標準座標系を$p mapsto \( x \( p \) \, y \( p \) \)$と書くことにする．このとき，上の命題より
  $ (frac(partial, partial r))_p & = (frac(partial, partial r) x) \( p \) dot.op (frac(partial, partial x))_p + (frac(partial, partial r) y) \( p \) dot.op (frac(partial, partial y))_p \,\
  (frac(partial, partial theta))_p & = (frac(partial, partial theta) x) \( p \) dot.op (frac(partial, partial x))_p + (frac(partial, partial theta) y) \( p \) dot.op (frac(partial, partial y))_p $が成り立つ．ところで定義より$(frac(partial, partial r) x) \( p \) = partial_1 \( x compose P^(- 1) \) \( P \( p \) \)$である．$P \( p \) eq.colon \( a \, b \)$と置けば，$(frac(partial, partial r) x) \( p \) = cos b$を得る．同様に計算して$(frac(partial, partial r) x) \( p \) = sin b$，$(frac(partial, partial theta) x) \( p \) = - a sin b$，$(frac(partial, partial theta) y) \( p \) = a cos b$を得るので，結局
  $     (frac(partial, partial r))_p & = cos b (frac(partial, partial x))_p + sin b (frac(partial, partial y))_p \, \
  (frac(partial, partial theta))_p & = - a sin b (frac(partial, partial x))_p + a cos b (frac(partial, partial y))_p $となる．このノートの記法としてはインフォーマルな書き方になるものの，
  $     frac(partial, partial r) & = cos theta frac(partial, partial x) + sin theta frac(partial, partial y) \, \
  frac(partial, partial theta) & = - r sin theta frac(partial, partial x) + r cos theta frac(partial, partial y) $と書くほうが馴染みのある方も多いだろう．

]
#defi[
  $y = \( y^1 \, dots.h \, y^n \)$を$U subset M$上の$C^oo$級座標系，$X$を$U$上定義されたベクトル場とする．このとき，任意の$p in U$に対して${(frac(partial, partial y^i))_p \, dots.h \, (frac(partial, partial y^i))_p}$は$T_p M$の基底をなすので，ある関数$f_y : U arrow.r bb(R)^n$が一意的に存在して，
  $ X_p = sum_i f_y^i \( p \) (frac(partial, partial y^i))_p $が成り立つ．このような表示のことを$y$による$X$の（局所）座標表示と呼ぶ．$X$が$C^oo$級，あるいは滑らかであるとは，$f_y$が$C^oo$級であることと定める．

]
#que[
  上記の「ベクトル場が滑らかである」ことの定義は well-defined
  である．すなわち，ベクトル場$X$の座標系$z$による座標表示
  $ X_p = sum_i f_z^i \( p \) (frac(partial, partial z^i))_p $
  に現れる$f_z$が$C^oo$級であるかどうかは，$C^oo$級座標系$z$のとり方によらない．

]
#que[
  ベクトル場が滑らかであるとは，直感的には「点$p$を動かすと，$X$の生やすベクトルが滑らかに変化する」ことだと思うだろう．実際それを定義したいのである．ここでは座標系によらない話をはじめてしまったせいで，滑らかさの定義がずいぶんめんどうなことになってしまった．標準座標しか使わないのであれば，次のように定義するのが一番はやいだろう；「ベクトル場$X$が滑らかであるとは，$M in.rev p mapsto "Vect" \( X_p \) in bb(R)^n$が$C^oo$級であることと定める」．さきほど述べた座標系によらない定義は，この定義を踏まえつつ座標依存性を消すことで得られる．特に，座標系として特に標準座標を取って考えれば，ここで述べた
  handy な定義が復元できる．

]
というわけで，あえて（もともとある標準座標を一旦切り離して）座標系からベクトル場を定め，そのベクトル場に沿って微分するという操作を定義し，座標を取り替えたときにベクトル場がどのような変換を受けるかを見てきた．後に，一般の微分可能多様体に対しても同様の定義や変換則が通ることを見ていくことにする．

ベクトル場に関する話題について，もう一つだけ述べておく．

#defi[
  $M colon.eq bb(R)^m$，$N colon.eq bb(R)^n$と置く．$U subset M$を開集合，$f : U arrow.r N$を関数とする．更に，$p in U$を取り，$X_p in T_p M$とする．このとき，$d f_p X_p = d f_p \( X_p \) in T_(f \( p \)) N$を，任意の関数$g : N arrow.r bb(R)$に対して$\( d f_p X_p \) \( g \) = X_p \( g compose f \)$を充たすようなものとして定める．この対応によって定まる線型写像$d f_p : T_p M arrow.r T_(f \( p \)) N$を，$f$の$p$における微分といい，$p mapsto d f_p$を$d f$と書いて$f$の微分という．

]
第2節で定義した多変数関数の微分を覚えていれば，それと記号や命名の衝突をしていることに気づかれよう．これは意図的である．先ほどは定義域と終域の次元が揃っている場合を考えて，座標系$y$に沿ったベクトル場$partial \/ partial y^i$を定義した．その定義の際に行った議論を，定義域と終域の次元が揃わないケースも含むような形で反芻してみる．$M colon.eq bb(R)^m$，$N colon.eq bb(R)^n$と置き，$M$の標準座標を$x_M$で，$N$の標準座標を$x_N$で表すことにする．@実用的な方の合成則
の主張は，$f : M arrow.r N$ならびに$g : N arrow.r bb(R)$に対して
$ partial_i \( g compose f compose x_M^(- 1) \) \( a \) = sum_j (partial_i \( x_N compose f^j compose x_M^(- 1) \)) \( a \) dot.op partial_j \( g compose x_N^(- 1) \) \( f \( a \) \) $が成り立つ，と言い換えることができる（$x_M$ならびに$x_N$が写像としては$"id"$であることに注意）．これをいま用意した記号を用いて書き換えると，
$
  (frac(partial, partial x_M^i) \( g compose f \)) \( a \) = sum_j (partial_i \( x_N compose f^j compose x_M^(- 1) \)) \( a \) dot.op (frac(partial, partial x_N^j) g) \( f \( a \) \)
$
すなわち
$
  (frac(partial, partial x_M^i))_a \( g compose f \) = sum_j (partial_i \( x_N compose f^j compose x_M^(- 1) \)) \( a \) dot.op (frac(partial, partial x_N^j))_(f \( a \)) g
$
を得る．これは先ほどの定義に則れば，
$ d f_a (frac(partial, partial x_M^i))_a = sum_j (partial_i \( x_N compose f^j compose x_M^(- 1) \)) \( a \) dot.op (frac(partial, partial x_N^j))_(f \( a \)) $にほかならない．すなわち，線型写像$d f_a : T_a M arrow.r T_(f \( a \)) N$を，標準座標系から定まる接ベクトルに関して行列表示すると$f$の
Jacobi
行列が得られると言ってもよいし，第2節で定義した$f : bb(R)^m arrow.r bb(R)^n$の微分$d f_a : bb(R)^m arrow.r bb(R)^n$は，$d f_a : T_a M arrow.r T_(f \( a \)) N$の仮の姿に過ぎなかった，とも言えるのである．

#que[
  ここでは標準座標系だけをとって議論したが，微分の定義は標準座標系という特殊な座標系に依存していない．したがってもちろん標準座標系以外でも似たような議論が通る．これは（行列計算というより）線型代数の基本的な，しかし（それゆえ）難しい議論であると思う．

]
微分の定義がそうであったのと同様に，第2節で示した命題の多くは，接空間の間の写像（写像の微分）を用いた装いへと持ち上げることができる．例えば，

#thm[
  $f : M arrow.r N$，$g : N arrow.r L$に対して，$d \( g compose f \) = d g compose d f$が成り立つ．

]
#proof[
  $X_p in T_p M$ならびに$h : L arrow.r bb(R)$を任意に取れば，$d \( g compose f \)_p \( X_p \) \( h \) = X_p \( h compose g compose f \) = \( d f_p \( X_p \) \) \( h compose g \) = \( \( d g_p \) \( d f_p \( X_p \) \) \) \( h \)$である．

]
== 微分形式
<微分形式>
$M = bb(R)^n$とし，$y : U arrow.r y \( U \)$を$U subset M$上の座標系とする．

#defi[
  $p in M$に対して，$T_p M$の双対空間$\( T_p M \)^(\*)$のことを$T_p^(\*) M$と書いて，$p$における余接空間という．$T_p^(\*) M$も線型空間の構造を持つ．
  更に，$y$の定めるベクトル場は$T_p M$の基底${(frac(partial, partial y^i))_p \, dots.h \, (frac(partial, partial y^i))_p}$を定めた．この基底に関する双対基底を${\( d y^1 \)_p \, dots.h \, (d y^n)_p}$と書く．

]
$d y^i$という表記を採る理由の一部をここで説明する．前項で述べた写像の微分について，やや特別な場合を考察してみる．$f : U arrow.r bb(R)$の$p$における微分$d f_p : T_p M arrow.r T_(f \( p \)) bb(R)$を考える．但し，$f$の終域の$bb(R)$には座標軸が入っていると考え，それを反映して$T_(f \( p \)) bb(R)$は同型写像$T_(f \( p \)) bb(R) in.rev frac(partial, partial x) mapsto 1 in bb(R)$によって$bb(R)$と同一視する．このとき，前項最後の議論から
$ d f_p (frac(partial, partial y^i))_p = (partial_i \( f compose y^(- 1) \)) \( p \) = (frac(partial, partial y^i) f) \( p \) $が従う．特に$f$として座標関数$y^j$を取れば，
$ d y^j_p (frac(partial, partial y^i))_p = (frac(partial, partial y^i) y^j) \( p \) = delta_i^j $がわかるので，特に$y^j$の$p$における微分をあつめた${\( d y^1 \)_p \, dots.h \, (d y^n)_p}$は${(frac(partial, partial y^i))_p \, dots.h \, (frac(partial, partial y^i))_p}$の双対基底と同一視できる．ここで走る同一視$T_(f \( p \)) bb(R) tilde.eq bb(R)$のことは明示的に考えないのがどうやら普通のようである．なので今後も断りなくこの同一視をつかう．

さて，この節の最初で述べた直感を活かすように微分形式を定義する．

#defi[
  $U subset M$を開集合とする．自然数$k gt.eq 1$に対して$omega : U arrow.r union.big_(p in M) and.big^k \( T_p^(\*) M \)$が$U$上の微分$k$-形式，あるいは単に$k$-形式であるとは，任意の$p in U$に対して$omega_p colon.eq omega \( p \) in and.big^k \( T_p^(\*) M \)$となることをいう．また，（滑らかな）関数$f : U arrow.r bb(R)$のことを微分0-形式ともいう#footnote[$cal(T)^0 \( T_p^(\*) M \) = and.big^0 \( T_p^(\*) M \)$の元は「ベクトルを$0$個受け取って実数を返す関数」だと考えれば実数と同一視できる．したがって$f : M arrow.r bb(R)$は$f : M arrow.r union.big_(p in M) and.big^0 \( T_p^(\*) M \)$ともみなせるので，このような定義をするのだと思う，];．$U$上の微分$k$-形式全体の集合を$Omega^k \( U \)$と書く．$omega in Omega^k \( U \)$の関数倍$f omega$のことを$f and omega$とも書く．

]
#que[
  微分形式の和，関数倍，外積が（ベクトル場の場合と同様にして）各点ごとに和，関数倍，外積を取る仕方で定義できる．厳密な定義はさぼります．

]
#defi[
  $omega$を$U$上の$k$-形式とする．このとき，任意の$p in U$に対して${(d y^(i_1))_p and dots.h and (d y^(i_k))_p med divides med 1 lt.eq i_1 < dots.h < i_k lt.eq n}$は$and.big^k T_p^(\*) M$の基底をなすので，$\( i_1 \, dots.h \, i_k \)$で添字付けられたある関数の族\$\\set{ f^y\_{i\_1,i\_2,\\dots,i\_n} \\colon U \\to \\mathbb{R}| 1 \\leq i\_1 \< \\dots \< i\_k \\leq n }\$が一意的に存在して，
  $ omega_p = sum_(1 lt.eq i_1 < i_2 < dots.h i_k lt.eq n) f_(i_1 \, i_2 \, dots.h \, i_n)^y \( p \) dot.op (d y^(i_1))_p and dots.h and (d y^(i_k))_p $が成り立つ．このような表示のことを$y$による$omega$の（局所）座標表示と呼ぶ．$omega$が$C^oo$級，あるいは滑らかであるとは，すべての$f_(i_1 \, i_2 \, dots.h \, i_n)^y$が$C^oo$級であることと定める．

]
#exm[
  上記の定義はお世辞にもわかりやすいとはいえないと思う．定義を理解するために次の例を考える；$f : M arrow.r bb(R)$の$p$における微分$d f_p : T_p M arrow.r bb(R)$を考えると，$d f_p in and.big^1 \( T_p^(\*) M \)$なので，特に$d f$は微分1-形式である．$d f$の座標表示を計算してみよう．${\( d y^1 \)_p \, dots.h \, (d y^n)_p}$は$and.big^1 \( T_p^(\*) M \)$の基底をなすので，ある関数$g_1 \, dots.h \, g_n : M arrow.r bb(R)$が存在して
  $ d f_p = sum_i g_i \( p \) dot.op (d y^i)_p $と書ける．ところで，すでに$d f_p (frac(partial, partial y^i))_p = (frac(partial, partial y^i) f) \( p \)$となることを見たので，$g_i = (frac(partial, partial y^i) f)$である．まとめると，
  $ d f_p = sum_i (frac(partial, partial y^i) f) \( p \) dot.op (d y^i)_p $を得る．

  ところで，しばしば$f$の「全微分」なる概念を
  $ d f colon.eq sum_i frac(partial f, partial y^i) d y^i $と「定義する」，という言い回しを聞いたことがあるかもしれない#footnote[そして往々にして，右辺，とくに$d y^i$が何なのかはきちんと説明されてこない，ということを私自身経験したことがあり，そのたびに苛立っていた．このようにごまかすのも仕方ないかもしれない，と穏やかに思えるようになったのはごく最近のことである．];．この慣習的な言い回しが意味する正確なところはいま述べたとおりである．

]
特に上の例で$f$として座標関数を取れば，微分1-形式の座標変換則を得るに至る．ベクトル場のそれとよく似ているが，しかし異なる変換を受けることを見てほしい．

#prop[
  $y = \( y^1 \, dots.h \, y^n \)$ならびに$z = \( z^1 \, dots.h \, z^n \)$を$U subset M$上の座標系とする．このとき，
  $ (d z^i)_p = sum_j (frac(partial, partial y^j) z^i) \( p \) dot.op (d y^j)_p $が成り立つ．したがって微分1-形式の変換則は
  $ d z^i = sum_j frac(partial z^i, partial y^j) d y^j $と書ける．

]
#dig[
  ここまで，ベクトル場と微分1-形式の座標変換則を見てきた．それぞれを再掲すると，
  $
    (frac(partial, partial z^i))_p = sum_j (frac(partial, partial z^i) y^j) \( p \) dot.op (frac(partial, partial y^j))_p
  $
  ならびに
  $ (d z^i)_p = sum_j (frac(partial, partial y^j) z^i) \( p \) dot.op (d y^j)_p $である．ここで，総和を取る添字である$j$が，ベクトル場の記号における括線よりも「上側」ならびに「下側」でそれぞれ現れることに注意されたい．このあとの計算で見るように，座標関数の添字を上付きにして，ベクトル場の記号として$frac(partial, partial y^i)$のようなものを採用すれば，座標変換の際に総和を取るべき添字は必ず「上付き」と「下付き」のセットで現れる．そのことを援用して，「上付き添字と下付き添字が登場した場合は，総和を書かなくとも自動的に和を取ることにする」という規約を採ることがある．この規約を
  Einstein 規約という．Einstein
  規約に則れば，例えば微分1-形式の座標変換則は
  $ d z^i = frac(partial z^i, partial y^j) d y^j $のように書かれることになる．物理などにおけるテンソル計算の際にはしばしば用いられる規約であるし，今後も座標変換に関わる計算を追いかける際に頭に入れておく価値はあると思う．但し，このノートにおいては
  Einstein
  規約は用いず，煩雑なのを承知なうえで総和の添字を明示的に書くつもりである．

  座標関数の添字を（おそらく一般的ではないであろう）上付きで表記した理由はここにある．ということを，このノートの最初で説明するのは（できないとまでは言わないが）私にとってはあまり好みなやり方ではなかった．

]
より一般に，微分$k$-形式の座標変換則も明示的に書ける．1-形式やベクトル場よりは複雑になるが，他方で積分の変数変換公式を念頭に置くと，この座標変換則は記憶に残りやすいと思う．

#prop[
  $y = \( y^1 \, dots.h \, y^n \)$ならびに$z = \( z^1 \, dots.h \, z^n \)$を$U subset M$上の座標系とする．このとき，$1 lt.eq i_1 < dots.h < i_k lt.eq n$を充たすような$\( i_1 \, dots.h \, i_k \)$に対して
  $ (d y^(i_1))_p and dots.h and (d y^(i_k))_p = sum_(1 lt.eq j_1 < dots.h < j_k lt.eq n) det (frac(partial y^(i_a), partial z^(j_b))) \( p \) dot.op (d z^(j_1))_p and dots.h and (d z^(j_k))_p $が成り立つ．但し，$(frac(partial y^(i_a), partial z^(j_b)))$は$\( a \, b \)$成分が$frac(partial y^(i_a), partial z^(j_b))$であるような$k times k$行列をあらわす．特に$n$-形式の場合は記述が少し簡単になり，
  $ (d y^1)_p and dots.h and (d y^n)_p = det (frac(partial y^i, partial z^j)) \( p \) dot.op (d z^1)_p and dots.h and (d z^n)_p $が成り立つ．

]
#proof[
  $\( j_1 \, dots.h \, j_k \) in bb(N)^k$を，$1 lt.eq j_1 < dots.h < j_k lt.eq n$を充たすように任意に一つ取る．以下この証明において，記号を軽くするために添字の$""_p$や関数の引数に入る$\( p \)$を省く．\$\\set{dz^{j\_1} \\wedge \\dots \\wedge dz^{j\_k} | 1 \\leq j\_1\< \\dots \< j\_k \\leq n }\$は$and.big^k \( T_p^(\*) M \)$の基底をなすので，$d y^(i_1) and dots.h and d y^(i_k) = sum_(1 lt.eq j_1 < dots.h < j_k lt.eq n) a_(j_1 \, j_2 \, dots.h \, j_k) d z^(j_1) and dots.h and d z^(j_k)$と展開したときの展開係数を決定すればよい．接ベクトルの座標変換則と@最高次交代テンソルの変換則
  より
  $
    & d y^(i_1) and dots.h and d y^(i_k) (frac(partial, partial z^(j_1)) \, dots.h \, frac(partial, partial z^(j_k)))\
    = & d y^(i_1) and dots.h and d y^(i_k) (frac(partial, partial z^(j_1)) \, dots.h \, frac(partial, partial z^(j_k)))\
    = & d y^(i_1) and dots.h and d y^(i_k) (sum_(ell = 1)^n frac(partial y^ell, partial z^(j_1)) frac(partial, partial y^ell) \, dots.h \, sum_(ell = 1)^n frac(partial y^ell, partial z^(j_k)) frac(partial, partial y^ell))\
    = & d y^(i_1) and dots.h and d y^(i_k) (sum_(a = 1)^k frac(partial y^(i_a), partial z^(j_1)) frac(partial, partial y^(i_a)) \, dots.h \, sum_(a = 1)^k frac(partial y^(i_a), partial z^(j_k)) frac(partial, partial y^(i_a)))\
    = & det (frac(partial y^(i_a), partial z^(j_b))) d y^(i_1) and dots.h and d y^(i_k) (frac(partial, partial y^(i_1)) \, dots.h \, frac(partial, partial y^(i_k))) = det (frac(partial y^(i_a), partial z^(j_b)))
  $
  であるから，展開係数は$det (frac(partial y^(i_a), partial z^(j_b)))$とわかる．

]
#que[
  そんなわけで，この変換則と重積分の変数変換公式とを念頭に置けば，いかにも微分$n$-形式を$bb(R)^n$上で積分することに意味があるように思えてくる．実際このあと微分形式の積分が定義できてしまうことを見ていく．それにしたってうまく行き過ぎているのだが，なんでこんなにうまくいくのか本当に謎である．交代性を課したことが全てを整えている印象があるが，交代性がどうしてここまで全てをきれいにしてくれるのか．

]
ここまで，0-形式$f$の微分$d f$が1-形式となることを見た．すでに見ているように，$d f$を標準基底に関して行列表示すると
Jacobi
行列が現れる．というわけで大雑把に言えば$d f$は$f$の方向微分に関する情報を全部持っているようなものである．これと似たようなことを一般の$n$-形式に対しても考えることができる；$n$-形式の方向微分とも言えるもの，それが外微分である．

#defi[
  $omega in Omega^n \( U \)$とし，その座標表示
  $ omega_p = sum_(1 lt.eq i_1 < i_2 < dots.h < i_k lt.eq n) f_(i_1 \, i_2 \, dots.h \, i_k)^y \( p \) dot.op (d y^(i_1))_p and dots.h and (d y^(i_k))_p $を考える．このもとで，$omega$の外微分$d omega in Omega^(n + 1) \( U \)$を，
  $
    d omega_p colon.eq sum_(1 lt.eq i_1 < i_2 < dots.h < i_k lt.eq n) (d f_(i_1 \, i_2 \, dots.h \, i_k)^y)_p and (d y^(i_1))_p and dots.h and (d y^(i_k))_p
  $
  によって定める．

]
#prop[
  外微分の定義は well-defined
  である．すなわち，$y = \( y^1 \, dots.h \, y^n \)$ならびに$z = \( z^1 \, dots.h \, z^n \)$をそれぞれ2つの座標系とするとき，$omega in Omega^k \( U \)$の2通りの座標表示
  $
    omega_p = sum_(1 lt.eq i_1 < i_2 < dots.h < i_k lt.eq n) f_(i_1 \, i_2 \, dots.h \, i_k) \( p \) dot.op (d y^(i_1))_p and dots.h and (d y^(i_k))_p = sum_(1 lt.eq j_1 < j_2 < dots.h < j_k lt.eq n) g_(j_1 \, j_2 \, dots.h \, j_k) \( p \) dot.op (d z^(j_1))_p and dots.h and (d z^(j_k))_p
  $
  に対して，
  $ sum_(1 lt.eq i_1 < i_2 < dots.h < i_k lt.eq n) (d f_(i_1 \, i_2 \, dots.h \, i_k))_p and (d y^(i_1))_p and dots.h and (d y^(i_k))_p = sum_(1 lt.eq j_1 < j_2 < dots.h < j_k lt.eq n) (d g_(j_1 \, j_2 \, dots.h \, j_k))_p and (d z^(j_1))_p and dots.h and (d z^(j_k))_p $が成り立つ．

]
証明に入る前に，これ以降このノートの終わりまで，証明や命題の記述において，記号を軽くするために添字の$""_p$や関数の引数に入る$\( p \)$を省くことがあることを断っておく．この省略をする理由は以降の証明を読んでいけば嫌でもわかる．

#proof[
  $omega$が0-形式の場合は示すべきことはない．微分の線型性より，ある一つの$\( i_1 \, dots.h \, i_k \)$，$1 lt.eq i_1 < dots.h < i_k lt.eq n$を用いて$omega_p = f_(i_1 \, i_2 \, dots.h \, i_k) \( p \) dot.op (d y^(i_1))_p and dots.h and (d y^(i_k))_p$と書ける場合に証明すれば充分である．$k$-形式に対する座標変換則より，
  $ sum_(1 lt.eq j_1 < dots.h < j_k lt.eq n) g_(j_1 \, j_2 \, dots.h \, j_k) "" #h(-1em) d z^(j_1) and dots.h and "" #h(-1em) d z^(j_k) = sum_(1 lt.eq j_1 < dots.h < j_k lt.eq n) f_(i_1 \, i_2 \, dots.h \, i_k) det (frac(partial y^(i_a), partial z^(j_b))) "" #h(-1em) d z^(j_1) and dots.h and "" #h(-1em) d z^(j_k) $がわかるので，微分の
  Leibniz 則より
  $ sum_(1 lt.eq j_1 < dots.h < j_k lt.eq n) "" #h(-1em) d g_(j_1 \, j_2 \, dots.h \, j_k) and "" #h(-1em) d z^(j_1) and dots.h and "" #h(-1em) d z^(j_k) = & sum_(1 lt.eq j_1 < dots.h < j_k lt.eq n) ("" #h(-1em) d f_(i_1 \, i_2 \, dots.h \, i_k) det (frac(partial y^(i_a), partial z^(j_b)))) and "" #h(-1em) d z^(j_1) and dots.h and "" #h(-1em) d z^(j_k)\
  & + sum_(1 lt.eq j_1 < dots.h < j_k lt.eq n) (f_(i_1 \, i_2 \, dots.h \, i_k) "" #h(-1em) d det (frac(partial y^(i_a), partial z^(j_b)))) and "" #h(-1em) d z^(j_1) and dots.h and "" #h(-1em) d z^(j_k)\
  = & "" #h(-1em) d f_(i_1 \, i_2 \, dots.h \, i_k) and "" #h(-1em) d y^(i_1) and dots.h and "" #h(-1em) d y^(i_k)\
  & + sum_(1 lt.eq j_1 < dots.h < j_k lt.eq n) (f_(i_1 \, i_2 \, dots.h \, i_k) "" #h(-1em) d det (frac(partial y^(i_a), partial z^(j_b)))) and "" #h(-1em) d z^(j_1) and dots.h and "" #h(-1em) d z^(j_k) $を得る．したがって示すべきことは
  $ sum_(1 lt.eq j_1 < dots.h < j_k lt.eq n) ("" #h(-1em) d det (frac(partial y^(i_a), partial z^(j_b)))) and "" #h(-1em) d z^(j_1) and dots.h and "" #h(-1em) d z^(j_k) = sum_(1 lt.eq j_1 < dots.h < j_k lt.eq n) (sum_(j = 1)^n frac(partial, partial z^j) det (frac(partial y^(i_a), partial z^(j_b))) "" #h(-1em) d z^j) and "" #h(-1em) d z^(j_1) and dots.h and "" #h(-1em) d z^(j_k) = 0 $に帰着する．以下，ある程度きちんと証明をつけるが，総じて直接計算による力技なので，多分自分で証明をつけたほうが理解はしやすいです．

  以下，$\( j_(1') \, dots.h \, j_(k') \)$，$1 lt.eq j_(1') < dots.h < j_(k') lt.eq n$を任意にとって一つ固定する（総和のいちばん外側のループ変数を固定して考えようとしている）．このとき，\$j\' \\in \\set{j\_1\', \\dots, j\_k\'}\$であるならば明らかに
  $ frac(partial, partial z^(j')) det (frac(partial y^(i_a), partial z^(j_(b')))) "" #h(-1em) d z^(j') and "" #h(-1em) d z^(j_(1')) and dots.h and "" #h(-1em) d z^(j_(k')) = 0 $である．なので，\$j\' \\notin \\set{j\_1\', \\dots, j\_k\'}\$の場合だけを考察すればよいから，そのように$j'$を取って固定する（内側のループ変数を固定して考えようとしている）．微分の
  Leibniz 則を使うと
  $ & frac(partial, partial z^(j')) det mat(delim: "(", frac(partial y^(i_1), partial z^(j_(1'))), dots.h, frac(partial y^(i_1), partial z^(j_(p'))), dots.h, frac(partial y^(i_1), partial z^(j_(k'))); dots.v, dots.down, dots.v, dots.down, dots.v; frac(partial y^(i_k), partial z^(j_(1'))), dots.h, frac(partial y^(i_k), partial z^(j_(p'))), dots.h, frac(partial y^(i_k), partial z^(j_(k'))); #none) "" #h(-1em) d z^(j') and "" #h(-1em) d z^(j_(1')) and dots.h and "" #h(-1em) d z^(j_(p')) and dots.h and "" #h(-1em) d z^(j_(k'))\
  = & sum_(p = 1)^k det mat(delim: "(", frac(partial y^(i_1), partial z^(j_(1'))), dots.h, frac(partial^2 y^(i_1), partial z^(j') partial z^(j_(p'))), dots.h, frac(partial y^(i_1), partial z^(j_(k'))); dots.v, dots.down, dots.v, dots.down, dots.v; frac(partial y^(i_k), partial z^(j_(1'))), dots.h, frac(partial^2 y^(i_k), partial z^(j') partial z^(j_(p'))), dots.h, frac(partial y^(i_k), partial z^(j_(k'))); #none) "" #h(-1em) d z^(j') and "" #h(-1em) d z^(j_(1')) and dots.h and "" #h(-1em) d z^(j_(p')) and dots.h and "" #h(-1em) d z^(j_(k')) $と展開できる．この第$r$項を取り出してくると，
  $
    det mat(delim: "(", frac(partial y^(i_1), partial z^(j_(1'))), dots.h, frac(partial^2 y^(i_1), partial z^(j') partial z^(j_(r'))), dots.h, frac(partial y^(i_1), partial z^(j_(k'))); dots.v, dots.down, dots.v, dots.down, dots.v; frac(partial y^(i_k), partial z^(j_(1'))), dots.h, frac(partial^2 y^(i_k), partial z^(j') partial z^(j_(r'))), dots.h, frac(partial y^(i_k), partial z^(j_(k'))); #none) "" #h(-1em) d z^(j') and "" #h(-1em) d z^(j_(1')) and dots.h and "" #h(-1em) d z^(j_(r')) and dots.h and "" #h(-1em) d z^(j_(k')) .
  $
  この項に対して，符号が逆になってちょうど打ち消し合うような項が総和の中に一意的に存在することを示す．$j'$に対する仮定より，$j_q < j' < j_(q + 1)$を充たすような整数$q gt.eq 0$がある（但し，形式的に$j_(0') = - oo$，$j_(k + 1') = oo$と解釈する）．更に$j' < j_r$と仮定して一般性を失わないのでそうする．2階微分の形から，打ち消し合う項が存在するならば，それは総和に現れるループ変数を$\( j_1 \, dots.h \, j_k \) = \( j_(1') \, dots.h \, j_(q') \, j' \, j_(q + 1') \, dots.h \, j_(r - 1') \, j_(r + 1') \, dots.h \, j_(k') \) \, j = j_(r') \, p = q + 1$とした項，すなわち
  $
    det mat(delim: "(", frac(partial y^(i_1), partial z^(j_(1'))), dots.h, frac(partial^2 y^(i_1), partial z^(j_(r')) partial z^(j')), dots.h, frac(partial y^(i_1), partial z^(j_(k'))); dots.v, dots.down, dots.v, dots.down, dots.v; frac(partial y^(i_k), partial z^(j_(1'))), dots.h, frac(partial^2 y^(i_k), partial z^(j_(r')) partial z^(j')), dots.h, frac(partial y^(i_k), partial z^(j_(k'))); #none) "" #h(-1em) d z^(j_(r')) and "" #h(-1em) d z^(j_(1')) and dots.h and "" #h(-1em) d z^(j_(q')) and "" #h(-1em) d z^(j') and "" #h(-1em) d z^(j_(q + 1')) and dots.h and "" #h(-1em) d z^(j_(r - 1')) and "" #h(-1em) d z^(j_(r + 1')) and dots.h and "" #h(-1em) d z^(j_(k')) .
  $
  のほかにはありえない（この時点で一意性は従う）．実際に符号が逆転することは行列式と外積の交代性を用いた直接計算より従う．

]
#que[
  最後の「従う」は「めんどくさくなったので省いた」の意である．実際に計算してみれば符号だけが変わり打ち消し合うことがわりあいすぐにわかるのだが，議論の内容の割に
  LaTeXのコード量がかさばりそうなので億劫になっている．

]
#dig[
  外微分の定義の与え方はいくつか考えられる．ここでは用意する道具立てが少なくて済み（0-形式に対する外微分，すなわち写像の微分さえあれば定義できて），意味が比較的わかりやすい（方向微分の$k$-形式への一般化であることが見てわかる）と思われる定義の与え方を採用した．この方法に欠点がないとは言わない；事実，well-defined
  なことの証明は軽くはない．このノートに整理して書くにあたり，私自身いろいろと紆余曲折を経たことを正直に述べておく．

  well-defined なことが明らかな定義としては Lie
  微分を使うものがあるが，（当然ながら）Lie
  微分を持ち出してその基本性質を先んじて述べておく必要がある．純粋に代数的な性質だけを列挙して公理的に定義する方法もあるにはあるし，Spivak
  においては多様体上の微分形式をそのように定義しているのだが，外微分の意味するところがよくわからないままでつらいのではなかろうか．

  結局，どの方法にも長所と短所があり，完璧な方法というものはないのだろう．歯がゆさをおぼえるところはあるが，定義一つとっても奥深いものがあると考えるのがよいところなのかもしれない．

]
#prop[
  $omega in Omega^k \( U \)$，$eta in Omega^ell \( U \)$とする．

  + $k = ell$のとき，$"" #h(-1em) d \( omega + eta \) = "" #h(-1em) d omega + "" #h(-1em) d eta$．

  + $"" #h(-1em) d \( omega and eta \) = \( "" #h(-1em) d omega \) and eta + \( - 1 \)^k omega and "" #h(-1em) d eta$．

  + $"" #h(-1em) d \( "" #h(-1em) d omega \) = 0$．$"" #h(-1em) d^2 = 0$と書く場合も多い．

]
#proof[
  + 0-形式の場合は微分の線型性にほかならず，一般の場合は0-形式の場合の線型性から直ちに出る．

  + $k = 0$の場合は外微分の定義そのままである．一般の場合に対しては，外微分の線型性より$omega = f_(i_1 \, dots.h \, i_k) "" #h(-1em) d y^(i_1) and dots.h and "" #h(-1em) d y^(i_k)$，$eta = g_(j_1 \, dots.h \, j_ell) "" #h(-1em) d y^(j_1) and dots.h and "" #h(-1em) d y^(j_ell)$と書ける場合に証明すれば充分である．このときは
    $ "" #h(-1em) d \( omega and eta \) = & "" #h(-1em) d \( f_(i_1 \, dots.h \, i_k) g_(j_1 \, dots.h \, j_ell) \) and "" #h(-1em) d y^(i_1) and dots.h and "" #h(-1em) d y^(i_k) and "" #h(-1em) d y^(j_1) and dots.h and "" #h(-1em) d y^(j_ell)\
    = & \( g_(j_1 \, dots.h \, j_ell) "" #h(-1em) d f_(i_1 \, dots.h \, i_k) + f_(i_1 \, dots.h \, i_k) "" #h(-1em) d g_(j_1 \, dots.h \, j_ell) \) and "" #h(-1em) d y^(i_1) and dots.h and "" #h(-1em) d y^(i_k) and "" #h(-1em) d y^(j_1) and dots.h and "" #h(-1em) d y^(j_ell)\
    = & g_(j_1 \, dots.h \, j_ell) "" #h(-1em) d f_(i_1 \, dots.h \, i_k) and "" #h(-1em) d y^(i_1) and dots.h and "" #h(-1em) d y^(i_k) and "" #h(-1em) d y^(j_1) and dots.h and "" #h(-1em) d y^(j_ell)\
    & + f_(i_1 \, dots.h \, i_k) "" #h(-1em) d g_(j_1 \, dots.h \, j_ell) and "" #h(-1em) d y^(i_1) and dots.h and "" #h(-1em) d y^(i_k) and "" #h(-1em) d y^(j_1) and dots.h and "" #h(-1em) d y^(j_ell)\
    = & "" #h(-1em) d f_(i_1 \, dots.h \, i_k) and "" #h(-1em) d y^(i_1) and dots.h and g_(j_1 \, dots.h \, j_ell) "" #h(-1em) d y^(i_k) and "" #h(-1em) d y^(j_1) and dots.h and "" #h(-1em) d y^(j_ell)\
    & + \( - 1 \)^k f_(i_1 \, dots.h \, i_k) and "" #h(-1em) d y^(i_1) and dots.h and "" #h(-1em) d y^(i_k) and "" #h(-1em) d g_(j_1 \, dots.h \, j_ell) and "" #h(-1em) d y^(j_1) and dots.h and "" #h(-1em) d y^(j_ell)\
    = & \( "" #h(-1em) d omega \) and eta + \( - 1 \)^k omega and "" #h(-1em) d eta $である．

  + やはり外微分の線型性より，$omega = f_(i_1 \, dots.h \, i_k) "" #h(-1em) d y^(i_1) and dots.h and "" #h(-1em) d y^(i_k)$と書ける場合に示せば充分である．
    $ "" #h(-1em) d omega = sum_(s = 1)^n frac(partial f_(i_1 \, dots.h \, i_k), partial y^s) "" #h(-1em) d y^s and "" #h(-1em) d y^(i_1) and dots.h and "" #h(-1em) d y^(i_k) $であるから，
    $ "" #h(-1em) d "" #h(-1em) d omega = sum_(t = 1)^n sum_(s = 1)^n frac(partial^2 f_(i_1 \, dots.h \, i_k), partial y^t partial y^s) "" #h(-1em) d y^t and "" #h(-1em) d y^s and "" #h(-1em) d y^(i_1) and dots.h and "" #h(-1em) d y^(i_k) $となり，$frac(partial^2 f_(i_1 \, dots.h \, i_k), partial y^t partial y^s) "" #h(-1em) d y^t and "" #h(-1em) d y^s and "" #h(-1em) d y^(i_1) and dots.h and "" #h(-1em) d y^(i_k)$と$frac(partial^2 f_(i_1 \, dots.h \, i_k), partial y^s partial y^t) "" #h(-1em) d y^s and "" #h(-1em) d y^t and "" #h(-1em) d y^(i_1) and dots.h and "" #h(-1em) d y^(i_k)$は符号が逆転して打ち消し合うので総和は0である．

]
ベクトル場や接ベクトルをうつす写像として「写像の微分」が定義できたように，微分形式に対しては「引き戻し」が定義できる．

#defi[
  $M colon.eq bb(R)^m$，$N colon.eq bb(R)^n$とし，$U subset N$を開集合とする．このとき，$omega in Omega^k \( U \)$の$f : M arrow.r N$による引き戻し$f^(\*) omega in Omega^k \( f^(- 1) \( U \) \)$を，$v_1 \, dots.h \, v_k in T_p M$に対して
  $ \( f^(\*) omega \)_p \( v_1 \, dots.h \, v_k \) colon.eq omega_(f \( p \)) \( "" #h(-1em) d f_p v_1 \, dots.h \, "" #h(-1em) d f_p v_k \) $とすることで定める．

]
#prop[
  $omega in Omega^k \( U \)$，$eta in Omega^ell \( U \)$，$U subset N$を開集合とし，$f : M arrow.r N$とする．

  + $y$を$M$の，$z$を$N$の標準座標系とするとき，$f^(\*) \( "" #h(-1em) d z^k \) = sum_i frac(partial \( z^k compose f \), partial y^i) d y^i$．

  + $k = ell$のとき，$f^(\*) \( omega + eta \) = f^(\*) omega + f^(\*) eta$．

  + $f^(\*) \( omega and eta \) = f^(\*) omega and f^(\*) eta$．

  + $f^(\*) \( "" #h(-1em) d omega \) = "" #h(-1em) d \( f^(\*) \( omega \) \)$．

]
#proof[
  (i)-(iii) については総じて直接計算なので，(i)
  のみ示す．$Y = sum_i Y^i frac(partial, partial y^i)$を$M$上のベクトル場とするとき，
  $ f^(\*) \( "" #h(-1em) d z^k \) \( Y \) = "" #h(-1em) d z^k \( d f \( Y \) \) & = "" #h(-1em) d z^k (sum_i Y^i d f frac(partial, partial y^i))\
  & = "" #h(-1em) d z^k (sum_i Y^i sum_j partial_i \( z^j compose f compose y^(- 1) \) frac(partial, partial z^j))\
  & = "" #h(-1em) d z^k (sum_i Y^i sum_j frac(partial \( z^j compose f \), partial y^j) frac(partial, partial z^j))\
  & = sum_i Y^i frac(partial \( z^k compose f \), partial y^j) $であることから
  (i) は従う．(ii), (iii) も同様に証明できて，(i) よりかんたんである．

  (iv)
  を示そう．$omega$の次数に関する帰納法による．$omega$が0-形式の場合は，$Y$を$U$上のベクトル場とすれば合成則より
  $ f^(\*) \( "" #h(-1em) d omega \) \( Y \) = "" #h(-1em) d omega \( "" #h(-1em) d f \( Y \) \) = "" #h(-1em) d \( omega compose f \) \( Y \) = "" #h(-1em) d \( f^(\*) omega \) \( Y \) $となるからよい．$k$-形式の場合に示せているとして，外積の線型性より$omega and "" #h(-1em) d y^i$の形の$k + 1$-形式に対して示せば充分である．
  $ f^(\*) \( "" #h(-1em) d \( omega and "" #h(-1em) d y^i \) \) & = f^(\*) \( "" #h(-1em) d omega and "" #h(-1em) d y^i \)\
  & = \( f^(\*) "" #h(-1em) d omega \) and \( f^(\*) "" #h(-1em) d y^i \)\
  & = \( "" #h(-1em) d f^(\*) omega \) and \( "" #h(-1em) d f^(\*) y^i \)\
  & = "" #h(-1em) d \( f^(\*) omega and f^(\*) y^i \)\
  & = "" #h(-1em) d \( f^(\*) \( omega and y^i \) \)\ $である．

]
#dig[
  Spivak
  に扱われているトピックでこのノートに書かなかったこととして，閉形式と完全形式の概念，ならびに
  Poincaré
  の補題がある．これらの話題を，私が重要でないと思っているわけではない．むしろ面白い話題がたくさん転がっていると思っている…のだが，せっかくなら
  de Rham
  コホモロジーあたりまでは勉強して書いたほうが良いような気もする．他方，そこまで寄り道しているといつまで経ってもこのノートの終わりが見えない．というわけで，いったん潔くぜんぶカットすることにした．

  できることなら，コホモロジー理論が工学的に活きる場面を見てみたい．コホモロジーによって本質的に捉えられる工学的な知見なり，既存手法を大幅に改善する道のりなり，そういったものが見つかると心底わくわくできると思う．もちろん，これは「工学的な問題を解決したい」ではなくて「数学を使いたい」なので動機としてはかなり不純（見方によっては純粋すぎる？）で，よい研究になりにくそうな気もしているのですが…

]
== 微分形式の積分
<微分形式の積分>
微分形式に対する積分を定義する．

#defi[
  $M = bb(R)^n$とし，$U subset M$を開集合または閉集合とする．更に$y : U arrow.r y \( U \)$を$U$上の座標系であって，$p in U$に対して$det J_y \( p \) > 0$であるようなものとする．$omega in Omega^n \( U \)$の座標表示を
  $ omega = f^y "" #h(-1em) d y^1 and dots.h and "" #h(-1em) d y^n $とするとき，$omega$の$U$上の積分を，
  $ integral_U omega colon.eq integral_(y \( U \)) f^y compose y^(- 1) \( x \) "" #h(-1em) d lambda^n \( x \) $で定める（右辺は
  Lebesgue 測度に関する積分）．

]
#prop[
  上記の微分形式の積分の定義は well-defined
  である．すなわち，$y$ならびに$z$をそれぞれ$det J_y \( p \) > 0$および$det J_z \( p \) > 0$を充たすような$U$上の座標系とし，$omega$の2通りの座標表示を
  $ omega = f^y "" #h(-1em) d y^1 and dots.h and "" #h(-1em) d y^n = f^z "" #h(-1em) d z^1 and dots.h and "" #h(-1em) d z^n $とするとき，
  $ integral_(y \( U \)) f^y compose y^(- 1) \( x \) "" #h(-1em) d lambda^n \( x \) = integral_(z \( U \)) f^z compose z^(- 1) \( x \) "" #h(-1em) d lambda^n \( x \) $が成り立つ．

]
<微分形式の積分はwell-defined>
#proof[
  微分$n$-形式に対する座標変換則より$f^y \( p \) = f^z \( p \) dot.op det J_(z compose y^(- 1)) \( y \( p \) \)$である．したがって重積分の変数変換公式より
  $ integral_(y \( U \)) f^y \( y^(- 1) \( x \) \) "" #h(-1em) d lambda^n \( x \) & = integral_(y \( U \)) f^z compose y^(- 1) \( x \) det J_(z compose y^(- 1)) \( x \) "" #h(-1em) d lambda^n \( x \)\
  & = integral_(y \( U \)) \( f^z compose z^(- 1) \) compose \( z compose y^(- 1) \) \( x \) det J_(z compose y^(- 1)) \( x \) "" #h(-1em) d lambda^n \( x \)\
  & = integral_(\( z compose y^(- 1) \) compose y \( U \)) \( f^z compose z^(- 1) \) \( x \) "" #h(-1em) d lambda^n \( x \) = integral_(z \( U \)) \( f^z compose z^(- 1) \) \( x \) "" #h(-1em) d lambda^n \( x \) $を得る．但し，ここで$det J_y > 0$および$det J_z > 0$であることから$det J_(z compose y^(- 1)) > 0$であることを用いた．

]
#dig[
  証明を見ればわかるように，本質的に効いているのは積分を Lebesgue
  測度に関するものとしていることではなく，積分が変数変換公式を充たすことである．なので微分形式の積分を
  Riemann
  積分を用いて定義してもこのあたりの議論で困ることはない．もっと言えば，変数変換公式を充たしさえすれば積分の実装がどうなっていようと問題ないと思われる．しかしながら，Lebesgue
  測度に関する積分と Riemann
  積分以外にこの形の変数変換公式と整合的な積分を私は知らない．あるのだろうか？

]
#dig[
  ところで，ここでの議論を少し検討すれば座標変換を「行列式が正のものに限る」としなければ証明が通らないことがわかるが，これは「多様体の向きを指定しなければ積分が定義できない」という事情の特別な場合と考えることができる．だったらそれをちゃんと説明しなさいよと思うのは無理もないが，個人的にはこの事情は$bb(R)^n$の場合に言われてもよくわからず，少なくとも球面$bb(S)^n$の場合のほうがしっくりきやすい．というわけでそこまでその事情の説明を遅らせることにして，ここでは証明を通すためだけに天下りに「行列式が正」だけ指定することにした．

]
ここまでで，$M = bb(R)^n$上の微分$n$-形式に対してその積分を定義した．他方，このノートの最終目標の一つは，曲線や曲面の上で微積分を展開することである．例えば$M = bb(R)^n$上の曲線上で定義された何かを積分する「線積分」の概念はないと困る．

線積分や面積分の定義を得るために，微分形式の引き戻しが役に立つ．

#defi[
  $k \, n$を0以上の整数とし，$M = bb(R)^n$とする．$C^oo$級写像$c : bb(R)^k supset \[ 0 \, 1 \]^k arrow.r M$のことを$M$内の曲$k$方体という．特に曲1方体のことを曲線と呼ぶ．$I^n : \[ 0 \, 1 \]^n in.rev x mapsto x in M$のことを標準$n$方体という．

]
#dig[
  ふつうは$c$が$C^oo$級でなくても，連続でありさえすれば曲$n$-方体と呼ぶことが多い．のだが，今後$c$上の積分を考えるときにわざわざ$C^oo$級であることを断るのも煩わしいし，（微分ができるかわからない世界での）トポロジーをやるつもりもないので，最初から方体は$C^oo$級であると定義してしまうことにした．

]
直感的には，曲$k$方体とは曲線片や曲面片のことをあらわしている．この時点で曲$k$方体上での微分形式の積分が定義できなくはないので，とりあえず定義してしまうことにする．

#defi[
  $M = bb(R)^n$，$c : \[ 0 \, 1 \]^k arrow.r M$を$M$上の曲$k$-方体，$omega in Omega^k \( M \)$を$M$上の$k$-形式とする．$k > 0$のとき，$omega$の$c$上での積分を，
  $ integral_c omega colon.eq integral_(\[ 0 \, 1 \]^k) c^(\*) omega $によって定める．$k = 0$のときは，$integral_c omega colon.eq omega \( c \( 0 \) \)$と定める．

]
古典ベクトル解析で線積分や面積分を見知っている方を念頭に置いて，この定義がそれら古典的な定義の一般化になっていることを見るために，次の命題を証明しておくことにする；

#prop[
  $M = bb(R)^2$とし，$M$の標準座標を$\( x \, y \)$で表す．$M$上の2-形式$P "" #h(-1em) d x + Q "" #h(-1em) d y$に対して，
  $ integral_c P "" #h(-1em) d x + Q "" #h(-1em) d y = lim sum_(i = 0)^n \( P compose c \( t^i \) \) (c^1 \( t_(i + 1) \) - c^1 \( t_i \)) + \( Q compose c \( t^i \) \) (c^2 \( t_(i + 1) \) - c^2 \( t_i \)) $が成り立つ．ただし，$t_0 \, t_1 \, dots.h \, t_n$は$\[ 0 \, 1 \]$の分割，$t^i$は$t^i in \[ t_i \, t_(i + 1) \]$を充たすような任意の点，極限は$max \| t_(i + 1) - t_i \| arrow.r 0$を充たすようなあらゆる分割にわたる．

]
#proof[
  左辺を定義に従って計算する．
  $ integral_c P "" #h(-1em) d x + Q "" #h(-1em) d y & = integral_(\[ 0 \, 1 \]) c^(\*) \( P "" #h(-1em) d x + Q "" #h(-1em) d y \)\
  & = integral_(\[ 0 \, 1 \]) \( P compose c \) dot.op c^(\*) \( "" #h(-1em) d x \) + \( Q compose c \) dot.op c^(\*) \( "" #h(-1em) d y \)\
  & = integral_(\[ 0 \, 1 \]) \( P compose c \) dot.op frac("" #h(-1em) d \( x compose c \), "" #h(-1em) d t) "" #h(-1em) d t + \( Q compose c \) dot.op frac("" #h(-1em) d \( y compose c \), "" #h(-1em) d t) "" #h(-1em) d t\ $ 右辺の被積分関数は$\[ 0 \, 1 \]$上で連続かつ有界，したがって特に
  Riemann 可積分であるから，Riemann
  和の極限としても書ける．すなわち，$t_0 \, t_1 \, dots.h \, t_n$を$\[ 0 \, 1 \]$の分割，$t^i$を$t^i in \[ t_i \, t_(i + 1) \]$を充たすような任意の点としたとき，
  $ integral_(\[ 0 \, 1 \]) \( P compose c \) dot.op frac("" #h(-1em) d \( x compose c \), "" #h(-1em) d t) "" #h(-1em) d t + \( Q compose c \) dot.op frac("" #h(-1em) d \( y compose c \), "" #h(-1em) d t) "" #h(-1em) d t = & integral_(\[ 0 \, 1 \]) \( P compose c \) dot.op frac("" #h(-1em) d c^1, "" #h(-1em) d t) "" #h(-1em) d t + \( Q compose c \) dot.op frac("" #h(-1em) d c^2, "" #h(-1em) d t) "" #h(-1em) d t\
  = & lim sum_(i = 0)^n \( P compose c \( t^i \) \) dot.op frac("" #h(-1em) d c^1, "" #h(-1em) d t) \( t^i \) dot.op (t_(i + 1) - t_i)\
  & + \( Q compose c \( t^i \) \) dot.op frac("" #h(-1em) d c^2, "" #h(-1em) d t) \( t^i \) dot.op (t_(i + 1) - t_i) $が成り立つ．ただし，極限は$max \| t_(i + 1) - t_i \| arrow.r 0$を充たすようなあらゆる分割にわたる．

  ここで，各$i = 0 \, 1 \, dots.h \, n$に対して平均値の定理より，$s^i in \[ t_i \, t_(i + 1) \]$であって$frac(d c^1, d t) \( s^i \) = frac(c^1 \( t_(i + 1) \) - c^1 \( t_i \), t_(i + 1) - t_i)$を充たすようなものがあることに注意する．$c^2$に対しても同様のことが言えること，ならびに上記
  Riemann
  和における$t^i in \[ t_i \, t_(i + 1) \]$は任意だったことを踏まえれば，ある$s^i \, u^i in \[ t_i \, t_(i + 1) \]$が存在して，
  $
    integral_c P "" #h(-1em) d x + Q "" #h(-1em) d y = lim sum_(i = 0)^n \( P compose c \( s^i \) \) dot.op (c^1 \( t_(i + 1) \) - c^1 \( t_i \)) + \( Q compose c \( u^i \) \) dot.op (c^2 \( t_(i + 1) \) - c^2 \( t_i \))
  $
  と書き直せる．あとは，極限
  $ integral_c P "" #h(-1em) d x + Q "" #h(-1em) d y = lim sum_(i = 0)^n \( P compose c \( s^i \) \) (c^1 \( t_(i + 1) \) - c^1 \( t_i \)) + \( Q compose c \( u^i \) \) (c^2 \( t_(i + 1) \) - c^2 \( t_i \)) $が$s^i \, u^i in \[ t_i \, t_(i + 1) \]$のとり方に依らないことを示せばよい．$P compose c$が$C^oo$級，特に$\[ 0 \, 1 \]$で
  Lipschitz
  連続なので，ある定数$L > 0$が存在して，任意の$t^i in \[ t_i \, t_(i + 1) \]$に対して$\| P compose c \( t^i \) - P compose c \( s^i \) \| lt.eq L \( t_(i + 1) - t_i \)$が成り立つ．ところで極限は$max \| t_(i + 1) - t_i \| arrow.r 0$を充たすようなあらゆる分割にわたるのだから，この誤差は極限をとれば0になる．

]
というわけで，曲線（曲$k$方体$c$の像）じたいを細かく分割して積分する，という素朴な定義と，引き戻しを用いた定義は等価になることがわかる．引き戻しを使って定義するのは，高次元の場合でも定義に煩わしさが出ないことが一つの利点である．もうひとつの利点…というか都合としては，素朴な定義から引き戻しを用いた定義を復元することは困難である，というものもある．

#que[
  と書いたものの，「困難である」かどうか，私はきちんと確かめきったわけではない．もちろん不可能性の証明は一般に難しいのですが…

]
この後に登場する Stokes
の定理との兼ね合いがあるので，もう少し曲方体に関わる定義や基本性質を述べておく必要がある．ややインフォーマルな言い方であるが，次のような準備が必要となる；Stokes
の定理は微積分学の基本定理の一般化と捉えられる．ところでもともとの微積分学の基本定理は，閉区間$\[ a \, b \]$上の積分を，その境界$a$ならびに$b$における情報のみから計算できるということを主張していた．その対応付けをにらむならば，曲方体にたいしてその「境界」を定義しておく必要がありそうである．定義を見ればわかるが，ここでの「境界」は単一の方体として表すには無理があるので，方体の形式的な和や整数倍を考えられるように拡張しておく必要がある．

#defi[
  $M$内の曲$k$方体の整数係数の形式的な線型結合で表される元のことを$M$内の曲$k$鎖体という．例えば，$c_1 \, c_2$が曲$k$方体であるとき，$3 c_1 - 4 c_2$は曲$k$鎖体である．

  標準$k$方体$I^k$に対し，その境界$partial I^k$と呼ばれる曲$k - 1$鎖体を次のように定義する．まず$i = 1 \, 2 \, dots.h \, k$並びに$alpha = 0 \, 1$に対して，曲$k - 1$方体$I_(\( i \, alpha \))^k$を
  $ I_(\( i \, alpha \))^k \( x \) colon.eq \( x^1 \, x^2 \, dots.h \, x^(i - 1) \, alpha \, x^i \, dots.h \, x^k \) $によって定め，$I^k$の$\( i \, alpha \)$境面という．このもとで
  $ partial I^k colon.eq sum_(i = 1)^k sum_(alpha = 0)^1 \( - 1 \)^(i + alpha) I_(\( i \, alpha \))^k $と定める．

  一般の曲$k$方体$c$に対しては，その$\( i \, alpha \)$境面を$c_(\( i \, alpha \)) colon.eq c compose I_(\( i \, alpha \))^k$によって定めた上で，
  $ partial c colon.eq sum_(i = 1)^k sum_(alpha = 0)^1 \( - 1 \)^(i + alpha) c_(\( i \, alpha \)) $と定める．更に一般の曲$k$鎖体$c = sum a_i c_i$に対しては$partial c colon.eq sum a_i partial c_i$と定める．

]
#dig[
  ホモロジー群をご存知であれば，$partial^2 = 0$であること，曲$n$鎖体からなる$bb(Z)$加群は境界準同型と合わせてチェイン複体の条件を全て充たすこと（従ってホモロジー群が定義できること）まで察しがつくかもしれない．このノートの範囲では必要ないだろうからやっていないだけで，おそらく特異チェイン複体と同様にこのチェイン複体からも意味のあるホモロジー理論が取り出せるのだと思う．

]
#defi[
  $M = bb(R)^n$，$omega in Omega^k \( M \)$を$M$上の$k$-形式とする．一般の曲$k$鎖体$c = sum a_i c_i$に対して，$omega$の$c$上での積分を
  $ integral_c omega colon.eq sum a_i integral_(c_i) omega $によって定める．特に，1-形式の1鎖体上での積分のことを線積分，2-形式の2鎖体上での積分のことを面積分という．

]
ここまでで，Stokes の定理を述べる準備が整った．

#thm[
  $U subset M$を開集合，$c : \[ 0 \, 1 \]^k arrow.r U$を曲$k$鎖体とし，$omega in Omega^(k - 1) \( U \)$とする．このとき，
  $ integral_c "" #h(-1em) d omega = integral_(partial c) omega . $

]
#proof[
  総じて，単純計算のみで証明が終わる．まず$c = I^k$，$\[ 0 \, 1 \]^k subset U$となっている場合を証明する．すでに微分形式の積分が座標系に依らないことは証明してあるので，これ以降は$M$に標準座標を入れて計算する．$omega$は次の形の$k - 1$-形式
  $ f_() "" #h(-1em) d x^1 and "" #h(-1em) d x^2 and dots.h accent("" #h(-1em) d x^i, ̂) dots.h and "" #h(-1em) d x^k $の形式和なので，それぞれに対して命題を証明すれば充分である（$accent("" #h(-1em) d x^i, ̂)$は，$i$番目を飛ばす，という意味）．

  $integral_(partial I^k) f_() "" #h(-1em) d x^1 and "" #h(-1em) d x^2 and dots.h accent("" #h(-1em) d x^i, ̂) dots.h and "" #h(-1em) d x^k$を評価する．
  $ integral_(partial I^k) f_() "" #h(-1em) d x^1 and "" #h(-1em) d x^2 and dots.h accent("" #h(-1em) d x^i, ̂) dots.h and "" #h(-1em) d x^k & = sum_(j = 1)^k sum_(alpha = 0)^1 integral_(I_(\( j \, alpha \))^k) f_() "" #h(-1em) d x^1 and "" #h(-1em) d x^2 and dots.h accent("" #h(-1em) d x^i, ̂) dots.h and "" #h(-1em) d x^k\
  & = sum_(j = 1)^k sum_(alpha = 0)^1 integral_(\[ 0 \, 1 \]^(k - 1)) (I_(\( j \, alpha \))^k)^(\*) f_() "" #h(-1em) d x^1 and "" #h(-1em) d x^2 and dots.h accent("" #h(-1em) d x^i, ̂) dots.h and "" #h(-1em) d x^k\
  & = sum_(j = 1)^k sum_(alpha = 0)^1 integral_(\[ 0 \, 1 \]^(k - 1)) (f compose I_(\( j \, alpha \))^k) ((I_(\( j \, alpha \))^k)^(\*) "" #h(-1em) d x^1) and ((I_(\( j \, alpha \))^k)^(\*) "" #h(-1em) d x^2) and dots.h and ((I_(\( j \, alpha \))^k)^(\*) "" #h(-1em) d x^k)\ $ ところで， \$\$\\begin{aligned}
  \\left(\\left(I^k\_{(j,\\alpha)}\\right)^\*\\mathop{}\\!dx^\\ell \\right) &= \\sum\_m \\frac{\\partial \\left(x^{\\ell} \\circ I^k\_{(j, \\alpha)}\\right)}{\\partial x^m} \\mathop{}\\!dx^m
  =\\begin{dcases\*}
  \\mathop{}\\!dx^\\ell & if \$j\\neq\\ell\$ \\\\
  0 & if \$j = \\ell\$
  \\end{dcases\*}
  \\end{aligned}\$\$なので，結局 \$\$\\begin{aligned}
  &\\int\_{\[0,1\]^{k-1}} \\left(f \\circ I^k\_{(j,\\alpha)}\\right) \\left(\\left(I^k\_{(j,\\alpha)}\\right)^\*\\mathop{}\\!dx^1\\right) \\wedge \\left(\\left(I^k\_{(j,\\alpha)}\\right)^\*\\mathop{}\\!dx^2\\right) \\wedge \\dots \\wedge \\left(\\left(I^k\_{(j,\\alpha)}\\right)^\*\\mathop{}\\!dx^k\\right) \\\\
  =& \\begin{dcases\*}
  \\int\_{\[0,1\]^{k-1}} \\left(f \\circ I^k\_{(j,\\alpha)}\\right) \\mathop{}\\!dx^1 \\wedge \\mathop{}\\!dx^2 \\wedge \\dots \\widehat{\\mathop{}\\!dx^i} \\dots \\wedge \\mathop{}\\!dx^k & if \$j = i\$ \\\\
  0 & if \$j \\neq i\$
  \\end{dcases\*} \\\\
  =& \\begin{dcases\*}
  \\int\_{\[0,1\]^{k-1}} f (x^1, x^2, \\dots, \\alpha, \\dots, x^k)  \\mathop{}\\!dx^1 \\mathop{}\\!dx^2 \\cdots \\widehat{\\mathop{}\\!dx^i} \\cdots \\mathop{}\\!dx^k & if \$j = i\$ \\\\
  0 & if \$j \\neq i\$
  \\end{dcases\*} \\\\
  =& \\begin{dcases\*}
  \\int\_{\[0,1\]^{k-1}} f (x^1, x^2, \\dots, \\alpha, \\dots, x^k)  \\mathop{}\\!dx^1 \\mathop{}\\!dx^2 \\cdots \\mathop{}\\!dx^i \\cdots \\mathop{}\\!dx^k & if \$j = i\$ \\\\
  0 & if \$j \\neq i\$
  \\end{dcases\*}
  \\end{aligned}\$\$ である．ゆえに
  $
    integral_(partial I^n) f_() "" #h(-1em) d x^1 and "" #h(-1em) d x^2 and dots.h accent("" #h(-1em) d x^i, ̂) dots.h and "" #h(-1em) d x^k = & \( - 1 \)^(i + 1) integral_(\[ 0 \, 1 \]^(k - 1)) f \( x^1 \, x^2 \, dots.h \, 1 \, dots.h \, x^k \) "" #h(-1em) d x^1 dots.h.c "" #h(-1em) d x^k\
    & + \( - 1 \)^i integral_(\[ 0 \, 1 \]^(k - 1)) f \( x^1 \, x^2 \, dots.h \, 0 \, dots.h \, x^k \) "" #h(-1em) d x^1 dots.h.c "" #h(-1em) d x^k .
  $
  一方で，
  $ integral_(I^n) "" #h(-1em) d (f "" #h(-1em) d x^1 and "" #h(-1em) d x^2 and dots.h accent("" #h(-1em) d x^i, ̂) dots.h and "" #h(-1em) d x^k) & = integral_(I^n) partial_i f "" #h(-1em) d x^i and "" #h(-1em) d x^1 and "" #h(-1em) d x^2 and dots.h accent("" #h(-1em) d x^i, ̂) dots.h and "" #h(-1em) d x^k\
  & = \( - 1 \)^(i - 1) integral_(I^n) partial_i f "" #h(-1em) d x^1 and "" #h(-1em) d x^2 and dots.h and "" #h(-1em) d x^i and dots.h and "" #h(-1em) d x^k\
  & = \( - 1 \)^(i - 1) integral_(I^n) partial_i f "" #h(-1em) d x^1 dots.h.c "" #h(-1em) d x^k . $更に
  Fubini の定理と微積分学の基本定理から，
  $
    \( - 1 \)^(i - 1) integral_(I^n) partial_i f "" #h(-1em) d x^1 dots.h.c "" #h(-1em) d x^k = & \( - 1 \)^(i - 1) integral_0^1 dots.h.c integral_0^1 (integral_0^1 partial_i f "" #h(-1em) d x^i) "" #h(-1em) d x^1 "" #h(-1em) d x^2 dots.h accent("" #h(-1em) d x^i, ̂) dots.h "" #h(-1em) d x^k\
    = & \( - 1 \)^(i - 1) integral_0^1 dots.h.c integral_0^1 (f \( x^1 \, dots.h \, 1 \, dots.h \, x^k \) - f \( x^1 \, dots.h \, 0 \, dots.h \, x^k \)) "" #h(-1em) d x^1 "" #h(-1em) d x^2 dots.h accent("" #h(-1em) d x^i, ̂) dots.h "" #h(-1em) d x^k\
    = & \( - 1 \)^(i + 1) integral_0^1 dots.h.c integral_0^1 (f \( x^1 \, dots.h \, 1 \, dots.h \, x^k \)) "" #h(-1em) d x^1 dots.h.c "" #h(-1em) d x^k\
    & + \( - 1 \)^i integral_0^1 dots.h.c integral_0^1 (f \( x^1 \, dots.h \, 0 \, dots.h \, x^k \)) "" #h(-1em) d x^1 dots.h.c "" #h(-1em) d x^k
  $
  となるので，結局$integral_(I^n) d omega = integral_(partial I^n) omega$を得る．

  $c$が一般の曲$k$方体のときは，定義より$integral_(partial c) omega = integral_(partial I^k) c^(\*) omega$#footnote[$integral_(partial c) omega = integral_(\[ 0 \, 1 \]^k) \( partial c \)^(\*) omega = integral_(\[ 0 \, 1 \]^k) (sum_(i = 1)^k sum_(alpha = 0)^1 \( - 1 \)^(i + alpha) c compose I_(\( i \, alpha \))^k)^(\*) omega = integral_(\[ 0 \, 1 \]^k) sum_(i = 1)^k sum_(alpha = 0)^1 \( - 1 \)^(i + alpha) (I_(\( i \, alpha \))^k)^(\*) compose c^(\*) omega = integral_(\[ 0 \, 1 \]^k) (partial I^k)^(\*) compose c^(\*) omega = integral_(partial I^k) c^(\*) omega$である．];なので，
  $ integral_c "" #h(-1em) d omega = integral_(I^k) c^(\*) \( "" #h(-1em) d omega \) = integral_(I^k) "" #h(-1em) d \( c^(\*) omega \) = integral_(partial I^k) c^(\*) omega = integral_(partial c) omega . $$c$が一般の曲$k$鎖体の場合は積分の線型性と曲$k$方体に対する結果よりよい．

]
Spivak いわく Stokes の定理は3つの大きな特徴を持っているとされる．

+ 自明な定理である．

+ 自明であるのは，主張にあらわれる概念たちが適切に定義されてきたがゆえである．

+ 複数の重要な帰結を導く．

ここまでの議論ではじめのふたつの特徴が確かに認められること，ならびにここからの議論でもうひとつの特徴が認められることが納得できたなら，このノートの目標は完全に達成されたといえる．

10pt 15pt #strong[] . 5pt plus 1pt minus 1pt

= 微分可能多様体
<微分可能多様体>
微分可能多様体を定義し，前節に定義したベクトル場や微分形式，Stokes
の定理を微分可能多様体にまで拡張する．微分可能多様体に対する Stokes
の定理が，古典ベクトル解析における大定理たちを系として持つことを証明する．

== 多様体の定義
<多様体の定義>
$k$次元多様体とは，大雑把に言ってしまえば「局所的に$bb(R)^k$と同一視できる空間」である．それを厳密な形で述べることからはじめる．

#defi[
  $M subset bb(R)^n$の各点$p$が次の条件を充たすとき，$M$は$k$次元（微分可能）多様体であると言われる；$p$を含む開集合$U_p subset bb(R)^n$，および開集合$V_p subset bb(R)^n$ならびに微分同相写像$h_p : U_p arrow.r V_p$が存在して，\$h\_p(U\_p \\cap M) = V\_p \\cap \\left(\\mathbb{R}^k \\times \\set{0}\\right)\$，すなわち\$h\_p(U\_p \\cap M) = \\set{y \\in V\_p | y^{k+1} = \\dots = y^n = 0}\$が成り立つ．

]
#exm[
  自明な$k$次元微分可能多様体の例は$bb(R)^k$の開集合である．もう少し自明でない例として，$k$次元球面\$\\mathbb{S}^k \\coloneqq \\set{p \\in \\mathbb{R}^{k+1} | \\|p\\|=1}\$がある．これが微分可能多様体であることを見たければ，上記の条件を直接確かめればよい．のだが，面倒なのでまだノートに書き起こしていない．

]
ここに「面倒」と書いたが，$bb(R)^n$の部分集合が多様体であるかどうか，もっとかんたんに判定できる場合がある；

#prop[
  $A subset bb(R)^n$を開集合，$g : A arrow.r bb(R)^p$を$C^oo$級関数とする．更に，$g \( p \) = 0$となるような$p in A$において，$g$の
  Jacobi
  行列の階数が$k$であったと仮定する．このとき，$M colon.eq g^(- 1) \( 0 \)$は$n - k$次元多様体である．

]
#proof[
  @陰関数定理の言い換え
  より，各点$p in g \( M \)$に対して，$g \( p \)$を含む開集合$U_p$上で定義された微分同相$F_p : U_p arrow.r bb(R)^n$であって，$g compose F_p^(- 1) \( p \) = \( p^(n - k + 1) \, dots.h \, p^n \)$を充たすようなものがある．$F_p \( U_p \) colon.eq V_p$と置く．$F_p : U_p arrow.r V_p$が，定義の条件にあるような微分同相写像であること，すなわち\$F\_p(U\_p \\cap M) = V\_p \\cap \\left( \\mathbb{R}^{n-k} \\times \\set{0} \\right)\$を示せばよい．

  \$F\_p(U\_p \\cap M) \\subset V\_p \\cap \\left( \\mathbb{R}^{n-k} \\times \\set{0} \\right)\$を示すために，$q in U_p sect M$を任意に取って$r colon.eq F_p \( q \)$と置く．$r in V_p$はよい．$g compose F_p^(- 1) \( r \) = g \( p \) = 0$なので，$r^(n - p + 1) = dots.h = r^n = 0$，すなわち\$r \\in \\mathbb{R}^{n-k} \\times \\set{0}\$がわかる．

  逆の包含を示すために\$r \\in V\_p \\cap \\left( \\mathbb{R}^{n-k} \\times \\set{0} \\right)\$を取る．$F_p^(- 1) \( r \) in U_p$はよい．$g compose F_p^(- 1) \( r \) = 0$なので$F_p^(- 1) \( r \) in M$である．

]
この命題によって$bb(S)^n$が$n$次元多様体となることがすぐわかる．というのも，$g : bb(R)^(n + 1) arrow.r bb(R)$を$g \( p \) colon.eq parallel p parallel^2 - 1$によって定めれば，$g$は$p in bb(S)^n$において微分が消えておらず，したがってこの命題の前件を充たすとわかるからである．

さて，もう一つ定義と同値な条件を述べておこう．ベクトル場や微分形式を多様体の上で定義するには，こちらの条件のほうが使いやすい．

#thm[
  $M subset bb(R)^n$が$k$次元多様体であることと，$M$の各点$p$が次の条件（座標条件と呼ばれる）を充たすことは同値である；$p$を含む開集合$U_p subset bb(R)^n$ならびに開集合$W_p subset bb(R)^k$，単射な$C^oo$級関数$f : W_p arrow.r bb(R)^n$が存在して，

  + $f \( W_p \) = M sect U_p$．

  + $W_p$の各点$q$において，$f$の Jacobi 行列$J_f \( q \)$の階数は$k$．

  + $f^(- 1) : f \( W_p \) arrow.r W_p$は連続．

]
#proof[
  $M$が$k$次元多様体であったとする．$p in M$を任意に取れば，定義にあるような微分同相$h_p : U_p arrow.r V_p$が存在する．このとき，\$W\_p \\coloneqq \\set{(b^1, \\dots, b^k) | b \\in V\_p \\cap (\\mathbb{R}^k \\times \\set{0})}\$として，$f : W_p arrow.r bb(R)^n$を$f \( a \) colon.eq h_p^(- 1) \( a \, 0 \)$で定める．$h_p$が$C^oo$級微分同相であることから$f$の単射性と$C^oo$級であることがわかる．$W_p subset bb(R)^k$が開集合であることはよく，\$(a,0) \\in V\_p \\cap (\\mathbb{R}^k \\times \\set{0})\$なので$f \( a \) = h_p^(- 1) \( a \, 0 \) in U_p sect M$である．更に$f^(- 1) = h_p \|_(f \( W_p \))$なので（連続関数の制限は常に連続なのだから）$f^(- 1)$は連続である．最後に，関数$H_p : bb(R)^n arrow.r bb(R)^k$を$H_p \( a \) colon.eq \( h_p^1 \( a \) \, dots.h \, h_p^k \( a \) \)$によって定めれば，$H_p$は微分可能であり，更に$H_p \( f \( q \) \) = q$を充たす．したがって
  Jacobi
  行列を考えることで$J_(H_p) \( f \( q \) \) dot.op J_f \( q \) = I_k$がわかるので，特に$J_f \( q \)$の階数は$k$である．

  逆に$M$の各点が座標条件を充たすと仮定する．$p in M$を任意に取れば，座標条件にあらわれる関数$f : W_p arrow.r bb(R)^n$が存在する．$p = f \( q \)$によって$q in bb(R)^k$を定める．関数$g : W_p times bb(R)^(n - k) arrow.r bb(R)^n$を，$g \( a \, b \) colon.eq f \( a \) + \( 0 \, b \)$で定めると，$det D_g \( q \, 0 \) = det D_f \( q \) eq.not 0$であることから，逆関数定理より$\( q \, 0 \)$を含む開集合$V'$ならびに$p$を含む開集合$U'$が存在して，$g$は$V'$上で$C^oo$級の逆写像$h_p : U' arrow.r V'$を持つ．また，$f$が座標条件を充たすことから，\$\\set{f(a) | (a,0) \\in V\' } = U\'\' \\cap M\$を充たす開集合$U''$が存在する#footnote[この部分は行間が大きいと思うが，本文に組み込むと議論の見通しが悪くなるので脚注で補う；座標条件の
    (i)
    より，$f \( W_p \) = U_1 sect M$となるような開集合$U_1$がある．更に座標条件の
    (iii)
    より$f^(- 1)$は連続であるから，\$W\' \\coloneqq \\set{ a | (a,0) \\in V\'}\$は開集合であることとあわせれば@開集合の引き戻しは開集合
    より\$\\set{f(a) | (a,0) \\in V\' } = f(W\') = U\_2 \\cap f(W\_p)\$となるような開集合$U_2$がある．$U'' colon.eq U_1 sect U_2$とすればよい．];．$U_p colon.eq U' sect U''$，$V_p colon.eq g^(- 1) \( U_p \)$とする．このとき，\$U\_p \\cap M = \\set{ f(a) | (a,0) \\in V\_p} = \\set{ g(a,0) | (a,0) \\in V\_p}\$なので#footnote[この部分も行間があるので補う．2つ目の等号はよいと思うので，\$U\_p \\cap M = \\set{ g(a,0) | (a,0) \\in V\_p}\$を示す．$V_p subset V'$なので，\$\\set{ g(a,0) | (a,0) \\in V\_p} \\subset  \\set{ g(a,0) | (a,0) \\in V\'} = U\'\' \\cap M\$であり，かつ\$\\set{ g(a,0) | (a,0) \\in V\_p} \\subset g(V\') = U\'\$であるから，\$\\set{ g(a,0) | (a,0) \\in V\_p} \\subset U\' \\cap U\'\' \\cap M = U\_p \\cap M\$である．逆の包含を示すために$p in U_p sect M$を取る．\$p \\notin \\set{ g(a,0) | (a,0) \\in V\_p}\$であったとすると，\$p \\in \\set{ g(a,0) | (a,0) \\in V\'}\$なので，結局\$p \\in \\set{ g(a,0) | (a,0) \\in V\' \\setminus V\_p}\$であることになるが，これは$p in U_p = g \( V_p \)$に反する．];，\$h\_p(U\_p \\cap M) = g^{-1}(U\_p \\cap M) = g^{-1}(\\set{g(a,0) | (a,0) \\in V\_p}) = \\set{(a,0) | (a,0) \\in V\_p} = V\_p \\cap (\\mathbb{R}^k \\times \\set{0})\$である．

]
ここに現れた$f : W_p arrow.r bb(R)^n$の逆写像$f^(- 1) : f \( W_p \) arrow.r W_p$を，$p$のまわりの座標系という．今後$M$上の座標系を取る場合には，いちいち逆写像を取り直したり定義域を書き下すのが煩雑なので，「$p$のまわりの座標系$f : V_p arrow.r bb(R)^k$」などと，逆写像を持ち出さずに記号を定義し，定義域の宣言も暗黙に済ませることにする．

#exm[
  上記の定理における座標条件の (iii)
  は本質的である．例えば単位開区間$\( 0 \, 1 \)$を6の字につないだ図形を考えると，これは1次元多様体ではない．「T字」になっている部分において座標が取れないためである．

]
座標条件において，座標系は単に「連続」であることしか課していない（微分可能性を課していない）ので，座標系がたかだか連続でしかない例があるのではないかと思うかもしれないが，実際にはそのようなことはない．証明を見ればわかるように座標系はある微分可能な関数の制限として得られるし，他にも次のようなことが成り立つ．

#prop[
  $f_1 : V_1 arrow.r bb(R)^k$並びに$f_2 : V_2 arrow.r bb(R)^k$を$p$のまわりの座標系とする．このとき，$f_2 compose f_1^(- 1) : f_1 \( V_1 \) arrow.r bb(R)^k$は$C^oo$級であり，その
  Jacobi 行列は正則である．

]
#proof[
  $f_2$の逆写像を$f' : f_2 \( V_2 \) arrow.r V_2$とする．このとき，先の定理の証明と同様にして関数$g : f_2 \( V_2 \) times bb(R)^(n - k) arrow.r bb(R)^n$ならびにその逆写像$h : U' arrow.r V'$が取れる．このとき$f_2 = \( h^1 \, dots.h \, h^k \)$であることが以下のようにしてわかる；$a in f_2 \( V_2 \)$を任意に取れば，$f_2 \( g \( a \, 0 \) \) = f_2 compose f' \( a \) = a$であり，かつ$h compose g \( a \, 0 \) = \( a \, 0 \)$であることと逆写像の一意性から$f_2 = \( h^1 \, dots.h \, h^k \)$である．$f_1^(- 1)$の
  Jacobi
  行列の階数が$k$であることと，$h$が微分同相であることをあわせて結論を得る．

]
Stokes
の定理を多様体に対して拡張するにあたり，ふち付き多様体の概念を導入する必要がある．

#defi[
  \$\\mathbb{H}^k \\coloneqq \\set{(p^1, \\dots, p^k) \\in \\mathbb{R}^k | p^k \\geq 0}\$を半空間という．$M subset bb(R)^n$の各点$p$が次の条件のいずれかを充たすとき，$M$は$k$次元ふち付き多様体であると言われる．

  + $p$を含む開集合$U_p subset bb(R)^n$，および開集合$V_p subset bb(R)^n$ならびに微分同相写像$h_p : U_p arrow.r V_p$が存在して，\$h\_p(U\_p \\cap M) = V\_p \\cap \\left(\\mathbb{R}^k \\times \\set{0}\\right)\$，すなわち\$h\_p(U\_p \\cap M) = \\set{y \\in V\_p | y^{k+1} = \\dots = y^n = 0}\$が成り立つ．

  + $p$を含む開集合$U_p subset bb(R)^n$，および開集合$V_p subset bb(R)^n$ならびに微分同相写像$h_p : U_p arrow.r V_p$が存在して，\$h\_p(U\_p \\cap M) = V\_p \\cap \\left(\\mathbb{H}^k \\times \\set{0}\\right)\$，すなわち\$h\_p(U\_p \\cap M) = \\set{y \\in V\_p | y^k \\geq 0, y^{k+1} = \\dots = y^n = 0}\$が成り立ち，更に$h_p \( p \)$の第$k$成分は0である．

  上の条件のうち (ii)
  を充たすような点全体のことを$partial M$と書いて，$M$のふち，または境界という．定義の
  (ii)
  にある$h_p$の存在より，$partial M$が$k - 1$次元多様体であることがわかる．

]
#prop[
  $M$をふち付き多様体とする．このとき，各点$p in M$は上記の条件 (i) または
  (ii) のどちらかしか充たさない．言い換えると，(i) ならびに (ii)
  を同時に充たす$p in M$は存在しない．

]
#proof[
  背理法による．$p in M$が (i) と (ii) を同時に充たすとして，(i)
  にあるような微分同相$h_1 : U arrow.r V_1$ならびに (ii)
  にあるような微分同相$h_2 : U arrow.r V_2$をとる．$g_1 colon.eq \( h_1^1 \, dots.h \, h_1^k \)$，$g_2 colon.eq \( h_2^1 \, dots.h \, h_2^k \)$によって$g_1 : U arrow.r bb(R)^k$，$g_2 : U arrow.r bb(H)^k$を定めると，$g_2 compose g_1^(- 1)$は$g_1 \( p \)$を含む$bb(R)^k$の開集合を$bb(H)^k$の部分集合（とくに$bb(R)^k$の開集合ではない）にうつす．ところが$det D_(g_2 compose g_1^(- 1)) \( g_1 \( p \) \) eq.not 0$なので，これは逆写像定理に反する．

]
== 多様体上のベクトル場と微分形式
<多様体上のベクトル場と微分形式>
ベクトル場ならびに微分形式の定義を多様体まで拡張する．とはいえ，多様体になったことで話が変わる部分はそう大きくない．以下しばらく，$M$を$k$次元多様体とする．

#defi[
  $p in M$とし，$f : V_p arrow.r bb(R)^k$を$p$のまわりの座標系，$g : f \( V_p \) arrow.r bb(R)^n$をその逆写像とする．座標系の定義より，$g$の
  Jacobi
  行列の階数は$k$であるから，特にその微分$d g_(f \( p \)) : T_(f \( p \)) \( f \( V_p \) \) arrow.r T_p bb(R)^n$の像は$T_p bb(R)^n$の$k$次元部分線型空間をなす．この像$"Im" d g_(f \( p \))$のことを$T_p M$と書いて，$M$の$p$における接空間という．$T_p M$の元のことを$M$の$p$における接ベクトルという．

  $T M colon.eq union.big_(p in M) T_p M$を$M$の接ベクトル束という．$X : M arrow.r T M$が$M$上のベクトル場であるとは，$X \( p \) colon.eq X_p$が$T_p M$の元であることをいう．

]
ベクトル場は，必ずしも$M$全域で定義されている必要はない．特に，ベクトル場として$p in M$のまわりの座標系$y : V_p arrow.r bb(R)^k$を考えて，$V_p$上でのみ定義されたものを考えることがある．そのようなベクトル場のことは「$p$のまわりで定義されたベクトル場」のように言うことにする．

#defi[
  $p in M$とし，$y : V_p arrow.r bb(R)^k$を$p$のまわりの座標系とする．このとき，$p$のまわりで定義されたベクトル場$frac(partial, partial y^i)$を次のように定める；$y$の逆写像を$z : y \( V_p \) arrow.r V_p$とし，$bb(R)^k$に標準座標から定まるベクトル場を$frac(partial, partial x^i)$と書く．このとき，$(frac(partial, partial y^i))_p colon.eq d z_p (frac(partial, partial x^i))_(y \( p \))$と定める．$z$の
  Jacobi
  行列の階数が$k$であることから，${(frac(partial, partial y^1))_p \, dots.h \, (frac(partial, partial y^k))_p}$は$T_p M$の基底をなす．

]
この定義から，自動的に$frac(partial, partial y^i)$は$f : V_p arrow.r bb(R)$に対する微分作用素となる．具体的に作用を書き下せば，
$ (frac(partial, partial y^i))_p f = d z_p (frac(partial, partial x^i))_(y \( p \)) f = (frac(partial, partial x^i))_(y \( p \)) \( f compose z \) = partial_i \( f compose z \) \( y \( p \) \) = partial_i \( f compose y^(- 1) \) \( y \( p \) \) $となる．この作用は，@Euclid空間での座標系から定まるベクトル場
における定義と酷似していることに気づかれたい#footnote[というか，ここの定義から逆算して
  Euclid
  空間の場合を定義した，というのが実際のところである．];．座標変換則もまた，Euclid
空間の場合と同様にして得られる．

#prop[
  $y = \( y^1 \, dots.h \, y^n \)$ならびに$z = \( z^1 \, dots.h \, z^n \)$を$U subset M$上の座標系とする．このとき，
  $ (frac(partial, partial z^i))_p = sum_j (frac(partial, partial z^i) y^j) \( p \) dot.op (frac(partial, partial y^j))_p $が成り立つ．したがって，ベクトル場の変換則は
  $ frac(partial, partial z^i) = sum_j frac(partial y^j, partial z^i) frac(partial, partial y^j) $と書ける．

]
微分形式ならびに関係する概念の定義，および基本性質たちも，Euclid
空間の場合と同様にして話が進む．あらわれる証明も Euclid
空間の場合と同様な（はずな）ので，すべて省略する．

#defi[
  $p in M$に対して，$T_p M$の双対空間$\( T_p M \)^(\*)$のことを$T_p^(\*) M$と書いて，$p$における余接空間という．$T_p^(\*) M$も線型空間の構造を持つ．
  更に，$y$の定めるベクトル場は$T_p M$の基底${(frac(partial, partial y^i))_p \, dots.h \, (frac(partial, partial y^i))_p}$を定めた．この基底に関する双対基底を${\( d y^1 \)_p \, dots.h \, (d y^n)_p}$と書く．

]
#defi[
  $y : U arrow.r bb(R)^k$を$M$上の座標系とする．自然数$k gt.eq 1$に対して$omega : U arrow.r union.big_(p in M) and.big^k \( T_p^(\*) M \)$が$U$上の微分$k$-形式，あるいは単に$k$-形式であるとは，任意の$p in U$に対して$omega_p colon.eq omega \( p \) in and.big^k \( T_p^(\*) M \)$となることをいう．また，（滑らかな）関数$f : U arrow.r bb(R)$のことを微分0-形式ともいう．$U$上の微分$k$-形式全体の集合を$Omega^k \( U \)$と書く．$omega in Omega^k \( U \)$の関数倍$f omega$のことを$f and omega$とも書く．

]
#defi[
  $omega$を$U$上の$k$-形式とする．このとき，任意の$p in U$に対して${(d y^(i_1))_p and dots.h and (d y^(i_k))_p med divides med 1 lt.eq i_1 < dots.h < i_k lt.eq n}$は$and.big^k T_p^(\*) M$の基底をなすので，$\( i_1 \, dots.h \, i_k \)$で添字付けられたある関数の族\$\\set{ f^y\_{i\_1,i\_2,\\dots,i\_n} \\colon U \\to \\mathbb{R}| 1 \\leq i\_1 \< \\dots \< i\_k \\leq n }\$が一意的に存在して，
  $ omega_p = sum_(1 lt.eq i_1 < i_2 < dots.h i_k lt.eq n) f_(i_1 \, i_2 \, dots.h \, i_n)^y \( p \) dot.op (d y^(i_1))_p and dots.h and (d y^(i_k))_p $が成り立つ．このような表示のことを$y$による$omega$の（局所）座標表示と呼ぶ．$omega$が$C^oo$級，あるいは滑らかであるとは，すべての$f_(i_1 \, i_2 \, dots.h \, i_n)^y$が$C^oo$級であることと定める．

]
#prop[
  $y = \( y^1 \, dots.h \, y^n \)$ならびに$z = \( z^1 \, dots.h \, z^n \)$を$U subset M$上の座標系とする．このとき，
  $ (d z^i)_p = sum_j (frac(partial, partial y^j) z^i) \( p \) dot.op (d y^j)_p $が成り立つ．したがって微分1-形式の変換則は
  $ d z^i = sum_j frac(partial z^i, partial y^j) d y^j $と書ける．

]
#prop[
  $y = \( y^1 \, dots.h \, y^n \)$ならびに$z = \( z^1 \, dots.h \, z^n \)$を$U subset M$上の座標系とする．このとき，$1 lt.eq i_1 < dots.h < i_k lt.eq n$を充たすような$\( i_1 \, dots.h \, i_k \)$に対して
  $ (d y^(i_1))_p and dots.h and (d y^(i_k))_p = sum_(1 lt.eq j_1 < dots.h < j_k lt.eq n) det (frac(partial y^(i_a), partial z^(j_b))) \( p \) dot.op (d z^(j_1))_p and dots.h and (d z^(j_k))_p $が成り立つ．但し，$(frac(partial y^(i_a), partial z^(j_b)))$は$\( a \, b \)$成分が$frac(partial y^(i_a), partial z^(j_b))$であるような$k times k$行列をあらわす．特に$n$-形式の場合は記述が少し簡単になり，
  $ (d y^1)_p and dots.h and (d y^n)_p = det (frac(partial y^i, partial z^j)) \( p \) dot.op (d z^1)_p and dots.h and (d z^n)_p $が成り立つ．

]
#defi[
  $omega in Omega^n \( U \)$とし，その座標表示
  $ omega_p = sum_(1 lt.eq i_1 < i_2 < dots.h < i_k lt.eq n) f_(i_1 \, i_2 \, dots.h \, i_k)^y \( p \) dot.op (d y^(i_1))_p and dots.h and (d y^(i_k))_p $を考える．このもとで，$omega$の外微分$d omega in Omega^(n + 1) \( U \)$を，
  $
    d omega_p colon.eq sum_(1 lt.eq i_1 < i_2 < dots.h < i_k lt.eq n) (d f_(i_1 \, i_2 \, dots.h \, i_k)^y)_p and (d y^(i_1))_p and dots.h and (d y^(i_k))_p
  $
  によって定める．

]
#prop[
  $omega in Omega^k \( U \)$，$eta in Omega^ell \( U \)$とする．

  + $k = ell$のとき，$"" #h(-1em) d \( omega + eta \) = "" #h(-1em) d omega + "" #h(-1em) d eta$．

  + $"" #h(-1em) d \( omega and eta \) = \( "" #h(-1em) d omega \) and eta + \( - 1 \)^k omega and "" #h(-1em) d eta$．

  + $"" #h(-1em) d \( "" #h(-1em) d omega \) = 0$．$"" #h(-1em) d^2 = 0$と書く場合も多い．

]
#defi[
  $M$，$N$を多様体とし，$y : U arrow.r bb(R)^k$を$N$の座標系とする．このとき，$omega in Omega^k \( U \)$の$f : M arrow.r N$による引き戻し$f^(\*) omega in Omega^k \( f^(- 1) \( U \) \)$を，$v_1 \, dots.h \, v_k in T_p M$に対して
  $ \( f^(\*) omega \)_p \( v_1 \, dots.h \, v_k \) colon.eq omega_(f \( p \)) \( "" #h(-1em) d f_p v_1 \, dots.h \, "" #h(-1em) d f_p v_k \) $とすることで定める．

]
#prop[
  $omega in Omega^k \( U \)$，$eta in Omega^ell \( U \)$，$U subset N$を開集合とし，$f : M arrow.r N$とする．

  + $k = ell$のとき，$f^(\*) \( omega + eta \) = f^(\*) omega + f^(\*) eta$．

  + $f^(\*) \( omega and eta \) = f^(\*) omega and f^(\*) eta$．

  + $f^(\*) \( "" #h(-1em) d omega \) = "" #h(-1em) d \( f^(\*) \( omega \) \)$．

]
== 多様体の向き
<多様体の向き>
微分形式の座標変換則には Jacobi
行列の行列式が現れる．それが原因で，座標の取り替え方によっては符号が変わる．なので，Euclid
空間において微分形式の積分を well-defined に定義するには，座標変換の
Jacobi
行列の行列式が正であることを要求しなければいけなかった．それと同様の要求が微分可能多様体に対しても必要になる．それが「向きを選ぶ」という操作である．

#defi[
  線型空間$V$の基底上の二項関係$tilde.op$を次のように定める；「\$\\mathcal{V} = \\set{v\_1, \\dots, v\_n}\$ならびに\$\\mathcal{W} = \\set{w\_1, \\dots, w\_n}\$を$V$の基底とし，$w_i eq.colon sum a_i^j v_j$と置く．$cal(V) tilde.op cal(W)$となるのは，$det (a_i^j) > 0$がなりたつとき」．$tilde.op$は$V$の基底に対する同値関係を定める．この同値関係に関する同値類のことを$V$の向きという．\$\\set{v\_1, \\dots, v\_n}\$が属する向きのことを$\[ v_1 \, dots.h \, v_n \]$と書き，属さない向きのことを$- \[ v_1 \, dots.h \, v_n \]$と書く．特に$V = bb(R)^n$の場合，標準基底\$\\set{e\_1, \\dots, e\_n}\$が属する向き$\[ e_1 \, dots.h \, e_n \]$を自然な向き，または右手系といい，右手系でない向きを左手系という．

]
#que[
  $V$の向きは常に2つ存在する．

]
#dig[
  このノートではここで「右手系」や「左手系」を定義した．ここより前でこれらの言葉を証明に組み込むことはしていない．が，それはそれとして，$bb(R)^2$や$bb(R)^3$の場合に「右手系」や「左手系」という言葉を多少なりとも見た人は多いと思う．

]
#defi[
  $M$を$k$次元多様体とする．各$p in M$ごとに，$T_p M$の向きのひとつ$mu_p$を選んで集めた集合\$\\set{\\mu\_p | p \\in M}\$のことを，$M$の接空間の向きの系という．

  \$\\set{\\mu\_p | p \\in M}\$を$M$の接空間の向きの系とする．向きの系\$\\set{\\mu\_p | p \\in M}\$は次の条件を充たすときに一貫しているといわれ，充たさないときに一貫してないといわれる；任意の座標系$f : V_p arrow.r bb(R)^k$をとり，その逆写像を$g : f \( V_p \) arrow.r V_p$とするとき，任意の$a \, b in f \( V_p \)$に対して$\[ d g_a \( "Tan"_a \( e_1 \) \) \, d g_a \( "Tan"_a \( e_2 \) \) \, dots.h \, d g_a \( "Tan"_a \( e_k \) \) \] = mu_(g \( a \))$と$\[ d g_b \( "Tan"_b \( e_1 \) \) \, d g_b \( "Tan"_b \( e_2 \) \) \, dots.h \, d g_b \( "Tan"_b \( e_k \) \) \] = mu_(g \( b \))$が同値である．

  一貫した$M$の接空間の向きの系が存在するとき，$M$は向き付け可能であるという．このとき，ふたつ存在する一貫した$M$の接空間の向きの系のおのおのを$M$の向きという．向きの定まった多様体のことを向きづけられた多様体という．

]
#defi[
  $M$を向き付けられた多様体とし，その向きを\$\\mu = \\set{\\mu\_p | p \\in M}\$とする．座標系$f : V_p arrow.r bb(R)^k$をとり，その逆写像を$g : f \( V_p \) arrow.r V_p$とする．$f$が向きを保つとは，ある$a in f \( V_p \)$に対して，すなわち任意の$a in f \( V_p \)$に対して$\[ d g_a \( "Tan"_a \( e_1 \) \) \, dots.h \, d g_a \( "Tan"_a \( e_k \) \) \] = mu_(g \( a \))$が成り立つことをいう．

]
$f$が向きを保たないならば，線型変換$T : bb(R)^k arrow.r bb(R)^k$であって$det T = - 1$であるようなものを取れば$T compose f$は向きを保つ．したがって，各点において向きを保つ座標系が存在する．

#lem[
  $f_1 \, f_2 : V_p arrow.r bb(R)^k$を$p$のまわりの向きを保つ座標系とする．このとき，$det D_(f_2 compose f_1^(- 1)) > 0$である．

]
<向きを保てば座標変換の行列式は正>
#proof[
  $f_1$，$f_2$の逆写像をそれぞれ$g_1$，$g_2$とする．$f_1$と$f_2$がいずれも向きを保つことから，
  $
    \[ d g_1_p \( "Tan"_p \( e_1 \) \) \, d g_1_p \( "Tan"_p \( e_2 \) \) \, dots.h \, d g_1_p \( "Tan"_p \( e_k \) \) \] = \[ d g_2_p \( "Tan"_p \( e_1 \) \) \, d g_2_p \( "Tan"_p \( e_2 \) \) \, dots.h \, d g_2_p \( "Tan"_p \( e_k \) \) \]
  $
  である．更に$g_2 compose f_2 compose g_1 = g_1$なので，特に$d g_2 compose d \( f_2 compose g_1 \) = d g_1$を得る．したがって
  $ & \[ d g_2 compose d \( f_2 compose g_1 \)_p \( "Tan"_p \( e_1 \) \) \, d g_2 compose d \( f_2 compose g_1 \)_p \( "Tan"_p \( e_2 \) \) \, dots.h \, d g_2 compose d \( f_2 compose g_1 \)_p \( "Tan"_p \( e_k \) \) \]\
  = & \[ d g_2_p \( "Tan"_p \( e_1 \) \) \, d g_2_p \( "Tan"_p \( e_2 \) \) \, dots.h \, d g_2_p \( "Tan"_p \( e_k \) \) \] $を得るから，
  $ & \[ d \( f_2 compose g_1 \)_p \( "Tan"_p \( e_1 \) \) \, d \( f_2 compose g_1 \)_p \( "Tan"_p \( e_2 \) \) \, dots.h \, d \( f_2 compose g_1 \)_p \( "Tan"_p \( e_k \) \) \]\
  = & \[ "Tan"_p \( e_1 \) \, "Tan"_p \( e_2 \) \, "Tan"_p \( e_k \) \] $となる．したがって$det D_(f_2 compose f_1^(- 1)) > 0$を得る．

]
#defi[
  $M$を$k$次元ふち付き多様体とし，$p in partial M$ならびに$p$のまわりの座標系$f : V_p arrow.r bb(H)^k$を任意に取る．このとき$T_p partial M$は$T_p M$の$k - 1$次元部分線型空間である．したがって，$T_p M$における$T_p partial M$の直交補空間は1次元線型空間をなすから，特にこの直交補空間に属する長さ1のベクトル$v$が2本取れる．その中で，$d f_p \( v \)$の$frac(partial, partial x^k)$成分が負のものを，$M$の$p$における単位外法線といい$n \( p \)$であらわす．

]
#defi[
  $M$を$k$次元ふち付き多様体とし，$mu$を$M$の向きとする．$p in partial M$を任意に取る．このとき，$v_1 \, dots.h \, v_(k - 1) in T_p partial M$を，$\[ n \( p \) \, v_1 \, dots.h \, v_(k - 1) \] = mu_p$が成り立つように取る．ここで，$v_1 \, dots.h \, v_(k - 1)$が定める$T_p partial M$の向き$\[ v_1 \, dots.h \, v_(k - 1) \]$を$\( partial M \)_p$と書く．\$\\set{(\\partial M)\_p | p \\in M}\$は$partial M$の向きを定める．この向きを$M$から定まる$partial M$の向きという．

]
#exm[
  ふち付き多様体$bb(H)^k$に通常の向き（$bb(R)^k$と同じ向き）を入れて考える．更に，境界\$\\partial \\mathbb{H}^k = \\set{x \\in \\mathbb{H}^k | x^k=0 }\$を$bb(R)^(k - 1)$と同一視する．この$bb(R)^(k - 1)$に入る向きを考察してみる．$p in partial bb(H)^k$ならびに$T_p bb(H)^k$の基底\$\\set{v\_1, \\dots, v\_{k-1}}\$を任意に取ると，$\[ n \( p \) \, v_1 \, dots.h \, v_(k - 1) \]$が自然な向きと一致するから，$n \( p \) = - "Tan"_p \( e_k \)$と併せれば$\[ - "Tan"_p \( e_k \) \, v_1 \, dots.h \, v_(k - 1) \] = \[ e_1 \, dots.h \, e_k \]$である．また，$\[ - "Tan"_p \( e_k \) \, v_1 \, dots.h \, v_(k - 1) \] = - \[ "Tan"_p \( e_k \) \, v_1 \, dots.h \, v_(k - 1) \] = \[ v_1 \, "Tan"_p \( e_k \) \, dots.h \, v_(k - 1) \] = \( - 1 \)^k \[ v_1 \, dots.h \, v_(k - 1) \, "Tan"_p \( e_k \) \]$である．ゆえに$\[ v_1 \, dots.h \, v_k \] = \( - 1 \)^k \[ e_1 \, dots.h \, e_(k - 1) \]$である．

]
== Stokes の定理
<stokes-の定理>
以下しばらく，$M$を$k$次元ふち付き多様体とする．

#defi[
  $omega$を$M$上の$ell$形式，$c : \[ 0 \, 1 \]^ell arrow.r M$を$M$上の曲$ell$方体とする．$omega$の$c$上の積分を$integral_c omega colon.eq integral_(\[ 0 \, 1 \]^p) c^(\*) omega$によって定める．$ell$鎖体上での$omega$の積分も同様に定義する．

]
#defi[
  $M$が向きづけられているとする．$omega$を$M$上の$k$形式，$c : \[ 0 \, 1 \]^p arrow.r M$を$M$上の曲$k$方体とする．更に$M$上の座標系$f : V_p arrow.r bb(R)^k$であって，$c \( \[ 0 \, 1 \]^k \) subset V_p$であるようなものが存在したとする．$c$が向きを変えないとは，$f$が向きを変えないことをいう．

]
#defi[
  $c : \[ 0 \, 1 \]^k arrow.r M$を向きを変えない曲$k$方体，$omega$を$M$上の$k$形式とし，更に$omega$は$c \( \[ 0 \, 1 \]^k \)$の外部で0であるとする．このとき，$M$上での$omega$の積分を$integral_M omega colon.eq integral_c omega$によって定める．

]
#prop[
  上記の定義は well-defined
  である；$c_1 \, c_2 : \[ 0 \, 1 \]^k arrow.r M$を，向きを変えない曲$k$方体とする．更に$omega$を$M$上の$k$形式であって，$c_1 \( \[ 0 \, 1 \]^k \) sect c_2 \( \[ 0 \, 1 \]^k \)$の外部で0であるとする．このとき，$integral_(c_1) omega = integral_(c_2) omega$が成り立つ．

]
#proof[
  $c_1 \, c_2$が向きを保つことと@向きを保てば座標変換の行列式は正
  より$det D_(c_2^(- 1) compose c_1) > 0$が出るので，@微分形式の積分はwell-defined
  と同様に証明すればよい．

]
#defi[
  $omega$を$M$上の$k$形式，$cal(O)$を$M$の開被覆とし，$cal(O)$に従属する$M$上の1の分割$Phi$を取る．このとき，各$phi in Phi$に対して，$phi dot.op omega$はある開集合の外で0であるから，特にある曲方体の外部で0なので，積分$integral_M phi dot.op omega$が定義できる．無限級数$sum_(phi in Phi) integral_M phi dot.op \| omega \|$が収束するとき，$omega$の$M$上の積分を$integral_M omega colon.eq sum_(phi in Phi) integral_M phi dot.op omega$によって定める．

]
#que[
  $M$がコンパクトならば$cal(O)$から有限部分被覆を選び直して考えればよいので，積分$integral_M omega$は必ず定義できる．

]
#que[
  「無限級数$sum_(phi in Phi) integral_M phi dot.op \| omega \|$が収束する」という条件は，積分が開被覆や1の分割に依らないことを保証するのに必要である．のだが，今後は$M$がコンパクトな場合（少なくとも，$omega$がコンパクト台を持つ場合）を主に考察するので，この点に関しては立ち入らない．

]
#lem[
  $c : \[ 0 \, 1 \]^k arrow.r M$を向きを保つ曲$k$方体とする．このとき，$c_(\( k \, 0 \))$は$partial M$の向きを，$k$が奇数なら保たず，偶数ならば保つ．

]
#proof[
  $M$に与えられた向きを\$\\mu = \\set{\\mu\_p | p \\in M}\$とする．$\[ d c_p \( "Tan"_p \( e_1 \) \) \, dots.h \, d c_p \( "Tan"_p \( e_k \) \) \] = mu_p$であるとして一般性を失わないのでそうする．$I_(\( k \, 0 \))^k \( x \) = \( x \, 0 \)$なので，$i = 1 \, dots.h \, k - 1$に対して$d (I_(\( k \, 0 \))^k)_p \( "Tan"_p \( e_i \) \) = "Tan"_p \( e_i \)$である．更に$c_(\( k \, 0 \)) = c compose I_(\( k \, 0 \))^k$すなわち$d c_(\( k \, 0 \)) = d c compose d I_(\( k \, 0 \))^k$であることから，$i = 1 \, dots.h \, k - 1$に対して$d c_p \( "Tan"_p \( e_i \) \) = d (c_(\( k \, 0 \)))_p \( "Tan"_p \( e_i \) \)$を得る．$d c_p \( "Tan" \( e_k \) \) in.not T_p partial M$であることと単位外法線の定義から$\[ - d c_p \( "Tan"_p \( e_k \) \) \, d c_p \( "Tan"_p \( e_1 \) \) dots.h \, d c_p \( "Tan"_p \( e_(k - 1) \) \) \] = \[ n \( x \) \, d c_p \( "Tan"_p \( e_1 \) \) dots.h \, d c_p \( "Tan"_p \( e_(k - 1) \) \) \]$を得る．したがって$k$が奇数ならば$\[ - d c_p \( "Tan"_p \( e_k \) \) \, d c_p \( "Tan"_p \( e_1 \) \) dots.h \, d c_p \( "Tan"_p \( e_(k - 1) \) \) \] = \[ d c_p \( "Tan"_p \( e_1 \) \) dots.h \, d c_p \( "Tan"_p \( e_k \) \) \] = mu_p$を得るので，$partial M$に入る向きは$\[ d c_p \( "Tan"_p \( e_1 \) \) dots.h \, d c_p \( "Tan"_p \( e_(k - 1) \) \) \]$と一致する．したがって$c_(\( k \, 0 \))$は向きを保つ．$k$が偶数の場合も同様に議論して$c_(\( k \, 0 \))$は向きを保たないとわかる．

]
#lem[
  $omega$を$M$上の$k - 1$形式とする．更に$c : \[ 0 \, 1 \]^k arrow.r M$を向きを保つ曲$k$方体であって，$c_(\( k \, 0 \)) subset partial M$が成り立つようなものとする．加えて，内点が$partial M$に含まれるような境面は$c_(\( k \, 0 \))$に限られるとする．このとき，$integral_(partial M) omega = integral_(partial c) omega$が成り立つ．

]
#proof[
  まず内点が$partial M$に含まれるような境面は$c_(\( k \, 0 \))$に限られることと，$c_(\( k \, 0 \))$は$partial M$の向きを，$k$が奇数なら保たず，偶数ならば保つから，$integral_(partial M) omega = \( - 1 \)^k integral_(c_(\( k \, 0 \))) omega$である．したがって$integral_(partial c) omega = integral_(\( - 1 \)^k c_(\( k \, 0 \))) omega = \( - 1 \)^k integral_(c_(\( k \, 0 \))) omega = \( - 1 \)^(2 k) integral_(partial M) omega = integral_(partial M) omega$

]
#thm[
  $M$をコンパクトふち付き$k$次元多様体，$omega$を$M$上の微分$k - 1$形式とするとき，$integral_M "" #h(-1em) d omega = integral_(partial M) omega$が成り立つ．

]
#proof[
  証明を3段階に分割する．

  まず，$M \\ partial M$の曲方体$c$であって，$c \( \[ 0 \, 1 \]^k \)$の外部で$omega$が0になるようなものが取れたとする．このとき$integral_M "" #h(-1em) d omega = integral_c "" #h(-1em) d omega = integral_(partial c) omega$であるが，$omega$は$partial c$上で0なので$integral_M "" #h(-1em) d omega = 0$である．同様に$omega$は$partial M$上で0なので$integral_(partial M) omega = 0$である．

  次いで，向きを保つ曲$k$方体$c : \[ 0 \, 1 \]^k arrow.r M$であって，$c \( \[ 0 \, 1 \]^k \)$の外で$omega$が0であり，$c_(\( k \, 0 \)) subset partial M$が成り立ち，内点が$partial M$に含まれるような境面は$c_(\( k \, 0 \))$に限られるようなものが取れたとする．この場合は$integral_(partial M) omega = integral_(partial c) omega = integral_c "" #h(-1em) d omega = integral_M "" #h(-1em) d omega$となって定理が成り立つ．

  一般の場合は$M$の有限開被覆$cal(O)$ならびに$cal(O)$に従属する1の分割$Phi$を取れば，$phi in Phi$に対して$phi dot.op omega$は上記2つのいずれかに帰着する．$0 = "" #h(-1em) d \( 1 \) = "" #h(-1em) d \( sum_(phi in Phi) phi \) = sum_(phi in Phi) "" #h(-1em) d phi$なので，$sum_(phi in Phi) "" #h(-1em) d phi and omega = 0$である．したがって$integral_M "" #h(-1em) d omega = sum_(phi in Phi) integral_M phi and "" #h(-1em) d omega = integral_M sum_(phi in Phi) (phi and "" #h(-1em) d omega + "" #h(-1em) d phi and omega) = integral_M sum_(phi in Phi) "" #h(-1em) d (phi and omega) = integral_(partial M) sum_(phi in Phi) phi and omega = integral_(partial M) omega$を得る．

]
== Riemann 計量と体積形式
<riemann-計量と体積形式>
@行列式の特徴づけ
を踏まえれば，行列式$det$の定義として，$omega in and.big^n \( bb(R)^n \)$の元であって$omega \( e_1 \, dots.h \, e_n \) = 1$を充たすもの，という定義を採っても構わない#footnote[学部の線型代数の講義でいきなり外積代数の一般論を広げてこの定義をするのはとっつきづらくて敬遠される気もする．のだが，同じくらいとっつきにくい（と私は感じる）Leibniz
  の明示公式は学部1年で教わるのだし，やり方を工夫して外積代数の一般論を学部1年生に仕込めたりしないのだろうか？];．この定義は一般の線型空間$V$に対してそのままは通らないが，内積が与えられているもとで一般化した概念を定義することはできる；

#thm[
  $T$を$V$の内積とし，\$\\set{v\_1, \\dots, v\_n}\$を$T$に関する正規直交基底とする．このとき，ある$omega in and.big^n \( V^(\*) \)$が存在して，$\[ v_1 \, dots.h \, v_n \] = \[ w_1 \, dots.h \, w_n \]$を充たすような任意の正規直交基底\$\\set{w\_1, \\dots, w\_n}\$に対し$omega \( v_1 \, dots.h \, v_n \) = 1$を充たす．この$omega$を，内積$T$および向き$\[ v_1 \, dots.h \, v_n \]$の定める$V$の体積要素という．特に，$bb(R)^n$の標準内積および自然な向きの定める体積要素は行列式$det$である．

]
#proof[
  \$\\set{v\_1^\*, \\dots, v\_n^\*}\$を\$\\set{v\_1, \\dots ,v\_n}\$の双対基底とすれば，$omega colon.eq v_1^(\*) and dots.h and v_n^(\*)$は$omega \( v_1 \, dots.h \, v_n \) = 1$を充たす．$w_i eq.colon sum a_i^j v_j$によって行列$A eq.colon (a_i^j)$を定めれば，$bb(R)^n$の場合と同様の議論で$A$は直交行列になることがわかるので，$det A = plus.minus 1$となる．したがって@最高次交代テンソルの変換則
  により，$\[ v_1 \, dots.h \, v_n \] = \[ w_1 \, dots.h \, w_n \]$であるならば$omega \( w_1 \, dots.h \, w_n \) = 1$である．

]
#prop[
  $V = bb(R)^n$とする．$v_1 \, dots.h \, v_(n - 1) in V$を任意にとって固定する．このとき，任意の$w in V$に対して，次の式を充たすような$z in V$が一意的に存在する；
  $ angle.l z \, w angle.r = det thin \( v_1 \, dots.h \, v_(n - 1) \, w \) . $この$z$を$v_1 times dots.h times v_(n - 1)$と書いて，$v_1 \, dots.h \, v_(n - 1)$のクロス積またはベクトル積という．

]
#proof[
  $phi : V arrow.r bb(R)$を$phi \( w \) colon.eq det thin \( v_1 \, dots.h \, v_(n - 1) \, w \)$で定めれば，$phi$は線型写像なので，$phi in V^(\*)$である．したがって@双対空間は縦ベクトル
  の結果より任意の$w in V$に対して$phi \( w \) = angle.l z \, w angle.r$を充たす$z$が一意的に存在する．

]
このクロス積は，背伸びした高校生が学んだり，学部のベクトル解析で見かけるであろうあのクロス積と実際には同じものである．のだが，定義だけをみてもそれがわかる気がしないので，クロス積の諸性質（こちらのほうがまだ見慣れているだろう）を証明しておくことにする；

#prop[
  $V = bb(R)^n$とする．

  + クロス積をとる写像$V^(n - 1) in.rev \( v_1 \, dots.h \, v_(n - 1) \) mapsto v_1 times dots.h times v_(n - 1) in V$は多重線型である．

  + 任意の$sigma in frak(S)_(n - 1)$に対して，$v_(sigma \( 1 \)) times dots.h times v_(sigma \( n - 1 \)) = "sgn" sigma \( v_1 times dots.h times v_(n - 1) \)$．

  + 以下$V = bb(R)^3$とする．$x = sum_i x^i e_i$ならびに$y = sum_i y^i e_i$に対して，$x times y = \( x^2 y^3 - x^3 y^2 \) e_1 + \( x^3 y^1 - x^1 y^3 \) e_2 + \( x^1 y^2 - x^2 y^1 \) e_3$が成り立つ．

  + $angle.l x \, x times y angle.r = 0$ならびに$angle.l y \, x times y angle.r = 0$である．

  + $theta$を$x$と$y$のなす角とするとき，$parallel x times y parallel = parallel x parallel dot.op parallel y parallel dot.op \| sin theta \|$．

]
#proof[
  + 行列式の多重線型性より従う．

  + 行列式の交代性より従う．

  + Sarrus
    の公式より$det thin \( x \, y \, z \) = \( x^2 y^3 - x^3 y^2 \) z^1 + \( x^3 y^1 - x^1 y^3 \) z^2 + \( x^1 y^2 - x^2 y^1 \) z^3$であるからよい．

  + 前段の結果と合わせて内積を直接計算せよ．

  + $det thin \( x \, y \, z \)$は$x \, y \, z in bb(R)^3$の張る平行六面体の体積であった．ここで，$z = x times y \/ parallel x times y parallel$の場合を考えると，$\| det thin \( x \, y \, z \) \| = parallel x times y parallel$である．$angle.l x \, x times y angle.r = angle.l y \, x times y angle.r = 0$をすでに見たので，$parallel x times y parallel$は$x$と$y$が張る平行四辺形の面積である．

]
後々でやるかもしれないことを見越して，クロス積に関係するようなしないようなコメントをいくつか付け加えておくことにする#footnote[実のところ，聞きかじりに基づいて「ここでこのコメントを入れておくと後で話のネタが増えるだろう」とヤマを張っているだけである．立てたフラグを回収する保証はない．];；

#exm[
  $V = bb(R)^3$とする．$z in bb(R)^3$に対して，$phi_z \( x \, y \) colon.eq det thin \( x \, y \, z \)$によって関数$phi_z$を定めると，$phi_z in and.big^2 \( bb(R)^3 \)$である．直接計算によって，$phi_(e_1) = e_2^(\*) and e_3^(\*)$，$phi_(e_2) = e_3^(\*) and e_1^(\*)$，$phi_(e_3) = e_1^(\*) and e_2^(\*)$がわかるので，$phi : bb(R)^3 in z mapsto phi_z in and.big^2 \( bb(R)^3 \)$は同型写像である．この同型は，微分2-形式をベクトル場と同一視する際に用いられる．この仕方の同一視に基づいて得られるベクトル場は物理学において軸性ベクトル場と呼ばれるものであり，通常のベクトル場（物理学では極性ベクトル場という）とは座標変換の際に受ける変換が異なる，ということを気が向いたら見る．古典電磁気学においては，電場は極性ベクトル場であり，磁束密度は軸性ベクトル場である，らしい．

]
#exm[
  更に，$z = z^1 e_1 + z^2 e_2 + z^3 e_3$に対して$z^(\*) in and.big^1 \( bb(R)^3 \)$を，$z^(\*) colon.eq z^1 e_1^(\*) + z^2 e_2^(\*) + z^3 e_3^(\*)$によって定める．この写像も同型写像であるから，この2つの同型写像を合成して得られる$and.big^1 \( bb(R)^3 \) in.rev z^(\*) mapsto phi_z in and.big^2 \( bb(R)^3 \)$も同型写像である．かくして得られた同型写像を$\* : and.big^1 \( bb(R)^3 \) arrow.r and.big^2 \( bb(R)^3 \)$と書いて，Hodge
  スター作用素という．Hodge スター作用素は微分可能多様体上の Laplacian
  の定義に直接的に現れるのだが，どうして出てくるのか私はよく納得していない．なのでここで寄り道して定義を出した（が，Laplacian
  について書くかどうかは未定である）．

]
#defi[
  $T_p M$の内積$g \( p \) = g_p : T_p M times T_p M arrow.r bb(R)$を，$g_p \( v \, w \) colon.eq angle.l v \, w angle.r_p$によって定める（ただし，$angle.l dot.op \, dot.op angle.r_p$は$T_p bb(R)^n$の標準内積）．この$g$を$M$の
  Riemann
  計量という．$M$が2次元の場合，$g$のことを第一基本形式ともいう．Riemann計量$g$が与えられた多様体のことを
  Riemann 多様体という．

]
#defi[
  $M$を向きづけられた Riemann 多様体とし，その Riemann
  計量を$g$，向きを$mu$とする．このとき，各$p in M$に対して，$g_p$ならびに向き$mu_p$が定める$T_p M$の体積要素$omega_p$が存在する．したがって，$omega : p mapsto omega_p$は$M$上の$k$形式となるが，これを$mu$ならびに$g$によって定まる$M$の体積要素といい，しばしば$"" #h(-1em) d V$と書く（が，これは$k - 1$形式$V$の外微分などではない）．$integral_M "" #h(-1em) d V$が存在するならば，その値を$M$の体積という．

  特に$M$が1次元のときは$d V$を$d s$とも書いて，線素と呼ぶこともある．$integral_M "" #h(-1em) d s$は「長さ」と呼ぶほうが一般的である．2次元のときは$"" #h(-1em) d V$を$"" #h(-1em) d A$ないし$"" #h(-1em) d S$とも書いて，面素と呼ぶこともある．$integral_M "" #h(-1em) d A$は「面積」と呼ぶほうが一般的である．

]
#exm[
  $M subset bb(R)^3$を2次元多様体とし，$omega_p in and.big^2 \( T_p M \)$を$omega_p \( v \, w \) colon.eq det \( v \, w \, n \( p \) \)$によって定める．このとき，$v \, w$が$\[ v \, w \] = mu_p$を充たすような$T_p M$の正規直交基底であるならば，$omega_p \( v \, w \) = 1$である．したがって$omega = "" #h(-1em) d A$である．他方，ベクトル積の定義から$omega \( v \, w \) = angle.l v times w \, n \( p \) angle.r$であり，$v times w$は$n \( p \)$の定数倍なので，$\[ v \, w \] = mu_p$ならば$"" #h(-1em) d A \( v \, w \) = \| v times w \|$である．

]
#thm[
  $n$を単位外法線ベクトル場とし，$\( x \, y \, z \)$を$bb(R)^3$の座標とする．更に$M subset bb(R)^3$を2次元多様体とし，$"" #h(-1em) d A$を面素とする．このとき，$M$上で

  + $"" #h(-1em) d A = n^1 "" #h(-1em) d y and "" #h(-1em) d z + n^2 "" #h(-1em) d z and "" #h(-1em) d x + n^3 "" #h(-1em) d z and "" #h(-1em) d x$

  + $n^1 "" #h(-1em) d A = "" #h(-1em) d y and "" #h(-1em) d z$

  + $n^2 "" #h(-1em) d A = "" #h(-1em) d z and "" #h(-1em) d x$

  + $n^3 "" #h(-1em) d A = "" #h(-1em) d x and "" #h(-1em) d z$

  が成り立つ．ただし，包含写像$iota : M arrow.r bb(R)^3$による引き戻し$iota^(\*) \( "" #h(-1em) d x \)$のことも$"" #h(-1em) d x$と書いていることに注意せよ．

]
== 古典ベクトル解析の諸定理
<古典ベクトル解析の諸定理>
最後に，ここまで見た一般論から，古典ベクトル解析の大定理たちが出せることをみて終わりにする．以下，このノートの終わりまで，$bb(R)^2$の座標を$\( x \, y \)$で，$bb(R)^3$の座標を$\( x \, y \, z \)$で表すことにする．また，多様体はすべて向き付けられているとして，その境界にはもとの多様体から定まる向きを入れる．

#thm[
  $M$を$bb(R)^2$内のコンパクト2次元ふちつき多様体，$alpha \, beta : M arrow.r bb(R)$を$C^oo$級関数とする．このとき，
  $ integral_(partial M) alpha "" #h(-1em) d x + beta "" #h(-1em) d y = integral_M (partial_1 beta - partial_2 alpha) "" #h(-1em) d x and "" #h(-1em) d y $が成り立つ．古典的な書き方をすれば，
  $ integral_(partial M) alpha "" #h(-1em) d x + beta "" #h(-1em) d y = integral_M (frac(partial beta, partial x) - frac(partial alpha, partial y)) "" #h(-1em) d x "" #h(-1em) d y $が成り立つ．

]
#proof[
  $omega = alpha "" #h(-1em) d x + beta "" #h(-1em) d y$とした際の Stokes
  の定理である．

]
#thm[
  $M$を$bb(R)^3$内のコンパクト3次元ふちつき多様体，$n$を$M$の単位外法線ベクトル場，$F$を$M$上の$C^oo$級ベクトル場とする．このとき，
  $ integral_M (partial_1 F^1 + partial_2 F^2 + partial_3 F^3) "" #h(-1em) d V = integral_(partial M) angle.l F \, n angle.r "" #h(-1em) d A $が成り立つ．

]
#proof[
  $omega = F^1 "" #h(-1em) d y and "" #h(-1em) d z + F^2 "" #h(-1em) d z and "" #h(-1em) d x + F^3 "" #h(-1em) d x and "" #h(-1em) d y$としたときの
  Stokes
  の定理である．実際，$n^1 "" #h(-1em) d A = "" #h(-1em) d y and "" #h(-1em) d z$などより$angle.l F \, n angle.r "" #h(-1em) d A = omega$がわかる．

]
#thm[
  $M$を$bb(R)^3$内のコンパクト3次元ふちつき多様体，$n$を$M$の単位外法線ベクトル場，$F$を$M$上の$C^oo$級ベクトル場とする．更に，ベクトル場$nabla times F$を，$(partial_2 F^3 - partial_3 F^2) frac(partial, partial x) + (partial_3 F^1 - partial_1 F^3) frac(partial, partial y) + (partial_1 F^2 - partial_2 F^1) frac(partial, partial z)$によって定める．また，$partial M$上のベクトル場$T$を，$"" #h(-1em) d s \( T \) = 1$を充たすような唯一のものとして定める．このとき，
  $ integral_M angle.l nabla times F \, n angle.r "" #h(-1em) d A = integral_(partial M) angle.l F \, T angle.r "" #h(-1em) d s $が成り立つ．

]
#proof[
  $omega = F_1 "" #h(-1em) d x + F_2 "" #h(-1em) d y + F_3 "" #h(-1em) d z$としたときの
  Stokes
  の定理である．実際，$n^1 "" #h(-1em) d A = "" #h(-1em) d y and "" #h(-1em) d z$などより$angle.l nabla times F \, n angle.r "" #h(-1em) d A = "" #h(-1em) d omega$がわかり，$"" #h(-1em) d s \( T \) = 1$より$T^1 "" #h(-1em) d s = "" #h(-1em) d x$などがわかるので，$omega = angle.l F \, T angle.r "" #h(-1em) d s$が従う．

]
