; ────┤ Practical Assignment in Computer Organization │ August 2021 ├────
; Gabriel Victor Cardoso Fernandes - 11878296
; Gabriel Alves Kuabara - 11275043
; Lourenço de Salles Roselino - 11796805

; Characters that build the map
; player - z yellow
; normal wall - } blue
; deadly wall - { red
; finish flag - ) pink
; coins - * yellow

jmp main

; ────────┤ Menu and map strings and data ├────────
menu_art : string "                                                                                                                                                                          Tomb of the Mask                                                                                                                                                                                      Gabriel Alves Kuabara                                                       Gabriel Victor Cardoso Fernandes                                                 Lourenyo de Salles Roselino                                                                                                       }}}}}}}}                                }      }                                } }  } }                                }      }                                } }  } }                                } }}}} }                                }      }                                }}}}}}}}                                                                                                                                                                                                                                Press Enter to Play              "
level1 : string "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}*                    )   }}}}}}}}}}}}}}}*}}}}}}}}}}}}}}}}}}}}}}} }}}}}}}}}}}}}}}*}}}}}}}}}}}}}}}}}}}}}}}   }}}}}}}}}}}}}*}}}}}}}}}}}******}}}}}} } }}}}}}}}}}}}}*}}}}}}}}}}}*}}{}*}}}}        }}}}}}}}}}******************}}}}  * *      }}}}}}}*}          }}}*}}}}}}} ***   }} }}}}}}}*              *}}}}}}  }}*      }}}}}}}*            }}*}}}}}}    *   }}}}}}}}}}*}********************        }}}}}}}}}}*}}}}}}}}}}} }}}}}}}}}}}}}}}}}}}}}}}}}}}*}}}*******}                         }}}*}}}*******} }}}} }}}}}}}}}}}}}}}}}} }}}**********}} }}}} }}}}}}}}}}}}}}}}}}  }}}}}}}}}}}}}} }}}}****************}}}  }}}}}}****}}}} }}}}*********************}}}}}**********}}}}*              **** }}}}}}****}}}}}*}}}{*      }      }****}}}}}  ****}*****}}}{********      }}}}}}}}}} }***}}*}}}}}}}}}}}}}}}*}}}}} }}}}}}}}}} }}}}}}*}}}}}}}}}}}}}}}*}}}}} }}}}}}}}}} }}}}}**}}}}}}}}}}}}}}}*}}}}} }}}}}}}}}} }}}}}*}}}}}}}}}}}}}}}}*}}}}} }}}}}}}}}}***************************** }}}}}}}}}} }}}}}*}}}}}}}}}}}}}}}} }}}} }}}}}}}}}}} }}}}}*}}}}}}}}}}}}}}}}           }}}}}{*            B    D         S  k E }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}             GET TO THE )               "

map : var #1200		; Working copy of the level, rebuilt on every restart

sprite_colors : var #10
static sprite_colors + #0, #2816	; Coin color
static sprite_colors + #1, #1024	; Normal wall color
static sprite_colors + #2, #2304	; Deadly wall color
static sprite_colors + #3, #3328	; Flag color
static sprite_colors + #4, #0		; no color
static sprite_colors + #5, #256	; Box color
static sprite_colors + #6, #1792	; Key color
static sprite_colors + #7, #1280	; Locked door color
static sprite_colors + #8, #1536	; Switch color
static sprite_colors + #9, #3072	; Switch door color

; ─────────────────────────────────────────────────────

; ──────────┤ Player related data ├──────────
start_position : var #1
static start_position, #1067	; Player starting position

coin_count: var #1			; keeps how many coins the player has
static coin_count + #0, #0

coin_record: var #1			; coin count when the current level started
static coin_record + #0, #0

coin_print_position: var #1
static coin_print_position, #1196	; Screen position where the coins are printed

key_count: var #1
static key_count + #0, #0

key_print_position: var #1
static key_print_position, #1192	; Screen position of the key counter

;Speed variables
speed : var #2
static speed + #0, #40	; vertical speed   (up || down)
static speed + #1, #1	; horizontal speed (left || right)
; ─────────────────────────────────────────────────────

; ────────────┤ Clock delay data ├────────────
loop_count : var #1
static loop_count, #1

nops_per_loop : var #1
static nops_per_loop, #300000
; ─────────────────────────────────────────────────────
                         
main:
	; Fresh game state
	loadn r6, #0
	store coin_count, r6
	store coin_record, r6
	store key_count, r6
	
	; Print the title screen
	loadn r0, #0
	loadn r1, #menu_art
	call print_string

; ────────────┤ Waits for Enter on the title screen ├────────────
wait_start:
	loadn r2, #13		; Enter character
	inchar r1
	cmp r1, r2
	jne wait_start
		
start_game:
	call load_level		; r0 = player position after this call
	jmp read_direction

; ────────────┤ Copies the level into the working map ├────────────
load_level:
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	
	; Copy the level string into the working map
	loadn r1, #level1
	loadn r2, #map
	loadn r5, #1200
	load_level_copy:
	loadi r3, r1
	storei r2, r3
	inc r1
	inc r2
	dec r5
	jnz load_level_copy
	
	; Clear the counters that belong to one level
	loadn r6, #0
	store key_count, r6
	
	; Print the board and the player
	loadn r0, #0
	loadn r1, #map
	call print_string
	load r0, start_position	; r0 = player start position
	call print_player
	
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	rts

; ────────────┤ Restarts the current level ├────────────
restart_level:
	load r6, coin_record	; Coins go back to the level start value
	store coin_count, r6
	call load_level
	rts

; ────────────┤ Movement reading ├────────────
read_direction:
	loadn r1, #0
	loadn r2, #0
	
	inchar r1		; r1 = dir | direction read from the user
	
	cmp r1, r2		; read nothing -> loop to read again
	jeq read_direction
	
	; Turn uppercase letters into lowercase
	loadn r2, #'A'
	cmp r1, r2
	jle keys_checked
	loadn r2, #'Z'
	cmp r1, r2
	jgr keys_checked
	loadn r2, #32
	add r1, r1, r2
	
	keys_checked:
	; Restart key
	loadn r2, #'r'
	cmp r1, r2
	jne check_movement
	call restart_level
	jmp read_direction

; r1 = direction read
check_movement:
	; ────────────┤ Vertical movement check ├────────────
	loadn r3, #0	; speed[0] = #40 -> vertical (up || down)
	
	; ────────────┤ Up check ├────────────
	loadn r2, #'w'
	cmp r1, r2		; dir == 'w'
	loadn r5, #speed_decrement
	jeq speed_decrement
	
	; ────────────┤ Down check ├────────────
	loadn r2, #'s'
	cmp r1, r2		; dir == 's'
	loadn r5, #speed_increment
	jeq speed_increment
	
	; ────────────┤ Horizontal movement check ├────────────
	loadn r3, #1	; speed[1] = #1 -> horizontal (left || right)
	
	; ────────────┤ Right check ├────────────
	loadn r2, #'d'
	cmp r1, r2		; dir == 'd'
	loadn r5, #speed_increment
	jeq speed_increment

	; ────────────┤ Left check ├────────────
	loadn r2, #'a'	; speed[3] = going left
	cmp r1, r2		; dir == 'a'
	loadn r5, #speed_decrement
	jeq speed_decrement
	
	jmp read_direction	; If nothing moved -> read input again

; ────────────┤ End of movement reading ├────────────	

; ────────────┤ Speed functions ├────────────
; Generate the movement speed in r2
; Continuous movement jumps to r5 (avoids unnecessary ifs)
speed_increment:	; Movement right or down -> increment pos
	nop
	loadn r1, #speed	; r1 = end(speed)
	add r1, r1, r3			; r1 = end(speed[i])
	loadi r2, r1			; r2 = speed[i]
	
	add r1, r0, r2	; r1 = next_pos | next_pos = current_pos + speed
	
	jmp check_collision

speed_decrement:	; Movement left or up -> decrement pos
	nop
	loadn r1, #speed	; r1 = end(speed)
	add r1, r1, r3			; r1 = end(speed[i])
	loadi r2, r1			; r2 = speed[i]
	
	sub r1, r0, r2	; r1 = next_pos | next_pos = current_pos - speed

; ────────────┤ Collision logic ├────────────
; r0 = current_pos | r2 = speed
check_collision:
	loadn r6, #map	; r6 = end(map)
	add r6, r6, r1	; r6 = end(map[next_pos])
	loadi r6, r6	; r6 = map[next_pos] | sprite we will compare
	
	; ────┤ Empty position: keep moving ├────
	loadn r4, #' '
	cmp r6, r4
	jne position_not_empty
	
	call move_player
	; Keep moving: jump to the speed function (its address is in r5)
	push r5
	rts
	; ────────────────────────────────────────
	
	position_not_empty:
	; ────┤ Coin: get rich ├────
	loadn r4, #'*'
	cmp r6, r4
	jne no_coin_collected

	call update_coins	
	call move_player
	; Keep moving: jump to the speed function (its address is in r5)
	push r5
	rts
	; ────────────────────────────────────────
	
	no_coin_collected:
	; ────┤ Box: push it ahead ├────
	loadn r4, #'B'
	cmp r6, r4
	jne no_box_hit
	
	push r3			; Save the speed index
	cmp r1, r0		; Which way is the dash going?
	jgr box_beyond_add	; Right or down: beyond = next + speed
	sub r3, r1, r2		; Left or up: beyond = next - speed
	jmp box_beyond_ok
	box_beyond_add:
	add r3, r1, r2		; Right or down: beyond = next + speed
	box_beyond_ok:
	loadn r4, #map
	add r4, r4, r3		; r4 = address of the tile beyond
	loadi r6, r4		; r6 = tile beyond the box
	loadn r7, #' '
	cmp r6, r7		; empty tile: the box slides
	jeq push_box
	loadn r7, #'{'
	cmp r6, r7		; trap: the box covers it
	jeq push_box
	loadn r7, #'S'
	cmp r6, r7		; switch: the box presses it
	jeq push_box
	
	pop r3			; Restore the speed index
	loadn r6, #0
	call print_player
	jmp read_direction	; The box is blocked, stop the dash
	
	push_box:
	loadn r7, #'B'
	storei r4, r7		; Move the box one tile ahead
	loadn r4, #'S'
	cmp r6, r4		; Was the box pushed onto a switch?
	jeq push_box_switch
	push_box_draw:
	loadn r7, #'B'
	loadn r6, #256		; Box color
	add r7, r7, r6
	outchar r7, r3		; Draw the box in its new tile
	pop r3			; Restore the speed index
	call move_player
	push r5
	rts			; Keep the dash moving
	
	push_box_switch:
	call open_switch_door
	jmp push_box_draw
	; ────────────────────────────────────────
	
	no_box_hit:
	; ────┤ Key: pick it up ├────
	loadn r4, #'k'
	cmp r6, r4
	jne no_key_hit
	
	call update_keys
	call move_player
	push r5
	rts			; Keep the dash moving
	; ────────────────────────────────────────
	
	no_key_hit:
	; ────┤ Door: open with a key ├────
	loadn r4, #'D'
	cmp r6, r4
	jne no_door_hit
	
	load r4, key_count
	loadn r7, #0
	cmp r4, r7
	jeq door_stop		; No key in hand, the door holds
	
	; Erase the door from the map and the screen
	loadn r3, #map
	add r3, r3, r1
	loadn r4, #' '
	storei r3, r4
	outchar r4, r1
	
	; Spend the key and show the new count
	load r4, key_count
	dec r4
	store key_count, r4
	push r0
	load r0, key_print_position
	inc r0
	loadn r1, #1840		; '0' + silver
	add r1, r1, r4
	outchar r1, r0
	pop r0
	
	door_stop:
	loadn r6, #0
	call print_player
	jmp read_direction
	; ────────────────────────────────────────
	
	no_door_hit:
	; ────┤ Switch: press it ├────
	loadn r4, #'S'
	cmp r6, r4
	jne no_switch_hit
	
	call open_switch_door
	call move_player
	push r5
	rts			; Keep the dash moving
	; ────────────────────────────────────────
	
	no_switch_hit:
	; ────┤ Switch door: closed until the switch is pressed ├────
	loadn r4, #'E'
	cmp r6, r4
	jne no_gate_hit
	loadn r6, #0
	call print_player
	jmp read_direction
	; ────────────────────────────────────────
	
	no_gate_hit:
	; ────┤ Normal wall: ask for movement ├────
	loadn r4, #'}'
	cmp r6, r4
	jne no_wall_hit
	
	loadn r6, #0
	call print_player
	jeq read_direction
	
	no_wall_hit:
	; ────┤ Trap: restart the level ├────
	loadn r4, #'{'
	cmp r6, r4
	jne no_trap_hit
	call restart_level
	jmp read_direction
	
	no_trap_hit:
	; ────┤ Flag: level cleared ├────
	loadn r4, #')'
	cmp r6, r4
	jne no_flag_hit
	jmp main		; Single level for now, back to the title screen
	
	no_flag_hit:
	; ────┤ Unknown tile: hold like a wall ├────
	loadn r6, #0
	call print_player
	jmp read_direction

; ────────────┤ End of collision logic ├────────────

; ────────────┤ Movement ├────────────
; r0 = current_pos | r1 = next_pos
move_player:
	push r2
	push r3
	
	; ────┤ Erasing the player from the current position ├────
	loadn r2, #' '
	outchar r2, r0	; Erase the player from map[r0]
	; ──────────────────────────────────────────
	
	; ────┤ Update and print the player at the next position ├────
	mov r0, r1		; r0 = next_pos
	loadn r3, #map	; r3 = end(map)
	add r1, r0, r3	; r1 = end(map[next_pos])
	storei r1, r2	; Erase whatever is in the next position
	call print_player
	; ───────────────────────────────────────────────────
	
	call delay_clock
	pop r3
	pop r2
	rts

; ────────┤ End of movement ├────────

; ────────────┤ General utilities ├────────────
; r0 = screen position | r1 = string address | r2 = string color
print_string:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	
	loadn r3, #'\0'		; Stop condition for the string print
	loadn r6, #sprite_colors
	
print_string_loop:
	loadi r4, r1	; r4 = sprite  | sprite = string[i]
	cmp r4, r3		; sprite == '\0' -> finished printing
	jeq print_string_end
	
	
	loadn r5, #'*'
	cmp r4, r5		; sprite = coin
	loadn r2, #0
	jeq print_sprite
	
	loadn r5, #'}'
	cmp r4, r5		; sprite = normal wall
	loadn r2, #1
	jeq print_sprite
	
	loadn r5, #'{'
	cmp r4, r5		; sprite = deadly wall
	loadn r2, #2
	jeq print_sprite
	
	loadn r5, #')'
	cmp r4, r5		; sprite = flag
	loadn r2, #3
	jeq print_sprite
	
	loadn r5, #'B'
	cmp r4, r5		; sprite = box
	loadn r2, #5
	jeq print_sprite
	
	loadn r5, #'k'
	cmp r4, r5		; sprite = key
	loadn r2, #6
	jeq print_sprite
	
	loadn r5, #'D'
	cmp r4, r5		; sprite = locked door
	loadn r2, #7
	jeq print_sprite
	
	loadn r5, #'S'
	cmp r4, r5		; sprite = switch
	loadn r2, #8
	jeq print_sprite
	
	loadn r5, #'E'
	cmp r4, r5		; sprite = switch door
	loadn r2, #9
	jeq print_sprite
	
	loadn r2, #4
	
	print_sprite:
	add r2, r2, r6	; sprite_color = end(sprite_colors[sprite])
	loadi r2, r2	; sprite_color = sprite_colors[sprite]
	add r4, r2, r4	; sprite + sprite_color
	outchar r4, r0
	
	inc r0	; pos++
	inc r1	; i++ (string[i])
	jmp print_string_loop

print_string_end:
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

; r0 = player position
print_player:
	push r1
	push r2
	
	loadn r1, #'z'	; r1 = player
	loadn r2, #768	; Player color
	add r1, r1, r2
	outchar r1, r0	; Print the player at map[r0]

	pop r2
	pop r1
	rts

update_coins:
	push r0
	push r1
	push r2
	push r3
	push r4
	
	load r2, coin_count
	inc r2
	store coin_count, r2
	
	load r0, coin_print_position
	loadn r1, #2858		; r1 = yellow coin
	outchar r1, r0
	
	inc r0
	
	loadn r1, #100	; First digit
	div r1, r2, r1
	
	loadn r3, #2864	; r3 = yellow color
	add r1, r3, r1	; r1 = first digit + yellow color
	outchar r1, r0
	
	inc r0
	
	loadn r4, #10	; Second digit
	div r1, r2, r4
	mod r1, r1, r4
	
	add r1, r3, r1	; r1 = second digit + yellow color
	outchar r1, r0
	
	inc r0
	
	loadn r1, #10	; Third digit
	mod r1, r2, r1
	
	add r1, r3, r1	; r1 = third digit + yellow color
	outchar r1, r0
	
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

update_keys:
	push r0
	push r1
	push r2
	
	load r2, key_count
	inc r2
	store key_count, r2
	
	load r0, key_print_position
	loadn r1, #1899		; r1 = silver key icon
	outchar r1, r0
	
	inc r0
	
	loadn r1, #1840		; r1 = digit offset ('0' + silver)
	add r1, r1, r2
	outchar r1, r0
	
	pop r2
	pop r1
	pop r0
	rts

; Opens the switch door and is called when a switch is pressed
open_switch_door:
	push r4
	push r7
	
	loadn r4, #map
	loadn r7, #1115		; Switch door cell (row 27, col 35)
	add r4, r4, r7
	loadn r7, #' '
	storei r4, r7		; The door opens in the map
	
	loadn r7, #1115
	loadn r4, #' '
	outchar r4, r7		; The door is erased on the screen
	
	pop r7
	pop r4
	rts


; Delay function: keeps the clock busy to slow the game down
delay_clock:
	push r0
	push r1
	push r2
	
	loadn r0, #1		; number of loops
	loadn r2, #0
	
	delay_loop:
	loadn r1, #300000	; number of nops
	dec r0
	delay_nop:	; runs (n_loops * n_nops) times
	nop
	dec r1
	cmp r1, r2
	jne delay_nop
	
	cmp r0, r2
	jne delay_loop
	
	pop r2
	pop r1
	pop r0
	rts
