#import "preamble.typ": * // なお import の代わりに include だと同じエラーで動かない。
#show: thmrules

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
