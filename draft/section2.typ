#import "preamble.typ": * // なお import の代わりに include だと同じエラーで動かない。
#show: thmrules

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
