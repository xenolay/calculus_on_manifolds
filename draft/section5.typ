#import "preamble.typ": * // なお import の代わりに include だと同じエラーで動かない。
#show: thmrules

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
$ integral f "" #h(-1em) d mu colon.eq sup {integral g "" #h(-1em) d mu med mid(bar.v) med 0 lt.eq g lt.eq f \, g は 単 関 数} $によって定義した．即ち，可測関数を単関数によって下から近似することで求めた．単関数によって下から近似するとは，おおらかに言えば，空間$X$をいくつかの可測集合\$\\set{A\_i}\$に分割し，各集合$A_i$における近似値$a_i$を定めることであった．直感的には，$X$の分割$A_i$が何かしらの意味で細かくなればなるほど近似の精度が良くなっていくと思われるし，実際に#link(<非負単関数の列>)[\[非負単関数の列\]];の証明では，$X$の分割を細かくしていくことで，所与の可測関数に収束する単関数の列を作った．ということで，大雑把で感覚的な物言いをすると，$X$の「とても細かい分割」\$\\set{A\_i}\$が与えられているとき，$a_i in A_i$を任意に取れば
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
    $ tau colon.eq mat(delim: "(", 1, 2, dots.h.c, ell, ell + 1, dots.h.c, ell + k; k + 1, k + 2, dots.h.c, k + ell, 1, dots.h.c, k) $で定めると，$"sgn" tau = \( - 1 \)^(k ell)$である#footnote[いわゆる「あみだくじ」を書いて符号を計算するのが一番簡単だと思う．];．#link(<交代化作用素の基本性質>)[\[交代化作用素の基本性質\]]
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
  $y$が標準座標系$x$の場合は$partial \/ partial x^i colon.eq E_i$と定めればよい．それ以外の場合は，$F = f compose x^(- 1)$，$G = x compose y^(- 1)$と置いて$(partial_i \( f compose y^(- 1) \)) \( y \( p \) \) = (partial_i \( f compose x^(- 1) compose x compose y^(- 1) \)) \( y \( p \) \) = (partial_i \( F compose G \)) \( y \( p \) \)$に対して#link(<実用的な方の合成則>)[\[実用的な方の合成則\]];を適用すると，
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
第2節で定義した多変数関数の微分を覚えていれば，それと記号や命名の衝突をしていることに気づかれよう．これは意図的である．先ほどは定義域と終域の次元が揃っている場合を考えて，座標系$y$に沿ったベクトル場$partial \/ partial y^i$を定義した．その定義の際に行った議論を，定義域と終域の次元が揃わないケースも含むような形で反芻してみる．$M colon.eq bb(R)^m$，$N colon.eq bb(R)^n$と置き，$M$の標準座標を$x_M$で，$N$の標準座標を$x_N$で表すことにする．#link(<実用的な方の合成則>)[\[実用的な方の合成則\]];の主張は，$f : M arrow.r N$ならびに$g : N arrow.r bb(R)$に対して
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
  $\( j_1 \, dots.h \, j_k \) in bb(N)^k$を，$1 lt.eq j_1 < dots.h < j_k lt.eq n$を充たすように任意に一つ取る．以下この証明において，記号を軽くするために添字の$""_p$や関数の引数に入る$\( p \)$を省く．\$\\set{dz^{j\_1} \\wedge \\dots \\wedge dz^{j\_k} | 1 \\leq j\_1\< \\dots \< j\_k \\leq n }\$は$and.big^k \( T_p^(\*) M \)$の基底をなすので，$d y^(i_1) and dots.h and d y^(i_k) = sum_(1 lt.eq j_1 < dots.h < j_k lt.eq n) a_(j_1 \, j_2 \, dots.h \, j_k) d z^(j_1) and dots.h and d z^(j_k)$と展開したときの展開係数を決定すればよい．接ベクトルの座標変換則と#link(<最高次交代テンソルの変換則>)[\[最高次交代テンソルの変換則\]];より
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
