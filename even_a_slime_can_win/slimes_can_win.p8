pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
--even a slime can win
--by mrtravelingbard

--global variables
wait=0
wait_cnt=0
main_sel=1

--init scenes
function init_intro()
	scene="intro"
	set_wait(60)
	_update=update_intro
	_draw=draw_intro
end

function init_mainmenu()
	scene="mainmenu"
	menu_sel=1
	menu_options={"new game","continue"}
	set_wait(30)
	_update=update_mainmenu
	_draw=draw_mainmenu
end

function init_savemenu()
	scene="savemenu"
	menu_sel=1
	set_wait(30)
	_update=update_savemenu
	_draw=draw_savemenu
end

function init_game()
	scene="game"
	game_win=false
	game_over=false
	menu_active=false
	bbeg_defeated=false
	--setup calls
	init_map() --in map code
	init_titles()
	init_skills()
	init_skillpools()
	--init_npcs() --in dialogue code
	init_party()
	set_wait(30)
	_update=update_game
	_draw=draw_game
end

function init_battle()
	scene="battle"
	menu_sel=1
	set_wait(30)
	_update=update_battle
	_draw=draw_battle
end

--init game data
function init_titles()
	titles={
		immortal={
			name="The Immortal",
			sprite=8,
			arrow=133,
			zones={
				{label="miss",  zone_start=0,   zone_stop=90,  result="miss"},
				{label="block", zone_start=90,  zone_stop=200, result="block"},
				{label="hit",   zone_start=200, zone_stop=330, result="hit"},
				{label="taunt",  zone_start=330, zone_stop=360, result="taunt"}
			}
		},
		quick_blow={
			name="The Quick Blow",
			sprite=1,
			arrow=132,
			zones={
				{label="miss",   zone_start=0,   zone_stop=100, result="miss"},
				{label="hit",    zone_start=100, zone_stop=270, result="hit"},
				{label="fumble", zone_start=270, zone_stop=310, result="miss"},
				{label="crit",   zone_start=310, zone_stop=360, result="crit"}
			}
		},
		eldest={
			name="The Eldest's Legacy",
			sprite=1,
			arrow=132,
			zones={
				{label="miss",   zone_start=0,   zone_stop=60,  result="miss"},
				{label="bonus",  zone_start=60,  zone_stop=140, result="bonus"},
				{label="hit",    zone_start=140, zone_stop=330, result="hit"},
				{label="crit",   zone_start=330, zone_stop=360, result="crit"}
			}
		},
		slip_master={
			name="The Slip Master",
			sprite=1,
			arrow=132,
			zones={
				{label="miss",   zone_start=0,   zone_stop=100, result="miss"},
				{label="hit",    zone_start=100, zone_stop=270, result="hit"},
				{label="fumble", zone_start=270, zone_stop=310, result="miss"},
				{label="dodge",   zone_start=310, zone_stop=360, result="dodge"}
			}
		},
		coiled={
			name="The Coiled One",
			sprite=1,
			arrow=132,
			zones={
				{label="miss",   zone_start=0,   zone_stop=100, result="miss"},
				{label="hit",    zone_start=100, zone_stop=270, result="hit"},
				{label="delay", zone_start=270, zone_stop=310, result="delay"},
				{label="miss",   zone_start=310, zone_stop=360, result="miss"}
			}
		},
		constrictor={
			name="The Constrictor",
			sprite=1,
			arrow=132,
			zones={
				{label="miss",   zone_start=0,   zone_stop=100, result="miss"},
				{label="hit",    zone_start=100, zone_stop=270, result="hit"},
				{label="constrict", zone_start=270, zone_stop=310, result="constrict"},
				{label="miss",   zone_start=310, zone_stop=360, result="miss"}
			}
		},
		red={
			name="The Red",
			sprite=15,
			arrow=134,
			zones={
				{label="miss", zone_start=0,   zone_stop=160, result="miss"},
				{label="hit",  zone_start=160, zone_stop=300, result="hit"},
				{label="crit", zone_start=300, zone_stop=340, result="crit"},
				{label="free", zone_start=340, zone_stop=360, result="free"}
			}
		},
		once_red={
			name="The Once Red",
			sprite=29,
			arrow=136,
			zones={
				{label="miss", zone_start=0,   zone_stop=160, result="miss"},
				{label="hit",  zone_start=160, zone_stop=300, result="hit"},
				{label="crit", zone_start=300, zone_stop=340, result="crit"},
				{label="free", zone_start=340, zone_stop=360, result="free"}
			}
		},
		green={
			name="The Green",
			sprite=22,
			arrow=135,
			zones={
				{label="miss", zone_start=0,   zone_stop=160, result="miss"},
				{label="hit",  zone_start=160, zone_stop=300, result="hit"},
				{label="crit", zone_start=300, zone_stop=340, result="crit"},
				{label="free", zone_start=340, zone_stop=360, result="free"}
			}
		},
		metal_sworn={
			name="The Metalsworn",
			sprite=57,
			arrow=140,
			zones={
				{label="miss", zone_start=0,   zone_stop=160, result="miss"},
				{label="hit",  zone_start=160, zone_stop=300, result="hit"},
				{label="crit", zone_start=300, zone_stop=340, result="crit"},
				{label="free", zone_start=340, zone_stop=360, result="free"}
			}
		},
		metal={
			name="The Metal",
			sprite=50,
			arrow=139,
			zones={
				{label="miss", zone_start=0,   zone_stop=160, result="miss"},
				{label="hit",  zone_start=160, zone_stop=300, result="hit"},
				{label="crit", zone_start=300, zone_stop=340, result="crit"},
				{label="free", zone_start=340, zone_stop=360, result="free"}
			}
		},
		creeping_death={
			name="The Creeping Death",
			sprite=43,
			arrow=138,
			zones={
				{label="miss", zone_start=0,   zone_stop=160, result="miss"},
				{label="hit",  zone_start=160, zone_stop=300, result="hit"},
				{label="crit", zone_start=300, zone_stop=340, result="crit"},
				{label="free", zone_start=340, zone_stop=360, result="free"}
			}
		},
		kingslayer={
			name="The Kingslayer",
			sprite=36,
			arrow=137,
			zones={
				{label="miss", zone_start=0,   zone_stop=160, result="miss"},
				{label="hit",  zone_start=160, zone_stop=300, result="hit"},
				{label="crit", zone_start=300, zone_stop=340, result="crit"},
				{label="free", zone_start=340, zone_stop=360, result="free"}
			}
		}
	}
end

function init_skills()
	skills={
		--immortal
		immortal=init_skill("immortal,passive,0,resurrect at beginning of round"),
		revenge=init_skill("revenge,active,0,deals damage based on # of deaths since last use"),
		--quick_blow
		stunning=init_skill("stunning,passive,0,all attacks have a chance to stun"),
		quick_blow=init_skill("quick blow,active,0,deals damage with higher priority"),
		--eldest
		legacy=init_skill("eldest's legacy,passive,0,increased HP by 300%"),
		gift=init_skill("eldest's gift,active,0,give a portion of your hp to others 1:3"),
		--slip_master
		slippery=init_skill("slippery,passive,0,upon dodging an attack inflict prone"),
		slip_stance=init_skill("slip stance,active,0,dodge all physical attacks but cannot act"),
		--coiled
		capitalize=init_skill("capitalize,passive,0,deals double damage to stunned, proned, or constrict"),
		coil=init_skill("coil,active,0,charges for x turns and deals x * damage"),
		--constrictor
		lingering=init_skill("lingering impact,passive,0,when a debuff caused by you is removed add new debuffs"),
		constrict=init_skill("constrict,active,0,constrict target based on strength"),
		--red
		red=init_skill("red,passive,0,can use magic and gain mp based on magic stat"),
		gold_burn=init_skill("gold burn,passive,0,each coin used to regain mp reduces maxhp by 1"),
		recover_mp=init_skill("recover mp,active,1,use a coin to recover all mp & increase max by 3"),
		--once_red
		once_red=init_skill("once red,passive,0,can use magic and retains mp from being red"),
		mana_dart=init_skill("mana dart,active,1,magical damage based on remaining mana"),
		--green
		green=init_skill("green,passive,0,can absorb herbs as charges to be used in healing"),
		healing_poultice=init_skill("healing poultice,active,0,use 1 charge to heal a single target"),
		the_green=init_skill("the green,active,0,use 3 charges to heal the party"),
		--metal_sworn
		metal_sworn=init_skill("metal_sworn,passive,0,once the metal is absorbed a new power will be born"),
		absorb=init_skill("absorb,active,0,restores a low amount of hp to self"),
		--metal
		metal=init_skill("metal,passive,0,damage taken reduced by 50%"),
		sword=init_skill("sword,active,0,deals 2x damage & can inflict bleeding"),
		shield=init_skill("shield,active,0,takes the hits for the party for a turn"),
		--creeping_death
		purple=init_skill("purple,passive,0,physical attacks dealt or taken can inflict poison"),
		poison_impact=init_skill("poison impact,active,0,deals damage based on # of poison stacks"),
		--kingslayer
		kingslayer=init_skill("kingslayer,passive,0,deal 2x total damage to boss enemies or 3x if bleeding"),
		sharpen=init_skill("sharpen,active,0,increases attack stat by 4 (stacks up to 3)"),
		--spells
		fire_dart=init_skill("fire dart,active,1,fire damage to single target"),
		lesser_fireball=init_skill("lesser fireball,active,1,fire damage & chance to inflict burn"),
		lesser_heat=init_skill("lesser heat,active,1,if wearing metal target takes fire damage & def debuff"),
		cold_breeze=init_skill("cold breeze,active,1,ice damage to single target"),
		lesser_frost=init_skill("lesser frost,active,1,ice damage & chance to inflict slow"),
		static_bolt=init_skill("static bolt,active,1,lightning damage to random target"),
		lesser_lightning=init_skill("lesser lightning,active,1,lightning damage & chance to inflict stun"),
		minor_shielding=init_skill("minor shielding,active,1,increases defense by 4 to single target"),
		minor_bulwark=init_skill("minor bulwark,active,1,increases defense by 4 to party")
	}
end

function init_skillpools()
	skill_pools={
		immortal=init_skillpool("immortal,revenge"),
		quick_blow=init_skillpool("stunning,quick_blow"),
		eldest=init_skillpool("legacy,gift"),
		slip_master=init_skillpool("slippery,slip_stance"),
		coiled=init_skillpool("capitalize,coil"),
		constrictor=init_skillpool("lingering,constrict"),
		red=init_skillpool("red,gold_burn,recover_mp"),
		once_red=init_skillpool("once_red,mana_dart"),
		green=init_skillpool("green,healing_poultice,the_green"),
		metal_sworn=init_skillpool("metal_sworn,absorb"),
		metal=init_skillpool("metal,sword,shield"),
		creeping_death=init_skillpool("purple,poison_impact"),
		kingslayer=init_skillpool("kingslayer,sharpen"),
		shop_1=init_skillpool("fire_dart,cold_breeze,static_bolt,minor_shielding"),
		shop_2=init_skillpool("lesser_fireball,lesser_heat,lesser_frost,lesser_lightning,minor_bulwark")
	}
end

--init helper functions
function init_temp_stats()
	--1=str 2=dex 3=con 4=mag
	--5=atk 6=def 7=spd 8=matk 
	--9=mdef 10=maxhp 11=maxmp
	temp_stats={}
	for i=1,11 do
		add(temp_stats,0)
	end
	return temp_stats
end

function init_skill(string_data)
	local name,type,mp_cost,desc=unpack(split(string_data))
	return {
		name=name,
		type=type,
		mp_cost=mp_cost,
		desc=desc
	}
end

function init_skillpool(string_data)
	local skill_set={}
	for name in all(split(string_data)) do 
		add(skill_set,skills[name])
	end
	return skill_set
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
	local option_cnt=#menu_options
	if wait_cnt==2 then
		if menu_control(#menu_options) then
			if menu_sel==1 then init_game() end
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
		if (not game_over) then
			update_map()
			--move_party()
			check_win_lose()
		else
			if (btnp(5)) extcmd("reset")
		end
	end
end

--update menus, windows, etc
-->8
--draw code

--draw scenes
function draw_intro()
	cls()
	print("a mr traveling bard production",0,60,7)
end

function draw_mainmenu()
	cls()
	if wait_check() and wait_cnt<2 then
		wait_cnt+=1
		set_wait(60)
	end
	if wait_cnt>=1 then
		print("even a slime can win",20,60,7)
	end
	if wait_cnt==2 then
		for n=1,#menu_options do
			print((menu_sel==n and ">" or " ")..menu_options[n],40,88+(n*8),7)
		end
	end
end

function draw_savemenu()
	cls()
	if wait_check() then
		print("placeholder for save menu",0,0,7)
	end
end

function draw_game()
	cls()
	if game_over==false then
		if wait_check() then
			draw_map()
		end
	else
		draw_win_lose()
	end
end

--draw menus, windows, etc

--draw misc
function draw_win_lose()
	camera()
	if game_win then
	 print("★ you win! ★",37,64,7) 
	else 
		print("game over! :(",38,64,7)
 end
 print("press ❎ to play again",20,72,5)
end
-->8
--dialogue code

-- flags
flags={}

function set_flag(key,val)
 flags[key]=val
end

function get_flag(key)
 return flags[key]
end

-- dialogue engine
dlg={
 active=false,
 npc=nil,     
 entry=nil,   
 page=1,      
 on_end=nil,  
 --text box config
 box_x=4,
 box_y=88,
 box_w=120,
 box_h=36,
 pad=4,
 name_h=8
}

function dlg_find_entry(npc)
 for entry in all(npc.dialogue) do
  if entry.cond==nil or entry.cond() then
   return entry
  end
 end
 return nil
end

function dlg_start(npc)
 local entry=dlg_find_entry(npc)
 if entry==nil then return end

 dlg.active=true
 dlg.npc=npc
 dlg.entry=entry
 dlg.page=1
 dlg.on_end=entry.on_end
end

function dlg_advance()
 if not dlg.active then return end
 
 if dlg.page<#dlg.entry.pages then
  dlg.page+=1
 else
  dlg_close()
 end
end

function dlg_close()
 local cb=dlg.on_end
 dlg.active=false
 dlg.npc=nil
 dlg.entry=nil
 dlg.on_end=nil
 if cb then cb() end
end

function dlg_update()
 if not dlg.active then return end

 if btnp(4) then
  dlg_advance()
 end
end

function dlg_draw()
 if not dlg.active then return end

 local bx=dlg.box_x
 local by=dlg.box_y
 local bw=dlg.box_w
 local bh=dlg.box_h
 local p=dlg.pad
	
	-- shadow
 rectfill(bx+2,by+2,bx+bw+2,by+bh+2,0)

 -- box body
 rectfill(bx,by,bx+bw,by+bh,1)
 rect(bx,by,bx+bw,by+bh,7)

 -- speaker
 if dlg.npc and dlg.npc.name then
  local name=dlg.npc.name
  local nw=#name*4+p*2
  rectfill(bx,by-dlg.name_h,bx+nw,by,1)
  rect(bx,by-dlg.name_h,bx+nw,by,7)
  print(name,bx+p,by-dlg.name_h+1,10)
 end

 -- page text
 local txt=dlg.entry.pages[dlg.page]
 print(txt,bx+p,by+p,7)

 -- advance prompt w/ blink
 if (time()*4)%2<1 then
  print("v",bx+bw-6,by+bh-6,6)
 end
end


function init_npcs()
	--npcs
npcs={
 guard={
  name="guard",
  x=60, y=40,
  dialogue={
   {
   	cond=function()
     return not get_flag("enemies_defeated")
    end,
    pages={
     "the city is under\nattack! monsters\nfrom the east!",
     "please, you must\nhelp us before it\nis too late!",
    },
    on_end=function()
     set_flag("quest_started", true)
    end,
   },
   {
    cond=function()
     return get_flag("enemies_defeated")
      and not get_flag("mayor_thanked")
     end,
    pages={
     "you did it! the\nmonsters are gone!",
     "the mayor wants to\nspeak with you at\nthe town hall.",
    },
    on_end=nil,
   },
   {
    pages={
     "the city is safe\nonce more, thanks\nto you.",
  	 },
    on_end=nil,
   }
  }
 },
	merchant={
  name="merchant",
  x=90, y=50,
  dialogue={
   {
    cond=function()
     return not get_flag("quest_started")
    end,
    pages={
     "sorry, i'm closed\nright now. come\nback later.",
    },
    on_end=nil,
    },
   {
    pages={
     "welcome! looking\nfor supplies before\nyour journey?",
     "i have potions,\nropes, and maps\navailable.",
    },
    on_end=function()
     set_flag("merchant_visited", true)
    end,
   }
  }
 }
}
end
-->8
--battlesystem code

function init_battle()
	--game states
	battle_state={
		player_turn=1,
		player_spin=2,
	 	player_result=3,
		enemy_turn=4,
		anim=5,
		win=6,
		lose=7
	}
	--battle test data
	battle={
		state=1,
		active_char=1,
		enemy={
			name="rat",
			sprite=70,
			hp=15,
			maxhp=15,
			atk=10,
			def=4,
			status={}
		},
		message="your turn!",
		battle_select=1,
		anim_timer=0,
		frames=0,
		player_defends=false,
		enemy_defends=false,
		result=nil
	}
	--anim config
	anim={
		frames=0,
		maxframes=0,
		fn=nil,
		done=nil
	}
	
	--wheel init
	wheel={
  angle=0,
  speed=2,
  spinning=false
	}
	zones={
  {label="miss",zone_start=0,zone_stop=200,result="miss"},
  {label="hit",zone_start=200,zone_stop=320,result="hit"},
  {label="crit",zone_start=320,zone_stop=360,result="crit"}
	}
	
	init_battlers()
	
	--setup main functions
	scene="battle"
	_update = update_battle 
	_draw = draw_battle
end

-- init battler helper
function init_battlers()
	party={
  {name="knight",hp=30,maxhp=30,atk=8,zones=zones_physical},
  {name="mage",hp=20,maxhp=20,atk=12,zones=zones_magic},
  {name="rogue",hp=22,maxhp=22,atk=7,zones=zones_rogue},
  {name="healer",hp=18,maxhp=18,atk=4,zones=zones_heal}
	}
	e_spr=battle.enemy.sprite
	p_spr=2
end

-- update battle scene
function update_battle()
	battle.anim_timer-=1
		
	if battle.state==battle_state.anim then
		anim.frames-=1
		if anim.frames<=0 then anim.done() end
		return
	end		
	if battle.state==battle_state.player_turn then
		update_battle_menu()
	elseif battle.state==battle_state.player_spin then
  update_wheel()
  if btnp(4) then
   battle.result=check_zone(wheel.angle)
   battle.state=battle_state.result
  end
 elseif battle.state==battle_state.player_result then
  apply_result(battle.result)
  -- advance to next character or enemy turn
	elseif battle.state==battle_state.enemy_turn then
		--wait for animation, then enemy acts
		if battle.anim_timer<=0 then
			local dmg=max(battle.enemy.atk+flr(rnd(3))-p.def,1)
			if player_defends then
				dmg=max(flr(dmg/2),1)
			end
			play_anim(
				dmg*3,
				function()
					local shake=flr(rnd(3))-1
					rectfill(0,0,127,127,0)
					spr(e_spr,59,32+shake)
					spr(p_spr,58,52)
				end,
				function()
					p.hp-=dmg
					battle.message=battle.enemy.name.." hits for "..dmg.."!"
					battle.anim_timer=30
					battle.state=battle_state.player_turn
				end)
			--check lose
			if p.hp<=0 then
				p.hp=0
				battle.state=battle_state.lose
				battle.message="you lost..."
			end
		end
	else
		--go back to the game
		if battle.anim_timer<=0 then
			scene="game"
			_update=update_game 
		 _draw=draw_game					
		end
	end
end

-- draw battle scene
function draw_battle()
	cls()
	--enemy info
	print(battle.enemy.name,35,10,7)
	draw_bar(35,17,battle.enemy.hp,battle.enemy.maxhp,8)
	--player info
	--draw_box(3,8,30,64)
	print("????",35,68,7)
	draw_bar(35,75,p.hp,p.maxhp,11)
	draw_bar(35,82,p.mp,p_maxmp,9)
	--sprite w/ override
	if battle.state==battle_state.anim and anim.fn then
		anim.fn()
	else
		if battle.enemy.hp>0 then
			--enemy
			spr(e_spr,59,32)
		end
		--player
		spr(p_spr,58,52)
	end
	--action menu (player turn only)
	if battle.state==battle_state.player_turn then
		print((battle.battle_select==1 and ">" or " ").."sword",4,96,7)
		print((battle.battle_select==2 and ">" or " ").."shield",4,104,7) 
		print((battle.battle_select==3 and ">" or " ").."skills",4,112,7)
		print((battle.battle_select==4 and ">" or " ").."items",4,120,7)
 end
	--win/lose overlay & battle log
	if battle.state==battle_state.win or battle.state==battle_state.lose then
		local col=battle.state==battle_state.win and 11 or 8
		print(battle.message,44,44,col)
	else
		print(battle.message,37,96,7)
	end
end

function draw_bar(x,y,val,maxval,col)
	local w=40
	--rect(x,y,x+w,y+4,7)
	local fill=max(0,flr((val/maxval)*w)-1)
	if fill>0 then rectfill(x+1,y+1,x+fill,y+3,col) end
	print(val.."/"..maxval,x+w+2,y,7)
end

function update_battle_menu()
	--move select
	if btnp(2) then 
		battle.battle_select-=1
		if battle.battle_select<1 then
			battle.battle_select=4
		end 
	end
	if btnp(3) then 
		battle.battle_select+=1 
		if battle.battle_select>4 then
			battle.battle_select=1
		end
	end
	--confirm action
	if btnp(4) and battle.anim_timer<=0 then
		if battle.battle_select==1 then
			--sword attack
			local dmg=max(p.atk+flr(rnd(3))-battle.enemy.def,1)
			play_anim(
				20,
				function() 
					local shake=flr(rnd(3))-1 
					spr(p_spr,58+shake,52+shake)
					spr(e_spr,59,32)
				end,
				function()
					battle.enemy.hp-=dmg
					battle.message="you hit for "..dmg.."!"
					battle.anim_timer=30
					--check win
					if battle.enemy.hp<=0 then
						battle.enemy.hp=0
						battle.state=battle_state.win
						battle.message="you won!"
						--temp
						slime_defeated=true
						--end of temp
						battle.anim_timer=60
						return
					end
					battle.state=battle_state.enemy_turn
				end)	
		elseif battle.battle_select==2 then
			--shield
			local dmg=max(flr(p.atk/2)+flr(rnd(3))+p.shield_score-battle.enemy.def,1)
			local stun_chance=rnd(1)<0.25 --25% chance true
			play_anim(
				10,
				function() 
					local shake=flr(rnd(3))-1 
					spr(p_spr,58+shake,52+shake)
					spr(e_spr,59,32)
				end,
				function()
					player_defends=true
					battle.enemy.hp-=dmg
					battle.message="you hit for "..dmg.."!"
					battle.anim_timer=30
					--check win
					if battle.enemy.hp<=0 then
						battle.enemy.hp=0
						battle.state=battle_state.win
						battle.message="you won!"
						--temp
						slime_defeated=true
						--end of temp
						battle.anim_timer=60
						return
					end
					battle.state=battle_state.enemy_turn
				end)	
		end
	end
end

-- battle animations
function play_anim(maxframes,fn,done)
	anim.frames=maxframes
	anim.maxframes=maxframes
	anim.fn=fn
	anim.done=done
	battle.state=battle_state.anim
end

function heal_anim(heal)
	--items and skills should use
	--this by passing heal amount
	local heal=heal or p.maxhp-p.hp
	play_anim(
		15,
		function()
			local c=anim.frames%2==0 and 11 or 7
			draw_bar(35,75,p.hp,p.maxhp,c)
		end,
		function()
			p.hp=min(p.hp+heal,p.maxhp)
			battle.message="healed "..heal.." hp!"
			battle.anim_timer=30
			battle.state=battle_state.enemy_turn
		end)
end

-- wheel logic
function update_wheel()
 if wheel.spinning then
  wheel.angle=(wheel.angle+wheel.speed)%360
 end
end

function check_zone(angle)
 for _,z in ipairs(zones) do
  if angle>=z.deg_start and angle<z.deg_stop then
   return z.result
  end
 end
end

function draw_wheel(cx,cy,r)
 -- draw zone arcs
 for _, z in ipairs(zones) do
  for deg = z.deg_start, z.deg_stop do
   local t = deg / 360  
   local x = cx + cos(t) * r
   local y = cy - sin(t) * r 
   line(cx, cy, x, y, z.color)
  end
 end
 -- draw needle
 local t=wheel.angle/360
 local nx=cx+cos(t)*r
 local ny=cy+sin(t)*r
 line(cx,cy,nx,ny,7)
end


-->8
--map code

function init_map()
	--timers
	map_timer=0
	map_anim=15

	--map tile settings
	wall=split([[192,193,194,195
	,196,197,198,203,205,206,207
	,213,214,215,216,217,218,219
	,224,229,238,239,240,245]])
	anim1=split("238,254")
	anim2=split("239,255")
	herbs=split("220,221,222")
	gold=split("223,236,237")
	recover=split("238,239,252")	
end

function update_map()
	if (map_timer<0) then
		update_tiles()
		map_timer=map_anim
	end
	map_timer-=1
end

function draw_map()
	mapx=flr(party.x/16)*16
	mapy=flr(party.y/16)*16
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
-->8
--party code

function init_party()
	party={
		x=0,
		y=0,
		dx=0, --x facing: -1 (left), 0, 1 (right)
		dy=-1, --y facing: -1 (up), 0, 1 (down)
		l_spr=1,
		members={
			init_member("slime1,immortal,1,1,1,1")
		}
	}
	--set_stats()
	--starting inventory
	--p_inventory={}
	--set_inventory()
end

function init_member(string_data)
	local name,title,str,dex,con,mag=unpack(split(string_data))
	--add math
	return {
		name=name,
		title=title,
		sprite=titles[title].sprite,
		mastered_titles={},
		active_zones=titles[title].zones,
		maxhp=con*5,
		hp=con*5,
		maxmp=0,
		mp=0,
		atk=str*2,
		def=con*2,
		spd=dex*2,
		matk=mag*2,
		mdef=mag*2,
		str=str,
		dex=dex,
		con=con,
		mag=mag,
		status={},
		temp_stats=init_temp_stats(),
		skills=skill_pools[title]
	}
end

function refresh_stats(member)
--sets all member stats
	local refresh=refresh or false
	local temp_str,temp_dex,temp_con,temp_mag,temp_atk,temp_def,temp_spd,temp_matk,temp_mdef=unpack(member.temp_stats)
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



-->8
--utility functions

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

function nearest_npc(px,py,range)
 local best=nil
 local best_dst=range*range

 for _,npc in pairs(npcs) do
  local dx=npc.x-px
  local dy=npc.y-py
  local dst=dx*dx+dy*dy
  if dst<=best_dst then
   best=npc
   best_dst=dst
  end
 end

 return best
end

function menu_control(option_cnt)
	if btnp(2) then 
		menu_sel-=1
		if menu_sel<1 then
			menu_sel=option_cnt
		end 
	end
	if btnp(3) then 
		menu_sel+=1 
		if menu_sel>option_cnt then
			menu_sel=1
		end
	end
	if btnp(4) then
		return true
	end
end

function check_win_lose()
	if bbeg_defeated then
		game_win=true
		game_over=true
	elseif party_wiped() then
		game_win=false
		game_over=true
	end
end

function party_wiped()
 for i=1,#party.members do
  if party.members[i].hp>0 then
   return false
  end
 end
 return true
end
__gfx__
000000000000000000000000000000000000c0000000c00070000000000000000000000000000000000000000000100000001000700000000000000000000000
00000000000000000000000000000000000d7c00000d7c007000700000000000000000000000000000000000000d6100000d6100700070000000000000000000
0070070000000000000000000000000000dcccc000dcccc0000070700000000000000000000000000000000000d1111000d11110000070700000000000000000
000770000000c0000000c0000000c00000ccccc000ccccc007000070000000000000100000001000000010000011111000111110070000700000000000008000
00077000000d7c00000d7c00000d7c0000ccccc000dcccd0070c0070000c0000000d1100000d1100000d11000011111000d111d00701007000010000000d7800
0070070000d7ccc000d7ccc000d7ccc000dcccd00000000000d7c00000d7c00000d1111000d1111000d1111000d111d00000000000d6100000d6100000d78880
0000000000c0c0c000ccccc000ccc0c000000000000000000d7cccc00d7cccc000161610001111100011161000000000000000000d6111100d61111000808080
0000000000dcccd000dcccd000dcccd00000000000000000cccccccccccccccc00d111d000d111d000d111d00000000000000000111111111111111100d888d0
0000000000000000000080000000800070000000000000000000000000000000000000000000b0000000b0007000000000000000000000000000000000000000
0000000000000000000d7800000d78007000700000000000000000000000000000000000000d7b00000d7b007000700000000000000000000000000000000000
000000000000000000d8888000d88880000070700000000000000000000000000000000000dbbbb000dbbbb00000707000000000000000000000000000000000
0000800000008000008888800088888007000070000000000000b0000000b0000000b00000bbbbb000bbbbb007000070000000000000e0000000e0000000e000
000d7800000d78000088888000d888d00708007000080000000d7b00000d7b00000d7b0000bbbbb000dbbbd0070b0070000b0000000d7e00000d7e00000d7e00
00d7888000d7888000d888d00000000000d7800000d7800000d7bbb000d7bbb000d7bbb000dbbbd00000000000d7b00000d7b00000d7eee000d7eee000d7eee0
008888800088808000000000000000000d7888800d78888000b0b0b000bbbbb000bbb0b000000000000000000d7bbbb00d7bbbb000e0e0e000eeeee000eee0e0
00d888d000d888d00000000000000000888888888888888800dbbbd000dbbbd000dbbbd00000000000000000bbbbbbbbbbbbbbbb00deeed000deeed000deeed0
0000e0000000e0007000000000000000000000000000000000000000000090000000900070000000000000000000000000000000000000000000200000002000
000d7e00000d7e007000700000000000000000000000000000000000000d7900000d79007000700000000000000000000000000000000000000d7200000d7200
00deeee000deeee0000070700000000000000000000000000000000000d9999000d99990000070700000000000000000000000000000000000d2222000d22220
00eeeee000eeeee00700007000000000000090000000900000009000009999900099999007000070000000000000200000002000000020000022222000222220
00eeeee000deeed0070e0070000e0000000d7900000d7900000d79000099999000d999d007090070000900000005720000057200000572000022222000d222d0
00deeed00000000000d7e00000d7e00000d7999000d7999000d7999000d999d00000000000d7900000d7900000572220005722200057222000d222d000000000
00000000000000000d7eeee00d7eeee0009a9a900099999000999a9000000000000000000d7999900d7999900020202000222220002220200000000000000000
0000000000000000eeeeeeeeeeeeeeee00d999d000d999d000d999d0000000000000000099999999999999990052225000522250005222500000000000000000
70000000000000000000000000000000000000000000600000006000700000000000000000000000000000000000000000001000000010007000070000000000
7000700000000000000000000000000000000000000d7600000d7600700070000000000000001000000010000000010000011100000111007000070000000000
000070700000000000000000000000000000000000d6666000d666600000707000000000000111000001110000000100000d7c00000d7c000001000700010000
07000070000000000000600000006000000060000066666000666660070000700000000000006000000060000000c60000dcccc000dcccc00711100700111000
0702007000020000000d7600000d7600000d76000066666000d666d00706007000060000000d6c00000d7c00000d760000ccccc000ccccc00706000700060000
00d7200000d7200000d7666000d7666000d7666000d666d00000000000d7600000d7600000d76cc000d7ccc000d7ccc000ccccc000dcccd000d7c00000d7c000
0d7222200d72222000656560006666600066656000000000000000000d7666600d76666000c0c0c000ccccc000ccc0c000dcccd0000000000d7cccc00d7cccc0
222222222222222200d666d000d666d000d666d00000000000000000666666666666666600dcccd000dcccd000dcccd00000000000000000cccccccccccccccc
00fff00000060000000000000099900000040000000000000dd666000dd666070dd666070dd666000dd666000dd6660a0dd6660a0dd666000dd666000dd66600
0f00f00000666000000000000900900000444000000000000dd666070dd666070dd666070dd666000dd666070dd6660a0dd6660a0dd666000dd666000dd66600
0f00dd000ed6de0000000600090055000e545e00000004000d0006070d0006070d0006070d0006000d0006070d00060a0d00060a0d0006000d0006000d000600
000d66000066600000006e60000544000044400000004e400dd066070dd066070dd066070dd066000dd066070dd0660a0dd0660a0dd066000dd066000dd05445
000666000066d000006666d60004440000445000004444a40add69070add696109dd696109dd690009dd69070add696109dd696109dd69000add69000add4444
00ed6de000dd00f00ff6666000e545e0005500900994444007a9996107a9990109999901099999000999996107a99901099999010999990007a9990007a95445
00066600000f00f0f00000000004440000090090900000000a9dd6010a9dd6000ddd6600777116000ddd66010a9dd6000ddd6600aaa116000a9dd6000a9dd440
00006000000fff000ff0000000004000000999000990000099d0d00099d0d00099d9699099d9699099d9699099d0d00099d9699099d9699099d0d00099d0d000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0dd66600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0dd66600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0dd066000a7adddd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0add690009a9d0dd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07a99900999900660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9a9dd600999960660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
000000000000000000000000000000000000c00000001000000080000000b0000000e00000009000000020000000600000001000000000000000000000000000
00000000000000000000000000000000000d7c00000d1100000d7800000d7b00000d7e00000d7900000d7200000d760000011100000000000000000000000000
0000000000009999999900000000000000d7ccc000d1111000d7888000d7bbb000d7eee000d7999000d7222000d7666000d7ccc0000000000000000000000000
0000000000995555555599000000000000ccccc0001111100088888000bbbbb000eeeee000999990002222200066666000ccccc0000000000000000000000000
0000000099554444444455990000000000d060d000d060d000d060d000d060d000d060d000d060d000d060d000d060d000d060d0000000000000000000000000
00000009554400000000445590000000000060000000600000006000000060000000600000006000000060000000600000006000000000000000000000000000
00000095440000000000004459000000000060000000600000006000000060000000600000006000000060000000600000006000000000000000000000000000
00000954000000000000000045900000000060000000600000006000000060000000600000006000000060000000600000006000000000000000000000000000
00000954000000000000000045900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00009540000000000000000004590000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00095400000000000000000000459000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00095400000000000000000000459000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00095400000000000000000000459000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00954000000000000000000000045900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00954000000000000000000000045900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00954000000000000000000000045900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00954000000000000000000000045900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00954000000000000000000000045900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00954000000000000000000000045900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00954000000000000000000000045900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00095400000000000000000000459000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00095400000000000000000000459000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00095400000000000000000000459000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00009540000000000000000004590000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000954000000000000000045900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000954000000000000000045900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000095440000000000004459000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000009554400000000445590000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000995544444444559900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009955555555990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000099999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000dd00000000000000dd00000000000000dd00000000055555555555555555555555555555555555555555555005555555551111555d555550555555d55
0ddd00dddd00ddd00ddd00dddd00ddd00ddd00dddd00ddd00dd55555555555555555555555555555555555dd55555dd0555555551dddd1555d5550055555d555
0dddd5dddd5dddd55dddd5dddd5dddd55dddd5dddd5dddd00dddd55555555555555555555555d555555555dd5555ddd0555555551dd6dd1555500055d5555555
0dddd55ddd5ddd5555ddd55ddd5ddd5555ddd55ddd5dddd00dddd55555d55555555555555555555555555555555dddd0555555551ddd6d155500005d55555555
00dd555dd555dd5555dd555dd555dd5555dd555dd555dd0000dd555d55555555555555d555555555555d55555555dd005555555512ddddd155000055555555d5
005555555555555555555555555555555555555555555500005555dd55555555555555555555555555555555555555005555555512dd6dd1d000055d55555555
0ddd55555dd555555555555555d555555555555555555dd00ddd55dd55555dd55d55555555555dd555555555d5555dd0555555555122dd1550005d5555d55555
ddddd5555ddd5555555555d555dd5555555555d5555dddddddddd55555555dd55555dd5555555dd555555555555ddddd555555555511115500555555555555d5
ddddd555555555555dd5555555dd55555dd55555555dddddddddd5555d5555555555dd555d5555555555ddd5555ddddd5555555555555d555555555555555555
0dd5555d555555555dd55555555555d55dd5555dd555ddd00dd555555555555555555d555555555555555dd55555ddd0555555555555d5555b5b555555555555
005555555555555555555555555555555555555dd555550000555555555555555555555555555555555555555555550055555555d555555555b5555555555555
00dd55555555d555555555555d5555555555555d5555dd0000dd555dd555dd5555dd555dd555dd5555dd555dd555dd00555b5b55555b5b555b5b555555555555
0dddd55555555555555555555555555555555555555dddd00dddd5ddd55ddd555dddd5ddd55ddd555dddd5ddd55dddd05555b5555555b5d555555b5b5555a555
0dddd555dd555555555d5555555555555555d555555dddd00dddd5dddd5dddd55dddd5dddd5dddd55dddd5dddd5dddd0555b5b55555b5b55b5b555b555559555
0dd55555dd55555555555555555555555555555555555dd00ddd00dddd00ddd00ddd00dddd00ddd00ddd00dddd00ddd05555555555d555555b555b5b55555555
0055555555555555555555555555555555555555555555000000000dd00000000000000dd00000000000000dd000000055555555555555d5b5b5555555555555
00555555555555555555555555555555555555dd555555005555dddd5555555500000000000000000000000000000000555555555a5555a555dddd5555dddd55
0ddd555555d555555555555555555555555555dd5555ddd0555555dd555555550000000000000000000000000000000055555555595555955dccccd55dcc7cd5
0dddd5555555555555555555555555555d555555555dddd0555555555555555500000000000000000000000000000000555555555555aa55dc77cccddcccc77d
0dddd55555555555555555555555555555555555555dddd0555555555555555500000000000000000000000000000000555555a555a5995ad7ccc7cddcc7cccd
00dd555dd55555555555555555555555555555555555dd0055d555555555555500000000000000000000000000000000555555955595aa59dccccc7ddc7ccccd
005555ddd5555555555555555555555555555555555555005555555555555555000000000000000000000000000000005a55a5a555a5995adcc77ccddcccc7cd
0ddd5555555555555555555555555555555555555d555dd055555d55555555550000000000000000000000000000000059559595a59555595dccccd55dcc7cd5
ddddd5555555d555555555555555555555555555555ddddd555555555555555500000000000000000000000000000000555555559555555555dddd5555dddd55
ddddd55555555555555555555555555555555555555ddddd55555555555555550000000000000000000000000000000055555555000000005555555555555555
0dd5555d555555555555555555555555555d55555555ddd055555555555555550000000000000000000000000000000055040555000000005222555558885555
00555555555555555555555555555555555555ddd555550055555555555555550000000000000000000000000000000054444455000000005555225555558855
00dd5555555555555555555555555555555555dd5555dd0055555555555555550000000000000000000000000000000040404045000000005555552555555585
0dddd55555555d55555555555555555555555555555dddd055555555555555550000000000000000000000000000000054444455000000002552252585588585
0dddd555dd555555555555555555555555555555555dddd055555555555555550000000000000000000000000000000055111555000000002552552585585585
0dd55555dd555555555555555555555555555d5555555dd055555555555555550000000000000000000000000000000055111555000000005255225558558855
00555555555555555555555555555555555555555555550055555555555555550000000000000000000000000000000055555555000000005525555555855555
__map__
c0c1c2c3c2c3c2c3c2c3c4c50000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d0d1d2d3d2d3d2d3d2d3d4d50000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e0e1eee3e3e3e3e3e3cee4e50000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
f0f1e3e3e3cfe3e3cfe3f4f50000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e0e1e3e3e3e3e3e3e3e3e4e50000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
f0f1e3e3e3e3e3cfe3e3f4f5e900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c6f1e3e3e3e3e3e3e3e3e4e5e900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
f0e1e3e3cfe3e3dce3e3f4e6c2c3000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c6c7c8c9c8c9c8c9c8c9c8c9c8c9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d6d7d8d9d8d9d8d9d8d9d8d9d8d9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
