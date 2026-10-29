pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
--knights of power last light
--by mr traveling bard

--global variables
version,wait,wait_cnt,main_sel="V0.2.1",0,0,1
--for menus
menu_back={items="main",item_use="items",skills="main",skill_use="skills",status="main"}
--for cutscenes
dirs={r={1,0},l={-1,0},u={0,-1},d={0,1}}
--for battle
battle_state={menu=1,target=2,anim=3,enemy=4,win=5,lose=6,idle=7,skill=8}
--for levelups
stat_keys=split"str,dex,con,mag"

--init scenes
function init_intro()
	set_wait(60)
	_update=update_intro
	_draw=draw_intro
end

function init_mainmenu()
	menu_sel=1
	menu_options={"new game","continue"}
	set_wait(30)
	_update=update_mainmenu
	_draw=draw_mainmenu
end

function init_savemenu()
	menu_sel=1
	set_wait(30)
	_update=update_savemenu
	_draw=draw_savemenu
end

function init_game()
	game_win,game_over,cutscene_on,bbeg_defeated,routines=false,false,false,false,{}
	init_map()
	init_dialogue()
	init_enemies()
	init_statuseffect()
	init_inventory()
	init_skills()
	init_status()
	init_player()
	init_npcs()
	init_scenes()
	set_wait(30)
	_update = update_game 
	_draw = draw_game
end

--init menus/windows
function init_use_menu()
	useselect=1
end

--init game data
function init_npcs()
	npc_data,who={},{}

	--elder
	npc("136,3,10,elder",
		run_once(1,"in our most dire need, where are the gnomes, the wild men, and the wizards of the spiral;tower? will they stand by & watch us burn?! or...are they already dead?"))

	--kids
	npc("134,11,1",
		run_once(2,"my dad said he heard something by this side of the wall. he looks worried...i'm scared."))
	npc("133,7,3",
		run_once(3,"what are those at the gate yelling about? what's going on?"))
	--kid + hero conversation, then a repeat line
	npc("132,6,8",
		run_once(4,"my grandma said you shouldn't show monsters fear. it only makes them stronger.;i'm still scared though...;hero:you don't have to be afraid. i won't let them inside these walls. the light will prevail.;but...aren't you scared too?;hero:of course. but sometimes we have to fight what is in front of us, even if we're scared.;hero:because the cost of not doing so is too high. stay strong. the light will win this day."),
		init_dlg("|i'm staying strong, mister."))
	--repeatable
	npc("135,7,8",
		init_dlg("|the little blue ones look kind of cute.;are they really monsters?"))

	--villagers
	npc("128,12,8",
		run_once(6,"i don't care about goddesses, gods, light, or darkness. but when a bunch of monsters,;ogres, & lizard folk turn up with weapons, well... i'm open to divine intervention."))
	npc("129,9,2",
		run_once(7,"how can the goddess of light let this happen? has the light truly faded?;should we accept our fate? is this the end?"))

	--guards
	npc("142,13,3",
		run_once(10,"i know it's just beyond this wall. will it climb or...is it strong enough to bust through?"))
	npc("141,7,13,gl",
		run_once(11,"this is bad. we simply don't have the numbers to hold this many back!"))
	npc("139,9,13,gr",
		run_once(12,"we are supposed to deal with bandits & the occasional monster. but this...;this is a small army... what if it's only the vanguard?"))

	--no dialogue: 2 villagers + monsters idx13-21
	for r in all(split("130,11,10;131,9,10;163,15,3,chest_guardian;166,8,14,tag:gate_scene;164,7,15,tag:gate_scene;166,8,15,tag:gate_scene;164,9,15,tag:gate_scene;162,3,14,tag:gate_scene;167,2,15,tag:gate_scene;162,12,14,tag:gate_scene;167,13,15,tag:gate_scene",";")) do
		npc(r)
	end
end

function init_inventory()
	--setup variables
	invselect=1
	--add inventory
	--format:item_num,name,quick desc,full desc,
	--q heal amount,q status effect to add, q se to remove,
	--f heal amount,f se to add,f se to remove;
	if not inventory_data then
		inventory_data=split([[
		1,dwarven bread,quick:heal 3hp/3 turns,full:heal 6hp+3 def/3 turns,3,4,0,6,5,4;
		2,kobold's bane,quick:cure burned,full:quick+3 atk/3 turns,0,0,1,0,6,1;
		3,rogue's folly,quick:cure fouled,full:quick+3 spd/3 turns,0,0,2,0,7,2;
		4,weak health potion,quick:heal 5hp,full:heal 12hp,5,0,0,12,0,0,0;
		5,whitewood tincture,quick:+3 mag/3 turns,full:+3 to stats/3 turns,0,8,0,0,9,0]],";")
	end
end

function init_skills()
	skiselect=1
	if (skill_defs) return
	--name,desc1,desc2,mp,menu-usable,target
	--target: e=one enemy s=self a=all enemies
	--(desc2 padding leaves room for the damage number)
	skill_defs={
		init_skill("sword of light  ,one enemy,   holy damage,4,0,e"),
		init_skill("healing light   ,self,restores hp to full,6,1,s"),
		init_skill("shield of light ,self,negate all damage/1 turn,2,0,s"),
		init_skill("flash of light  ,all enemies,   holy damage + 50% stun,3,0,a"),
		init_skill("the last light  ,all enemies,release remaining light,60,0,a")
	}
end

function init_status()
	status_labels1=split([[
	1,lv: ;
	2,hp: ;
	3,mp: ;
	4,xp: ;
	5,status: ;
	6, ;
	7, ;
	8,=equipment=;
	9,iron sword : +;
	10,iron shield: +]],";")
	status_labels2=split([[
	11,  str: ;
	12,  dex: ;
	13,  con: ;
	14,  mag: ;
	15,  atk: ;
	16,  def: ;
	17,  spd: ;
	18,  eva: ;
	19,m.atk: ;
	20,m.def:	]],";")
end

function init_statuseffect()
	--num,name,stat,value,
	--2nd stat, value;
	--10=all 0=hp
	statuseffect_data=split([[
	1,burned,0,-1,5,-3;
	2,fouled,0,-2,0,0;
	3,afraid,10,-2,0,0;
	4,full,0,3,0,0;
	5,sturdy,0,6,6,3;
	6,strong,5,3,0,0;
	7,swift,7,3,0,0;
	8,smart,4,3,0,0;
	9,super,10,3,0,0;
	10,safe,0,0,0,0;
	11,stun,0,0,0,0]],";")
end

function init_temp_stats()
--1,str 2,dex 3,con 4,mag
--5,atk 6,def 7,spd 8,matk 9,mdef
	p.temp_stats={}
	for i=1,9 do
		add(p.temp_stats,0)
	end
end

--init helpers
function npc(s,...)
	--npc("sprite,x,y", dlg1, dlg2, ...)
	--first dialogue whose conditions pass wins
	local sprite,x,y,key=unpack(split(s))
	local n={sprite=sprite,x=x,y=y,dialogue={...}}
	if key then
		if sub(key,1,4)=="tag:" then
			--just to group together for scenes as needed
			n.tag=sub(key,5)
		else
			who[key]=n
		end
	end
	add(npc_data,n)
end

function run_once(id,pages,action)
	--one-time conversation: plays run_once, then
	--this npc falls silent (unless you add another entry after it)
	--remove the run_once() wrapper for a repeatable npc
	return init_dlg("!t"..id.."|"..pages.."|t"..id,action)
end

function init_skill(s)
	local name,d1,d2,mp,menu,tgt=unpack(split(s))
	return {name=name,d1=d1,d2=d2,mp=mp,menu=menu==1,tgt=tgt}
end

--main config
_init = init_intro 
-->8
--update code

--update scenes
function update_intro()
	if btnp(4) or wait_check() then
		init_mainmenu()
	end
end

function update_mainmenu()
	if wait_cnt==2 then
		if menu_control(#menu_options) then
			if menu_sel==1 then init_name() end
			if menu_sel==2 then init_savemenu() end
		end
	end
end

function update_savemenu()
	if wait_check() then
		if btnp(4) then
			init_mainmenu()
		end
	end
end

function update_game()
	if wait_check() then
		if not game_over then
			run_async()
			if lu then
				update_levelup()
			elseif dialogue.active then
				update_dialogue()
			elseif menu_mode then
				update_menus()
			else
				update_map()
				if not cutscene_on then
					if btnp(5) then
						menu_mode,menuselect="main",1
					else
						move_player()
					end
				end
				check_win_lose()
			end
		elseif btnp(5) then
			extcmd("reset")
		end
	end
end

--update menus
function update_menus()
	local m=menu_mode

	--a message box cycles input until dismissed
	if active_text then
		if (btnp(4)) active_text=nil
		return
	end

	if btnp(5) then
		menu_mode=menu_back[m]

	elseif m=="main" then
		menuselect=nav(menuselect,4,1,0)
		if btnp(4) then
			if menuselect==1 then
				init_inventory()
				menu_mode="items"
			elseif menuselect==2 then
				init_skills()
				menu_mode="skills"
			elseif menuselect==3 then
				menu_mode="status"
			end
		end

	elseif m=="items" then
		local n=#p_inventory
		if n>0 then
			invselect=nav(invselect,n,3,2)
			if (btnp(4)) menu_mode,useselect="item_use",1
		end

	elseif m=="skills" then
		skiselect=nav(skiselect,#p_skills,3,2)
		if (btnp(4)) menu_mode,useselect="skill_use",1

	elseif m=="item_use" or m=="skill_use" then
		useselect=nav(useselect,2,3,2)
		if btnp(4) then
			local item=m=="item_use"
			menu_mode=item and "items" or "skills"
			if useselect==1 then
				if item and check_can_use_item() then
					use_item()
				elseif not item and check_can_use_skill() then
					use_skill()
				end
			end
		end
	end
end

--update helper functions
function update_tiles()
	for x=mapx,mapx+15 do
		for y=mapy,mapy+15 do
			if (is_tile(anim1,x,y)) then
				swap_tile(x,y)
				--sfx(3)
			elseif (is_tile(anim2,x,y)) then
				unswap_tile(x,y)
				--sfx(3)
			end
		end
	end
end

function check_can_use_item()
	if p_inventory[invselect][1]==4 and p.hp==p.maxhp then
		active_text="\n\n     your health is full"
		return false
	end
	return true
end

function check_can_use_skill()
	local s,m=p_skills[skiselect]
	if not s.menu then
		m="\n\n   skill can't be used now"
	elseif s.mp>p.mp or p.mp==0 then
		m="\n\n    your mana is too low"
	elseif skiselect==2 and p.hp==p.maxhp then
		m="\n\n     your health is full"
	end
	if m then
		active_text=m
		return false
	end
	return true
end

function check_win_lose()
	if bbeg_defeated then
		game_win=true
		game_over=true
	elseif p.hp<=0 then
		game_win=false
		game_over=true
	end
end

--utility functions

function async(func)
	add(routines,cocreate(func))
end

function run_async()
	for r in all(routines) do
		if costatus(r) == "dead" then
			del(routines,r)
		else
			assert(coresume(r))
		end
	end
end

function is_empty(t)
	--checks if a table is empty
	for _,_ in pairs(t) do
		return false
	end
	return true
end

function wait_check()	
	if wait==0 then
		return true
	else
		wait-=1
		return false
	end
end

function set_wait(num)
	wait=num
end

function menu_control(n)
	menu_sel=nav(menu_sel,n,3,2)
	return btnp(4)
end

function dir(a,b)
	return (btnp(a) and 1 or 0)-(btnp(b) and 1 or 0)
end

function nav(v,n,a,b)
	return (v+dir(a,b)-1)%n+1
end


-->8
--draw code

--draw scenes
function draw_intro()
	cls()
	draw_centered("a mr traveling bard production")
end

function draw_mainmenu()
	cls()

	if wait_check() and wait_cnt<2 then
		wait_cnt+=1
		set_wait(60)
	end

	if wait_cnt>=1 then
		draw_mainmenu_animation(60, 28)
	end

	if wait_cnt==2 then
		for n=1,#menu_options do
			print((menu_sel==n and ">" or " ")..menu_options[n],40,88+(n*8),7)
		end
		print(version,0,120,5)
	end
end

function draw_savemenu()
	cls()
	if wait_check() then
		draw_centered("placeholder for save menu")
	end
end

function draw_game()
	cls()
	if game_over==false then
		if wait==0 then
			draw_map()
			draw_npcs()
			draw_player()
			camera()
			if (dialogue.active) draw_dialogue()
			draw_menus()
			if (lu) draw_levelup()
			--==debug start==

			--==debug end==
		end
	else
		draw_win_lose()
	end
end

--draw menus
function draw_menus()
	local m=menu_mode
	if (not m) return

	check_hp_color()
	draw_menu()
	draw_mini_status(faces.hero)

	if m=="items" or m=="item_use" then draw_inventory() end
	if m=="skills" or m=="skill_use" then draw_skills() end
	if m=="status" then draw_status() end
	if (m=="item_use" or m=="skill_use") draw_use_menu()

	draw_text()
end

--draw helper functions
function draw_mainmenu_animation(x,y)
spr(144,x,y)
	local t=time()*.45%1
	if t<.7 then
		for i=1,t/.7*3\1+1 do
			if (rnd()>.4) pset(x+6+rnd(3)\1,y-2+rnd(5)\1,6)
		end
	end
	local f=t<.7 and 7 or 10
	line(x+7,y,x+7,y+4,f)
	draw_centered("knights of power: last light",60,f)
end

function draw_menu()	
	menux,menuy=10,7
	
	draw_box(1,14,4,2)
	if menuselect==1 then
	--x1=8,x2=30
	rectfill(menux-2,menuy-1,menux+20,menuy+5,13)
 elseif menuselect==2 then
	--x1=32,x2=58
	rectfill(menux+22,menuy-1,menux+48,menuy+5,13)
 elseif menuselect==3 then
	--x1=60,x2=86
	rectfill(menux+50,menuy-1,menux+76,menuy+5,13)
 else
	--x1=88,x2=118
	rectfill(menux+78,menuy-1,menux+108,menuy+5,13)
 end
	print("items skills status options",menux,menuy,7)
--troubleshooting
--print(menuselect,1,1,12)
end

function draw_inventory()
	local invx,invy=10,2
 local line_item=0

	--inventory box
	draw_box(5,11,4,44)
	--description box
	draw_box(2,14,4,19)
	--print if available
 if p_inventory and #p_inventory>0 then
 	--invselect
 	rectfill(invx-2,invy+38+(invselect*8),invx+85,invy+44+(invselect*8),13)
		--inventory
		for i=1,#p_inventory do
			if p_inventory[i][3]>0 then
				line_item+=1
				print(pad(p_inventory[i][3]).." "..p_inventory[i][2],invx,invy+39+(line_item*8),7)
			end
		end
		--description
		print(p_inventory[invselect][4],invx,invy+22,7)
		print(p_inventory[invselect][5],invx,invy+30,7) 
	end	
end

function draw_skills()
	local skix,skiy=10,2
	--skills box
	draw_box(5,11,4,44)
	--desc box
	draw_box(2,14,4,19)
	--skill select
	rectfill(skix-2,skiy+38+(skiselect*8),skix+85,skiy+44+(skiselect*8),13)
	--skills
	for i,s in inext,p_skills do
		print(s.name.." "..pad(s.mp).."mp",skix,skiy+39+i*8,7)
	end
	--desc
	local s,d=p_skills[skiselect],skill_dmg(skiselect)
	print(s.d1,skix,skiy+22,7)
	if (d>0) print(d,skix,skiy+30,9)
	print(s.d2,skix,skiy+30,7)
end

function draw_use_menu()
	local usex,usey=106,48
 
	draw_box(3,2,101,44)
	--use select
	rectfill(usex,usey-1+(useselect*8),usex+13,usey+5+(useselect*8),13)
	--use menu
	print("use?",usex,usey,7)
	print("yes",usex+1,usey+8,7)
	print("no",usex+1,usey+16,7)
end

function draw_mini_status(face)
	mini_statusx,mini_statusy=42,92

	draw_box(3,5,42,94,face)
	print("lv: "..p.lvl,mini_statusx+6,mini_statusy+7,7)
	print("hp: ",mini_statusx+6,mini_statusy+15,7)
	print(pad(p.hp),mini_statusx+22,mini_statusy+15,hp_color)
	print("/",mini_statusx+30,mini_statusy+15,7)
	print(p.maxhp,mini_statusx+34,mini_statusy+15,maxhp_color)
	print("mp: "..pad(p.mp).."/"..p_maxmp,mini_statusx+6,mini_statusy+23,7)	
end

function draw_status()
	local statusx,statusy=10,2

	--status box
 	draw_box(12,14,4,19)
	--labels
	print(p.name,statusx,statusy+22,7)
	print(p.title,statusx,statusy+30,7)
	draw_print(status_labels1,statusx,statusy+30)
	draw_print(status_labels2,statusx+72,statusy+30)
	--values
	print(p.lvl,statusx+14,statusy+38,7)
	--hp & mp
	print(pad(p.hp),statusx+14,statusy+46,hp_color)
	print("/",statusx+22,statusy+46,7)
	print(p.maxhp,statusx+26,statusy+46,maxhp_color)
	print(pad(p.mp).."/"..p_maxmp,statusx+14,statusy+54,7)
	print(p.xp,statusx+14,statusy+62,7)
	--status
	if is_empty(p.status) then
			print("normal",statusx+28,statusy+70,7)	
	else
		print_range(p.status,1,2,statusx+28,statusy+70)
		print_range(p.status,3,5,statusx,statusy+78)
		print_range(p.status,6,8,statusx,statusy+86)
	end
		--equipment
		print(p.sword_score,statusx+57,statusy+102,7)
		print(p.shield_score,statusx+57,statusy+110,7)
	--the rest of the stats
	
	temp_stats=split(p_str_total..",;"..p_dex_total..",;"..p_con_total..",;"..p_mag_total..",;"..p.atk..",;"..p.def..",;"..p.spd..",;"..p.eva.."%,;"..p.matk..",;"..p.mdef..",",";")
	local t=p.temp_stats
	for i=1,10 do
		temp_stats[i]=temp_stats[i]..check_color(i<8 and t[i] or i==8 and t[2]+t[7] or t[i-1])
	end
	draw_print(temp_stats,statusx+98,statusy+30,true)
end

function check_color(v)
	return v>0 and 11 or v<0 and 8 or 7
end

function check_hp_color()
 maxhp_color=check_color(p.temp_stats[3])
 hp_color=(p.hp==p.maxhp and maxhp_color or 7)
end

function draw_print(split_string,x,y,color_flag)
	local color_flag=color_flag or false
	
	for i=1,#split_string do
		if color_flag then
			local label,c_num=unpack(split(split_string[i],","))	
			print(label,x,y+(i*8),c_num)
		else
			local line_item,label=unpack(split(split_string[i],","))
			print(label,x,y+(i*8),7)	
		end
	end
end

function draw_text()
	--message box only (input is in update_menus)
	if (not active_text) return
	local x,y=4,52
	draw_box(3,14,4,52)
	print(active_text,x+4,y+4,7)
	if (flr(time()*4)%2==0) spr(96,x+108,y+20)
end

function draw_box(rows,columns,x,y,face)
	--face is the sprite or default box
	local c,h,v,f=unpack(box_styles[face] or box_styles[64])
	f=f or 81
	local r,w=rows*8,columns*8

	--corners (face corner has the portrait)
	spr(face or c,x,y)
	spr(c,x+w,y,1,1,true)
	spr(c,x,y+r,1,1,false,true)
	spr(c,x+w,y+r,1,1,true,true)

	--horizontal edges
	for i=1,columns-1 do
		spr(h,x+i*8,y)
		spr(h,x+i*8,y+r,1,1,false,true)
		--fill
		for n=1,rows-1 do
			spr(f,x+i*8,y+n*8)
		end
	end

	--vertical edges
	for n=1,rows-1 do
		spr(v,x,y+n*8)
		spr(v,x+w,y+n*8,1,1,true)
	end
end

function draw_win_lose()
	camera()
	if (game_win) then
		draw_centered("★ you win! ★",64)
	else
		draw_centered("game over! :(",64)
	end
 	draw_centered("press ❎ to play again",72,5)
end

--draw misc
function draw_centered(text,y,c)
	print(text,64-#text*2,y or 60,c or 7)
end

function print_range(list,start_i,end_i,x,y)
  local str = ""
  for i = start_i, min(#list, end_i) do
    str = str .. list[i][1] .. " "
  end
  if str ~= "" then print(str,x,y,7) end
end

function trim(s)
	while sub(s,-1)==" " do s=sub(s,1,-2) end
	return s
end

function pad(n) 
	return (n<10 and "0" or "")..n
end

-->8
--player code

function init_player()
--sets all initial player data

	p={}
--[[	
 p.x=2 --starting x
	p.y=3 --starting y
	p.dx=0 --x facing: -1 (left), 0, 1 (right)
	p.dy=-1 --y facing: -1 (up), 0, 1 (down)
	p.sprite=1
	==starting stats==
	p.name="????"
	p.title="the last"
	p.lvl=1
	p.mp=60
	p.xp=0
	p.str=4
	p.dex=4
	p.con=4
	p.mag=4
	==starting equipment stats==
	p.sword_score=5
	p.shield_score=2
	]]
	p.x,p.y,p.dx,p.dy,p.sprite,p.name,p.title,p.lvl,p.mp,p.xp,p.str,p.dex,p.con,p.mag,p.sword_score,p.shield_score=
	unpack(split("2,3,0,-1,1,????,the last light,1,60,0,4,4,4,4,2,2"))
	--starting stats
	set_xp_table()
	p_maxmp=60 --just for drawing
	p.status={}
	init_temp_stats()
	set_stats()
	p_skills={}
	set_skills()
	--testing area
	--change_statuseffects(1,true)
	--p.hp=2
	--starting inventory
	p_inventory={}
	set_inventory()
end

function init_name()
	nm,ch,c,a="","",1,"abcdefghijklmnopqrstuvwxyz*"
	_update=function()
		c=nav(c,27,3,2)
		ch=sub(a,c,c)
		if btnp(5) then
			nm=sub(nm,1,-2)
		elseif btnp(4) then
			if ch=="*" then
				init_game()
				p.name=nm!="" and nm or "lance"
			elseif #nm<8 then
				nm..=ch
			end
		end
	end
	_draw=function()
		cls()
		spr(144,60,28)
		print("name your hero:\n"..nm..ch,30,50,7)
		print("⬆️⬇️ letter 🅾️ add ❎ del *=done",0,120,5)
	end
end

function set_xp_table()
	--orders papa johns pizza
	xp_table = split("10,30,90,270")
end

function set_inventory()
	--sets starting player inv
	start_inv=split("1,1;2,8;3,11;4,1;5,2",";")
 	--start_inv=split("5,2;1,2",";")
	if start_inv then
		for i=1,#start_inv do
			local item_num,quantity=unpack(split(start_inv[i],","))
		
			add_item(item_num,quantity)
		end
	end
end

function add_item(item_num,quantity)
	--adds/updates items to player
	
	local inum,iname,qdesc,fdesc,qheal,qadd_stat,qremove_stat,fheal,fadd_stat,fremove_stat=lookup_inventory_data(item_num)
	local exists=exists_in(p_inventory,iname)
	if exists then
		p_inventory[exists][3]+=quantity
	else 
		add(p_inventory,{inum,iname,quantity,qdesc,fdesc,qheal,qadd_stat,qremove_stat,fheal,fadd_stat,fremove_stat})
	end
end

function lookup_inventory_data(item_num)
	return unpack(split(inventory_data[item_num],","))
end

function lookup_statuseffect_data(status_num)
	return unpack(split(statuseffect_data[status_num],","))
end

function use_item(use_type)
--uses items
	local use_type=use_type or "f"
	local qheal,qadd,qremove,fheal,fadd,fremove=unpack(p_inventory[invselect],6,11)
	--=quick use=
 if use_type=="q" then
		--remove statuses if available
		if qremove>0 then
			change_statuseffects(qremove,false)
		end
		--add statuses if available
		if qadd>0 then
			change_statuseffects(qadd,true)
		end
		--recover health if available
		if qheal>0 then
			p.hp+=qheal
			if p.hp>p.maxhp then
				p.hp=p.maxhp
			end
		end
	--=full use=
	else
		--remove statuses if available
		if fremove>0 then
			change_statuseffects(fremove,false)
		end
		--add statuses if available
		if fadd>0 then
			change_statuseffects(fadd,true)
		end
		--recover health if available
		if fheal>0 then
			p.hp+=fheal
			if p.hp>p.maxhp then
				p.hp=p.maxhp
			end
		end
	end
	--deduct from inventory
	p_inventory[invselect][3]-=1
	if p_inventory[invselect][3]==0 then
	 local i=(invselect==#p_inventory and invselect-1 or invselect)
	 deli(p_inventory,invselect)
	 invselect=i
	end
	--cleanup
	init_use_menu()
end

function change_statuseffects(status_num,add_boolean,for_enemy)
	local for_enemy=for_enemy or false
	local snum,sdesc,stat1,val1,stat2,val2=lookup_statuseffect_data(status_num)
	
	if add_boolean then
		local exists=exists_in(p.status,sdesc)
		if exists then
			p.status[exists][2]=3
		else
			add(p.status,{sdesc,3})
			change_stats(stat1,val1)
			change_stats(stat2,val2)
		end
	else
		local exists=exists_in(p.status,sdesc,true)
		if exists then
			change_stats(stat1,val1,true)
			change_stats(stat2,val2,true)
		end
	end
	set_stats(true)
end

function change_stats(stat_num,value,stat_revert)
--0,hp 10,all main stats
	local stat_revert=stat_revert or false
	
	if stat_num>0 then
		if stat_num==10 then
			for i=1,9 do
				if stat_revert then
					p.temp_stats[i]-=value
				else
					p.temp_stats[i]+=value
				end
			end
		else
			if stat_revert then
				p.temp_stats[stat_num]-=value
			else
				p.temp_stats[stat_num]+=value
			end
		end
	end
end

function exists_in(t,v,delete_flag)
	local delete_flag=delete_flag or false
	local n=#t
	
	for i=1,n do
		if t[i][1]==v then
			if delete_flag then
				deli(t,i)
				return true
			else
				return i
			end
		end
	end
	return false
end

function check_for_levelup()
	if xp_table[p.lvl] and p.xp>=xp_table[p.lvl] then
		p.lvl+=1
		lu={step=1,sel=1}
	end
end

function lu_next()
	--steps: 1 stat, 2 skill cost, 3 lv5 info, 4 done
	local s,l=lu.step+1,p.lvl
	if (s==2 and l!=2 and l!=4) s=3
	if (s==3 and l!=5) s=4
	if s==3 then
		p.mp+=10
		p_maxmp+=10
		p_skills[5].name="the last light+ "
		p_skills[5].d2="destroy the darkness"
		set_last_light()
	end
	if s==4 then
		lu=nil
		set_stats()
		check_for_levelup()
	else
		lu.step,lu.sel=s,1
	end
end

function update_levelup()
	local s=lu.step
	if s<3 then
		lu.sel=nav(lu.sel,4,3,2)
	end
	if btnp(4) then
		if s==1 then
			local k=stat_keys[lu.sel]
			p[k]+=1
			lu_next()
		elseif s==2 then
			local sk=p_skills[lu.sel]
			if sk.mp>1 then
				sk.mp-=1
				lu_next()
			end
		else
			lu_next()
		end
	end
end

function draw_levelup()
	local s=lu.step
	rectfill(0,0,127,127,0)
	rect(2,2,125,125,6)
	draw_centered("level up! lv "..p.lvl,10,10)
	if s==1 then
		draw_centered("raise a stat",24,6)
		for i=1,4 do
			local k=stat_keys[i]
			print((lu.sel==i and ">" or " ")..k.."  "..p[k].." > "..(p[k]+1),36,40+i*10,lu.sel==i and 7 or 6)
		end
		--TODO: add desc on hover
		--str increases atk in battle & skill checks
		--dex increases spd in battle & skill checks
		--con increases def, maxhp, & resistance checks
		--mag increase matk, mdef, & arcana checks
	elseif s==2 then
		draw_centered("reduce a skill's mp cost",24,6)
		for i=1,4 do
			local sk=p_skills[i]
			local c=sk.mp>1 and 7 or 5
			print((lu.sel==i and ">" or " ")..sk.name,8,40+i*10,c)
			print(sk.mp>1 and sk.mp.." > "..(sk.mp-1) or "min",96,40+i*10,c)
		end
		--TODO: add skill desc 1 & 2 on hover
	else
		print(wrap("the light within is honed into a sharp blade"),8,36,7)
		print("last light upgraded!",8,56,10)
		print(wrap("a residual spark of the goddess' light finds its way to you"),8,72,7)
		print("+10 mp",8,96,12)
	end
	draw_centered("z: confirm",114,5)
end

function set_stats(refresh)
--sets all player battle stats
	local refresh=refresh or false
	local temp_str,temp_dex,temp_con,temp_mag,temp_atk,temp_def,temp_spd,temp_matk,temp_mdef=unpack(p.temp_stats)
	local maxhp_start=p.maxhp
	
	p_str_total=p.str+temp_str
	p_dex_total=p.dex+temp_dex
	p_con_total=p.con+temp_con
	p_mag_total=p.mag+temp_mag

	p.atk = p.str*2 + p.sword_score + temp_atk
	p.def = p.con + p.shield_score + temp_def
	p.spd = p.dex + p.lvl + temp_spd
	p.eva = mid(0,p_dex_total*3+temp_spd*2,50)
	p.matk = p.mag*2 + p.sword_score + temp_matk
	p.mdef = p.mag + p.shield_score + temp_mdef
	p.maxhp = p.con*5 + p.lvl*2 + temp_con*3
	if refresh then
		--if maxhp increases hp increases
		local hpdiff=p.maxhp-maxhp_start
		if hpdiff>0 then
			p.hp+=hpdiff
		end
		--if maxhp decreases hp decreases to match maxhp if over it
		if p.hp>p.maxhp then
			p.hp=p.maxhp
		end
		return
	end
	p.hp = p.maxhp
end

function set_skills()
	--sets player skill list
	p_skills=skill_defs
end

function skill_dmg(i,u)
	--damage shown in menu & used in battle
	--u is p for the menu and hero battler in a fight
	u=u or p
	return i==1 and u.atk+(u.matk*2) or i==4 and u.matk or 0
end

function skill_cost(i,u)
	--the last light costs all your mp
	return i==5 and u.mp or p_skills[i].mp
end

function use_skill()
	if (skiselect==2) p.hp=p.maxhp
	p.mp-=p_skills[skiselect].mp
	set_last_light()
	init_use_menu()
end

function set_last_light()
	p_skills[5].mp=p.mp
end

function draw_player()
	spr(p.sprite,p.px or p.x*8,p.py or p.y*8,1.0,1.0,flip_x)
end

function move_player()
	local mx,my=dir(1,0),dir(3,2)
	if mx!=0 or my!=0 then
		p.dx,p.dy=mx,my
		if (mx!=0) flip_x=mx<0
	end
	local nx,ny=p.x+mx,p.y+my
	interact(nx,ny)
	if can_move(nx,ny) then
		p.x,p.y=mid(0,nx,127),mid(0,ny,63)
	else sfx(0) end
end

function interact(x,y)
	targetx,targety=p.x+p.dx,p.y+p.dy
	--tile triggers
	local t=triggers[x+y*128]
	if (t) dialogue_start(t)

	--talk to npc
	if btnp(4) then
		for n in all(npc_data) do
			if targetx==n.x and targety==n.y then
				dialogue_start(n)
				break
			end
		end
	end
end

-->8
--map code

function init_map()
	--timers
	timer=0
	anim_time=15 --30 = 1 second

	--map tile settings
	wall=split([[3,4,5,6,7,8,9,10
	,11,12,13,14,15,18,21,22,23,24
	,25,28,29,32,33,34,35,36,37,38
	,44,45,50,52]],",")
	anim1=split([[12,14,28,44,60,62]],",")
	anim2=split([[13,15,29,45,61,63]],",")
	lose={}
	win={}	
end

function update_map()
	if (timer<0) then
		update_tiles()
		timer=anim_time
	end
	timer-=1
end

function draw_map()
	mapx=flr(p.x/16)*16
	mapy=flr(p.y/16)*16
	camera(mapx*8,mapy*8)
	
	map(0,0,0,0,128,64)
end

function draw_npcs()
	for n in all(npc_data) do
  		spr(n.sprite, n.px or n.x*8, n.py or n.y*8)
	end
end


function is_tile(tile_type,x,y)
	tile=mget(x,y)
	for i=1,#tile_type do
		if (tile==tile_type[i]) return true
	end
	return false
end

function can_move(x,y)
	--check if an npc is there
	for n in all(npc_data) do
		if x==n.x and y==n.y then
			return false
		end
	end
	--if no npc, is it a wall?
	return not is_tile(wall,x,y)
end

function swap_tile(x,y)
	tile=mget(x,y)
	mset(x,y,tile+1)
end

function unswap_tile(x,y)
	tile=mget(x,y)
	mset(x,y,tile-1)
end
-->8
--dialogue code

function init_dialogue()
	init_boxes()
	flags,dialogue,triggers={},{},{}
	--tile triggers: fire when you step on x,y
	--entries must set a flag (or they re-fire)
	--a function is optionally possible in the final slot
	trigger(2,4,
		run_once("exit_temple","as you leave this once holy place to face the agents of darkness, you are struck by;a feeling that you will likely never return.;did your goddess feel the same when she stood alone against the dark gods?")
	)
end

function trigger(x,y,...)
	triggers[x+y*128]={dialogue={...}}
end

function init_dlg(s,action)
	--"req flags|page;page;page|set flags" flags comma separated, "!" = must be false / set false
	--action = optional function run when it closes (use it to start a battle or cutscene)
	local req,pages,sets=unpack(split(s,"|",false))
	return {
		cond=make_cond(req),
		pages=split(pages,";",false),
		on_end=make_onend(sets,action)
	}
end

function init_boxes()
	--one row per box style:
	--name,face,corner,h_border,v_border[,fill]
	faces,box_styles={},{}
	for r in all(split([[default,64,64,65,80;hero,66,68,67,82;alt,69,84,70,85]],";")) do
		local name,face,c,h,v,f=unpack(split(r))
		faces[name]=face
		box_styles[face]={c,h,v,f}
	end
end

function parse_flags(s)
	if (not s or s=="") return
	local t={}
	for k in all(split(s,",",false)) do
		local n=sub(k,1,1)=="!"
		t[n and sub(k,2) or k]=not n
	end
	return t
end

function make_cond(r)
	local t=parse_flags(r)
	if t then
		return function()
			for f,v in next,t do
				if (flags[f] or false)~=v then return false end
			end
			return true
		end
	end
end

function make_onend(sets,action)
	local t=parse_flags(sets)
	if t or action then
		return function()
			for f,v in next,t or {} do flags[f]=v end
			if (action) action()
		end
	end
end

function dialogue_start(src)
	for e in all(src.dialogue) do
		if not e.cond or e.cond() then
			if not e.pages[1] or e.pages[1]=="" then
				if (e.on_end) e.on_end()
			else
				dialogue={active=true,entry=e,page=1,src=src}
			end
			return
		end
	end
end

function update_dialogue()
	if btnp(4) then
		local d=dialogue
		if d.page<#d.entry.pages then
			d.page+=1
		else
			--close first so on_end can open
			--another dialogue or a battle
			dialogue={}
			if (d.entry.on_end) d.entry.on_end()
		end
	end
end

function draw_dialogue()
	local pg,face=dialogue.entry.pages[dialogue.page],64
	local k=split(pg,":",false)[1]
	if faces[k] then face,pg=faces[k],sub(pg,#k+2) end
	dialogue.y=dialogue.y or dialogue_y()
	local by=dialogue.y
	draw_box(3,15,0,by,face)
	print(wrap(pg),5,by+5,7)
	if (time()%.5<.25) spr(96,116,by+20)
end

function dialogue_y()
	--this is to prevent the dialogue box covering talking sprites
	--bottom box (default) covers screen y 96-128, top box covers 0-32
	local lo,hi
	for e in all({p,dialogue.src}) do
		if e.y then
			local sy=(e.py or e.y*8)-mapy*8
			lo=lo or sy+8>96
			hi=hi or sy<32
		end
	end
	return lo and not hi and 0 or 96
end

function wrap(s,w)
	w=w or 29
	local out,line="",""
	for word in all(split(s," ",false)) do
		if line!="" and #line+#word+1>w then
			out..=line.."\n"
			line=word
		else
			line..=(line=="" and "" or " ")..word
		end
	end
	return out..line
end

-->8
--cutscene code

function cutscene(fn)
	--run fn as a locked cutscene:
	--player input and the menu are off until it ends
	cutscene_on=true
	async(function()
		fn()
		cutscene_on=false
	end)
end

function when(flag,fn)
	--run fn in the background once a flag is set
	--(no input lock, ex. npcs that wander off)
	async(function()
		while not flags[flag] do yield() end
		fn()
	end)
end

--cutscene commands (use inside cutscene or when)
function pause(n)
	--pause for n frames
	for i=1,n do yield() end
end

function walk(e,steps,spd)
	--move p or any npc along "r,l,u,d"
	--spd = pixels per frame (default 1, 8 frames/tile)
	spd=spd or 1
	for s in all(split(steps)) do
		local d=dirs[s]
		local dx,dy=d[1],d[2]
		local tx,ty=(e.x+dx)*8,(e.y+dy)*8
		if e==p then
			p.dx,p.dy=dx,dy
			if (dx!=0) flip_x=dx<0
		end
		e.px,e.py=e.px or e.x*8,e.py or e.y*8
		while e.px!=tx or e.py!=ty do
			e.px+=mid(-spd,tx-e.px,spd)
			e.py+=mid(-spd,ty-e.py,spd)
			yield()
		end
		e.x+=dx
		e.y+=dy
	end
	e.px,e.py=nil,nil
end

function say(s)
	--show text, wait until it is closed
	--"page;page;hero: hero page" same format as init_dlg
	dialogue_start({dialogue={init_dlg("|"..s)}})
	dlg_wait()
end

function talk(n)
	--run an npc's normal (flag based) dialogue
	dialogue_start(n)
	dlg_wait()
end

function dlg_wait()
	while dialogue.active do yield() end
end

function fight(group)
	--start a battle and wait for it. returns true if won
	--(the script is frozen while the battle scene runs)
	local won
	start_battle(group,function(w) won=w end)
	repeat yield() until won!=nil
	while lu do yield() end
	return won
end

--scenes
function init_scenes()
	--cutscene triggers
	--"!gate_scene||gate_scene" = once only, no pages, just run the action
	trigger(8,14,
		init_dlg("!gate_scene||gate_scene",function() cutscene(gate_scene) end))

	--when triggers
	--once the gate is won the elder walks off (adjust the path to your map!)
	when("gate_won",function()
		walk(who.elder,"l,u,u,u,u,u,u,u,u")
	end)
end

function gate_scene()
	--bumping the monster at (8,14) starts the gate scene.
	say("hero:this ends here.")
	pause(20)
	if fight("slimes_x2") then
		clear_gate_monsters()
		say("hero:...the light holds.;hero:for now.")
		pause(20)
		flags.gate_won=true
	end
	--if you lose, game over triggers by itself
end

function clear_gate_monsters()
	for n in all(npc_data) do
		if (n.tag=="gate_scene") del(npc_data,n)
	end
end

-->8
--battlesystem code

--init battle functions
function init_battle(en,on_end)
	local h=init_battler(p)
	h.x,h.y=58,52
	for i,e in inext,en do
		e.x,e.y=59+(i-(#en+1)/2)*16,32
	end
	battle={
		state=battle_state.menu,
		sel=1,
		message="your turn!",
		anim_timer=0,
		hero=h,
		enemies=en,
		popups={},
		on_end=on_end,
		en_id=1,
		xp=0
	}
	if (rnd(20)>p.spd+8) battle.state,battle.en_id=battle_state.enemy,1
	_update,_draw=update_battle,draw_battle
end

function init_enemies()
	--enemy data: name,sprite,hp,atk,def,xp
	enemy_defs={
		slime=init_enemy("slime,198,12,6,2,3"),
		undead=init_enemy("undead,198,14,8,3,4"),
		lizardman=init_enemy("lizardman,198,20,10,3,5"),
		gargoyle=init_enemy("gargoyle,198,18,10,2,5"),
		ogre=init_enemy("ogre,198,26,13,4,6"),
		cultist=init_enemy("cultist,198,26,11,3,6"),
		mid_rogue=init_enemy("famous rogue,198,30,12,3,12"),
		mid_mage=init_enemy("spiral mage,198,45,8,2,12"),
		mid_ogre=init_enemy("ogre warchief,198,40,14,4,12"),
		boss_undead=init_enemy("undead knight,198,60,11,5,20"),
		boss_necro=init_enemy("necromancer,198,55,9,3,25"),
		boss_shadow=init_enemy("shadow knight,198,75,14,6,0"),
		boss_dragon=init_enemy("dragon,198,100,15,6,40")
	}
	enemy_groups={
		slime={"slime"},
		slimes_x2={"slime","slime","slime","slime"}
	}
end

function init_enemy(s)
	local name,sprite,hp,atk,def,xp=unpack(split(s))
	return {name=name,sprite=sprite,hp=hp,maxhp=hp,atk=atk,def=def,xp=xp}
end

function init_battler(s,e)
	--copies stats so every fight starts fresh
	--(works for the hero p and for enemy defs)
	return {
		name=s.name,
		sprite=e and s.sprite or 224,
		hp=s.hp,maxhp=s.maxhp,
		mp=s.mp or 0,maxmp=s.maxmp or p_maxmp,
		atk=s.atk,def=s.def,
		matk=s.matk,mdef=s.mdef,
		shield=s.shield_score or 0,
		xp=s.xp or 0
	}
end

--call battle functions
function start_battle(group,on_end)
	--any npc, tile or dialogue action can call this
	--on_end(won) runs when the fight is over
	local en={}
	for k in all(enemy_groups[group]) do
		add(en,init_battler(enemy_defs[k],true))
	end
	init_battle(en,on_end)
end

function end_battle(won)
	local h=battle.hero
	p.hp,p.mp=max(h.hp,0),h.mp
	p.xp+=battle.xp
	check_for_levelup()
	set_last_light()
	_update,_draw=update_game,draw_game
	if (battle.on_end) battle.on_end(won)
end

--update battle functions
function update_battle()
	local b=battle
	local s=b.state
	b.anim_timer-=1
	update_popups()

	if s==battle_state.anim then
		anim.t-=1
		anim.fn()
		if anim.t<=0 then
			b.state=battle_state.idle
			anim.done()
		end
	elseif s==battle_state.menu then
		update_battle_menu()
	elseif s==battle_state.skill then
		update_battle_skills()
	elseif s==battle_state.target then
		update_battle_target()
	elseif s==battle_state.enemy then
		update_enemy_turn()
	elseif s==battle_state.win or s==battle_state.lose then
		if (b.anim_timer<=0) end_battle(s==battle_state.win)
	end
end

function update_battle_menu()
	local b,h=battle,battle.hero
	b.sel=nav(b.sel,4,3,2)
	if btnp(4) and b.anim_timer<=0 then
		local sh=b.sel==2
		if b.sel<3 then
			choose("e",function(t) do_attack(h,t,sh) end)
		elseif b.sel==3 then
			b.state,b.ksel=battle_state.skill,1
		else
			b.message="coming soon!"
		end
	end
end

function update_battle_skills()
	local b,n=battle,#p_skills
	b.ksel=nav(b.ksel,n,3,2)
	if (btnp(5)) b.state=battle_state.menu
	if (btnp(4) and b.anim_timer<=0) use_battle_skill(b.ksel)
end

function update_battle_target()
	local b=battle
	b.tsel=nav(b.tsel,#b.tl,1,0)
	if (btnp(5)) b.state=b.back
	if (btnp(4)) b.act(b.tl[b.tsel])
end

function update_enemy_turn()
	local b,h=battle,battle.hero
	if (b.anim_timer>0) return

	--round over
	if b.en_id>#b.enemies then
		h.defending,h.safe=false,false
		tick_status(h)
		if h.hp<=0 then
			b.state,b.message,b.anim_timer=battle_state.lose,"you lost...",60
		else
			b.state,b.sel,b.message=battle_state.menu,1,"your turn!"
		end
		return
	end

	local e=b.enemies[b.en_id]
	b.en_id+=1
	if (e.hp<=0) return
	if e.stun then
		e.stun=false
		b.message,b.anim_timer=e.name.." is stunned!",30
		return
	end

	local d=calc_dmg(e.atk,h.def)
	local dodged=rnd(100)<p.eva
	if (h.defending) d=max(flr(d/2),1)
	if (h.safe or dodged) d=0
	play_anim(max(d*3,10),
		function() b.shake,b.sx=e,flr(rnd(3))-1 end,
		function()
			b.shake=nil
			land_hit(h,d,h.safe and "blocked by the light!" or dodged and e.name.." missed!" or e.name.." hits for "..d.."!",8)
			if h.hp<=0 then
				b.state,b.message,b.anim_timer=battle_state.lose,"you lost...",60
			else
				b.state=battle_state.enemy
			end
		end)
end

--battle actions
function choose(tgt,fn)
	--runs fn once the target is selected
	--tgt "e": 1 enemy, default if only 1 is alive
	--all others don't need a target
	local b=battle
	b.act,b.back=fn,b.state
	if tgt=="e" then
		b.tl,b.tsel=alive(b.enemies),1
		if #b.tl>1 then
			b.state=battle_state.target
			return
		end
		fn(b.tl[1])
	else
		fn()
	end
end

function do_attack(u,t,shield)
	local b=battle
	local d=calc_dmg(shield and flr(u.atk/2)+u.shield or u.atk,t.def)
	play_anim(shield and 10 or 20,
		function() b.shake,b.sx=u,flr(rnd(3))-1 end,
		function()
			b.shake=nil
			u.defending=shield
			land_hit(t,d,"you hit for "..d.."!",8)
			end_player_action()
		end)
end

function use_battle_skill(i)
	local b,h,s=battle,battle.hero,p_skills[i]
	if skill_cost(i,h)>h.mp or h.mp==0 then
		b.message="your mana is too low"
	elseif i==2 and h.hp==h.maxhp then
		b.message="your health is full"
	else
		choose(s.tgt,function(t) cast(i,t) end)
	end
end

function cast(i,t)
	--1 sword 2 heal 3 shield 4 flash 5 last light
	local b,h,s=battle,battle.hero,p_skills[i]
	local c=skill_cost(i,h)
	local base=i==5 and h.matk*h.mp*(p.lvl==5 and 2 or 1) or skill_dmg(i,h)
	local ts=s.tgt=="a" and alive(b.enemies) or {t}
	h.mp-=c
	play_anim(20,
		function() b.shake,b.sx=h,flr(rnd(3))-1 end,
		function()
			b.shake=nil
			if i==2 then
				land_hit(h,h.hp-h.maxhp,"you are fully healed!",11)
			elseif i==3 then
				h.safe=true
				b.message,b.anim_timer="shield of light up!",30
			else
				local d
				for e in all(ts) do
					d=calc_dmg(base,e.mdef or 0,1)
					land_hit(e,d,"",7)
					if (i==4 and rnd()<.5) e.stun=true
				end
				b.message=trim(s.name)..(#ts>1 and " hits all!" or " hits for "..d.."!")
			end
			end_player_action()
		end)
end

function end_player_action()
	local b=battle
	for e in all(b.enemies) do
		if e.hp>0 then
			b.state,b.en_id=battle_state.enemy,1
			return
		end
	end
	--enemies defeated
	local total_xp=0
	for e in all(b.enemies) do
		if e.hp<=0 then
			total_xp+=e.xp
		end
	end
	b.state,b.message,b.anim_timer,b.xp=battle_state.win,"you won!\nyou gain "..total_xp.."xp",60,total_xp
end

--battle helpers
function tick_status(h)
	--runs at the end of every round. effects with stat 0 are hp per turn
	--(burned -1, fouled -2, full +3 ...), then the turn counter drops and 
	--expired statuses are removed through change_statuseffects
	local hp0=h.hp
	p.hp=h.hp
	for st in all(p.status) do
		for n=1,#statuseffect_data do
			local _,name,s1,v1,s2,v2=lookup_statuseffect_data(n)
			if name==st[1] then
				if (s1==0) p.hp+=v1
				if (s2==0) p.hp+=v2
				p.hp=mid(0,p.hp,p.maxhp)
				st[2]-=1
				if (st[2]<=0) change_statuseffects(n,false)
			end
		end
	end
	h.hp,h.maxhp,h.atk,h.def,h.matk,h.mdef=p.hp,p.maxhp,p.atk,p.def,p.matk,p.mdef
	if (h.hp!=hp0) spawn_popup(h.x,h.y-4,abs(h.hp-hp0),h.hp>hp0 and 11 or 8)
end

function calc_dmg(atk,def,var)
	return max(atk+flr(rnd(var or 3))-def,1)
end

function land_hit(t,d,msg,col)
	--negative dmg heals
	t.hp=mid(0,t.hp-d,t.maxhp)
	spawn_popup(t.x,t.y-4,abs(d),col)
	battle.message=msg
	battle.anim_timer=30
end

function alive(side)
	local o={}
	for e in all(side) do
		if (e.hp>0) add(o,e)
	end
	return o
end

function play_anim(frames,fn,done)
	anim={t=frames,fn=fn,done=done}
	battle.state=battle_state.anim
end

function spawn_popup(x,y,v,c)
	add(battle.popups,{x=x+flr(rnd(5))-2,y=y,v=v,c=c,t=30})
end

function update_popups()
	for o in all(battle.popups) do
		o.y-=0.5
		o.t-=1
		if (o.t<=0) del(battle.popups,o)
	end
end

--draw battle functions
function draw_battle()
	cls()
	camera()
	local b,h=battle,battle.hero
	local w=b.state==battle_state.win

	--message / win-lose overlay
	if w or b.state==battle_state.lose then
		print(b.message,44,34,w and 11 or 8)
	else
		draw_centered(b.message,8,7)
	end

	--enemies
	for e in all(b.enemies) do
		if e.hp>0 then
			spr(e.sprite,e.x+(b.shake==e and b.sx or 0),e.y)
			mini_bar(e.x-3,e.y+10,e.hp,e.maxhp,14,8)
			if (e.stun) print("zz",e.x,e.y-6,6)
		end
	end

	--hero
	spr(h.sprite,h.x+(b.shake==h and b.sx or 0),h.y)
	print(h.name,35,68,7)
	draw_bar(35,75,h.hp,h.maxhp,11)
	draw_bar(35,82,h.mp,h.maxmp,9)

	--target cursor
	if b.state==battle_state.target then
		local t=b.tl[b.tsel]
		print("v",t.x+2,t.y-8+flr(sin(time()*2)*2),7)
		draw_centered(t.name,20,7)
	end

	--action menu
	if b.state==battle_state.menu then
		local m=split("sword,shield,skills,items")
		for i=1,4 do
			print((b.sel==i and ">" or " ")..m[i],4,88+i*8,7)
		end
	elseif b.state==battle_state.skill then
		local s,d=p_skills[b.ksel],skill_dmg(b.ksel)
		print(s.d1,4,16,6)
		if (d>0) print(d,4,22,9)
		print(s.d2,4,22,6)
		for i,s in inext,p_skills do
			local c=h.mp<skill_cost(i,h) and 5 or 7
			print((b.ksel==i and ">" or " ")..s.name,4,82+i*8,c)
			print(skill_cost(i,h).."mp",76,82+i*8,c)
		end	
	end

	--popups
	for o in all(b.popups) do
		local s=tostr(o.v)
		print(s,o.x-#s*2+1,o.y+1,0)
		print(s,o.x-#s*2,o.y,o.c)
	end
end

function draw_bar(x,y,val,maxval,col)
	local w=40
	local fill=max(0,flr((val/maxval)*w)-1)
	if fill>0 then rectfill(x+1,y+1,x+fill,y+3,col) end
	print(val.."/"..maxval,x+w+2,y,7)
end

function mini_bar(x,y,v,m,w,c)
	rectfill(x,y,x+w-1,y+1,5)
	rectfill(x,y,x+max(1,flr(v/m*w))-1,y+1,c)
end

__gfx__
000000004444444433344454335d5dd333333333335ddd53333333336644446666444466a782287a666666666666666622a222a222a262a23331133399999999
000000004ffffff133444544335ddd5333333333335d5dd33bbbbbb36647746666cccc66799aa997666666666666566622a222a222a767a23317713399499999
007007004f1ff1f13444544433dd5d5355d555d55d5d5d53bebbbbeb6686686666cccc6689aaaa9866566666666556662a222a2224266624316dd61399999949
000770004f1f1ff14f454445335d5d53dddddddddddddd53b2bbbb2b6688886666cccc662aa77aa266666566665555662a222a222a44444231d55d1394449999
000770004ffffff1f4f4f454335d5dd3555d555d555d55d3bbbbebbb6688886666cccc662aa77aa2466666646651156622a222a222a222a231dddd1399444999
00700700411111113f5f4f44335ddd53ddddddddddddddd3bbeb2bb16688886666c66c6689aaaa98444444446654456622a222a222a222a23444443399999499
0000000033341333f4f5f44333dd5d535d555d555d555d53bb2bbb116688886666477466799aa99744444444665555662a222a222a222a223344443399499999
00000000333410033f5f4433335d5d53ddddddddddddddd33bbb11136644446666444466a782287a44444444665665662a222a222a222a223334433399999949
33333333333333333311133333c33333333333e33333353333bbbb33ddd4d4dddd44d4ddddddddddddddddddddddddd15ddd5ddd335ddd534444144233244423
3333333333b33333315551333cac333333333b3b335535333bbbbbb3dd4774dddd2222ddddddddddddddddddddddddd5ddddddddd3dddddd4444244443444444
333333333b3b33331556551333c33c333e333333333555133bbbbb13dd5677dddd6222ddddd2dddddd5dddddddddddd5ddd5ddd5d3ddd5dd4442244443444244
33333333333333b3156555133333cac3b3b33333553553133bbbb113dd5577dddd7222ddddd5ddddddddd5ddddddddd5551dddddd33333dd2244424443333344
3333333333333b3b1555552133333c333333e3333555511333b11133dd5567dddd7622ddddd55ddd4dddddd4ddddddd5d1dddddd5ddd33334444442224443333
33333333333b333312555521333c3333333b3b333335533333342333dd5556dddd7762dddd555ddd44444444ddddddd5dddddddd3ddd33334444442434443333
3333333333b3b3333155221333cac333333333e33335533333342333dd5555dddd4774ddd55555dd44444444ddddddd1ddddddd13ddd3dd34444441434443443
333333333333333333333333333c333333333b3b3355553333442233dd4d44dddd4d4ddddddddddd4444444415555511dd5ddd5133331dd34442221233331443
11111111111c111111111111111111111111333333331111666666666666666665666566666466667677767777777777ddddddddddddddddd5ddd5dd33355515
111111111cc1c1111155511111111111111111333311111166666666666666665555555566666666666666667f777777dddddddddddddddd5555555533555155
11111111111111c115565511111111111111111331111111666666666656666666656665666666567776777677777777dddddddddd5dddddddd5ddd535551555
111111111111cc1c15655511111ccc1111111113311111116666666666666566555555556666666666666666777777f7ddddddddddddd5dd555555555f515551
1111111111111111155555211cc111c11111111111111111666666666666666665666566666666667677767777777777ddddddddddddddddd5ddd5ddf5f5f515
1111111111cc1111c255552c111111111111111111111111666666666666666655555555665666966666666677777777dddddddddddddddd555555553f1f5f55
11111111cc11c1111c5522c11111111111111111111111116666666666665666666566656666666677767776777f7777dddddddddddd5dddddd5ddd5f5f1f553
111111111111111111cccc11111111111111111111111111666666666666666655555555666666666666666677777777dddddddddddddddd555555553f1f5533
333233233bb2bb2bddbbbb333dddbb3d333339333393333344666644446666444a4444a44a4aa4a4333333333337733300000000000000000000000000000000
33232332bb2b2bb23bdddbddddbbddb3339339933993339346555d6446555d644a4444a415199151333773336337733700000000000000000000000000000000
32333332b2b333b23bbbbd133bbbdbdd39939a9339a939a346cccc644655d5644a4444a411111111333773333666677300000000000000000000000000000000
32333323b2b3bb2bddbbdd133bddb1d399a9aaa93aa939a946cccc6446cccc644a4444a411111111336663333337333300000000000000000000000000000000
332323233b2b2b2b33dd11dd33db11339aaaa7a99a7aa7a94d6666544d666654aaa99aaa15111151360707333477743300000000000000000000000000000000
332332333b2bb2b3333dd33ddd34ddd3977a77799777a7794dd5d5144dd5d514191991914a4444a4346104733401043300000000000000000000000000000000
3332333333b2bb333dd42dd333dd233d344444499444444344dd554444dd55444a4444a44a4444a4334444333344443300000000000000000000000000000000
33332333333b2b33d34422333d442233355555533555555344d5d14444d5d1444a4444a44a4444a4333443333334433300000000000000000000000000000000
0005555555555555dd66655555555555707075555555555566666555555555554404455555555555000555555555555503555555000555550005555500000000
0557777777777777dd6669999999999977777222222222226b6b6bbbbbbbbbbb4202488888888888055ddddddddddddd0337777705599999055bbbbb00000000
0575555555555555d11165555555555572727555555555556666655555555555288825555555555505d5555555555555333355550595555505b5555500000000
5755111111111111dd166111111111115777111111111111566611111111111189898111111111115d551111111111114ff41111595511115b55111100000000
57511111111111115dd611111111111152511111111111115b5111111111111128882111111111115d5111111111111154411111595111115b51111100000000
5751111111111111595111111111111152511111111111115b5111111111111152821111111111115d5111111111111157511111595111115b51111100000000
5751111111111111595111111111111152511111111111115b5111111111111158881111111111115d5111111111111157511111595111115b51111100000000
5751111111111111595111111111111152511111111111115b5111111111111152511111111111115d5111111111111157511111595111115b51111100000000
575111111111111159511111dd66655552511111222255555b511111dd66655558511111022555555d511111000000000aa55555000555550005555500000000
575111111111111159511111dd66677752511111f22f77775b511111dd666bbb5851111102f777775d511111000000000af77777055222220558888800000000
575111111111111159511111d111655552511111ffff55555b511111dbbb65555851111122f555555d5111110000000046655555052555550585555500000000
575111111111111159511111dd166111525111114ff4f1115b511111ddb6611158511111222211115d5111110000000064461111525511115855111100000000
5751111111111111595111115dd6111152511111422421115b5111115dd6111158511111228811115d5111110000000064461111525111115851111100000000
57511111111111115951111157511111525111114444f1115b5111115b51111158511111575111115d5111110000000057511111525111115851111100000000
5751111111111111595111115751111152511111575111115b5111115b51111158511111575111115d5111110000000057511111525111115851111100000000
5751111111111111595111115751111152511111575111115b5111115b51111158511111575111115d5111110000000057511111525111115851111100000000
00000000000dd0000000700000000000000000008888888888888888222222223333333333333333333333333333333333333333333333339999999999999999
00000000000770000000770000000000000000008ddd9dd88bbbbbb82d1dddd23dddd7d33dddddd33dddddd33dd77dd33d7777d33ddbbdd39dd99dd999dddd99
00000000000770000000777000000000000000008dd999d88dbdbbb821dd1d123ddd47733dd77dd337d77d7337d77d733d7777d33dbbbbd39d9aa9d99d9dd9d9
0000000000077000d777777700000000000000008dd9a9d88dbddbd8211181823d4444d337d77d7337d77d733d7777d33dd77dd33bddddb399a77a999dd99dd9
7777777777777777d777777700000000000000008d9a79d88ddddbd82111111234444dd33d7777d33d7777d33dd77dd33d7777d33ddbbdd399a77a999dd99dd9
077777700777777000007770000000000000000089a77a988dddddd821d1d1d234444dd33d7777d33dd77dd33d7dd7d337d77d733dbbbbd39d9aa9d99d9dd9d9
007777000077770000007700000000000000000089777a988dbddbd821d1d1d23444ddd3377dd7733d7dd7d33d77d7733d7dd7d33bddddb39dd99dd999dddd99
00077000000770000000700000000000000000008888888888888888222222223333333333333333333333333333333333333333333333339999999999999999
0dd666000dd666000dd666000dd666000dd666000dd666000dd66600070707000707070007070700070707000707070000000000000000000000000000000000
0dd666070dd666000dd666070dd666000dd666070dd666000dd66607077777060777770007777700077777000777770600000000000000000000000000000000
0d1116070dd111000dd111070d1116000d1116070dd666000dd66607077777060777770007777700077777000777770600000000000000000000000000000000
0dd166070ddd16000ddd16070dd166000dd166070dd666000dd66607072727060772720007272700077777000777770600000000000000000000000000000000
0add69070add69000add690709dd690009dd69070a9a9a000a9a9a07017771060177770001777100021212000212120600000000000000000000000000000000
07a9996107a9990007a99961099999000999996109a7a90009a7a961011111520111110001111100011211000112115200000000000000000000000000000000
0a9dd6010a9dd6000a9dd6010ddd66000ddd6601099a9900099a9901011555020115550005555500011211000112110200000000000000000000000000000000
99d0d00099d0d00099d0d00099d9699099d969909999999099999990115050001150500011515110111111101111111000000000000000000000000000000000
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
0010000000000000d000000dd000000dd000000dd666666d0002220000022200000222000005440000054400000440000022000000220040002200c00dd66600
016101600000110050d00d0550d00d055066660560d00d06000f2f00000f2f00000f2f00500445055004450000054500002f0000002f00f0002f00f00dd66607
011401000004111055055055550660555605506565066056022444ff022444ff022444ff4454445444544450000445000222004002220840022208400ddbbb07
0414140000114140555555555565565556566565656556560244444f0244444f0244444f444454444555544054045550022288f002228040022280400dddb607
0044400001444010550550555565565556066065656556560f04440fff04440f0f0444ff4404440505554400544454500228f0400228f0400228f04005dd6507
01555000111556105005500550066005560550656006600600055500ff055500000555ff55054504055545000005450002880040028800000288000005555561
1150500016105000d055550dd055550dd066660d60555506000f0f00000f0f00000f0f00000404000004040000040400028880400288800002888000055dd601
101010000010100000500500005005000050050006666660000f0f00000f0f00000f0f0000050500000505000005050022888800228888002288880055d0d000
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

__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
3434343434023232323232161616031610101010101010102020222020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
34350a3534023208331932101610032e10121010101020202020202020212020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
340b1b0b34103233333332101010031010101010202022202021202020201010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
340b1a0b34103233333332101010031010102020202020202020202010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
34341a3434103232333232101016031020202020202020202022201010101110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1717271717101413271413141010031020212020202021201010101012101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10102728281718183a2828131417031020202020201010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02023717171039292c2929323232031020201010101010111010101011101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3232313232132929292929313132031010101010111010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3231313119323829292932313132031010101010101010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3231313131321039292932310932031010101010101012101010101012101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3209313131321439292932323232031110101010101010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3232323232321039292910100202031010101010101010101110101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0404040404040429292904040404051010101110101010101010101010101210000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10101c101110102929291c101010101010101010101010101012101010111010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10101010101c1029292910101110161610101010101010101010101011101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000400000d02000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002d07000000390703907039070390603905039050390303901000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000600001305013050220502e05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300000f62015620000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
