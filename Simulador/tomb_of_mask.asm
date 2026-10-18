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
map : string "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}*                    )   }}}}}}}}}}}}}}}*}}}}}}}}}}}}}}}}}}}}}}} }}}}}}}}}}}}}}}*}}}}}}}}}}}}}}}}}}}}}}}   }}}}}}}}}}}}}*}}}}}}}}}}}******}}}}}} } }}}}}}}}}}}}}*}}}}}}}}}}}*}}{}*}}}}        }}}}}}}}}}******************}}}}  * *      }}}}}}}*}          }}}*}}}}}}} ***   }} }}}}}}}*              *}}}}}}  }}*      }}}}}}}*            }}*}}}}}}    *   }}}}}}}}}}*}********************        }}}}}}}}}}*}}}}}}}}}}} }}}}}}}}}}}}}}}}}}}}}}}}}}}*}}}*******}                         }}}*}}}*******} }}}} }}}}}}}}}}}}}}}}}} }}}**********}} }}}} }}}}}}}}}}}}}}}}}}  }}}}}}}}}}}}}} }}}}****************}}}  }}}}}}****}}}} }}}}*********************}}}}}**********}}}}*              **** }}}}}}****}}}}}*}}}{*      }      }****}}}}}  ****}*****}}}{********      }}}}}}}}}} }***}}*}}}}}}}}}}}}}}}*}}}}} }}}}}}}}}} }}}}}}*}}}}}}}}}}}}}}}*}}}}} }}}}}}}}}} }}}}}**}}}}}}}}}}}}}}}*}}}}} }}}}}}}}}} }}}}}*}}}}}}}}}}}}}}}}*}}}}} }}}}}}}}}}***************************** }}}}}}}}}} }}}}}*}}}}}}}}}}}}}}}} }}}} }}}}}}}}}}} }}}}}*}}}}}}}}}}}}}}}}           }}}}}{*            B                     }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}             GET TO THE )               "

; We have 2 lines to print: menu_art[1080] and menu_art[1120]
win_message: string "Congratulations      "
lose_message: string "Better luck next time"

sprite_colors : var #6
static sprite_colors + #0, #2816	; Coin color
static sprite_colors + #1, #1024	; Normal wall color
static sprite_colors + #2, #2304	; Deadly wall color
static sprite_colors + #3, #3328	; Flag color
static sprite_colors + #4, #0		; no color
static sprite_colors + #5, #256	; Box color

; ─────────────────────────────────────────────────────

; ──────────┤ Player related data ├──────────
start_position : var #1
static start_position, #1067	; Player starting position

coin_count: var #1			; keeps how many coins the player has
static coin_count + #0, #0

coin_print_position: var #1
static coin_print_position, #1196	; Screen position where the coins are printed

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
	loadn r7, #0	; Loads the initial game state (0 = start | 1 = lost | 2 = won)
	loadn r6, #0

print_menu:
	loadn r0, #0		; r0 = print_pos
	loadn r1, #menu_art ; r1 = end(menu_art)
	call print_string	; Print the menu

	cmp r6, r7		; If the game state is not the initial one, end the program
	jeq menu_timer_setup
	call delay_clock
	halt
	
	menu_timer_setup:
	; Initialize the timer for the user to press Enter
	loadn r0, #0
	loadn r3, #300000
		
; ────────────┤ Waits until the user presses enter to start the game ├────────────
menu_input_loop:
	loadn r2, #13 ; Enter character
	inc r0
	cmp r0, r3
	jeq main
	
	inchar r1 ; Read the keyboard
	cmp r1, r2
	jeq start_game ; If Enter was pressed, start the game.	
	jmp menu_input_loop   ; Otherwise stay in the loop
		
start_game:
	loadn r0, #0	; r0 = print_pos
	loadn r1, #map	; r1 = end(map)
	call print_string	; Print the map
	
	; ────┤ From here on the player position is always in r0 ├────
	load r0, start_position ; r0 = player start position
	loadn r6, #0
	call print_player

; ────────────┤ Movement reading ├────────────
read_direction:
	loadn r1, #0
	loadn r2, #0
	
	inchar r1		; r1 = dir | direction read from the user
	
	cmp r1, r2		; read nothing -> loop to read again
	jeq read_direction

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
	
	pop r3			; Restore the speed index
	loadn r6, #0
	call print_player
	jmp read_direction	; The box is blocked, stop the dash
	
	push_box:
	loadn r7, #'B'
	storei r4, r7		; Move the box one tile ahead
	loadn r7, #'B'
	loadn r6, #256		; Box color
	add r7, r7, r6
	outchar r7, r3		; Draw the box in its new tile
	pop r3			; Restore the speed index
	call move_player
	push r5
	rts			; Keep the dash moving
	; ────────────────────────────────────────
	
	no_box_hit:
	; ────┤ Normal wall: ask for movement ├────
	loadn r4, #'}'
	cmp r6, r4
	jne no_wall_hit
	
	loadn r6, #0
	call print_player
	jeq read_direction
	
	no_wall_hit:
	; ────┤ Deadly wall: lose the game ├────
	loadn r4, #'{'
	cmp r6, r4
	loadn r7, #1	; Player lost
	jeq game_over
	
	; ────┤ Flag: win the game ├────
	loadn r4, #')'
	cmp r6, r4
	loadn r7, #2	; Player won

; r7 = final state (0 = nothing | 1 = defeat | 2 = victory)
game_over:
	loadn r5, #1
	loadn r6, #lose_message
	cmp r5, r7		; final state == defeat
	jeq game_over_exit
	
	loadn r5, #2
	loadn r6, #win_message
	cmp r5, r7	; final state == victory
	
	game_over_exit:	; Copy the result string and leave the game
	call copy_string
	jeq print_menu

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

; Writes a string inside another starting at the position in r6
; r6 = end(string)
copy_string:
	loadn r3, #1089		; Initial position of the ending message
	loadn r4, #menu_art	; r4 = end(menu)
	add r3, r3, r4		; r3 = end(menu[message_pos])
	loadn r4, #'\0'		; String stop character
	
	copy_string_loop:
	loadi r5, r6	; r5 = menu[message_pos]
	cmp r5, r4		; r5 == '\0' -> finished printing
	jeq copy_string_end
	
	copy_character:
	storei r3, r5

	inc r3	; menu_pos++
	inc r6	; string_pos++
	jmp copy_string_loop
	
	copy_string_end:
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
