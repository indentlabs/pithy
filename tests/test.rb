#!/usr/bin/ruby

require_relative '../lib/pithy'

def assert_eq(description, lhs:, rhs:)
  if lhs != rhs
    puts "Assert failed: #{description}\n\t#{lhs.inspect} != #{rhs.inspect}"
  else
    puts "PASS: #{description}"
  end
end

expected_excel_sequence = %w(
  a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 
  aa ab ac ad ae af ag ah ai aj ak al am an ao ap aq ar as at au av aw ax ay az aA aB aC aD aE aF aG aH aI 
  aJ aK aL aM aN aO aP aQ aR aS aT aU aV aW aX aY aZ ba bb bc bd be bf bg bh bi bj bk bl bm bn bo bp bq br 
  bs bt bu bv bw bx by bz bA bB bC bD bE bF bG bH bI bJ bK bL bM bN bO bP bQ bR bS bT bU bV bW bX bY bZ ca 
  cb cc cd ce cf cg ch ci cj ck cl cm cn co cp cq cr cs ct cu cv cw cx cy cz cA cB cC cD cE cF cG cH cI cJ 
  cK cL cM cN cO cP cQ cR cS cT cU cV cW cX cY cZ da db dc dd de df dg dh di dj dk dl dm dn do dp dq dr ds 
  dt du dv dw dx dy dz dA dB dC dD dE dF dG dH dI dJ dK dL dM dN dO dP dQ dR dS dT dU dV dW dX dY dZ ea eb 
  ec ed ee ef eg eh ei ej ek el em en eo ep eq er es et eu ev ew ex ey ez eA eB eC eD eE eF eG eH eI eJ eK 
  eL eM eN eO eP eQ eR eS eT eU eV eW eX eY eZ fa fb fc fd fe ff fg fh fi fj fk fl fm fn fo fp fq fr fs ft 
  fu fv fw fx fy fz fA fB fC fD fE fF fG fH fI fJ fK fL fM fN fO fP fQ fR fS fT fU fV fW fX fY fZ ga gb gc 
  gd ge gf gg gh gi gj gk gl gm gn go gp gq gr gs gt gu gv gw gx gy gz gA gB gC gD gE gF gG gH gI gJ gK gL 
  gM gN gO gP gQ gR gS gT gU gV gW gX gY gZ ha hb hc hd he hf hg hh hi hj hk hl hm hn ho hp hq hr hs ht hu 
  hv hw hx hy hz hA hB hC hD hE hF hG hH hI hJ hK hL hM hN hO hP hQ hR hS hT hU hV hW hX hY hZ ia ib ic id 
  ie if ig ih ii ij ik il im in io ip iq ir is it iu iv iw ix iy iz iA iB iC iD iE iF iG iH iI iJ iK iL iM 
  iN iO iP iQ iR iS iT iU iV iW iX iY iZ ja jb jc jd je jf jg jh ji jj jk jl jm jn jo jp jq jr js jt ju jv 
  jw jx jy jz jA jB jC jD jE jF jG jH jI jJ jK jL jM jN jO jP jQ jR jS jT jU jV jW jX jY jZ ka kb kc kd ke 
  kf kg kh ki kj kk kl km kn ko kp kq kr ks kt ku kv kw kx ky kz kA kB kC kD kE kF kG kH kI kJ kK kL kM kN 
  kO kP kQ kR kS kT kU kV kW kX kY kZ la lb lc ld le lf lg lh li lj lk ll lm ln lo lp lq lr ls lt lu lv lw 
  lx ly lz lA lB lC lD lE lF lG lH lI lJ lK lL lM lN lO lP lQ lR lS lT lU lV lW lX lY lZ ma mb mc md me mf 
  mg mh mi mj mk ml mm mn mo mp mq mr ms mt mu mv mw mx my mz mA mB mC mD mE mF mG mH mI mJ mK mL mM mN mO 
  mP mQ mR mS mT mU mV mW mX mY mZ na nb nc nd ne nf ng nh ni nj nk nl nm nn no np nq nr ns nt nu nv nw nx 
  ny nz nA nB nC nD nE nF nG nH nI nJ nK nL nM nN nO nP nQ nR nS nT nU nV nW nX nY nZ oa ob oc od oe of og 
  oh oi oj ok ol om on oo op oq or os ot ou ov ow ox oy oz oA oB oC oD oE oF oG oH oI oJ oK oL oM oN oO oP 
  oQ oR oS oT oU oV oW oX oY oZ pa pb pc pd pe pf pg ph pi pj pk pl pm pn po pp pq pr ps pt pu pv pw px py 
  pz pA pB pC pD pE pF pG pH pI pJ pK pL pM pN pO pP pQ pR pS pT pU pV pW pX pY pZ qa qb qc qd qe qf qg qh 
  qi qj qk ql qm qn qo qp qq qr qs qt qu qv qw qx qy qz qA qB qC qD qE qF qG qH qI qJ qK qL qM qN qO qP qQ 
  qR qS qT qU qV qW qX qY qZ ra rb rc rd re rf rg rh ri rj rk rl rm rn ro rp rq rr rs rt ru rv rw rx ry rz 
  rA rB rC rD rE rF rG rH rI rJ rK rL rM rN rO rP rQ rR rS rT rU rV rW rX rY rZ sa sb sc sd se sf sg sh si 
  sj sk sl sm sn so sp sq sr ss st su sv sw sx sy sz sA sB sC sD sE sF sG sH sI sJ sK sL sM sN sO sP sQ sR 
  sS sT sU sV sW sX sY sZ ta tb tc td te tf tg th ti tj tk tl tm tn to tp tq tr ts tt tu tv tw tx ty tz tA 
  tB tC tD tE tF tG tH tI tJ tK tL tM tN tO tP tQ tR tS tT tU tV tW tX tY tZ ua ub uc ud ue uf ug uh ui uj 
  uk ul um un uo up uq ur us ut uu uv uw ux uy uz uA uB uC uD uE uF uG uH uI uJ uK uL uM uN uO uP uQ uR uS 
  uT uU uV uW uX uY uZ va vb vc vd ve vf vg vh vi vj vk vl vm vn vo vp vq vr vs vt vu vv vw vx vy vz vA vB 
  vC vD vE vF vG vH vI vJ vK vL vM vN vO vP vQ vR vS vT vU vV vW vX vY vZ wa wb wc wd we wf wg wh wi wj wk 
  wl wm wn wo wp wq wr ws wt wu wv ww wx wy wz wA wB wC wD wE wF wG wH wI wJ wK wL wM wN wO wP wQ wR wS wT 
  wU wV wW wX wY wZ xa xb xc xd xe xf xg xh xi xj xk xl xm xn xo xp xq xr xs xt xu xv xw xx xy xz xA xB xC 
  xD xE xF xG xH xI xJ xK xL xM xN xO xP xQ xR xS xT xU xV xW xX xY xZ ya yb yc yd ye yf yg yh yi yj yk yl 
  ym yn yo yp yq yr ys yt yu yv yw yx yy yz yA yB yC yD yE yF yG yH yI yJ yK yL yM yN yO yP yQ yR yS yT yU 
  yV yW yX yY yZ za zb zc zd ze zf zg zh zi zj zk zl zm zn zo zp zq zr zs zt zu zv zw zx zy zz zA zB zC zD 
  zE zF zG zH zI zJ zK zL zM zN zO zP zQ zR zS zT zU zV zW zX zY zZ Aa Ab Ac Ad Ae Af Ag Ah Ai Aj Ak Al Am 
  An Ao Ap Aq Ar As At Au Av Aw Ax Ay Az AA AB AC AD AE AF AG AH AI AJ AK AL AM AN AO AP AQ AR AS AT AU AV 
  AW AX AY AZ Ba Bb Bc Bd Be Bf Bg Bh Bi Bj Bk Bl Bm Bn Bo Bp Bq Br Bs Bt Bu Bv Bw Bx By Bz BA BB BC BD BE 
  BF BG BH BI BJ BK BL BM BN BO BP BQ BR BS BT BU BV BW BX BY BZ Ca Cb Cc Cd Ce Cf Cg Ch Ci Cj Ck Cl Cm Cn 
  Co Cp Cq Cr Cs Ct Cu Cv Cw Cx Cy Cz CA CB CC CD CE CF CG CH CI CJ CK CL CM CN CO CP CQ CR CS CT CU CV CW 
  CX CY CZ Da Db Dc Dd De Df Dg Dh Di Dj Dk Dl Dm Dn Do Dp Dq Dr Ds Dt Du Dv Dw Dx Dy Dz DA DB DC DD DE DF 
  DG DH DI DJ DK DL DM DN DO DP DQ DR DS DT DU DV DW DX DY DZ Ea Eb Ec Ed Ee Ef Eg Eh Ei Ej Ek El Em En Eo 
  Ep Eq Er Es Et Eu Ev Ew Ex Ey Ez EA EB EC ED EE EF EG EH EI EJ EK EL EM EN EO EP EQ ER ES ET EU EV EW EX 
  EY EZ Fa Fb Fc Fd Fe Ff Fg Fh Fi Fj Fk Fl Fm Fn Fo Fp Fq Fr Fs Ft Fu Fv Fw Fx Fy Fz FA FB FC FD FE FF FG 
  FH FI FJ FK FL FM FN FO FP FQ FR FS FT FU FV FW FX FY FZ Ga Gb Gc Gd Ge Gf Gg Gh Gi Gj Gk Gl Gm Gn Go Gp 
  Gq Gr Gs Gt Gu Gv Gw Gx Gy Gz GA GB GC GD GE GF GG GH GI GJ GK GL GM GN GO GP GQ GR GS GT GU GV GW GX GY 
  GZ Ha Hb Hc Hd He Hf Hg Hh Hi Hj Hk Hl Hm Hn Ho Hp Hq Hr Hs Ht Hu Hv Hw Hx Hy Hz HA HB HC HD HE HF HG HH 
  HI HJ HK HL HM HN HO HP HQ HR HS HT HU HV HW HX HY HZ Ia Ib Ic Id Ie If Ig Ih Ii Ij Ik Il Im In Io Ip Iq 
  Ir Is It Iu Iv Iw Ix Iy Iz IA IB IC ID IE IF IG IH II IJ IK IL IM IN IO IP IQ IR IS IT IU IV IW IX IY IZ 
  Ja Jb Jc Jd Je Jf Jg Jh Ji Jj Jk Jl Jm Jn Jo Jp Jq Jr Js Jt Ju Jv Jw Jx Jy Jz JA JB JC JD JE JF JG JH JI 
  JJ JK JL JM JN JO JP JQ JR JS JT JU JV JW JX JY JZ Ka Kb Kc Kd Ke Kf Kg Kh Ki Kj Kk Kl Km Kn Ko Kp Kq Kr 
  Ks Kt Ku Kv Kw Kx Ky Kz KA KB KC KD KE KF KG KH KI KJ KK KL KM KN KO KP KQ KR KS KT KU KV KW KX KY KZ La 
  Lb Lc Ld Le Lf Lg Lh Li Lj Lk Ll Lm Ln Lo Lp Lq Lr Ls Lt Lu Lv Lw Lx Ly Lz LA LB LC LD LE LF LG LH LI LJ 
  LK LL LM LN LO LP LQ LR LS LT LU LV LW LX LY LZ Ma Mb Mc Md Me Mf Mg Mh Mi Mj Mk Ml Mm Mn Mo Mp Mq Mr Ms 
  Mt Mu Mv Mw Mx My Mz MA MB MC MD ME MF MG MH MI MJ MK ML MM MN MO MP MQ MR MS MT MU MV MW MX MY MZ Na Nb 
  Nc Nd Ne Nf Ng Nh Ni Nj Nk Nl Nm Nn No Np Nq Nr Ns Nt Nu Nv Nw Nx Ny Nz NA NB NC ND NE NF NG NH NI NJ NK 
  NL NM NN NO NP NQ NR NS NT NU NV NW NX NY NZ Oa Ob Oc Od Oe Of Og Oh Oi Oj Ok Ol Om On Oo Op Oq Or Os Ot 
  Ou Ov Ow Ox Oy Oz OA OB OC OD OE OF OG OH OI OJ OK OL OM ON OO OP OQ OR OS OT OU OV OW OX OY OZ Pa Pb Pc 
  Pd Pe Pf Pg Ph Pi Pj Pk Pl Pm Pn Po Pp Pq Pr Ps Pt Pu Pv Pw Px Py Pz PA PB PC PD PE PF PG PH PI PJ PK PL 
  PM PN PO PP PQ PR PS PT PU PV PW PX PY PZ Qa Qb Qc Qd Qe Qf Qg Qh Qi Qj Qk Ql Qm Qn Qo Qp Qq Qr Qs Qt Qu 
  Qv Qw Qx Qy Qz QA QB QC QD QE QF QG QH QI QJ QK QL QM QN QO QP QQ QR QS QT QU QV QW QX QY QZ Ra Rb Rc Rd 
  Re Rf Rg Rh Ri Rj Rk Rl Rm Rn Ro Rp Rq Rr Rs Rt Ru Rv Rw Rx Ry Rz RA RB RC RD RE RF RG RH RI RJ RK RL RM 
  RN RO RP RQ RR RS RT RU RV RW RX RY RZ Sa Sb Sc Sd Se Sf Sg Sh Si Sj Sk Sl Sm Sn So Sp Sq Sr Ss St Su Sv 
  Sw Sx Sy Sz SA SB SC SD SE SF SG SH SI SJ SK SL SM SN SO SP SQ SR SS ST SU SV SW SX SY SZ Ta Tb Tc Td Te 
  Tf Tg Th Ti Tj Tk Tl Tm Tn To Tp Tq Tr Ts Tt Tu Tv Tw Tx Ty Tz TA TB TC TD TE TF TG TH TI TJ TK TL TM TN 
  TO TP TQ TR TS TT TU TV TW TX TY TZ Ua Ub Uc Ud Ue Uf Ug Uh Ui Uj Uk Ul Um Un Uo Up Uq Ur Us Ut Uu Uv Uw 
  Ux Uy Uz UA UB UC UD UE UF UG UH UI UJ UK UL UM UN UO UP UQ UR US UT UU UV UW UX UY UZ Va Vb Vc Vd Ve Vf 
  Vg Vh Vi Vj Vk Vl Vm Vn Vo Vp Vq Vr Vs Vt Vu Vv Vw Vx Vy Vz VA VB VC VD VE VF VG VH VI VJ VK VL VM VN VO 
  VP VQ VR VS VT VU VV VW VX VY VZ Wa Wb Wc Wd We Wf Wg Wh Wi Wj Wk Wl Wm Wn Wo Wp Wq Wr Ws Wt Wu Wv Ww Wx 
  Wy Wz WA WB WC WD WE WF WG WH WI WJ WK WL WM WN WO WP WQ WR WS WT WU WV WW WX WY WZ Xa Xb Xc Xd Xe Xf Xg 
  Xh Xi Xj Xk Xl Xm Xn Xo Xp Xq Xr Xs Xt Xu Xv Xw Xx Xy Xz XA XB XC XD XE XF XG XH XI XJ XK XL XM XN XO XP 
  XQ XR XS XT XU XV XW XX XY XZ Ya Yb Yc Yd Ye Yf Yg Yh Yi Yj Yk Yl Ym Yn Yo Yp Yq Yr Ys Yt Yu Yv Yw Yx Yy 
  Yz YA YB YC YD YE YF YG YH YI YJ YK YL YM YN YO YP YQ YR YS YT YU YV YW YX YY YZ Za Zb Zc Zd Ze Zf Zg Zh 
  Zi Zj Zk Zl Zm Zn Zo Zp Zq Zr Zs Zt Zu Zv Zw Zx Zy Zz ZA ZB ZC ZD ZE ZF ZG ZH ZI ZJ ZK ZL ZM ZN ZO ZP ZQ 
  ZR ZS ZT ZU ZV ZW ZX ZY ZZ aaa aab aac aad aae aaf aag aah aai aaj aak aal aam aan aao aap aaq aar aas 
  aat aau aav aaw aax aay aaz aaA aaB aaC aaD aaE aaF aaG aaH aaI aaJ aaK aaL aaM aaN aaO aaP aaQ aaR aaS 
  aaT aaU aaV aaW aaX aaY aaZ aba abb abc abd abe abf abg abh abi abj abk abl abm abn abo abp abq abr abs 
  abt abu abv abw abx aby abz abA abB abC abD abE abF abG abH abI abJ abK abL abM abN abO abP abQ abR abS 
  abT abU abV abW abX abY abZ aca acb acc acd ace acf acg ach aci acj ack acl acm acn aco acp acq acr acs 
  act acu acv acw acx acy acz acA acB acC acD acE acF acG acH acI acJ acK acL acM acN acO acP acQ acR acS 
  acT acU acV acW acX acY acZ ada adb adc add ade adf adg adh adi adj adk adl adm adn ado adp adq adr ads 
  adt adu adv adw adx ady adz adA adB adC adD adE adF adG adH adI adJ adK adL adM adN adO adP adQ adR adS 
  adT adU adV adW adX adY adZ aea aeb aec aed aee aef aeg aeh aei aej aek ael aem aen aeo aep aeq aer aes 
  aet aeu aev aew aex aey aez aeA aeB aeC aeD aeE aeF aeG aeH aeI aeJ aeK aeL aeM aeN aeO aeP aeQ aeR aeS 
  aeT aeU aeV aeW aeX aeY aeZ afa afb afc afd afe aff afg afh afi afj afk afl afm afn afo afp afq afr afs 
  aft afu afv afw afx afy afz afA afB afC afD afE afF afG afH afI afJ afK afL afM afN afO afP afQ afR afS 
  afT afU afV afW afX afY afZ aga agb agc agd age agf agg agh agi agj agk agl agm agn ago agp agq agr ags 
  agt agu agv agw agx agy agz agA agB agC agD agE agF agG agH agI agJ agK agL agM agN agO agP agQ agR agS 
  agT agU agV agW agX agY agZ aha ahb ahc ahd ahe ahf ahg ahh ahi ahj ahk ahl ahm ahn aho ahp ahq ahr ahs 
  aht ahu ahv ahw ahx ahy ahz ahA ahB ahC ahD ahE ahF ahG ahH ahI ahJ ahK ahL ahM ahN ahO ahP ahQ ahR ahS 
  ahT ahU ahV ahW ahX ahY ahZ aia aib aic aid aie aif aig aih aii aij aik ail aim ain aio aip aiq air ais 
  ait aiu aiv aiw aix aiy aiz aiA aiB aiC aiD aiE aiF aiG aiH aiI aiJ aiK aiL aiM aiN aiO aiP aiQ aiR aiS 
  aiT aiU aiV aiW aiX aiY aiZ aja ajb ajc ajd aje ajf ajg ajh aji ajj ajk ajl ajm ajn ajo ajp ajq ajr ajs 
  ajt aju ajv ajw ajx ajy ajz ajA ajB ajC ajD ajE ajF ajG ajH ajI ajJ ajK ajL ajM ajN ajO ajP ajQ ajR ajS 
  ajT ajU ajV ajW ajX ajY ajZ aka akb akc akd ake akf akg akh aki akj akk akl akm akn ako akp akq akr aks 
  akt aku akv akw akx aky akz akA akB akC akD akE akF akG akH akI akJ akK akL akM akN akO akP akQ akR akS 
  akT akU akV akW akX akY akZ ala alb alc ald ale alf alg alh ali alj alk all alm aln alo alp alq alr als 
  alt alu alv alw alx aly alz alA alB alC alD alE alF alG alH alI alJ alK alL alM alN alO alP alQ alR alS 
  alT alU alV alW alX alY alZ ama amb amc amd ame amf amg amh ami amj amk aml amm amn amo amp amq amr ams 
  amt amu amv amw amx amy amz amA amB amC amD amE amF amG amH amI amJ amK amL amM amN amO amP amQ amR amS 
  amT amU amV amW amX amY amZ ana anb anc and ane anf ang anh ani anj ank anl anm ann ano anp anq anr ans 
  ant anu anv anw anx any anz anA anB anC anD anE anF anG anH anI anJ anK anL anM anN anO anP anQ anR anS 
  anT anU anV anW anX anY anZ aoa aob aoc aod aoe aof aog aoh aoi aoj aok aol aom aon aoo aop aoq aor aos 
  aot aou aov aow aox aoy aoz aoA aoB aoC aoD aoE aoF aoG aoH aoI aoJ aoK aoL aoM aoN aoO aoP aoQ aoR aoS 
  aoT aoU aoV aoW aoX aoY aoZ apa apb apc apd ape apf apg aph api apj apk apl apm apn apo app apq apr aps 
  apt apu apv apw apx apy apz apA apB apC apD apE apF apG apH apI apJ apK apL apM apN apO apP apQ apR apS 
  apT apU apV apW apX apY apZ aqa aqb aqc aqd aqe aqf aqg aqh aqi aqj aqk aql aqm aqn aqo aqp aqq aqr aqs 
  aqt aqu aqv aqw aqx aqy aqz aqA aqB aqC aqD aqE aqF aqG aqH aqI aqJ aqK aqL aqM aqN aqO aqP aqQ aqR aqS 
  aqT aqU aqV aqW aqX aqY aqZ ara arb arc ard are arf arg arh ari arj ark arl arm arn aro arp arq arr ars 
  art aru arv arw arx ary arz arA arB arC arD arE arF arG arH arI arJ arK arL arM arN arO arP arQ arR arS 
  arT arU arV arW arX arY arZ asa asb asc asd ase asf asg ash asi asj ask asl asm asn aso asp asq asr ass 
  ast asu asv asw asx asy asz asA asB asC asD asE asF asG asH asI asJ asK asL asM asN asO asP asQ asR asS 
)
assert_eq("excel enumerator is correct",
  lhs: token_map_sequence.first(expected_excel_sequence.length),
  rhs: expected_excel_sequence.first(expected_excel_sequence.length)
)
