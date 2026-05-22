pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
--knights of power
--by mr traveling bard

--global variables
routines={}
--test=false

--==game state inits==
--intro state init
function init_intro()
	--variables
	scene="intro"
	--setup main functions
	_update=update_intro
	_draw=draw_intro
end

--main menu state init
function init_mainmenu()
 --variables
 text_timer=0
 text_wait=30
 scene="mainmenu"
	--setup main functions
	_update=update_mainmenu()
	_draw=draw_mainmenu()
end

--battle state init
function init_battle()
	--variables
--	scene="battle"
	--setup main functions
--	_update=update_battle()
--	_draw=draw_battle()
end

--save state init
function init_save()
	--variables
--	scene="save"
	--setup main functions
--	_update=update_save()
--	_draw=draw_save()
end

--game state init
function init_game()
	--variables
	scene="game"
	game_win=false
	game_over=false
	menu_active=false
	--setup calls
	init_map() --in map code
	init_text() --in text code
	init_statuseffect()
	init_inventory()
	init_skills()
	init_status()
	init_player() --in player code
	init_npcs()
	init_switches()
	--setup main functions
	_update = update_game 
	_draw = draw_game
end

--==game functions==
--menus
function init_menu()
	--setup variables
	menuselect=1
end

function init_use_menu()
	use_menu=false
	useselect=1
	usestep=false
end

--game data
function init_npc(id,name,sprite,x,y,dialogue)
 return {
  id=id,
  name=name,
  sprite=sprite,
  x=x,
  y=y,
  --dialogue should be {{},{}}
  dialogue=dialogue
 }
end

function init_npcs()
	--main npc data source
	npc_data={}
	--for easier maintenance
	npc_temp1={} --non-dialogue
	npc_temp2={} --dialogue only
	--map1
	npc_temp1=split([[
	1,elder,136,3,10;
	2,kid,134,11,1;
	3,kid,133,7,3;
	4,kid,132,6,8;
	5,kid,135,7,8;
	6,villager,128,12,8;
	7,villager,129,9,2;
	8,villager,130,11,10;
	9,villager,131,9,10;
	10,guard,142,13,3;
	11,guard,141,7,13;
	12,guard,139,9,13;
	13,monster,163,15,3;
	14,monster,166,8,14;
	15,monster,164,7,15;
	16,monster,166,8,15;
	17,monster,164,9,15;
	18,monster,162,3,14;
	19,monster,167,2,15;
	20,monster,162,12,14;
	21,monster,167,13,15]],";")

--npcid,order,end?,self?,switch,story_req,set_story,text		
	npc_temp2=split([[
	1;64;1;false;false;;0;0;in our most dire need, where \are the gnomes, the wild men, \and the wizards of the spiral|
	1;64;2;true;false;;0;0;tower? will they stand by & \watch us burn?! or...are they \already dead?|
	2;64;1;true;false;;0;0;my dad said he heard something\by this side of the wall. he\looks worried...i'm scared.|
	3;64;1;true;false;;0;0;what are those at the gate \yelling about? what's going \on?|
	4;64;1;false;true;;0;0;my grandma said you shouldn't\show monsters fear. it only\makes them stronger.|
	4;64;2;false;true;;0;0;i'm still scared though...|
	4;66;3;false;true;;0;0;you don't have to be afraid.\i won't let them inside these\walls. the light will prevail.|
	4;64;4;false;true;;0;0;but...aren't you scared too?|
	4;66;5;false;true;;0;0;of course. but sometimes we\have to fight what is in front\of us, even if we're scared.|
	4;66;6;true;true;;0;0;because the cost of not doing\so is too high. stay strong.\the light will win this day.|
	4;64;1;true;false;;0;0;i'm staying strong, mister.|
	5;64;1;false;false;;0;0;the little blue ones look \kind of cute.|
	5;64;2;true;false;;0;0;are they really monsters?|
	6;64;1;false;false;;0;0;i don't care about goddesses,\gods, light, or darkness. but\when a bunch of monsters,|
	6;64;2;true;false;;0;0;ogres, & lizard folk turn up\with weapons, well... i'm \open to divine intervention.|
	7;64;1;false;false;;0;0;how can the goddess of light\let this happen? has the \light truly faded?|
	7;64;2;true;false;;0;0;should we accept our fate?\is this the end?;66|
	10;64;1;true;false;;0;0;i know it's just beyond this\wall. will it climb or...is it\strong enough to bust through?|
	11;64;1;true;false;;0;0;this is bad. we simply don't\have the numbers to hold this\many back!|
	12;64;1;false;false;;0;0;we are supposed to deal with\bandits & the occasional\monster. but this...|
	12;64;2;true;false;;0;0;this is a small army... what\if it's only the vanguard?]],"|")
	
	for i=1,#npc_temp1 do
		local id,name,sprite,x,y=unpack(split(npc_temp1[i],","))
		local dialogue=parse_text(npc_temp2,true,id)
		add(npc_data,init_npc(id,name,sprite,x,y,dialogue))
	end
end

function init_inventory()
	--setup variables
	invselect=1
	invstep=false
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
	--setup variables
	skiselect=1
	skistep=false
	--add skills
	--format:skill_num,name,
	--desc line 1,desc line 2,
	--mp cost,damage,se add,menu useable;
	if not skills_data then
		skills_data=split([[
		1,sword of light  ,one enemy,   holy damage,2,0,0,0;
		2,healing light   ,self,restores hp to full,5,0,0,1;
		3,shield of light ,self,negate all damage/1 turn,2,0,10,0;
		4,flash of light  ,all enemies,   holy damage + 50% stun,3,0,0,0;
		5,the last light  ,all enemies,release remaining light,60,0,0,0]],";")
	end
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
	18,m.atk: ;
	19,m.def:	]],";")
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
	8,smart,8,3,0,0;
	9,super,10,3,0,0;
	10,safe,0,0,0,0]],";")
end

function init_temp_stats()
--1,str 2,dex 3,con 4,mag
--5,atk 6,def 7,spd 8,matk 9,mdef
	p.temp_stats={}
	for i=1,9 do
		add(p.temp_stats,0)
	end
end

function init_switches()
	switches={}
	--add(switches,{"test",false})
end

--main config
_init = init_intro 
-->8
--update code

--intro state update
function update_intro()
	if btnp(🅾️) then
		--go to main menu
		active_text=nil
		--init_mainmenu()
		init_game()
	end
end

--main menu state update
function update_mainmenu()
	if btnp(🅾️) and (active_text) then
		--go to game
		active_text=nil
		init_game()
	end
end

--battle state update
function update_battle()
	--code
end

--save state update
function update_save()
	--code
end

--game state update
function update_game()
	if (not game_over) then
		if ((not active_text) and (not menu_active) and (not active_dialogue)) then
			update_map()
			move_player()
			check_win_lose()
		elseif menu_active then
			if inventory_menu then
				if use_menu then
					update_use_menu()
				else
					update_inventory()
				end
			elseif skills_menu then
				if use_menu then
					update_use_menu()
				else
					update_skills()
				end
			elseif status_menu then 
				--lock select for main menu
			else
				update_menu()
			end
		end
	else
		if (btnp(❎))	extcmd("reset")
	end
end

--game functions
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

function update_menu()
--todo: consolidate all these
--update menus into single func
--since they are very similar
	if btnp(➡️) then
		if menuselect<4 then
			menuselect+=1
		else
			menuselect=1
		end
	elseif btnp(⬅️) then
		if menuselect>1 then
			menuselect-=1
		else
			menuselect=4
		end
	end
end

function update_inventory() 
	if btnp(⬇️) and p_inventory then
		if invselect<#p_inventory then
			invselect+=1
		else
			invselect=1
		end
	elseif btnp(⬆️) and p_inventory then
		if invselect>1 then
			invselect-=1
		else
			invselect=#p_inventory
		end
	end
end

function update_skills() 
	if btnp(⬇️) then
		if skiselect<#p_skills then
			skiselect+=1
		else
			skiselect=1
		end
	elseif btnp(⬆️) then
		if skiselect>1 then
			skiselect-=1
		else
			skiselect=#p_skills
		end
	end
end

function update_use_menu() 
	if btnp(⬇️) or btnp(⬆️) then
		if useselect==1 then
			useselect=2
		else
			useselect=1
		end
	end
end

function check_can_use_item()
	local value=p_inventory[invselect][1]
	
	if value==4 and p.hp==p.maxhp then
		active_text="\n\n     your health is full"
		draw_text()
		return false
	end
	return true
end

function check_can_use_skill()
	local mp_cost=p_skills[skiselect][5]
	--check if menu only
	if p_skills[skiselect][8]==0 and scene=="game" then
		active_text="\n\n   skill can't be used now"
		draw_text()
		return false
	--check if you have enough mana
	elseif (mp_cost>p.mp or p.mp==0) then
		active_text="\n\n    your mana is too low"
		draw_text()
		return false
	--check if you are already at full hp
	elseif skiselect==2 and p.hp==p.maxhp then
		active_text="\n\n     your health is full"
		draw_text()
		return false
	end
	return true
end

function check_win_lose()
	if (is_tile(win,p.x,p.y)) then
		game_win=true
		game_over=true
	elseif (is_tile(lose,p.x,p.y)) then
		game_win=false
		game_over=true
	end
end

function async(func)
	add(routines,cocreate(func))
end

function wait(frames)
	for i=1,frames do
		yield()
	end
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

function move(obj,key,dest,frames,expr)
	local init=obj[key]
	frames=frames or 30
	expr=expr or linear
	
	for i=1,frames do
		obj[key]=lerp(init,dest,expr(i/frames))
		yield()
	end
end

function lerp(a,b,t)
	return a+(b-a)*t
end

function linear(t)
	return t
end

function easeinelastic(t)
	if(t==0) return 0
	return 2^(10*t-10)*cos(2*t-2)
end

function is_empty(t)
--checks if a table is empty

	for _,_ in pairs(t) do
		return false
	end
	return true
end

-->8
--draw code

--intro state draw
function draw_intro()
	cls()
	active_text="\n   traveling bard studios\n\n          presents"
	draw_text(4,14,4,48)
end

--main menu state draw
function draw_mainmenu()
	cls() 
	active_text="\n   knights of power:\n\n              last light"
	draw_text(4,14,4,48)
end

--battle state draw
function draw_battle()
	--code
end

--save state draw
function draw_save()
	--code
end

--game state draw
function draw_game()
	cls()
	if (not game_over) then
		draw_map()
		draw_npcs()
		draw_player()
		if (not active_text) then
			if active_dialogue then
				draw_textbox(face)
			else
				--x button checks
				if (btnp(❎) and (not menu_active)) then
					init_menu()
					menu_active=true
 			elseif (btnp(❎) and menu_active) then
 				if not (inventory_menu or use_menu or skills_menu or status_menu) then
					menu_active=false
				else
					if (btnp(❎) and inventory_menu) then
						if (not use_menu) then
							inventory_menu=false
						else
							init_use_menu()
						end
					elseif (btnp(❎) and skills_menu) then
						if (not use_menu) then
							skills_menu=false
						else
							init_use_menu()
						end
					elseif (btnp(❎) and status_menu) then
						status_menu=false
					end
				end
			end
		end
		--draw active menus
		if menu_active then
			check_hp_color()
			draw_menu()
			draw_mini_status(66)
			--main menu options
			if (btnp(🅾️) and menuselect==1) then 
				if (not inventory_menu) init_inventory()
					inventory_menu=true 
				elseif (btnp(🅾️) and menuselect==2) then
					if (not skills_menu) init_skills()
					skills_menu=true
				elseif (btnp(🅾️) and menuselect==3) then 
					status_menu=true 
				end
				--items
				if inventory_menu then 
					draw_inventory()
					--use
					if (btnp(🅾️) and p_inventory and #p_inventory>0) then
						if invstep and (not usestep) then
							init_use_menu()
							use_menu=true 
						else
							invstep=true
						end
					end
					if use_menu then
						draw_use_menu()
						if (btnp(🅾️) and useselect==1) then
							if usestep then 
								if check_can_use_item() then
									use_item()
								else
									init_use_menu()
								end
							else
								usestep=true
							end
						elseif (btnp(🅾️) and useselect==2) then
							init_use_menu()
						end
					end
				end
				--skills
				if skills_menu then 
					draw_skills()
					--use
					if (btnp(🅾️) and skistep and (not usestep)) then
							init_use_menu()
							use_menu=true 
					else
							skistep=true
					end
					if use_menu then
						draw_use_menu()
						if (btnp(🅾️) and useselect==1) then
							if usestep then 
								if check_can_use_skill() then
									use_skill()
								else
									init_use_menu()
								end
							else
								usestep=true
							end
						elseif (btnp(🅾️) and useselect==2) then
							init_use_menu()
						end
					end
				end
				--status
				if status_menu then 
					draw_status()
				end
				--options
			end
		else
			draw_text()
		end
		--==testing area==
		--print(next_text,9)
		--print("p.x: "..p.x,0,0,0)
		--print("p.y: "..p.y,0,8,0)
		--print("p.dx: "..p.dx,0,16,0)
		--print("p.dy: "..p.dy,0,24,0)
		--print("t.x: "..(targetx or 0),0,32,0)
		--print("t.y: "..(targety or 0),0,40,0)
		--print(text_data[1][2],0,0,9)
		--print(text_data[2][2],0,8,9)
		--print(text_data[3][2],0,16,9)
		--print(npc_data[4].dialogue[1][6],0,0,0)
		--print(npc_data[4].dialogue[2][6],0,8,0)
		--print(npc_data[4].dialogue[7][6],0,16,0)	
		--print("diff x: "..abs(p.x - npc_data[1].x),0,32,0)
		--print("diff y: "..abs(p.y - npc_data[1].y),0,40,0)
		--==end of testing area==
	else
		draw_win_lose()
	end
end

--game functions
function draw_menu()	
	menux=mapx*8+10
	menuy=mapy*8+7
	
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
	local invx=mapx*8+10
	local invy=mapy*8+2
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
				print((p_inventory[i][3]<10 and "0" or "")..p_inventory[i][3].." "..p_inventory[i][2],invx,invy+39+(line_item*8),7)
			end
		end
		--description
		print(p_inventory[invselect][4],invx,invy+22,7)
		print(p_inventory[invselect][5],invx,invy+30,7) 
	end	
end

function draw_skills()
	local skix=mapx*8+10
	local skiy=mapy*8+2
	local line_item=0

	--skills box
 draw_box(5,11,4,44)
 --description box
	draw_box(2,14,4,19)
 --skiselect
 rectfill(skix-2,skiy+38+(skiselect*8),skix+85,skiy+44+(skiselect*8),13)
	--skills
	for i=1,#p_skills do
		line_item+=1
		print(p_skills[i][2].." "..(p_skills[i][5]<10 and "0" or "")..p_skills[i][5].."mp",skix,skiy+39+(line_item*8),7)
	end
	--description
	print(p_skills[skiselect][3],skix,skiy+22,7)
	if p_skills[skiselect][6]>0 and skiselect~=5 then
		print(p_skills[skiselect][6],skix,skiy+30,9)
	end
 print(p_skills[skiselect][4],skix,skiy+30,7) 	
end

function draw_use_menu()
	local usex=mapx*8+106
	local usey=mapy*8+48
 
 draw_box(3,2,101,44)
 --use select
 rectfill(usex,usey-1+(useselect*8),usex+13,usey+5+(useselect*8),13)
 --use menu
	print("use?",usex,usey,7)
	print("yes",usex+1,usey+8,7)
	print("no",usex+1,usey+16,7)
end

function draw_mini_status(face)
	mini_statusx=mapx*8+42
	mini_statusy=mapy*8+92

	draw_box(3,5,42,94,face)
	print("lv: "..p.lvl,mini_statusx+6,mini_statusy+7,7)
	print("hp: ",mini_statusx+6,mini_statusy+15,7)
	print((p.hp<10 and "0" or "")..p.hp,mini_statusx+22,mini_statusy+15,hp_color)
	print("/",mini_statusx+30,mini_statusy+15,7)
	print(p.maxhp,mini_statusx+34,mini_statusy+15,maxhp_color)
	print("mp: "..(p.mp<10 and "0" or "")..p.mp.."/"..p_maxmp,mini_statusx+6,mini_statusy+23,7)	
end

function draw_status()
	local statusx=mapx*8+10
	local statusy=mapy*8+2

	--status box
 draw_box(12,14,4,19)
 --labels
 print(p.name,statusx,statusy+22,7)
 print(p.title,statusx,statusy+30,7)
 draw_print(status_labels1,statusx,statusy+30)
 draw_print(status_labels2,statusx+72,statusy+38)
 --values
 print(p.lvl,statusx+14,statusy+38,7)
 --hp & mp
 print((p.hp<10 and "0" or "")..p.hp,statusx+14,statusy+46,hp_color)
 print("/",statusx+22,statusy+46,7)
 print(p.maxhp,statusx+26,statusy+46,maxhp_color)
 print((p.mp<10 and "0" or "")..p.mp.."/"..p_maxmp,statusx+14,statusy+54,7)
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
 
 temp_stats=split(p_str_total..",;"..p_dex_total..",;"..p_con_total..",;"..p_mag_total..",;"..p.atk..",;"..p.def..",;"..p.spd..",;"..p.matk..",;"..p.mdef..",",";")
	for i=1,9 do
		temp_stats[i]=temp_stats[i]..check_color(p.temp_stats[i])
	end
	draw_print(temp_stats,statusx+98,statusy+38,true)
end

function check_color(value)
	if value>0 then
		return 11
	elseif value<0 then
		return 8
	else 
		return 7
	end
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

function draw_textbox(face)
	--faces: default 64;hero 66
	face=face or 64
	textx=mapx*8
	texty=mapy*8+96
	
	if active_dialogue then
		--draw_box(3,15,0,52,face)
		draw_box(3,15,0,96,face)
		print(active_dialogue,textx+5,texty+5,7)
		if (flr(time()*4)%2==0) then
			spr(100,textx+116,texty+20)
		end
	end
	
	if (btnp(🅾️) and read) then
		active_dialogue=nil
		read=false	
	else
		read=true
	end
end

function draw_text(rows,col,x,y)
	--local iterate=iterate or false
	--local text_index=text_index or 0
	local rows=rows or 3
	local col=col or 14
	local x=x or 4
	local y=y or 52
	 
	if active_text then
		if scene=="game" then
			textx=mapx*8+x
			texty=mapy*8+y
		else
			textx=x
			texty=y
		end
	
		draw_box(rows,col,x,y)
		print(active_text,textx+4,texty+4,7)
		if (flr(time()*4)%2==0) then
			spr(100,textx+(col*8-4),texty+(rows*8-4))
		end
	end
	
	if (btnp(🅾️) and read) then
		active_text=nil
		read=false	
	else
		read=true
	end	
end

function draw_box(rows,columns,x,y,face)
	--face is the sprite or default box
	face=face or 64
	if (scene=="game") then
		boxx=mapx*8+x
		boxy=mapy*8+y
	else
		boxx=x
		boxy=y
	end
	--default box
	fill=81
	top_left=64
	v_border=80
	h_border=65
	--conditional updates
	if (face==66) then 
		top_left=68
		v_border=82
		h_border=67		
	elseif (face==69) then
		top_left=84
		v_border=85
		h_border=70
	end

	--building the box
	--face corner
	spr(face,boxx,boxy)
	--other three corners
	spr(top_left,boxx+(columns*8),boxy,1,1,true) --topright
	spr(top_left,boxx,boxy+(rows*8),1,1,false,true) --bottomleft
	spr(top_left,boxx+(columns*8),boxy+(rows*8),1,1,true,true) --bottomright
	for i=1,(columns-1) do
		--horizontal borders
		spr(h_border,boxx+i*8,boxy)
		spr(h_border,boxx+i*8,boxy+(rows*8),1,1,false,true)
 	for n=1,(rows-1) do
 		--vertical borders
			spr(v_border,boxx,boxy+n*8)
			spr(v_border,boxx+(columns*8),boxy+n*8,1,1,true,false)
 		--fill
 		spr(fill,boxx+i*8,boxy+n*8)
 	end
 end
end

function draw_win_lose()
	camera()
	if (game_win) then
		print("★ you win! ★",37,64,7)
 else
 	print("game over! :(",38,64,7)
 end
 	print("press ❎ to play again",20,72,5)
end

function print_range(list,start_i,end_i,x,y)
  local str = ""
  for i = start_i, min(#list, end_i) do
    str = str .. list[i][1] .. " "
  end
  if str ~= "" then print(str,x,y,7) end
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
	unpack(split("2,3,0,-1,1,????,the last light,1,60,0,4,4,4,4,5,2"))
	--starting stats
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

function lookup_skills_data(skill_num)
	return unpack(split(skills_data[skill_num],","))
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

function change_statuseffects(status_num,add_boolean)
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
--checks player xp against xp_table

	if (xp_table[p.lvl] >= p.xp) levelup()
end

function levelup()
--prompt the player which stat they would like to update
--draw_levelup()
	p.lvl+=1
	if p.lvl==5 then 
		p.mp+=10
		if p.mp>p_maxmp then 
			p_maxmp=p.mp
		end
		p_skills[5][2]="the last light+ "
		p_skills[5][4]="destroy the darkness"
	end
	set_stats()
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
	
	p.atk = p.str + p.lvl + p.sword_score + temp_atk
	p.def = p.con + p.shield_score + temp_def
	p.spd = p.dex + p.lvl + temp_spd
	p.matk = p.mag + p.lvl + p.sword_score + temp_matk
	p.mdef = p.mag + p.shield_score + temp_mdef
	p.maxhp = (p.con*4) + (p.lvl*4) + (temp_con*3)
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
	for i=1,#skills_data do		
			add_skill(i)
	end
end

function add_skill(skill_num)
--adds skills to player
	local snum,sname,sdesc1,sdesc2,smpcost,sdamage,sadd,smenu=lookup_skills_data(skill_num)
	--specific to 1 & 4 that describe values that need to be updated
	if snum==1 then
		sdamage=p.atk+(p.matk*2)
	elseif snum==4 then
		sdamage=p.matk
	elseif snum==5 then
		sdamage=(p.matk*p.mp)*(p.lvl==5 and 2 or 1)
	end
	add(p_skills,{snum,sname,sdesc1,sdesc2,smpcost,sdamage,sadd,smenu})
end

function use_skill(use_type)
--uses skills
	local use_type=use_type or "m"
	local smpcost,sdamage,sadd,smenu=unpack(p_skills[skiselect],5,8)
	--add statuses if available
	if sadd>0 then
		change_statuseffects(sadd,true)
	end
	--recover health if available
	if skiselect==2 then
		p.hp=p.maxhp
	end
	--deduct mp & adjust last light
	p.mp-=p_skills[skiselect][5]
	set_last_light()
	--cleanup
	init_use_menu()
end

function set_last_light()
	p_skills[5][5]=p.mp
end

function draw_player()
	spr(p.sprite,p.x*8,p.y*8,1.0,1.0,flip_x)
end

function move_player()
	local movex=0
	local movey=0
	
	if btnp(⬅️) then
	 movex=-1
	 flip_x=true
	end
	if btnp(➡️) then 
		movex=1
		flip_x=false
	end
	if (btnp(⬆️))	movey=-1
	if (btnp(⬇️))	movey=1
	
	if movex!=0 or movey!=0 then
		p.dx=movex
		p.dy=movey
	end
	
	local newx=p.x+movex
	local newy=p.y+movey
	
	interact(newx,newy)
		
	if (can_move(newx,newy)) then
		p.x=mid(0,newx,127)
		p.y=mid(0,newy,63)
	else
		sfx(0)
	end
end

function interact(x,y)
	targetx=p.x+p.dx
	targety=p.y+p.dy
	--check for text
	active_text=get_text(x,y)
	--check for npc dialogue
	if btnp(🅾️) and active_dialogue==nil then 
 	talking=true
 end
 if talking then
 	for n in all(npc_data) do
  	-- distance check between player and this specific npc
  	if targetx==n.x and targety==n.y then
   	active_dialogue,face=get_npc_dialogue(n) 
   	break
  	end
 	end
 end
 if active_dialogue==nil then
 	talking=false
 	clean_reads()
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
	anim1=split([[12,14,28,44,60
	,62]],",")
	anim2=split([[13,15,29,45,61
	,63]],",")
	--text=split([[26,63]],",")
	lose={}
	win={}
	cutscene={}	
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
  draw_npc(n.sprite, n.x, n.y)
 end
end

function draw_npc(sprite,x,y)
	spr(sprite,x*8,y*8)
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
--text code

function init_text()
	--story variables
	story_beat=0
	next_text=0
	cleaned_reads=true
	ended=false
	face=64
	
	--setup tables
	text_data={}
	cutscene_data={}
	
	--common text
	locked_door="the door is locked.\nperhaps there's a\nkey nearby..."

	--adding text to dictionary
	--(x,y,order,end?,self?,switch?,story?,set_story?,text
	set_alltext()
	
end

function set_alltext()	
	temp_text_data={}
	--initial text state
--x,y,order,end?,self?,switch,story_req,set_story,text	
	--map1
	temp_text_data=split([[
	2;4;1;false;true;;0;0;as you leave this once holy \place to face the agents of \darkness, you are struck by|
 2;4;2;false;true;;0;0;a feeling that you will \likely never return.|
 2;4;3;true;true;;0;1;did your goddess feel the \same when she stood alone \against the dark gods?]],"|")
 
 --load data into text_data 
 parse_text(temp_text_data,false)	
end

function parse_text(split_table,npc_flag,id)
 local id=id or 0
	local npc_dialogue={}
	
	for i=1,#split_table do
 	local order,text_end,set_selfswitch,switch,story_req,set_story,text=unpack(split(split_table[i],";"),3,9)
 	local split_text=split(text,"\\")
 	local end_flag= text_end=="true" and true or false
		local self_flag= set_selfswitch=="true" and true or false
 	
 	if #split_text>1 then
 		local temp_text=""
 		for i=1,#split_text do
 			temp_text=temp_text..split_text[i]..chr(10)
 		end		
 		--override text with temp
 		text=temp_text
 	end
 	if npc_flag then
 		local npcid,face=unpack(split(split_table[i],";"),1,2)
 		if npcid==id then
 			add(npc_dialogue,{npcid,false,order,end_flag,self_flag,false,switch,story_req,set_story,text,face})
 		end
 	else
 		local x,y=unpack(split(split_table[i],";"),1,2)
 		add_text(x,y,order,end_flag,self_flag,switch,story_req,set_story,text)
 	end
 end
 --returns a dialogue table for a npc init
 if npc_flag then
 	return npc_dialogue
 end
end

function add_text(x,y,order,text_end,set_selfswitch,switch,story_req,set_story,text)
--x,y that triggers it
--the boolean here is being set for normal iteration as false by default
--order of text as a number
--text_end is a boolean,false means there is more,true means it is the end
--set_selfswitch is a boolean, false will allow repeats, true will not allow repeats
--the boolean here is being set for normal selfswitch use if being used, false by default
--switch is a string that will be looked up if true otherwise ignore
--story_req is a num of the required story_beat, if 0 then doesn't matter
--set_story sets the story beat
	add(text_data,{x+y*128,false,order,text_end,set_selfswitch,false,switch,story_req,set_story,text})
end

function get_text(x,y)
--search texts for x and y
	local index=x+y*128
	local exists=exists_in(text_data,index)
	
	--does something exist on this tile?
	if exists then
		exists+=next_text
		local index,read,order,text_end,set_self,self,switch,story_req,set_story,text=unpack(text_data[exists])
		local checked=text_check(read,text_end,switch,story_req,set_story)
		
		--show text if not read yet
		if checked then
			--update read
			text_data[exists][2]=true
			--update selfswitch as needed
			if set_self then
				text_data[exists][6]=true
			end
			--send text
			return text
		else
			return nil
		end
	else
		--nothing was found for this tile
		return nil
	end
end

function get_npc_dialogue(npc)
	local line_index=first_available_dialogue(npc)
	local empty=is_empty(npc.dialogue)
	
	--does this npc have dialogue?
	if empty then
		return nil
	else
		local npcid,read,order,text_end,set_self,self,switch,story_req,set_story,text,face=unpack(npc.dialogue[line_index])
		local checked=text_check(read,text_end,switch,story_req,set_story)
		
		--show text if not read yet
		if checked and ended==false then
			--update read
			npc.dialogue[line_index][2]=true
			--update selfswitch as needed
			if set_self then
				npc.dialogue[line_index][6]=true
			end
			if text_end then
				ended=true
			end
			--send text and face
			return text,face
		else
			ended=false
			return nil
		end
	end	
end

function text_check(read,text_end,switch,story_req,set_story)
	local switch_exists=exists_in(switches,switch)
	--==checks==	
	--check switches
	if switch_exists then
		if switches[switch_exists][2]==false then
			return nil
		end
	end
	--check story req
	if story_req~=0 and story_req>story_beat then
		return nil
	end
	--show text if not read yet
	if read then
			return nil
	end
	--==passes==
	--update story beat as needed
	if story_beat<set_story then
		story_beat=set_story
	end
	--iterate if needed
	if text_end then
		next_text=0
		--setup cleaner
		cleaned_reads=false
	else
		next_text+=1
	end
	return true
end

function clean_reads()
--if selfswitch is false,then 
--update reads set to true from
--interactions
	for i=1,#text_data do
		if text_data[i][6]==false and text_data[i][2] then
			text_data[i][2]=false
		end
	end
	for n in all(npc_data) do
		for i=1,#n.dialogue do
			if n.dialogue[i][6]==false and n.dialogue[i][2] then
				n.dialogue[i][2]=false
			end
		end
	end
	cleaned_reads=true
end

function first_available_dialogue(npc)
	local n=#npc.dialogue
	
	for i=1,n do
		if npc.dialogue[i][2]==false and npc.dialogue[i][6]==false then
			return i
		end
	end
	return n
end

function add_cutscene(map_num,seq,switch,obj,action,key,dest,frames,text)
--add code
end

function get_cutscene()
--add code
end

function run_cutscene()
-- parse instructions and 
-- create async func like below
-- possible actions: 
-- wait,move,text,battle,animate

--	async(function()
--		move(p,"x",64)
--  wait(30)
--		move(p,"y",32)
--	end)
end

-->8
--battlesystem code
--this is a test
__gfx__
000000000dd66600000000004444444433344454335d5dd333333333335ddd536644446666444466a782287a66666666ddbbbb333dddbb3d3333333333377333
000000000dd66607000000004ffffff133444544335ddd5333333333335d5dd36647746666cccc66799aa997666666663bdddbddddbbddb33337733363377337
007007000d111607000000004f1ff1f13444544433dd5d5355d555d55d5d5d536686686666cccc6689aaaa98665666663bbbbd133bbbdbdd3337733336666773
000770000dd16607000000004f1f1ff14f454445335d5d53dddddddddddddd536688886666cccc662aa77aa266666566ddbbdd133bddb1d33366633333373333
000770000add6907000000004ffffff1f4f4f454335d5dd3555d555d555d55d36688886666cccc662aa77aa24666666433dd11dd33db11333607073334777433
0070070007a9996100000000411111113f5f4f44335ddd53ddddddddddddddd36688886666c66c6689aaaa9844444444333dd33ddd34ddd33461047334010433
000000000a9dd6010000000033341333f4f5f44333dd5d535d555d555d555d536688886666477466799aa997444444443dd42dd333dd233d3344443333444433
0000000099d0d00000000000333410033f5f4433335d5d53ddddddddddddddd36644446666444466a782287a44444444d34422333d4422333334433333344333
33333333333333333311133333c33333333333e33399993333bbbb3333333333333333336666666622a222a222a262a233333933339333334444444462466666
3333333333b33333315551333cac333333333b3b399999933bbbbbb33bbbbbb3333333336666566622a222a222a767a233933993399333931144444444466666
333333333b3b33331556551333c33c333e333333399999833bbbbb13bebbbbeb3b333b33666556662a222a222426662439939a9339a939a34444444414456666
33333333333333b3156555133333cac3b3b33333399998833bbbb113b2bbbb2b33b3b331665555662a222a222a44444299a9aaa93aa939a94444445444466666
3333333333333b3b1555552133333c333333e3333398883333b11133bbbbebbbb3bbbb136651156622a222a222a222a29aaaa7a99a7aa7a94444444444466666
33333333333b333312555521333c3333333b3b333334233333342333bbeb2bb13bbbbb136654456622a222a222a222a2977a77799777a7794444444444466666
3333333333b3b3333155221333cac333333333e33334233333342333bb2bbb113bbbb113665555662a222a222a222a2234444449944444431144444414666666
333333333333333333333333333c333333333b3b33442233334422333bbb111334343423665665662a222a222a222a2235555553355555534444444446666666
11111111111c11111111111111111131111111111111333333331111344444433333333344444444000000000000000044666644446666444a4444a44a4aa4a4
111111111cc1c111115551111111133c111111111111113333111111334444433355533344444444000000000000000046555d6446555d644a4444a415199151
11111111111111c115565511111133c1111111111111111331111111334444435544453344444444000000000000000046cccc644655d5644a4444a411111111
111111111111cc1c156555111311cc11111ccc111111111331111111334444454444445544444444000000000000000046cccc6446cccc644a4444a411111111
111111111111111115555521c33111111cc111c1111111111111111133444444444444444444444400000000000000004d6666544d666654aaa99aaa15111151
1111111111cc1111c255552c1c33111111111111111111111111111135444444444444444444444400000000000000004dd5d5144dd5d514191991914a4444a4
11111111cc11c1111c5522c111cc1111111111111111111111111111344444444444444444444444000000000000000044dd554444dd55444a4444a44a4444a4
111111111111111111cccc1111111111111111111111111111111111344444444444444444444444000000000000000044d5d14444d5d1444a4444a44a4444a4
6666666666666666656665666664666676777677777777779999999933444444444444443444444434444443000000000000000000000000333233233bb2bb2b
66666666666666665555555566666666666666667f777777994999993344444444444444334444443344444300000000000000000000000033232332bb2b2bb2
666666666656666666656665666666567776777677777777999999493344444444444444334444443544444300000000000000000000000032333332b2b333b2
6666666666666566555555556666666666666666777777f7944499993344444444444444334444445444444500000000000000000000000032333323b2b3bb2b
6666666666666666656665666666666676777677777777779944499935444444444444443344444444444444000000000000000000000000332323233b2b2b2b
6666666666666666555555556656669666666666777777779999949934444444344444443544444444444444000000000000000000000000332332333b2bb2b3
6666666666665666666566656666666677767776777f777799499999344433443333334434444444444444440000000000000000000000003332333333b2bb33
666666666666666655555555666666666666666677777777999999493333333333333333344444444444444400000000000000000000000033332333333b2b33
0005555555555555dd66655555555555000555557070755555555555000000000000000000000000000000000000000000000000000000000000000000000000
0557777777777777dd66699999999999055999997777722222222222000000000000000000000000000000000000000000000000000000000000000000000000
0575555555555555d111655555555555059555557272755555555555000000000000000000000000000000000000000000000000000000000000000000000000
5755111111111111dd16611111111111595511115777111111111111000000000000000000000000000000000000000000000000000000000000000000000000
57511111111111115dd6111111111111595111115251111111111111000000000000000000000000000000000000000000000000000000000000000000000000
57511111111111115951111111111111595111115251111111111111000000000000000000000000000000000000000000000000000000000000000000000000
57511111111111115951111111111111595111115251111111111111000000000000000000000000000000000000000000000000000000000000000000000000
57511111111111115951111111111111595111115251111111111111000000000000000000000000000000000000000000000000000000000000000000000000
575111111111111159511111dd666555000555555251111166666555000000000000000000000000000000000000000000000000000000000000000000000000
575111111111111159511111dd66677705522222525111116b6b6777000000000000000000000000000000000000000000000000000000000000000000000000
575111111111111159511111d1116555052555555251111166666555000000000000000000000000000000000000000000000000000000000000000000000000
575111111111111159511111dd166111525511115251111156661111000000000000000000000000000000000000000000000000000000000000000000000000
5751111111111111595111115dd61111525111115251111157511111000000000000000000000000000000000000000000000000000000000000000000000000
57511111111111115951111157511111525111115251111157511111000000000000000000000000000000000000000000000000000000000000000000000000
57511111111111115951111157511111525111115251111157511111000000000000000000000000000000000000000000000000000000000000000000000000
57511111111111115951111157511111525111115251111157511111000000000000000000000000000000000000000000000000000000000000000000000000
03555555022555554404455522225555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0337777702f7777742024777f22f7777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3333555522f5555528882555ffff5555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4ff4111122221111898981114ff4f111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
54411111228811112888211142242111777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5751111157511111528211114444f111077777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
57511111575111115888111157511111007777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
57511111575111115751111157511111000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0004f0000001100000044000000aa000000000000000000000000000000000000003f00400066000000220040008600600086006000d6006000d600600000000
000ff000000440000004f00000aaf000000000000000000000000000000000000003f7040066f0000002f004008df006008d4006000df006000d400600000000
00222000009990000044f000000af000000000000000000000322000000aa000003330040006f0000022f0040085500600855006001110050011100500000000
002222f0009999400042e0000001c00000099000000110000232200000aaaa000033333f000530000022288f005566f500556645001166f50011664500000000
0022f000009940000002200000011000000ff00000044000022440000a0ff0a000033f040005500000228f04055d6005055d6005011d6005011d600500000000
0055500000ddd00000022f0000011f0000fccf00004aa4000043340000feef000003300400055f000028800405ddd00005ddd00001ddd00501ddd00500000000
0050500000d0d0000022ee000011cc000005500000055000000220000002200000333304005533000028880405d0d00005d0d00001d0d00501d0d00500000000
0050500000d0d0000222eee00111ccc00005050000050500000202000002020003333330055533300228888050d0d00050d0d00010d0d00010d0d00000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000330000002220000054400d000000d0004300000000000000110000000000000000000000000000000000000000000000000000707070000000000
0007700600033300000f2f005004450550d00d050003300000000000000111000000000000000000000000000000000000000000000000000777770600000000
0066600600434000022444ff445444545505505500222000000c0000004140000000000000000000000000000000000000000000000000000777770600000000
06070706003434330244444f44445444555555550022223000d7c000001414110000000000000000000000000000000000000000000000000727270600000000
60777075004443060f04440f4404440555055055002223000d7ccc00004441060000000000000000000000000000000000000000000000000177710600000000
0006000503555600000555005505450450055005005550000c1c1c00015556000000000000000000000000000000000000000000000000000111115200000000
0060600033505000000f0f0000040400d055550d005050000dcccd00115050000000000000000000000000000000000000000000000000000115550200000000
0060600030303000000f0f0000050500005005000050500000000000101010000000000000000000000000000000000000000000000000001150500000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aa000000aa000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aaf00000aaf000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010aaf00070aaf000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011a6700077a67000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000111666f0777666f0
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011066f0077066f00
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001006700070067000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066770000667700
05440000000044500544000000004450000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05400000000004500540000000000450000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00540000000045000054000000004500000000222200000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00544000000445000054400000044500000000f22f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00055420024550000005542002455000000000ffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000228228220000000022822822000000022f4ff4f2200000000000000000000000000000000000000000000000000000000000000000000000000000000000
02202288882202200220226666220220002f22422422f24000000000000000000000000000000000000000000000000000000000000000000000000000000000
08829528825928800882826226282880022ff444444ffff000000000000000000000000000000000000000000000000000000000000000000000000000000000
002899288299820000282629226282000ff0444444440ff000000000000000000000000000000000000000000000000000000000000000000000000000000000
00288288882882000028262a926282000ff0044444400ff000000000000000000000000000000000000000000000000000000000000000000000000000000000
000288888888200000022299a9222000000004444440044000000000000000000000000000000000000000000000000000000000000000000000000000000000
00002288882200000000229a9a220000000005555550044000000000000000000000000000000000000000000000000000000000000000000000000000000000
00002828828200000000299aa9a20000000005555550044000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000028888200000000a09aaa9909000000002f002f0454400000000000000000000000000000000000000000000000000000000000000000000000000000000
00000028820000000000099a99a00000000002200f20445400000000000000000000000000000000000000000000000000000000000000000000000000000000
000000022000000000909a999a990a0000000ff00ff0044000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333311133333333333333333333333333333333333333333333333333333333333333333333333333333333333
3333333333b3333333333333333333333333333331555133333333339a9333333333333333b333333333333333333333333333333333333333b3333333333333
333333333b3b33333333333333333333333333331556551333333333a899999a333333333b3b3333333333333333333333333333333333333b3b333333333333
33333333333333b333333333333333333333333315556513333333339398898933333333333333b333333333333333333333333333333333333333b333333333
3333333333333b3b3333333333333333333333331255555133333333999338383333333333333b3b3333333333333333333333333333333333333b3b33333333
33333333333b333333333333333333333333333312556551333333338883333333333333333b333333333333333333333333333333333333333b333333333333
3333333333b3b3333333333333333333333333333122551333333333333333333333333333b3b3333333333333333333333333333333333333b3b33333333333
33333333333333333333333333333333333333330011113333333333333333333333333333333333333333333333333333333333333333333333333333333333
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333334a4444a4333333333333333333333333
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333334a4444a4333333333333333333333333
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333334a4444a4333333333333333333333333
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333334a4444a4333333333333333333333333
333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333aaa99aaa333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333319199191333333333333333333333333
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333334a4444a4333333333333333333333333
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333334a4444a4333333333333333333333333
331113333333333333333333333333333333333333333333333333333333333333111333333333333dd666333333333333333333333333333333333333333333
315551333333333333333333333333333333333333333333333333333333333331555133333333333dd666373333333333333333333333333333333333333333
155655133333333333333333333333333333333333333333333333333333333315565513333333333d1116373333333333333333333333333333333333333333
155565133333333333333333333333333333333333333333333333333333333315556513333333333dd166373333333333333333333333333333333333333333
125555513333333333333333333333333333333333333333333333333333333312555551333333333add69373333333333333333333333333333333333333333
1255655133333333333333333333333333333333333333333333333333333333125565513333333337a999613333333333333333333333333333333333333333
312255133333333333333333333333333333333333333333333333333333333331225513333333333a9dd6313333333333333333333333333333333333333333
0011113333333333333333333333333333333333333333333333333333333333001111333333333399d3d3333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333311111111
33333333333333333633363336333633363336333633363336333633333333333333333333333333333333333333333333333333333333333333333311111111
33333333333333330603060306030603060306030603060306030603333333333333333333333333333333333333333333333333333333333333333311111111
33333333333333333033303330333033303330333033303330333033333333333333333333333333333333333333333333333333333333333333333311111111
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333311111111
33333333333333333633363336333633363336333633363336333633333333333333333333333333333333333333333333333333333333333333333311111111
33333333333333330603060306030603060306030603060306030603333333333333333333333333333333333333333333333333333333333333333311111111
33333333333333333033303330333033303330333033303330333033333333333333333333333333333333333333333333333333333333333333333311111111
11111111333333333333333333333333333333333333333333333333333333333333333333333333111111111111111111111111111111111111111111111111
1111111133b333333633363333333333333333333333333336333633333333333333333333333333111111111111111111111111111111111111111111111111
111111113b3b33330603060333333333333333333333333306030603333333333333333333333333111111111111111111111111111111111111111111111111
11111111333333b33033303333333333333333333333333330333033333333333333333333333333111111111111111111111111111111111111111111111111
1111111133333b3b3333333333333333333333333333333333333333333333333333333333333333111111111111111111111111111111111111111111111111
11111111333b33333633363333333333333333333333333336333633333333333333333333333333111111111111111111111111111111111111111111111111
1111111133b3b3330603060333333333333333333333333306030603333333333333333333333333111111111111111111111111111111111111111111111111
11111111333333333033303333333333333333333333333330333033333333333333333333333333111111111111111111111111111111111111111111111111
11111111111111113333333333333333333333333333333333333333111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111113633363330333033303330333033303336333633111111111111111111111111111111111111111111111111115551111111111111111111
11111111111111110603060305030503050305030503050306030603111111111111111111111111111111111111111111111111155655111111111111111111
11111111111111113033303330333033303330333033303330333033111111111111111111111111111111111111111111111111155565111111111111111111
11111111111111113333333333333333333333333333333333333333111111111111111111111111111111111111111111111111125555511111111111111111
11111111111111113633363330333033303330333033303336333633111111111111111111111111111111111111111111111111c255655c1111111111111111
111111111111111106030603050305030503050305030503060306031111111111111111111111111111111111111111111111111c2255c11111111111111111
1111111111111111303330333033303330333033303330333033303311111111111111111111111111111111111111111111111111cccc111111111111111111
111111111111111111111111666666666666666666666666111111111111111111111111111111111111111111111111111c1111111111111111111111111111
1155511111111111111111116666666666666666666666661111111111111111111111111111111111111111111111111cc1c111111111111111111111111111
155655111111111111111111665666666656666666566666111111111111111111111111111111111111111111111111111111c1111111111111111111111111
1555651111111111111111116666656666666566666665661111111111111111111111111111111111111111111111111111cc1c111111111111111111111111
12555551111111111111111166666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111
c255655c111111111111111166666666666666666666666611111111111111111111111111111111111111111111111111cc1111111111111111111111111111
1c2255c11111111111111111666656666666566666665666111111111111111111111111111111111111111111111111cc11c111111111111111111111111111
11cccc11111111111111111166666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111c111111111111666666666666666666666666111c1111111111111111111111111111111111111111111111111111111111111111111111111111
111111111cc1c111111111116666666666666666666666661cc1c111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111c111111111665666666656666666566666111111c1111111111111111111111111111111111111111111111111111111111111111111111111
111111111111cc1c111111116666656666666566666665661111cc1c111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111166666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111cc11111111111166666666666666666666666611cc1111111111111111111111111111111111111111111111111111111111111111111111111111
11111111cc11c11111111111666656666666566666665666cc11c111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111166666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111166666666666666666666666611111111111111111111111111111111111111111111111111111111111111113333333333333333
11111111111111111111111166666666666666666666666611111111111111111111111111555111111111111111111111111111111111113333333333333333
11111111111111111111111166566666665666666656666611111111111111111111111115565511111111111111111111111111111111113333333333333333
11111111111111111111111166666566666665666666656611111111111111111111111115556511111111111111111111111111111111113333333333333333
11111111111111111111111166666666666666666666666611111111111111111111111112555551111111111111111111111111111111113333333333333333
111111111111111111111111666666666666666666666666111111111111111111111111c255655c111111111111111111111111111111113333333333333333
1111111111111111111111116666566666665666666656661111111111111111111111111c2255c1111111111111111111111111111111113333333333333333
11111111111111111111111166666666666666666666666611111111111111111111111111cccc11111111111111111111111111111111113333333333333333
11111111111111111111111166666666666666666666666611111111111111111111111111111111111111113333333333333333333333333311133333333333
11111111115551111111111166666666666666666666666611111111111111111111111111111111111111113333333333333333333333333155513333333333
11111111155655111111111166566666665666666656666611111111111111111111111111111111111111113333333333333333333333331556551333333333
11111111155565111111111166666566666665666666656611111111111111111111111111111111111111113333333333333333333333331555651333333333
11111111125555511111111166666666666666666666666611111111111111111111111111111111111111113333333333333333333333331255555133333333
11111111c255655c1111111166666666666666666666666611111111111111111111111111111111111111113333333333333333333333331255655133333333
111111111c2255c11111111166665666666656666666566611111111111111111111111111111111111111113333333333333333333333333122551333333333
1111111111cccc111111111166666666666666666666666611111111111111111111111111111111111111113333333333333333333333330011113333333333
111c1111111111111111111166666666666666666666666633333333333333336566656665666566656665666566656633333333333333333333333333333333
1cc1c111111111111111111166666666666666666666666633333333333333335555555555555555555555555555555533333333333333333333333333333333
111111c1111111111111111166566666665666666656666633333333333333336665666566656665666566656665666533333333333333333333333333333333
1111cc1c111111111111111166666566666665666666656633333333333333335555555555555555555555555555555533333333333333333333333333333333
11111111111111111111111166666666666666666666666633333333333333336566656665666566656665666566656633333333333333333333333333333333
11cc1111111111111111111166666666666666666666666633333333333333335555555555555555555555555555555533333333333333333333333333333333
cc11c111111111111111111166665666666656666666566633333333333333336665666566656665666566656665666533333333333333333333333333333333
11111111111111111111111166666666666666666666666633333333333333335555555555555555555555555555555533333333333333333333333333333333
111111111111111133333333666666666666666666666666333333336566656665666566666666666aaaaaa66566656633333333333333333333333333333333
11111111111111113333333366666666666666666666666633333333555555555555555566666666a666666a5555555533333333333333333333333333333333
11111111111111113333333366566666665666666656666633333333666566656665666566666666a667766a6665666533333333333333333333333333333333
11111111111111113333333366666566666665666666656633333333555555555555555566666666a676676a5555555533333333333333333333333333333333
11111111111111113333333366666666666666666666666633333333656665666566656666666666a676676a6566656633333333333333333333333333333333
11111111111111113333333366666666666666666666666633333333555555555555555566666666a667766a5555555533333333333333333333333333333333
11111111111111113333333366665666666656666666566633333333666566656665666566666666a666666a6665666533333333333333333333333333333333
111111111111111133333333666666666666666666666666333333335555555555555555666666666aaaaaa65555555533333333333333333333333333333333
11111111333333333333333333333333666666666666666666666666444444446666666666666666666666666566656633333333333333333333333333333333
111111113333333333333333333333336666666666666666666666661144444466666666666666666666666655555555333333333333333333b3333333333333
11111111333333333333333333333333665666666656666666566666444444446666666666666666666666666665666533333333333333333b3b333333333333
1111111133333333333333333333333366666566666665666666656644444454666666666666666666666666555555553333333333333333333333b333333333
111111113333333333333333333333336666666666666666666666664444444466666666666666666666666665666566333333333333333333333b3b33333333
1111111133333333333333333333333366666666666666666666666644444444666666666666666666666666555555553333333333333333333b333333333333
111111113333333333333333333333336666566666665666666656661144444466666666666666666666666666656665333333333333333333b3b33333333333
11111111333333333333333333333333666666666666666666666666444444446666666666666666666666665555555533333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333656665666566656665666566656665666566656633333333333333333333333333333333
3333333333b333333333333333333333333333333333333333333333555555555555555555555555555555555555555533b33333333333333333333333333333
333333333b3b3333333333333333333333333333333333333333333366656665666566656665666566656665666566653b3b3333333333333333333333333333
33333333333333b333333333333333333333333333333333333333335555555555555555555555555555555555555555333333b3333333333333333333333333
3333333333333b3b3333333333333333333333333333333333333333656665666566656665666566656665666566656633333b3b333333333333333333333333
33333333333b333333333333333333333333333333333333333333335555555555555555555555555555555555555555333b3333333333333333333333333333
3333333333b3b3333333333333333333333333333333333333333333666566656665666566656665666566656665666533b3b333333333333333333333333333
33333333333333333333333333333333333333333333333333333333555555555555555555555555555555555555555533333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333111333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333331555133333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333315565513333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333315556513333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333312555551333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333312556551333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333331225513333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333300111133333333333333333333333333

__gff__
0000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
3434343434043232323232161616051610101010101010102020222020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
34350a3534043208331932101610052e10121010101020202020202020212020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
340b1b0b34103233333332101010051010101010202022202021202020201010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
340b1a0b34103233333332101010051010102020202020202020202010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
34341a3434103232333232101016051020202020202020202022201010101110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1717271717101413271413141010051020212020202021201010101012101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10102728282828283a2828131417051020202020201010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
04043717171039292c2929323232051020201010101010111010101011101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3232313232132929292929313132051010101010111010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3231313119323829292932313132051010101010101010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3231313131321039292932310932051010101010101012101010101012101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3209313131321439292932323232051110101010101010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3232323232321039292910100404051010101010101010101110101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0606060606060629292906060606071010101110101010101010101010101210000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10101c101110102929291c101010101010101010101010101012101010111010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10101010101c1029292910101110161610101010101010101010101011101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000400000d02000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002d07000000390703907039070390603905039050390303901000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000600001305013050220502e05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300000f62015620000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
