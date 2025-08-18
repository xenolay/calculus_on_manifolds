#import "preamble.typ": * // なお import の代わりに include だと同じエラーで動かない。
#show: thmrules

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
