pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
nn,𝘬,𝘷="𝘷0.2.1",0,0no={items="main",item_use="items",skills="main",skill_use="skills",status="main"}nt={r={1,0},l={-1,0},u={0,-1},d={0,1}}eb=split"str,dex,con,mag"function ni()𝘢(60)_update=nd _draw=na end function e_()x=1en={"new game","continue"}𝘢(30)_update=nl _draw=nr end function nf()x=1𝘢(30)_update=n1 _draw=nu end function ns()eo={}nh()nc()n0()n2()e9()n4()ev()n3()ng()nm()n5()𝘢(30)_update=ex _draw=eq end function nm()g,𝘣={},{}n("136,3,10,elder",i"elder_bread|oh goddess, preserve us in this, our darkest hour.",i("gate_won|you held the gate...i never doubted the light would prevail.;take this. dwarven bread, the last from our stores. may it aid you in beating back the darkness.|elder_bread",function()ez"1,3"end),i"|in our most dire need, where are the gnomes, the wild men, and the wizards of the spiral;tower? will they stand by & watch us burn?! or...are they already dead?")n("134,11,1",i"chest_guardian|my dad looks more relaxed. you checked what was there, right? what was it?;hero:it was nothing. just some trees hitting the wall.",i"|my dad said he heard something by this side of the wall. he looks worried...i'm scared.")n("133,7,3",i"gate_won|what were they yelling about at the gate?;hero:there were some arguments but things have calmed for now.;people should be more considerate of others.",i"|what are those at the gate yelling about? what's going on?")n("132,6,8",ej(4,"my grandma said you shouldn't show monsters fear. it only makes them stronger.;i'm still scared though...;hero:you don't have to be afraid. i won't let them inside these walls. the light will prevail.;but...aren't you scared too?;hero:of course. but sometimes we have to fight what is in front of us, even if we're scared.;hero:because the cost of not doing so is too high. stay strong. the light will win this day."),i"gate_won|i hope when i'm older i can defeat monsters like you, mister.",i"|i'm staying strong, mister.")n("135,7,8",i"gate_won|they were much less cute when they were attacking...",i"|the little blue ones look kind of cute.;are they really monsters?")n("128,12,8",i"gate_won|good old fashioned skill of arms works too! thank you, knight.",i"|i don't care about goddesses, gods, light, or darkness. but when a bunch of monsters,;ogres, & lizard folk turn up with weapons, well... i'm open to divine intervention.")n("129,9,2",i"gate_won|thank the goddess we live another day!",i"|how can the goddess of light let this happen? has the light truly faded?;should we accept our fate? is this the end?")n("130,11,10",i"gate_won|what a relief. i thought surely this was the end...",i"|i've made my peace. whatever comes next, be it darkness or light, i accept it.")n("131,9,10",i"gate_won|i'm going to go find my spell book and study for the next wave...",i"|it's been years since i've used magic. i wish i studied more at the spiral tower.")n("141,13,3",i"guard2|...",i"chest_guardian and !guard2|i heard you fighting with it, could it have...?;hero:yes, it could have broken through. i fear there are many more where it came from. ready yourself for what is to come.|guard2",i"|i know it's just beyond this wall. will it climb or...is it strong enough to bust through?")n("140,7,13,gl",i"gate_won|thank you for letting us catch our breath. we'll do our best to hold back any others.",i"|this is bad. we simply don't have the numbers to hold this many back!")n("138,9,13,gr",i"guard|i wish you a safe return...",i"gate_won and !guard|thank you, this town is in your debt. without you, we would have been overrun.;hero:rest and ready for the waves to come.;there will be more?!;hero:very likely. i'll go forth to face them head on. should i fall, it will be up to you.;...|guard",i"|we are supposed to deal with bandits & the occasional monster. but this...;this is a small army... what if it's only the vanguard?")n("169,15,2,tag:chest_guardian",i("!chest_guardian||chest_guardian",function()𝘤(n8)end))for e in all(split("152,8,14,tag:gate_scene;162,7,15,tag:gate_scene;152,8,15,tag:gate_scene;162,9,15,tag:gate_scene;166,3,14,tag:gate_scene;159,2,15,tag:gate_scene;166,12,14,tag:gate_scene;159,13,15,tag:gate_scene",";"))do n(e)end end function e9()l=1e𝘷=split([[	1,dwarven bread,quick:heal 3hp/3 turns,full:heal 6hp+3 def/3 turns,3,4,0,6,5,4;
	2,kobold's bane,quick:cure burned,full:quick+3 atk/3 turns,0,0,1,0,6,1;
	3,rogue's folly,quick:cure fouled,full:quick+3 spd/3 turns,0,0,2,0,7,2;
	4,weak health potion,quick:heal 5hp,full:heal 12hp,5,0,0,12,0,0,0;
	5,whitewood tincture,quick:+3 mag/3 turns,full:+3 to stats/3 turns,0,8,0,0,9,0]],";")end function ev()m=1n6=e𝘢("1,sword of light  ,one enemy,   holy damage,4,0,e;2,healing light   ,self,restores hp to full,6,1,s;3,shield of light ,self,negate all damage/1 turn,2,0,s;4,flash of light  ,all enemies,   holy damage + 50% stun,3,0,a;5,the last light  ,all enemies,release remaining light,60,0,a","name,d1,d2,mp,menu,tgt")end function n3()nw=split([[	1,lv: ;
	2,hp: ;
	3,mp: ;
	4,xp: ;
	5,status: ;
	6, ;
	7, ;
	8,=equipment=;
	9,iron sword : +;
	10,iron shield: +]],";")n7=split([[	11,  str: ;
	12,  dex: ;
	13,  con: ;
	14,  mag: ;
	15,  atk: ;
	16,  def: ;
	17,  spd: ;
	18,  eva: ;
	19,m.atk: ;
	20,m.def:	]],";")end function n2()ny=split([[	1,burned,0,-1,5,-3;
	2,fouled,0,-2,0,0;
	3,afraid,10,-2,0,0;
	4,full,0,3,0,0;
	5,sturdy,0,6,6,3;
	6,strong,5,3,0,0;
	7,swift,7,3,0,0;
	8,smart,4,3,0,0;
	9,super,10,3,0,0;
	10,safe,0,0,0,0;
	11,stun,0,0,0,0]],";")end function nk()s.temp_stats=split"0,0,0,0,0,0,0,0,0"end function n(e,...)local n,o,t,e=unpack(split(e))local n={sprite=n,x=o,y=t,dialogue={...}}if(e)if(sub(e,1,4)=="tag:")n.tag=sub(e,5)else 𝘣[e]=n
add(g,n)end function ej(e,n,o)return i("!t"..e.."|"..n.."|t"..e,o)end function e𝘢(n,e)local e,t={},split(e)for n in all(split(n,";"))do local n,o=split(n),{}for e,t in inext,t do o[t]=n[e+1]end e[n[1]]=o end return e end _init=ni function nd()if(btnp(4)or 𝘥())e_()
end function nl()if 𝘷==2do if np(#en)do if(x==1)nb()
if(x==2)nf()
end end end function n1()if(𝘥())if(btnp(4))e_()
end function ex()if 𝘥()do if not e𝘣 do n_()if f do n9()elseif h.active do nv()elseif w do nx()else nq()if(not et)if(btnp(5))w,p="main",1else nz()
nj()end elseif btnp(5)do extcmd"reset"end end end function nx()local e=w if 𝘦 do if(btnp(4))𝘦=nil
return end if btnp(5)do w=no[e]elseif e=="main"do p=o(p,4,1,0)if(btnp(4))if p==1do e9()w="items"elseif p==2do ev()w="skills"elseif p==3do w="status"end
elseif e=="items"do local e=#u if(e>0)l=o(l,e,3,2)if(btnp(4))w,d="item_use",1
elseif e=="skills"do m=o(m,#a,3,2)if(btnp(4))w,d="skill_use",1
elseif e=="item_use"or e=="skill_use"do local e=e=="item_use"d=o(d,2,3,2)if btnp(4)do w=e and"items"or"skills"if d==1do if e do local e=e𝘤()if(e)𝘦="\n     "..e else e𝘥(false)
elseif n𝘷()do n𝘢()end end end end end function e𝘤()if(u[l][1]==4and s.hp==s.maxhp)return"your health is full"
end function n𝘷()local n,e=a[m]if n.menu<1do e="\n   skill can't be used now"elseif n.mp>s.mp or s.mp==0do e="\n    your mana is too low"elseif m==2and s.hp==s.maxhp do e="\n     your health is full"end if(e)𝘦=e return false
return true end function nj()e𝘣=q.bbeg_defeated or s.hp<=0end function ei(e)add(eo,cocreate(e))end function n_()for e in all(eo)do if(costatus(e)=="dead")del(eo,e)else assert(coresume(e))
end end function 𝘥()if(𝘬==0)return true else 𝘬-=1return false
end function 𝘢(e)𝘬=e end function np(e)x=o(x,e,3,2)return btnp(4)end function ed(e,n)return(btnp(e)and 1or 0)-(btnp(n)and 1or 0)end function o(e,n,o,t)return(e+ed(o,t)-1)%n+1end function na()cls()c"a mr traveling bard production"end function nr()cls()if(𝘥()and 𝘷<2)𝘷+=1𝘢(60)
if(𝘷>=1)n𝘣(60,28)
if 𝘷==2do for e=1,#en do local n=x==e if(n)spr(98,39,86+e*8)
?en[e],48,88+e*8,n and 7or 6
end?nn,0,120,5
end end function nu()cls()if(𝘥())c"placeholder for save menu"
end function eq()cls()if e𝘣 do n𝘤()else if 𝘬==0do n𝘥()n𝘦()n𝘧()camera()if(h.active)n𝘨()
n𝘩()if(e𝘦)e𝘧(split"yes,no")
if(f)n𝘪()
end end end function n𝘩()local e=w if(not e)return
n𝘫()n𝘬()n𝘭(e𝘨())if(e=="items"or e=="item_use")n𝘮()
if(e=="skills"or e=="skill_use")n𝘯()
if(e=="status")n𝘰()
if(e=="item_use"or e=="skill_use")e𝘧(split"yes,no")
n𝘱()end function n𝘣(e,n)spr(112,e,n)local o=time()*.45%1if o<.7do for o=1,o/.7*3\1+1do if(rnd()>.4)pset(e+6+rnd(3)\1,n-2+rnd(5)\1,6)
end end local o=o<.7and 7or 10line(e+7,n,e+7,n+4,o)c("knights of power: last light",60,o)end function n𝘬()n𝘲,n𝘳=10,7local e,n=split"8,32,60,88",split"30,58,86,118"y(1,14,4,2)rectfill(e[p],6,n[p],12,13)?"items skills status options",n𝘲,n𝘳,7
end function n𝘮()y(5,11,4,44)y(2,14,4,19)if#u>0do rectfill(8,40+l*8,95,46+l*8,13)for n,e in inext,u do?b(e[3]).." "..e[2],10,41+n*8,7
end local e=u[l]?e[4],10,24,7
?e[5],10,32,7
end end function n𝘯()y(5,11,4,44)y(2,14,4,19)rectfill(8,40+m*8,95,46+m*8,13)for n,e in inext,a do?e.name.." "..b(e.mp).."mp",10,41+n*8,7
end local e,n=a[m],ea(m)?e.d1,10,24,7
if(n>0)?n,10,32,9
?e.d2,10,32,7
end function e𝘧(e)y(#e+1,3,94,44)rectfill(98,47+d*8,122,53+d*8,13)?"use?",99,48,7
for e,n in inext,e do?n,99,48+e*8,7
end end function n𝘭(e)z,j=42,92y(3,5,42,94,e)?"lv: "..s.lvl,z+6,j+7,7
?"hp: ",z+6,j+15,7
?b(s.hp),z+22,j+15,e𝘩
?"/",z+30,j+15,7
?s.maxhp,z+34,j+15,el
?"mp: "..b(s.mp).."/"..𝘭,z+6,j+23,7
end function n𝘰()y(12,14,4,19)?s.name,10,24,7
?s.title,10,32,7
er(nw,10,32)er(n7,82,32)?s.lvl,24,40,7
?b(s.hp),24,48,e𝘩
?"/",32,48,7
?s.maxhp,36,48,el
?b(s.mp).."/"..𝘭,24,56,7
?s.xp,24,64,7
if#s.status<1do?"normal",38,72,7
else ef(s.status,1,2,38,72)ef(s.status,3,5,10,80)ef(s.status,6,8,10,88)end?s.sword_score,67,104,7
?s.shield_score,67,112,7
e1=split(n𝘴..",;"..e𝘪..",;"..n𝘵..",;"..n𝘶..",;"..s.atk..",;"..s.def..",;"..s.spd..",;"..s.eva.."%,;"..s.matk..",;"..s.mdef..",",";")local n=s.temp_stats for e=1,10do e1[e]=e1[e]..e𝘫(e<8and n[e]or e==8and n[2]+n[7]or n[e-1])end er(e1,108,32,true)end function e𝘫(e)return e>0and 11or e<0and 8or 7end function n𝘫()el=e𝘫(s.temp_stats[3])e𝘩=s.hp==s.maxhp and el or 7end function er(n,o,t,e)local i=e or false for e=1,#n do if i do local n,i=unpack(split(n[e]))?n,o,t+e*8,i
else local i,n=unpack(split(n[e]))?n,o,t+e*8,7
end end end function n𝘱()if(not 𝘦)return
y(3,14,4,52)?𝘦,8,56,7
if(time()%.5<.25)spr(96,112,72)
end function y(d,r,e,n,f)local o,t,i=unpack(eu[f]or eu[64])o,t,i=o or 64,t or 65,i or 80local a,l=d*8,r*8spr(f or o,e,n)spr(o,e+l,n,1,1,true)spr(o,e,n+a,1,1,false,true)spr(o,e+l,n+a,1,1,true,true)for o=1,r-1do spr(t,e+o*8,n)spr(t,e+o*8,n+a,1,1,false,true)for t=1,d-1do spr(81,e+o*8,n+t*8)end end for o=1,d-1do spr(i,e,n+o*8)spr(i,e+l,n+o*8,1,1,true)end end function n𝘤()camera()c(q.bbeg_defeated and"★ you win! ★"or"game over! :(",64)c("press ❎ to play again",72,5)end function c(e,n,o)?e,64-#e*2,n or 60,o or 7
end function ef(n,o,t,i,d)local e=""for o=o,min(#n,t)do e=e..n[o][1].." "end if(e~="")?e,i,d,7
end function n𝘸(e)while(sub(e,-1)==" ")e=sub(e,1,-2)
return e end function b(e)return(e<10and"0"or"")..e end function ng()s={}s.x,s.y,s.dx,s.dy,s.title,s.lvl,s.mp,s.xp,s.str,s.dex,s.con,s.mag,s.sword_score,s.shield_score=unpack(split"2,2,0,-1,the last light,1,60,0,4,4,4,4,2,2")n𝘹()𝘭=60s.status={}nk()es()a={}n𝘺()𝘮={sw={seq=split"225,227,229,227",hit="0010",fx=split"204,205,206,207"},sh={seq=split"230,230",shk=1},{seq=split"225,226,227,228,229,227",hit="000010",fx=split"204,205,206,207"},{seq=split"227,233,234,235,234,235,233,227"},{seq=split"227,232,227"},{seq=split"225,226",hit="01",fx=split"243,244,245,-245,245,-245"},down={seq=split"227,233,236",keep=1}}u={}n𝘻()end function nb()e,𝘯,𝘰,oe="","",1,"abcdefghijklmnopqrstuvwxyz*"_update=function()𝘰=o(𝘰,27,3,2)𝘯=sub(oe,𝘰,𝘰)if btnp(5)do e=sub(e,1,-2)elseif btnp(4)do if 𝘯=="*"do ns()s.name=e~=""and e or"lance"elseif#e<8do e..=𝘯 end end end _draw=function()cls()spr(112,60,28)?"name your hero:\n"..e..𝘯,30,50,7
?"⬆️⬇️ letter 🅾️ add ❎ del *=done",0,120,5
end end function n𝘹()e𝘬=split"10,30,90,270,810"end function n𝘻()eh=split("1,1;2,8;3,11;4,1;5,2",";")if(eh)for e=1,#eh do local e,n=unpack(split(eh[e]))e𝘭(e,n)end
end function e𝘭(e,n)local e=split(e𝘷[e])local o=e𝘮(u,e[2],2)if(o)u[o][3]+=n else add(e,n,3)add(u,e)
end function e𝘯(e)return unpack(split(ny[e],","))end function e𝘥(n)local e,n=u[l],n and 6or 9local t,n,o=e[n],e[n+1],e[n+2]if(o>0)ec(o,false)
if(n>0)ec(n,true)
s.hp=min(s.hp+t,s.maxhp)e[3]-=1if(e[3]==0)deli(u,l)l=min(l,#u)
end function ec(o,e)local n,t,i,d,a,l=e𝘯(o)local n=e𝘮(s.status,t)if e and n do s.status[n][2]=3elseif e or n do if(e)add(s.status,{t,3,o})else deli(s.status,n)
local e=e and 1or-1e𝘰(i,d*e)e𝘰(a,l*e)end es(true)end function e𝘰(e,o)for n=1,9do if(e==10or e==n)s.temp_stats[n]+=o
end end function e𝘮(e,o,t)for n=1,#e do if(e[n][t or 1]==o)return n end end function e0()if(e𝘬[s.lvl]and s.xp>=e𝘬[s.lvl])s.lvl+=1f={step=1,sel=1}
end function e2()local e,n=f.step+1,s.lvl if(e==2and n~=2and n~=4)e=3
if(e==3and n~=5)e=4
if(e==3)s.mp+=10𝘭+=10a[5].name="the last light+ "a[5].d2="destroy the darkness"𝘱()
if(e==4)f=nil es()e0()else f.step,f.sel=e,1
end function n9()local e=f.step if(e<3)f.sel=o(f.sel,4,3,2)
if btnp(4)do if e==1do local e=eb[f.sel]s[e]+=1e2()elseif e==2do local e=a[f.sel]if(e.mp>1)e.mp-=1e2()
else e2()end end end function n𝘪()local e=f.step rectfill(0,0,127,127,0)rect(2,2,125,125,6)c("level up! lv "..s.lvl,10,10)if e==1do c("raise a stat",24,6)for e=1,4do local n=eb[e]?(f.sel==e and">"or" ")..n.."  "..s[n].." > "..s[n]+1,36,40+e*10,f.sel==e and 7or 6
end elseif e==2do c("reduce a skill's mp cost",24,6)for n=1,4do local e=a[n]local o=e.mp>1and 7or 5?(f.sel==n and">"or" ")..e.name,8,40+n*10,o
?e.mp>1and e.mp.." > "..e.mp-1or"min",96,40+n*10,o
end else?e4"the light within is honed into a sharp blade",8,36,7
?"last light upgraded!",8,56,10
?e4"a residual spark of the goddess' light finds its way to you",8,72,7
?"+10 mp",8,96,12
end c("z: confirm",114,5)end function es(e)local o,t,i,e,d,a,l,n,r,f=e or false,unpack(s.temp_stats)local u=s.maxhp n𝘴=s.str+t e𝘪=s.dex+i n𝘵=s.con+e n𝘶=s.mag+d s.atk=s.str*2+s.sword_score+a s.def=s.con+s.shield_score+l s.spd=s.dex+s.lvl+n s.eva=mid(0,e𝘪*3+n*2,50)s.matk=s.mag*2+s.sword_score+r s.mdef=s.mag+s.shield_score+f s.maxhp=s.con*5+s.lvl*2+e*3if o do local e=s.maxhp-u if(e>0)s.hp+=e
if(s.hp>s.maxhp)s.hp=s.maxhp
return end s.hp=s.maxhp end function n𝘺()a=n6 end function ea(n,e)e=e or s return n==1and e.atk+e.matk*2or n==4and e.matk or 0end function 𝘲(e,n)return e==5and n.mp or a[e].mp end function n𝘢()if(m==2)s.hp=s.maxhp
s.mp-=a[m].mp 𝘱()end function 𝘱()a[5].mp=s.mp end function n𝘧()spr(on(),s.px or s.x*8,s.py or s.y*8,1,1,s.fx and s.dy==0)end function on()local e=s.dy<0and 117or s.dy>0and 115or 113return e+(s.sword and 1or 0)end function e𝘨()return 𝘳[s.mp==0and"d_hero"or"hero"]end function nz()local e,n=ed(1,0),ed(3,2)if(e~=0or n~=0)s.dx,s.dy=e,n if(e~=0)s.fx=e<0
local e,n=s.x+e,s.y+n oo(e,n)if(ot(e,n))s.x,s.y=mid(0,e,127),mid(0,n,63)else sfx(0)
end function oo(e,n)e3,eg=s.x+s.dx,s.y+s.dy local e=em[e+n*128]if(e)𝘧(e)
local e=e5(e3,eg)if(btnp(4)and e)𝘧(e)
if(btnp(4))oi(e3,eg)
local e=𝘴[e3+eg*128]if(btnp(4)and e and not et)𝘤(e)
end function nh()e8=0e𝘱={}poke(24406,128)poke(24407,128)memcpy(32768,8192,4096)reload(36864,8192,4096,"south.p8")e𝘲(10,12)e𝘲(11,12)end function nq()if e8<0do for e=e6,e6+15do for n=𝘵,𝘵+15do local o=mget(e,n)if(fget(o,1))mset(e,n,o~1)
end end e8=15end e8-=1end function e𝘲(e,n)e𝘱[e+n*128]=true end function e5(n,o)for e in all(g)do if(e.x==n and e.y==o)return e
end end function n𝘥()e6=s.x\16*16𝘵=s.y\16*16camera(e6*8,𝘵*8)map(0,0,0,0,128,64)for e in next,e𝘱 do local e,n=e%128,e\128spr(mget(e,n),e*8,n*8,1,1,true)end end function n𝘦()for e in all(g)do spr(e.sprite,e.px or e.x*8,e.py or e.y*8,1,1,e.fx)end end function ot(e,n)return not e5(e,n)and not fget(mget(e,n),0)end function n4()𝘶={}𝘨(15,1,"4,3;5,2")𝘨(19,17,"2,3")𝘨(23,0,"3,3")𝘨(25,0,"2,5")𝘨(17,46,"1;2;3;4;5")end function 𝘨(e,n,o)𝘶[e+n*128]=o end function oi(e,n)local o=e+n*128if(𝘶[o])ez(𝘶[o])𝘶[o]=nil mset(e,n,mget(e,n)+1)
end function ez(e)𝘧{dialogue={i("|found "..od(e).."!")}}end function od(e)local n=""for e in all(split(e,";",false))do local o,e=unpack(split(e))e=e or 1e𝘭(o,e)n..=(n==""and""or", ")..e.." "..split(e𝘷[o])[2]end return n end function nc()oa()q,h,em={},{},{}_(2,4,ej("exit_temple","as you leave this once holy place to face the agents of darkness, you are struck by;a feeling that you will likely never return.;did your goddess feel the same when she stood alone against the dark gods?"))_(25,54,i"|the way forward is blocked... for now.")_(26,54,i"|the way forward is blocked... for now.")_(27,54,i"|the way forward is blocked... for now.")end function _(e,n,...)em[e+n*128]={dialogue={...}}end function i(e,n)local e,o,t=unpack(split(e,"|",false))return{cond=ol(e),pages=split(o,";",false),on_end=of(t,n)}end function oa()𝘳,eu={},{}for e in all(split("def,64,64,65,80;hero,66,92,67,82;d_hero,83;shad,68,77,69,84;ogre,85;necro,70,93,71,86;undead,87,93,71,86;drak,72,78,73,88;mage,89;d_def,74,74,75,90;gnome,91;rogue,76",";"))do local n,e,o,t,i,d=unpack(split(e))𝘳[n]=e eu[e]={o,t,i,d}end end function e𝘳(e)if(not e or e=="")return
local n={}for e in all(split(e,",",false))do local o=sub(e,1,1)=="!"n[o and sub(e,2)or e]=not o end return n end function ol(e)local e=e𝘳(e)if e do return function()for e,n in next,e do if((q[e]or false)~=n)return false
end return true end end end function of(n,e)local n=e𝘳(n)if n or e do return function()for e,n in next,n or{}do q[e]=n end if(e)e()
end end end function 𝘧(n)if(n.x and s.x~=n.x)n.fx=s.x<n.x
for e in all(n.dialogue)do if not e.cond or e.cond()do if not e.pages[1]or e.pages[1]==""do if(e.on_end)e.on_end()
else h={active=true,entry=e,page=1,src=n}end return end end end function nv()if btnp(4)do local e=h if(e.page<#e.entry.pages)e.page+=1else h={}if(e.entry.on_end)e.entry.on_end()
end end function n𝘨()local e,o=h.entry.pages[h.page],64local n=split(e,":",false)[1]if(𝘳[n])o,e=𝘳[n],sub(e,#n+2)
if(n=="hero")o=e𝘨()
h.y=h.y or o1()local n=h.y y(3,15,0,n,o)?e4(e),5,n+5,7
if(time()%.5<.25)spr(96,116,n+20)
end function o1()local e,n for o in all{s,h.src}do if(o.y)local o=(o.py or o.y*8)-𝘵*8e=e or o+8>96n=n or o<32
end return e and not n and 0or 96end function e4(o,n)n=n or 29local t,e="",""for o in all(split(o," ",false))do if(e~=""and#e+#o+1>n)t..=e.."\n"e=o else e..=(e==""and""or" ")..o
end return t..e end function 𝘤(e)et=true ei(function()e()et=false end)end function ou(e,n)ei(function()while(not q[e])yield()
n()end)end function 𝘸(e)for e=1,e do yield()end end function e𝘴(e,o,n)n=n or 1for o in all(split(o))do local o=nt[o]local o,t=o[1],o[2]local i,d=(e.x+o)*8,(e.y+t)*8if(e==s)s.dx,s.dy=o,t
if(o~=0)e.fx=o<0
e.px,e.py=e.px or e.x*8,e.py or e.y*8while(e.px~=i or e.py~=d)e.px+=mid(-n,i-e.px,n)e.py+=mid(-n,d-e.py,n)yield()
e.x+=o e.y+=t end e.px,e.py=nil,nil end function k(e)𝘧{dialogue={i("|"..e)}}e𝘵()end function oj(e)𝘧(e)e𝘵()end function e𝘵()while(h.active)yield()
end function 𝘹(n)local e os(n,function(n)e=n end)repeat yield()until e~=nil while(f)yield()
return e end function oh()d,e𝘦=1,true repeat d=o(d,2,3,2)yield()until btnp(4)e𝘦=nil yield()return d==1end function 𝘺(e,o)for n=1,#e,2do mset(e[n],e[n+1],o)local e=e[n]+e[n+1]*128em[e],𝘴[e]=nil end end function n5()𝘴,ew={},4𝘻,ee=split"3,36,1,38,1,42,3,44,5,44,11,45,11,41,13,43",split"1,34,1,45,10,43,3,54"local e=i("!gate_scene||gate_scene",function()𝘤(oc)end)_(8,14,e)e5(8,14).dialogue={e}for e=1,#𝘻,2do local n,o=𝘻[e],𝘻[e+1]_(n,o,i("!sk"..e.."||sk"..e,function()𝘤(function()e𝘶(n,o)end)end))𝘴[n+o*128]=function()e𝘶(n,o)end end for e=1,#ee,2do local e,n=ee[e],ee[e+1]𝘴[e+n*128]=function()o0(e,n)end end n("175,12,59,boss",e𝘸(176))𝘣.boss.fx=true _(12,60,e𝘸(177))ou("gate_won",function()e𝘴(𝘣.elder,"l,u,u,u,u,u,u,u,u")end)end function oc()s.sword=true k"hero:this ends here."𝘸(20)if 𝘹"slime_x2"do for e in all(g)do if(e.tag=="gate_scene"and e.x==8)del(g,e)
end k"hero:...the light preserves.;ogre:we should return for now."o2()mset(2,14,56)mset(5,15,56)mset(10,14,56)𝘸(20)q.gate_won=true s.sword=false end end function o2()for e in all(g)do if(e.tag=="gate_scene")ei(function()e𝘴(e,"d,d")del(g,e)end)
end 𝘸(24)end function n8()if 𝘹"golem"do 𝘸(20)for e in all(g)do if(e.tag=="chest_guardian")del(g,e)
end end end function e𝘶(e,n)k"necro:grr..."if(𝘹(rnd{"undead","undead_x2"}))𝘺({e,n},15)
end function o0(e,n)k"hero:an unholy energy... perhaps if i use the light i may cleanse its influence."if oh()do if(s.mp<1)k"hero:...i have no light to spare."return
s.mp-=1𝘱()ew-=1𝘺({e,n},16)k"the sigil is cleansed. you gain 3 xp."s.xp+=3e0()end end function e𝘸(e)return i("!boss_scene||boss_scene",function()𝘣.boss.sprite=e 𝘤(o4)end)end function o4()k"hero:i'm sorry master... dark forces have desecrated your remains.;hero:turned your form against the light you served your whole life.;undead:then you know what you must do, my pupil.;hero:i do."s.sword=true local e={}for n=1,(ew+1)\2do add(e,"undead")end add(e,"boss_undead")for n=1,ew\2do add(e,"undead")end e7.knight=e if(𝘹"knight")del(g,𝘣.boss)k"the dark presence in the area is quelled for now."𝘺(𝘻,15)𝘺(ee,16)s.sword=false
end function o3(e,n)s.bx,s.by,s.x,s.y,s.defending,s.safe=s.x,s.y,58,52for o,n in inext,e do n.x,n.y=59+(o-(#e+1)/2)*16,32end r={state="menu",sel=1,message="your turn!",anim_timer=0,hero=s,enemies=e,popups={},on_end=n,en_id=1,xp=0,fx={}}if(rnd(20)>s.spd+8)r.state,r.en_id="enemy",1
_update,_draw=og,om end function n0()o5=e𝘢("slime,slime,152,12,6,2,3,a;undead,undead,156,14,8,3,4,a;l_man,lizardman,159,20,10,3,5,aar;garg,gargoyle,162,18,10,2,5,a;ogre,ogre,166,26,13,4,6,aah;golem,earth golem,169,26,11,3,6,aah;mid_rogue,famous rogue,193,30,12,3,12,aahr;mid_mage,spiral mage,172,45,8,2,12,aahr;mid_ogre,ogre warchief,200,40,14,4,12,aahf,1;boss_undead,undead knight,177,60,11,5,20,aacs,1;boss_necro,necromancer,180,55,9,3,25,aahr;boss_shadow,shadow knight,183,75,14,6,0,aahr;boss_drak,dragon,196,100,15,6,40,hhar;shadow,shadow,211,30,12,3,12,aar","name,sprite,hp,atk,def,xp,ai,cyc")e7={}for e in all(split("slime_x2,slime,slime;undead_x2,undead,undead;l_man_x2,l_man,l_man",";"))do local e=split(e)e7[deli(e,1)]=e end o8={[152]={seq=split"153,154,155",hit="001"},[156]={seq=split"157,158",hit="00100",fx=split"204,205,206,207"},[169]={seq=split"170,171,170,171",hit="1111"},[177]={seq=split"178,179",hit="00100",fx=split"204,205,206,207"}}end function o6(n)local e={}for n,o in next,n do e[n]=o end e.maxhp=n.hp return e end function os(e,o)local n={}for e in all(e7[e]or{e})do add(n,o6(o5[e]))end o3(n,o)end function ow(e)s.x,s.y=s.bx,s.by s.xp+=r.xp e0()𝘱()_update,_draw=ex,eq if(r.on_end)r.on_end(e)
end function og()local n=r local e=n.state n.anim_timer-=1o7()if e=="anim"do v.t-=1n.shake,n.sx=v.u,flr(rnd(3))-1if(v.step)v.step()
if(v.t<=0)n.shake=nil v.done()
elseif e=="menu"do oy()elseif e=="skill"do ok()elseif e=="items"or e=="use"do op()elseif e=="target"do ob()elseif e=="enemy"do o_()elseif e=="win"or e=="lose"do if(n.anim_timer<=0)ow(e=="win")
end end function oy()local e,n=r,r.hero e.sel=o(e.sel,4,3,2)if btnp(4)and e.anim_timer<=0do local o=e.sel==2if e.sel<3do e𝘹("e",function(e)o9(n,e,o)end)elseif e.sel==3do e.state,e.ksel="skill",1else if(#u>0)e.state,l="items",1else e.message="no items"
end end end function ok()local e,n=r,#a e.ksel=o(e.ksel,n,3,2)if(btnp(5))e.state="menu"
if(btnp(4)and e.anim_timer<=0)ov(e.ksel)
end function op()local e=r if e.state=="items"do l=o(l,#u,3,2)if(btnp(5))e.state="menu"
if(btnp(4))e.state,d="use",1
else d=o(d,3,3,2)if(btnp(5))e.state="items"
if btnp(4)do e.state="items"if d<3do local n=e𝘤()if(n)e.message=n else local n,o=s.hp,u[l]e𝘥(d==1)e𝘺(n)e.message,e.anim_timer=o[2].." used",30if(d==2)ey()else e.state="menu"
end end end end function ob()local e=r e.tsel=o(e.tsel,#e.tl,1,0)if(btnp(5))e.state=e.back
if(btnp(4))e.act(e.tl[e.tsel])
end function o_()local n,o=r,r.hero if(n.anim_timer>0)return
if(o.hp<=0)𝘩(o,𝘮.down,nil,function()n.state,n.message,n.anim_timer="lose","you lost...",60end)return
if n.en_id>#n.enemies do o.defending,o.safe=false,false ox(o)n.en_id=1if(o.hp>0)n.state,n.sel,n.message="menu",1,"your turn!"
return end local e=n.enemies[n.en_id]n.en_id+=1if(e.hp<=0)return
if(e.stun)e.stun=false n.message,n.anim_timer=e.name.." is stunned!",30return
local t=split(e.ai,1)e.n=(e.n or 0)+1local t=e.cyc and t[(e.n-1)%#t+1]or rnd(t)if(t=="f"and e.hp>e.maxhp/2)t="a"
if t=="f"do 𝘪(e,-(e.maxhp\4),e.name.." heals!",11)return elseif t=="c"do n.message,n.anim_timer=e.name.." is charging!",30return elseif t=="r"do e.atk+=2n.message,n.anim_timer=e.name.." rallies!",30return end local t,i=ek(e.atk*(t=="s"and 3or t=="h"and 2or 1),o.def),rnd(100)<s.eva if(o.defending)t=max(t\2,1)
if(o.safe or i)t=0
local function d()n.shake=nil 𝘪(o,t,o.safe and"blocked by the light!"or i and e.name.." missed!"or e.name.." hits for "..t.."!",8)n.state="enemy"end local n,i=o8[e.sprite],max(t*3,10)if(n)𝘩(e,n,t>0and{o},function()𝘫(i,t>0and o,d)end)else 𝘫(i,e,d)
end function e𝘹(o,n)local e=r e.act,e.back=n,e.state if o=="e"do e.tl,e.tsel=ep(e.enemies),1if(#e.tl>1)e.state="target"return
n(e.tl[1])else n()end end function o9(e,n,o)local i,t=r,ek(o and e.atk\2+e.shield_score or e.atk,n.def)𝘩(e,o and 𝘮.sh or 𝘮.sw,{n},function()𝘫(10,n,function()i.shake=nil e.defending=o 𝘪(n,t,"you hit for "..t.."!",8)ey()end)end)end function ov(n)local o,e,t=r,r.hero,a[n]if 𝘲(n,e)>e.mp or e.mp==0do o.message="your mana is too low"elseif n==2and e.hp==e.maxhp do o.message="your health is full"else e𝘹(t.tgt,function(e)oq(n,e)end)end end function 𝘩(n,e,a,l)local i,o,t,d=r,0,0,split"0,0,-4,-3,4,3,-3,4"v={t=#e.seq*6,u=e.shk and n,done=function()if(not e.keep)n.frame=nil
l()end,step=function()if(o%6==0)local o=o\6+1n.frame=e.seq[o]if(sub(e.hit or"",o,o)=="1")t+=1for n in all(a or{})do add(i.fx,{x=n.x+d[t*2-1],y=n.y+d[t*2],s=e.fx or split"240,241,242",t=0})end
o+=1end}i.state="anim"end function oq(n,d)local o,e,a=r,r.hero,a[n]local i,l,t=𝘲(n,e),n==5and e.matk*e.mp*(s.lvl==5and 2or 1)or ea(n,e),a.tgt=="a"and ep(o.enemies)or{d}e.mp-=i local function i()o.shake=nil if n==2do 𝘪(e,e.hp-e.maxhp,"you are fully healed!",11)elseif n==3do e.safe=true o.message,o.anim_timer="shield of light up!",30else local e for o in all(t)do e=ek(l,o.mdef or 0,1)𝘪(o,e,"",7)if(n==4and rnd()<.5)o.stun=true
end o.message=n𝘸(a.name)..(#t>1and" hits all!"or" hits for "..e.."!")end ey()end local o=𝘮[n]if not o do 𝘫(20,e,i)elseif n==1do 𝘩(e,o,t,function()𝘫(10,d,i)end)else 𝘩(e,o,t,i)end end function ey()local e=r if(#ep(e.enemies)>0)e.state,e.en_id="enemy",1return
local n=0for e in all(e.enemies)do n+=e.xp end e.state,e.message,e.anim_timer,e.xp="win","you won!\nyou gain "..n.."xp",60,n end function ox(e)local e=s.hp for e in all(s.status)do local d,a,n,o,t,i=e𝘯(e[3])if(n==0)s.hp+=o
if(t==0)s.hp+=i
s.hp=mid(0,s.hp,s.maxhp)e[2]-=1if(e[2]<=0)ec(e[3],false)
end e𝘺(e)end function e𝘺(e)if(s.hp~=e)e𝘻(s.x,s.y-4,abs(s.hp-e),s.hp>e and 11or 8)
end function ek(e,n,o)return max(e+flr(rnd(o or 3))-n,1)end function 𝘪(e,n,o,t)e.hp=mid(0,e.hp-n,e.maxhp)e𝘻(e.x,e.y-4,abs(n),t)r.message=o r.anim_timer=30end function ep(n)local e={}for n in all(n)do if(n.hp>0)add(e,n)
end return e end function 𝘫(e,n,o)v={t=e,u=n,done=o}r.state="anim"end function e𝘻(e,n,o,t)add(r.popups,{x=e+flr(rnd(5))-2,y=n,v=o,c=t,t=30})end function o7()for e in all(r.popups)do e.y-=.5e.t-=1if(e.t<=0)del(r.popups,e)
end for e in all(r.fx)do e.t+=1if(e.t\3>=#e.s)del(r.fx,e)
end end function om()cls()camera()local e,n=r,r.hero local o=e.state=="win"if o or e.state=="lose"do?e.message,44,100,o and 11or 8
else c(e.message,8,7)end for n in all(e.enemies)do if(n.hp>0)spr(n.frame or n.sprite,n.x+(e.shake==n and e.sx or 0),n.y)oz(n.x-3,n.y+10,n.hp,n.maxhp,14,8)if(n.stun)?"zz",n.x,n.y-6,6
end spr(n.frame or 224,s.x+(e.shake==s and e.sx or 0),s.y)?n.name,35,68,7
ne(35,75,n.hp,n.maxhp,11)ne(35,82,n.mp,𝘭,9)if e.state=="target"do local e=e.tl[e.tsel]?"v",e.x+2,e.y-8+flr(sin(time()*2)*2),7
c(e.name,20,7)end if e.state=="menu"do local o=split"sword,shield,skills,items"for n=1,4do?(e.sel==n and">"or" ")..o[n],4,88+n*8,7
end elseif e.state=="skill"do local o,t=a[e.ksel],ea(e.ksel)?o.d1,4,16,6
if(t>0)?t,4,22,9
?o.d2,4,22,6
for o,i in inext,a do local t=n.mp<𝘲(o,n)and 5or 7?(e.ksel==o and">"or" ")..i.name,4,82+o*8,t
?𝘲(o,n).."mp",76,82+o*8,t
end elseif e.state=="items"or e.state=="use"do local n=u[l]?n[4],4,16,6
?n[5],4,22,6
for e,n in inext,u do?(l==e and">"or" ")..b(n[3]).." "..n[2],4,82+e*8,7
end if e.state=="use"do for e,n in inext,split"quick,full,back"do?(d==e and">"or" ")..n,100,82+e*8,7
end end end for e in all(e.fx)do local n=e.s[e.t\3+1]spr(abs(n),e.x,e.y,1,1,n<0)end for e in all(e.popups)do local n=tostr(e.v)?n,e.x-#n*2+1,e.y+1,0
?n,e.x-#n*2,e.y,e.c
end end function ne(e,n,o,t,d)local i=max(0,flr(o/t*40)-1)if(i>0)rectfill(e+1,n+1,e+i,n+3,d)
?o.."/"..t,e+40+2,n,7
end function oz(e,n,t,i,o,d)rectfill(e,n,e+o-1,n+1,5)rectfill(e,n,e+max(1,flr(t/i*o))-1,n+1,d)end
__gfx__
000000004444444433344454335d5dd333333333335ddd53333333336644446666444466a782287a666666666666666622a222a222a262a23331133333333333
000000004ffffff133444544335ddd5333333333335d5dd33bbbbbb36647746666cccc66799aa997666666666666566622a222a222a767a23317713333333333
007007004f1ff1f13444544433dd5d5355d555d55d5d5d53bebbbbeb6686686666cccc6689aaaa9866566666666556662a222a2224266624316dd61333333333
000770004f1f1ff14f454445335d5d53dddddddddddddd53b2bbbb2b6688886666cccc662aa77aa266666566665555662a222a222a44444231d55d1333300333
000770004ffffff1f4f4f454335d5dd3555d555d555d55d3bbbbebbb6688886666cccc662aa77aa2466666646651156622a222a222a222a231dddd1333000033
00700700411111113f5f4f44335ddd53ddddddddddddddd3bbeb2bb16688886666c66c6689aaaa98444444446654456622a222a222a222a23444443334000433
0000000033341333f4f5f44333dd5d535d555d555d555d53bb2bbb116688886666477466799aa99744444444665555662a222a222a222a223344443333444433
00000000333410033f5f4433335d5d53ddddddddddddddd33bbb11136644446666444466a782287a44444444665665662a222a222a222a223334433333344333
33333333333333333311133333c33333333333e33333353333bbbb3366656566665565666666666666666666333555155ddd5ddd335ddd534444144233244423
3333333333b33333315551333cac333333333b3b335535333bbbbbb36657756666222266666666666666666633555155ddddddddd3dddddd4444244443444444
333333333b3b33331556551333c33c333e333333333555133bbbbb13663d776666d22266666266666656666635551555ddd5ddd5d3ddd5dd4442244443444244
33333333333333b3156555133333cac3b3b33333553553133bbbb113663377666672226666656666666665665f515551551dddddd33333dd2244424443333344
3333333333333b3b1555552133333c333333e3333555511333b111336633d766667d22666665566656666665f5f5f515d1dddddd5ddd33334444442224443333
33333333333b333312555521333c3333333b3b33333553333334233366333d666677d26666555666555555553f1f5f55dddddddd3ddd33334444442434443333
3333333333b3b3333155221333cac333333333e3333553333334233366333366665775666555556655555555f5f1f553ddddddd13ddd3dd34444441434443443
333333333333333333333333333c333333333b3b3355553333442233665655666656566666666666555555553f1f5533dd5ddd5133331dd34442221233331443
11111111111c1111111111111111111111113333333311116666666666646666656665667777777776777677ddddddddd5ddd5dd44a4a444444111c144414441
111111111cc1c111115551111111111111111133331111116666666666666666555555557f77777766666666dddddddd55555555449494a44442cc1c44424442
11111111111111c1155655111111111111111113311111116656666666666656666566657777777777767776dd5dddddddd5ddd5455a55a44442f11144424442
111111111111cc1c15655511111ccc111111111331111111666665666666666655555555777777f766666666ddddd5dd55555555444a44a44442f11144424442
1111111111111111155555211cc111c111111111111111116666666666666666656665667777777776777677ddddddddd5ddd5dd444944944442111144424442
1111111111cc1111c255552c1111111111111111111111116666666666566696555555557777777766666666dddddddd55555555455555544442f1c144424442
11111111cc11c1111c5522c1111111111111111111111111666656666666666666656665777f777777767776dddd5dddddd5ddd54444444444414c1c44414441
111111111111111111cccc111111111111111111111111116666666666666666555555557777777766666666dddddddd55555555333333332221211122212221
333233233bb2bb2b33333933339333334a4444a44a4aa4a433333333333773333333333335553333999999999999999999999999995559999995959933244423
33232332bb2b2bb233933993399333934a4444a41519915133377333633773373353333335553333999999999949999949999949954445999995559943444444
32333332b2b333b239939a9339a939a34a4444a41111111133377333366667733335333333553333999999999999994999999499544644599953b35943444244
32333323b2b3bb2b99a9aaa93aa939a94a4444a411111111336663333337333333333333333553339999999994449999999999995464445955beb3b543333344
332323233b2b2b2b9aaaaaa99aaaa7a9aaa99aaa15111151360707333477743333300033333000339999999999444999994994495444442595b3beb524443333
332332333b2bb2b39a7a77a99a7a77a9191991914a4444a4346104733401043333000003330000039999999999999499999994495244442555b3b3b534443333
3332333333b2bb339aa777a99a7777a94a4444a44a4444a4334444333344443333333333333333339999999999499999949999999544225995b3e3b534443443
33332333333b2b339a7777a99a7777a94a4444a44a4444a4333443333334433333333333333333339999999999999949999999999999999995b3b3b533331443
0005555555555555dd6665555555555570707555555555556666655555555555440445555555555500055555555555550aa55555000555550005555500000000
0557777777777777dd6669999999999977777222222222226b6b6bbbbbbbbbbb4202488888888888055ddddddddddddd0af77777055222220558888800000000
0575555555555555d11165555555555572727555555555556666655555555555288825555555555505d555555555555546655555052555550585555500000000
5755111111111111dd166111111111115777111111111111566611111111111189898111111111115d5511111111111164461111525511115855111100000000
57511111111111115dd611111111111152511111111111115b5111111111111128882111111111115d5111111111111164461111525111115851111100000000
5751111111111111595111111111111152511111111111115b5111111111111152821111111111115d5111111111111157511111525111115851111100000000
5751111111111111595111111111111152511111111111115b5111111111111158881111111111115d5111111111111157511111525111115851111100000000
5751111111111111595111111111111152511111111111115b5111111111111152511111111111115d5111111111111157511111525111115851111100000000
575111111111111159511111dd66655552511111222255555b511111dd66655558511111022555555d5111110355555500055555000555550000000000000000
575111111111111159511111dd66677752511111f22f77775b511111dd666bbb5851111102f777775d5111110337777705599999055bbbbb0000000000000000
575111111111111159511111d111655552511111ffff55555b511111dbbb65555851111122f555555d511111333355550595555505b555550000000000000000
575111111111111159511111dd166111525111114ff4f1115b511111ddb6611158511111222211115d5111114ff41111595511115b5511110000000000000000
5751111111111111595111115dd6111152511111422421115b5111115dd6111158511111228811115d51111154411111595111115b5111110000000000000000
57511111111111115951111157511111525111114444f1115b5111115b51111158511111575111115d51111157511111595111115b5111110000000000000000
5751111111111111595111115751111152511111575111115b5111115b51111158511111575111115d51111157511111595111115b5111110000000000000000
5751111111111111595111115751111152511111575111115b5111115b51111158511111575111115d51111157511111595111115b5111110000000000000000
00000000000dd0000000700088888888888888882222222233333333333333333333333333333333333333333333333399999999999999990000000000000000
0000000000077000000077008ddd9dd88bbbbbb82d1dddd23dddd7d33dddddd33dddddd33dd77dd33d7777d33ddbbdd39dd99dd999dddd990000000000000000
0000000000077000000077708dd999d88dbdbbb821dd1d123ddd47733dd77dd337d77d7337d77d733d7777d33dbbbbd39d9aa9d99d9dd9d90000000000000000
0000000000077000d77777778dd9a9d88dbddbd8211181823d4444d337d77d7337d77d733d7777d33dd77dd33bddddb399a77a999dd99dd90000000000000000
7777777777777777d77777778d9a79d88ddddbd82111111234444dd33d7777d33d7777d33dd77dd33d7777d33ddbbdd399a77a999dd99dd90000000000000000
07777770077777700000777089a77a988dddddd821d1d1d234444dd33d7777d33dd77dd33d7dd7d337d77d733dbbbbd39d9aa9d99d9dd9d90000000000000000
00777700007777000000770089777a988dbddbd821d1d1d23444ddd3377dd7733d7dd7d33d77d7733d7dd7d33bddddb39dd99dd999dddd990000000000000000
00077000000770000000700088888888888888882222222233333333333333333333333333333333333333333333333399999999999999990000000000000000
0dd666000dd666000dd666000dd666000dd666000dd666000dd666000707070007070700070707000707070007070700ddbbbb333dddbb3d4466664444666644
0dd666070dd666000dd666070dd666000dd666070dd666000dd6660707777706077777000777770007777700077777063bdddbddddbbddb346555d6446555d64
0d1116070dd111000dd111070d1116000d1116070dd666000dd6660707777706077777000777770007777700077777063bbbbd133bbbdbdd46cccc644655d564
0dd166070ddd16000ddd16070dd166000dd166070dd666000dd666070727270607727200072727000777770007777706ddbbdd133bddb1d346cccc6446cccc64
0add69070add69000add690709dd690009dd69070a9a9a000a9a9a07017771060177770001777100021212000212120633dd11dd33db11334d6666544d666654
07a9996107a9990007a99961099999000999996109a7a90009a7a9610111115201111100011111000112110001121152333dd33ddd34ddd34dd5d5144dd5d514
0a9dd6010a9dd6000a9dd6010ddd66000ddd6601099a9900099a990101155502011555000555550001121100011211023dd42dd333dd233d44dd554444dd5544
99d0d00099d0d00099d0d00099d9699099d9699099999990999999901150500011505000115151101111111011111110d34422333d44223344d5d14444d5d144
0004f0000001100000044000000aa000000000000000000000000000000000000003f004000660000008600600086006000d6006000d60060000000000000000
000ff000000440000004f00000aaf000000000000000000000000000000000000003f7040066f000008df006008d4006000df006000d40060003000000030000
00222000009990000044f000000af000000000000000000000322000000aa000003330040006f000008550060085500600111005001110050003300000033000
002222f0009999400042e0000001c00000099000000110000232200000aaaa000033333f00053000005566f500556645001166f5001166450033330000333300
0022f000009940000002200000011000000ff00000044000022440000a0ff0a000033f0400055000055d6005055d6005011d6005011d6005004ff400002ff200
0055500000ddd00000022f0000011f0000fccf00004aa4000043340000feef000003300400055f0005ddd00005ddd00001ddd00501ddd0050f3443f00f3ff3f0
0050500000d0d0000022ee000011cc0000055000000550000002200000022000003333040055330005d0d00005d0d00001d0d00501d0d0050003300000233000
0050500000d0d0000222eee00111ccc000050500000505000002020000020200033333300555333050d0d00050d0d00010d0d00010d0d0000004040000040400
00000000000aa00000011000000000000000000000033000000520000000000000000000000c0000000c00007000000000077000000770060007700000011000
00030000000af0000001f000000dd000000000000003330000052200000000000000000000d7c00000d7c0007000700000077006000770060007700000011100
0003300000ddd0000011f00000dffd00000ff000004340000055500000000000000c00000d1c1c000d1c1c000000707000666006006660060066600000414000
0033330000ddddf00015d0000ddffd0000dffd0000343430005554200003300000d7c0000ccccc000ccccc000700007006070706060707750607070000141411
009ff90000ddf000000550000d555500055dd5000044430000554200000333000d7ccc000ccccc000dcccd00070c007060777075607770056077707000444106
0f3333f00055500000055f0005ff5ff005ffdff00355500002544000000440000c1c1c000dcccd000000000000d7c00000070005000700000666655001555600
00033000005050000055dd0005555500055dd5003350500022544400003550000dcccd0000000000000000000d7cccc000707000007070000070700011505000
00040400005050000555ddd00050500000505000303030002554444003030300000000000000000000000000cc1c1dcc00707000007070000070700010101000
0010000000000000d000000d0000000000000000066666600002220000022200000222000005440000054400000440000022000000220040002200c00dd66600
016101600000110050d00d05000000000066660060000006000f2f00000f2f00000f2f00500445055004450000054500002f0000002f00f0002f00f00dd66607
011401000004111055055055000660000600006060066006022444ff022444ff022444ff4454445444544450000445000222004002220840022208400ddbbb07
0414140000114140555555550060060006066060606006060244444f0244444f0244444f444454444555544054045550022288f002228040022280400dddb607
0044400001444010550550550060060006066060606006060f04440fff04440f0f0444ff4404440505554400544454500228f0400228f0400228f04005dd6507
01555000111556105005500500066000060000606006600600055500ff055500000555ff55054504055545000005450002880040028800000288000005555561
1150500016105000d055550d000000000066660060000006000f0f00000f0f00000f0f00000404000004040000040400028880400288800002888000055dd601
101010000010100000500500000000000000000006666660000f0f00000f0f00000f0f0000050500000505000005050022888800228888002288880055d0d000
0dd666000dd666000dd6660b0dd66600b00110b40001100400b11004070707000707070607070700000000000000000000000000000000002222222200000000
0dd6660b0dd6660b0dd6660b0dd66600000170040b01700400017004077777060777770607777700070707000707070007070700070707002222222200000000
0ddbbb0b0dbbb60b0dbbb60b0dbbb60000111004001110040011100b077777060777770607777700077777000777770007777700077777002222222200000000
0dddb60b0ddb660b0ddb660b0ddb66000b1115570011155700111557072727060727270607272700077777000777770007777700077777002222222200000000
05dd650b05dd650b05dd656105dd6500001157040011570400115704017771060177715201777100072727000727270007272700072727002222222200000000
0555556105555561055555010555556000155004b01550b4001b5004011111520111110201111150017771000127210001272100222222222222222201111777
055dd6010ddd66010ddd66000bbbb110001555040015550400155504055555020555550006666220011111000111110001212100222222222222222201111770
55d0d00055d5655055d5655055d56550011555500115555001155550115151101151511011515110111111101121121012222210222222222222222211117277
000aa000000aa000000aa000000aa000054400000000445005440000000044500000000000000000000000000000000000000000000000000000000000000000
000af000000af000000aa000000ff000054000000000045005400000000004500000000000000000000000000000000000000000000000000000000000000000
00466000004660050044600000446000005400000000450000540000000045000000002222000000000000222200000007700000077700000007770000000000
006446f00064466f004477f50645f77000544000000445000054400000044500000000f22f000000000000f22f00000070000000700770000070007000000000
0066f00077f54007004440000f44400000055420024550000005542002455000000000ffff000000000000ffff00024000000000000070000000000700000000
003330000033300777333000053330000000228228220000000022822822000000022f4ff4f2200000022f4ff4f22ff000000000000077000000007700000000
0030300000303000003030000030300002202288882202200220226666220220002f22422422f240002f22422422fff000000000000777000777777077007000
0040400000404000004040000040400008829528825928800882826226282880022ff444444ffff0022ff444444ffff000000000000777000077770007770000
00000000000000000000000000555000002899288299820000282629226282000ff0444444440ff00ff044444444044000000000200002222022222222222222
0000000000000000005550000555550000288288882882000028262a926282000ff0044444400ff00ff004444440044000000000200000002000000220200202
00000000000000000555000005550050000288888888200000022299a92220000000044444400440000004444440044000000000200000002000000220000002
0000000000500000055500000555002000002288882200000000229a9a2200000000055555500440000005555550454400000000000000002000000220000002
0000000000555000005550000055500000002828828200000000299aa9a200000000055555500440000005555550445400200200002002002020020220200202
000000000005500000055000000550000000028888200000000a09aaa9909000000002f002f04544000002f002f0044000000000000000002000000220000002
0000000000055000005555000055550000000028820000000000099a99a00000000002200f204454000002200f20000000000000000000000000000222000022
00055000005555000555555005555550000000022000000000909a999a990a0000000ff00ff0044000000ff00ff0000000000000022222200222222222222222
000000000000000000000000000000000000000000000000000000000000000000000000000000000a0a000a0000a00000000000000000000005500000000000
00000000000000070000000a0000000000000000000000000000000000000000000000000000000000000a0000a000a000000000000000000055000000000000
000d6607000d6607000d660a000d6600000d6600000d6600404d6600575d660009066d0000000000a00000000000000000000000000000000050055000000555
000d6607000d6607000d660a000d6600000d6600000d6600545d6600777d66009a966d00000d6600000d6600a00d660a00000000000550000055500000005505
0009a9070009a9610009a9610009a9000009a9000009a9004dd9a9007dd9a900a669a900000d66000a0d660a000d660000000000005500000055555500555550
009a7a61009a7a01009a7a01009a7a9000da7a9000da7a90545a7a90777a7a909a9a7a900009a9000009a9000a09a90a0099a9dd055500000555550505555555
0099a9010099a9000099a9000099a990aa19a9907719a9900009a9905759a9900909a990009a7a90a09a7a90009a7a90d99a7a66055000005555000055555005
099d0600099d0600099d060009999999000d0699000d0699000d0999000d0999000609990999a9990999a9990999a9999999a966555000005550000055500500
000000000000000077000000000000000000000090099099000000000000099009900000000070000000900000000000000000000000000030bbbb03bbbbbbbb
0000000007000007777000770000000000aaaa0099a9aa09000000000000999009a90099000700700009000000000000030000300300b03000bbbb00bbbbbbbb
007707700077077007770770000000000a0700a009aa7aa90000000000099a9909aa99a90070070000900900000000000000000000000000bbbbbbbbbbbbbbbb
000070000007700000777700000770000a0770a00aa77a9900000a000099aaa99aaaaaa9000070070900900008000000000330000b0bb000bbbbbbbbbbbbbbbb
000700000007700000777700000770000a0770a099a777900000aa00009aa7a99aa7aaa900070070000900008000000000033000000bb0b0bbbbbbbbbbbbbbbb
007077000770770007777770000000000a0070a00a77aaa0000a7a00099a77a99a77a7a90000070000900900000000000000000000000000bbbbbbbbbbbbbbbb
0000000070000070770007770000000000aaaa00099aa99000a77a0009a777799a7777a900007000000090000800000003000030030b003000bbbb00bbbbbbbb
00000000000000077000007700000000000000009009009900a77a0099a777799a7777a9000000000009000080080000000000000000000030bbbb03bbbbbbbb
__map__
2a2a2a2a2a022828282828161616031610101223202020341034101116160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2a2909292a022807270b281016100334161110102021201010101f1016160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2a0a0d0a2a1028272727281010100310101010101020232011163f1616000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2a0a0c0a2a102827272728101010031010101110102020211016161600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2a2a0c2a2a102828272828101016031010131010202120101616160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06061f06061014131f1413141010031010101010222020101616000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10101f1f1f1f1e1e1e1f1f131406031011101020202320111616000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02021f0606101f1e7e1e1f282828031010102021202010161600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2828262828131f1e1e1f1f262628031010102020202310161600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
282626260b281f1e1e1f28262628031010102020201316160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
282626262628101e1e1e28260828031010102320202010161600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
280826262628141f1e1e28282828031110102020212014161600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
282828282828101e1e1e10100202031010102020202010161600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
040404040404041e1e1f04040404051010102320222010161600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
101032101110101f1e1e32101010101010101020202120101616000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
101010101032101f1e1e10101110161610101010202023201016160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
101010101010101f1f1f10101010101010101010102020201116160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
101610101110101f1f1f10101610111010111034102021201016160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
101010101010101e1e1f10101010161010101010202020101616000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2d2d2d2d2d2d101e1e1e1f1e1e1f101011101020232013161600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
101010101010101f1e1f1e1f1f1e202120202320202210161600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2d2d2d2d2d2d101f1e1e1f2f2f2e202020212020141016160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
101010101010101f1e1e1f2f2e20202320202010161616000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2d2d2d2d2d2d10101f1e10212020202e2f1f1616161600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10101010101010101f1e102020232e2f1e1e3f16160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2d2d2d2d2d2d10101f1e102021201f1e1e1e3f16160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10101010101014101e1f102020201f1f1f1f3f16160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10282828262810101f1e10102020201116161616160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
14282626262810101e1f11102021201016160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10282626262816101e1e10101020202216160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02280b26262810101e1e10161020232016160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02282828282810101f1f10101010202021161600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0101010101010101010101010000010100000100000101010100010100000000010101010101000001010100010100000303030305010303030300000001010900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003030303
__sfx__
000400000d02000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002d07000000390703907039070390603905039050390303901000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000600001305013050220502e05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300000f62015620000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000dd66607000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000dd66607000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000d111607000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000dd16607000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000add6907000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000007a99965000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000a9dd605000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000099d0d000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000707077007770077070707770077000000770777000007770077070707770777000000000700077700770777000007000777007707070777000000000
00000000707070700700700070700700700000007070700000007070707070707000707007000000700070707000070000007000070070007070070000000000
00000000770070700700700077700700777000007070770000007770707070707700770000000000700077707770070000007000070070007770070000000000
00000000707070700700707070700700007000007070700000007000707077707000707007000000700070700070070000007000070070707070070000000000
00000000707070707770777070700700770000007700700000007000770077707770707000000000777070707700070000007770777077707070070000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000007000770077707070000007707770777077700000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000700707070007070000070007070777070000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000070707077007070000070007770707077000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000700707070007770000070707070707070000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000007000707077707770000077707070707077700000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000077007707700777077707700707077700000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000700070707070070007007070707070000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000700070707070070007007070707077000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000700070707070070007007070707070000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000077077007070070077707070077077700000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__meta:title__
knights of power last light
by mr traveling bard
