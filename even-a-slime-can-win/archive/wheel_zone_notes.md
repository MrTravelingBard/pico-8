# Wheel zone data (removed from cart to save tokens)

Pulled out of `init_titles()` on 2026-09-12 to free up ~820 tokens while the wheel
minigame isn't wired up yet. Each title's `zones` list defines spin-result bands
(0-360, matching the wheel's angle), and `arrow` was the spin-needle sprite id.
Re-add these to the `titles` table (and reintroduce `init_battler`'s zones plumbing
+ the wheel logic section) whenever the wheel gets built.

| title | arrow | zone (label: start-stop -> result) |
|---|---|---|
| immortal | 133 | miss: 0-90 -> miss; block: 90-200 -> block; hit: 200-330 -> hit; taunt: 330-360 -> taunt |
| quick_blow | 132 | miss: 0-100 -> miss; hit: 100-270 -> hit; fumble: 270-310 -> miss; crit: 310-360 -> crit |
| eldest | 132 | miss: 0-60 -> miss; bonus: 60-140 -> bonus; hit: 140-330 -> hit; crit: 330-360 -> crit |
| slip_master | 132 | miss: 0-100 -> miss; hit: 100-270 -> hit; fumble: 270-310 -> miss; dodge: 310-360 -> dodge |
| coiled | 132 | miss: 0-100 -> miss; hit: 100-270 -> hit; delay: 270-310 -> delay; miss: 310-360 -> miss |
| constrictor | 132 | miss: 0-100 -> miss; hit: 100-270 -> hit; constrict: 270-310 -> constrict; miss: 310-360 -> miss |
| red | 134 | miss: 0-160 -> miss; hit: 160-300 -> hit; crit: 300-340 -> crit; free: 340-360 -> free |
| once_red | 136 | miss: 0-160 -> miss; hit: 160-300 -> hit; crit: 300-340 -> crit; free: 340-360 -> free |
| green | 135 | miss: 0-160 -> miss; hit: 160-300 -> hit; crit: 300-340 -> crit; free: 340-360 -> free |
| metal_sworn | 140 | miss: 0-160 -> miss; hit: 160-300 -> hit; crit: 300-340 -> crit; free: 340-360 -> free |
| metal | 139 | miss: 0-160 -> miss; hit: 160-300 -> hit; crit: 300-340 -> crit; free: 340-360 -> free |
| creeping_death | 138 | miss: 0-160 -> miss; hit: 160-300 -> hit; crit: 300-340 -> crit; free: 340-360 -> free |
| kingslayer | 137 | miss: 0-160 -> miss; hit: 160-300 -> hit; crit: 300-340 -> crit; free: 340-360 -> free |

## Note on the "standard" zone set

7 of the 13 titles (red, once_red, green, metal_sworn, metal, creeping_death,
kingslayer) share the identical zone set:
`miss: 0-160, hit: 160-300, crit: 300-340, free: 340-360`.
When you rebuild this, define it once as a shared `standard_zones` table and
reference it from each of those titles instead of repeating it 7 times — see
the earlier refactor suggestion.

## Removed wheel logic (functions, not data)

These were stubs/dead code, not referenced from `update_battle`/`draw_battle`,
so no logic was lost — just re-write from scratch when ready:
- `init_spin(zones)` — placeholder, empty
- `update_wheel()` — advanced `wheel.angle` by `wheel.speed` while `wheel.spinning`
- `check_zone(angle)` — looped a global `zones` table checking `deg_start`/`deg_stop`
  (note: field names didn't match the title zone data's `zone_start`/`zone_stop` —
  reconcile this when rebuilding)
- `draw_wheel(cx,cy,r)` — drew zone arcs + a needle from `wheel.angle`
- `apply_spin_result()` — placeholder, empty

Also removed: the `wheel={angle=0,speed=2,spinning=false}` init block from
`init_battle()`, `active_zones=titles[title].zones` from `init_member()`, and
an unused `local zones=src.active_zones or {}` from `init_battler()`.

function init_titles()
	titles={
		immortal={
			name="the immortal",
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
			name="the quick blow",
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
			name="the eldest's legacy",
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
			name="the slip naster",
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
			name="the coiled one",
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
			name="the constrictor",
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
			name="the red",
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
			name="the once red",
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
			name="the green",
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
			name="the metalsworn",
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
			name="the metal",
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
			name="the creeping death",
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
			name="the kingslayer",
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