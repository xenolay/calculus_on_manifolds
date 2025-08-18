#import "preamble.typ": * // なお import の代わりに include だと同じエラーで動かない。
#show: thmrules

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
