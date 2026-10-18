; ────┤ Practical Assignment in Computer Organization │ August 2021 ├────
; Gabriel Victor Cardoso Fernandes - 11878296
; Gabriel Alves Kuabara - 11275043
; Lourenço de Salles Roselino - 11796805

; Characters that build the map
; player - z yellow
; normal wall - } blue
; deadly wall - { red
; exit - open gap in the outer wall (dash through it)
; coins - * yellow
; crate - # brown (push it with a dash)
; key - $ silver
; door - = purple
; plate - @ teal
; gate - % blue
; lever - < olive
; bomb - & red
; shield - ^ aqua
; breakable wall - | gray (break it with a bomb)
; toggle wall - ! navy
;
; Keys: WASD dash, B bomb, R or ` restart the level, H or Tab help, Enter start

jmp main

; ────────┤ Menu and map strings and data ├────────
menu_art : string "                                                                                                                                       }}}}}}}}}}                              }        }                              }  }  }  }                              }        }                              }  }}}}  }                              }        }                              }        }                              }}}}}}}}}}                                                                   TOMB OF THE MASK                    GROUP 1 - FINAL PROJECT                                                             ORIGINAL GAME BY                 KUABARA - FERNANDES - ROSELINO                                                           MODIFIED BY                        GARCIA - LAMIO - RAMOS                 RUFINO - SUYO - TIMMALOG                                                         WASD DASH  R/` RESTART   H HELP                                                                                          PRESS ENTER TO PLAY                                                                                                                                                                           "
level1 : string "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}} }       }           }         }     }}} }}}}} } } } }}}}}}} }}} }}} } }}} } }}}   }   }   }       }   } }   } }   } }}}}} } }}} } }}} } } }}} } } } } } }}} }}}  *} }   }   } } }     } } }   } }   }}} }*} } }}}}} } } }}} } } } } }}} } } }}}   } }   } } }     } }     }     }    }} } } }}} } } }}} }}} }}}}}}}}}}}}}}} }}}   } } } }       }   }             } }}} }}} } }^}}}}}}} } }}}}}}}}} } }}}}} }}} }   } }  *}   }   }       } } }     }}} }}} } }}} } }}} } } } }}} }}} } }}}}}}}*  } }     }     } }#} }             }}}}} } } }}}}} }}}}} }}} } }}}}} } }}} }}  }   } }             } }   }     }{  }}}=}*} } }}}}}}}}}}}}} } } } } } }}} }}}}} } }*}      $}       } }     }   } } }}} } }^}}}}}}} } }}} }}} } }}}}} } } } }}} }   }#    } }        *} }   } } } } }}} }}}}} }}}}} }}} } } }}} } } }}} } } }}}     }    *}     } }   } } }       } }}}}} }}} }}}*} } }}} }}} } } }}}}} } } }}}  *}   }  *} }   } } }   } }{  }   } }}}*}}} }}} }}} }}} } } }}} } } } } }}} }}}      *}        {}*          }       }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}{}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}} L1 COINS 000 K 0 B 0 SHIELD -                                                  "
level2 : string "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}  }           }      }  }*       }  } }}} } }}}}} }}} }}}}}}} } } }}} } } }}} }}} * }   }   } }       } }   } } }   } }}} }}} } }}} } } }}}}} } }}}}} }}} } } }}} }*  } }   }   }     }     } }   }   }}} } } } } } }}} }}}}} } }}} } } }}} }}}}}   } }       } }   }         }     } }}}}}}} } }}}}} }}} } } }}} }}} } }}} } }}}     }   }       }     }   } }  *}   }}} }}}}}}} } } } }}} }}} } } } }}} }}} }}}         } }*         }  } }     }   }}} }}}}}}}}} } } } } } }}}}} }}} }}} }}}}}  ^} * } } }   } }*}     } } } }   } }}}}} } } } } }}} } }}} }}} } } } } }}} }} *}*} } } }*          }*  } }       } }}} } } } } }}}}} }}}}}}} }}} }}}}}}} } }}} }   }@    }   }     } }   }     } } }}} }}}}} } } } } } }}}}} } }}} }}} } } }}}  ^}   } } } }   }{   #}   } } } }   }}}*} } }}} }}} } }}} }}} }}} } } } }}} }}} }*}   } }     }#  }     }     } }   }}}*} }}} } } }}}}} }}} }}} }}} }}} } }}}}} } }   } }       }     } } }     } } }}}%} } }}} }}}}}}}}}}} } } } } }}}}} } }   }                   }     }         }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}} L2 COINS 000 K 0 B 0 SHIELD -                                                  "
level3 : string "}}}}}}}}}}}}}}}}}}}}} }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}} }}}}}}}}}}}}}}}}}}}    *}     }       }=  ^*}          {}}} }}} } } } }}}}} } }}}}} } }}} }}}}} }}}  *} } } }       }     }   *     }   }}} } }}} } }}}}}}}}}}}}} }}}}}}}}} } }}}}} } }   } }       }{}  #}  ^    } }   }}} } } }}} } }}}}} } } }}} }}} } } }}} }}} }           }     }   } }   } }     }}}}}}}}} }}}}}}} }}} } } } }}} } }}}*} }}}*      }   } * }       }   } }     } }}} } }}} } } } }}} }}}}} }}} } }}} } }}}}} }   }   } } }     }       } }   }   }}} } } }}}}} } }}}}} } }}}}}}} } } }}} }}} }         }   } } }*  }      {}     }}} }}}}}}}}} }}} } } }}} } } }}}}}}} } }}}        *}     } }    } *}   }     } }}}}} }}} } }}} }}} }}}}}}} } } }}} }}} }}}   } *  *}$&<}     }     } }   } }    }} }}} }}} } }}} } }}} }}}}} }}} } }}} }}} }   }    *}   }   }       }   }   }  }} } } } }}}}} }}}}} }}}}}}}}} }}} } }}}}} }   } }     }     }       }   }      }} }}} } } }}}}} }}}}} } }}}}}}} } }}} }}} }   }*}     }       }       } } }   }}} } } }}}}}}} }}}}} }}}}}}} }}} }}} } }}} } #|!                   }           }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}} L3 COINS 000 K 0 B 0 SHIELD -                                                  "
level4 : string "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}} }}}}}}}}}}} }}}}}}}}} *       }   }     ^            *}  {}}} }}} } } }*}*} } } }}} }}} }}} } }}} }}}   } } }   }   }   }   }** }       } }}}}} } } }*} }}}}}}} } }}} }}}}}}}}} } }}  = }     } }#    } } }   }     }     }}}}}}}}}}} } } }}}}} } } } } }}} }}}}} }}}     }   } }  *    } } } } } }       }}} }}} } }}} }}} } } } } }}} } }}} }}}}}}} }   }       } }     }   } }   }     }}} } }}}}}}}}} } }}}}}}}}} } }}} }}}}} }}} } }*   *}     }       }         }   }}} } }}} } }}}}} } }}}}}}} }}} }}}}} }}}}}       }#  }     }       }   }   }   }}} }}}}}}}}} }}}}}}} }}}}} }}} } } }}} }}}           }  ^   *}{    }   }       }}} }}}}}}} } } }}}}}}} }}}}} } } }}} } }}}   }    $@<}   }{  }*  }   }   }   } }}}}}}} }}}}} }}} } } }}} } } }}}}} }}} }}}     }  {}*    }       } } }         }}} }}}}} } }}}}}}} }}}}}}}}} }}}}} } }}}}} }   } }       } }     }         } } }}} } } } }}}}} }}} } } } } }}} }}}}} } }}}*  } } }   }     } } }   } }     } } }}}}} } } } } }}} }}}}} } }}} } }}} } } }}}    %!   }           }               }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}} L4 COINS 000 K 0 B 0 SHIELD -                                                  "
level5 : string "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}} }}}}}}} }  |}             }       }    *  } }}} } }!} }}}}} }}} } } }}} } }}} } } } }}}   }%}     }     } }     }   } } =   }}} } } }}}}}}} }}}}} }}} } }}} } }}}}} }}} } }       }   }   }         }   }   }}} } }}}}}}} }}} } }}} } }}} } } } } }}}}} } }          }}  *}       } } } } } }}} } } }}} }}} } }}} } }}}}} } }}} } } }}} }   &<}   } }  {}     }    *    } } }}} }}} } }*} } }}} }}}}} } }}}}}}}}} } }}}*  } }^   *    }{  } }{  }   }     } }}}}} }}} }}} }}} }}} } }}} } } }}} }}} }}} } }  *    }   }   }     } }*  } }   }}} } } }}} } } }}} }}}}} }}} }}} } } } }}} }   }   } } }  *    }       }     } }}} }}}}}}} } } }}}}} } }*}}}}}}} }}}}} }}}     }   } }* $@^} }           }     }}} } } } }}} }}}}} } }}} } }}}}}}} }}}}}}} }     }     }   } }   }   }   } }   }}} }}} }}}}}}} } }}} } } } } }}} } }}} }}}   } }#  }   } }   } } } }           }}} } }}} } }}}}} } }}} } }}} } }}}}}}} }}} }     }     } } } * }  *} }*      } }}} } }}}}}}}}} } }}} }}}}} }}}}} } }}} }}}           }#      }           }     }}}}}}} }}}}}}}}}}}}}}} }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}} L5 COINS 000 K 0 B 0 SHIELD -                                                  "

msg_blank: string " "
msg_clear: string "LEVEL CLEAR!"
msg_trap: string "TRAP! RESTARTING THE LEVEL"
msg_nobomb: string "NO BOMBS LEFT"
msg_nothing: string "NOTHING TO BREAK"
msg_win: string "YOU WIN! PRESS ENTER TO PLAY AGAIN"
msg_shield_bonus: string "SHIELD ALREADY ACTIVE +5 COINS"
help_art : string "                                                    TOMB OF THE MASK                          ICON LEGEND                                                          z   PLAYER        MOVE WITH WASD        *   COIN          +1 SCORE              #   CRATE         PUSH WITH A DASH      &   BOMB          PRESS B TO USE IT     ^   SHIELD        BLOCKS ONE TRAP       |   WEAK WALL     BREAK WITH A BOMB     {   TRAP          DEADLY - AVOID IT     $   KEY           OPENS ONE DOOR        =   DOOR          NEEDS A KEY           @   PLATE         OPENS EVERY GATE      %   GATE          CLOSED TILL PLATE     <   LEVER         FLIPS BLUE BLOCKS                                             EXIT   DASH OUT THROUGH THE OPEN GAP         IN THE LEFT OR TOP OUTER WALL                                              CONTROLS   WASD DASH      B BOMB                   R/` RESTART   H/TAB HELP                ENTER START OR CONFIRM                                               TIP: DASH RUNS UNTIL A WALL STOPS IT    TIP: PUSH CRATES WITH A DASH                                                     PRESS H, TAB OR ENTER TO RESUME                                                                                     "

map : var #1201		; Working copy of the level, rebuilt on every restart

scroll_buf : var #1201		; Transition buffer used by the level scroll

sprite_colors : var #15
static sprite_colors + #0, #2816	; Coin color
static sprite_colors + #1, #1024	; Normal wall color
static sprite_colors + #2, #2304	; Deadly wall color
static sprite_colors + #3, #3328	; Flag color
static sprite_colors + #4, #0		; no color
static sprite_colors + #5, #256	; Crate color
static sprite_colors + #6, #1792	; Key color
static sprite_colors + #7, #1280	; Door color
static sprite_colors + #8, #1536	; Plate color
static sprite_colors + #9, #3072	; Gate color
static sprite_colors + #10, #768	; Lever color
static sprite_colors + #11, #2304	; Bomb color
static sprite_colors + #12, #3584	; Shield color
static sprite_colors + #13, #2048	; Breakable wall color
static sprite_colors + #14, #1024	; Toggle wall color

; ─────────────────────────────────────────────────────

; ──────────┤ Player related data ├──────────
start_position : var #1
static start_position, #1067	; Player starting position

coin_count: var #1			; keeps how many coins the player has
static coin_count + #0, #0

coin_record: var #1			; coin count when the current level started
static coin_record + #0, #0

key_count: var #1
static key_count + #0, #0

bomb_count: var #1			; bombs in hand
static bomb_count + #0, #0

shield: var #1				; 1 while a shield is active
static shield + #0, #0

flip_list_cur: var #1			; address of the tile list the lever toggles
static flip_list_cur + #0, #0

level_index: var #1
static level_index + #0, #0

start1: var #1
static start1 + #0, #123

start2: var #1
static start2 + #0, #123

start3: var #1
static start3 + #0, #963

start4: var #1
static start4 + #0, #963

start5: var #1
static start5 + #0, #123

exit1: var #1
static exit1 + #0, #600		; (15,0) opening in the left outer wall
exit2: var #1
static exit2 + #0, #1000	; (25,0) opening in the left outer wall
exit3: var #1
static exit3 + #0, #21		; (0,21) opening in the top outer wall
exit4: var #1
static exit4 + #0, #240		; (6,0) opening in the left outer wall
exit5: var #1
static exit5 + #0, #33		; (0,33) opening in the top outer wall

exit_pos: var #1		; exit cell of the level being played
static exit_pos + #0, #0

flip1: var #1
static flip1 + #0, #0

flip2: var #1
static flip2 + #0, #0

flip3: var #2
static flip3 + #0, #1046
static flip3 + #1, #0

flip4: var #2
static flip4 + #0, #1046
static flip4 + #1, #0

flip5: var #2
static flip5 + #0, #85
static flip5 + #1, #0

;Speed variables
speed : var #2
static speed + #0, #40	; vertical speed   (up || down)
static speed + #1, #1	; horizontal speed (left || right)
; ─────────────────────────────────────────────────────

; ────────────┤ Clock delay data ├────────────
; Per-tile dash pacing = loop_count * nops_per_loop NOP rounds.
; The stock simulator build (no optimization flags, as compila.sh builds it)
; runs about 35 million instructions per second, so loop_count = 60 is about
; 1.2 million instructions per tile which is roughly 34 ms per tile, about
; two rendered frames. If the simulator is rebuilt with -O2 it runs about six
; times faster, so divide this number when you do that.
loop_count : var #1
static loop_count, #60

nops_per_loop : var #1
static nops_per_loop, #5000
; ─────────────────────────────────────────────────────
                         
main:
	; Fresh game state
	loadn r6, #0
	store coin_count, r6
	store coin_record, r6
	store key_count, r6
	store level_index, r6
	
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
	call start_level	; r0 = player position after this call
	jmp read_direction

; ────────────┤ Starts the selected level ├────────────
start_level:
	load r6, coin_count	; Snapshot the coin count for this level
	store coin_record, r6
	call load_level
	rts

; ────────────┤ Picks the level data for level_index ├────────────
; Returns r1 = level string, r5 = exit cell, r6 = start, r7 = flip list
pick_level_data:
	load r4, level_index
	loadn r3, #0
	cmp r4, r3
	jne pick_not_one
	loadn r1, #level1
	loadn r7, #flip1
	load r5, exit1
	load r6, start1
	rts
	
	pick_not_one:
	loadn r3, #1
	cmp r4, r3
	jne pick_not_two
	loadn r1, #level2
	loadn r7, #flip2
	load r5, exit2
	load r6, start2
	rts
	
	pick_not_two:
	loadn r3, #2
	cmp r4, r3
	jne pick_not_three
	loadn r1, #level3
	loadn r7, #flip3
	load r5, exit3
	load r6, start3
	rts
	
	pick_not_three:
	loadn r3, #3
	cmp r4, r3
	jne pick_not_four
	loadn r1, #level4
	loadn r7, #flip4
	load r5, exit4
	load r6, start4
	rts
	
	pick_not_four:
	loadn r1, #level5
	loadn r7, #flip5
	load r5, exit5
	load r6, start5
	rts

; ────────────┤ Copies the selected level into the working map ├────────────
load_level:
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	call pick_level_data	; r1 = level | r5 = exit | r6 = start | r7 = flip list
	store flip_list_cur, r7
	store start_position, r6
	store exit_pos, r5
	
	; Copy the level string into the working map
	loadn r2, #map
	loadn r5, #1201
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
	store bomb_count, r6
	store shield, r6
	
	; Print the board, the player, the counters and a clean message line
	loadn r0, #0
	loadn r1, #map
	call print_string
	load r0, start_position	; r0 = player start position
	call print_player
	call draw_hud
	loadn r1, #msg_blank
	call show_message
	
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	rts

; ────────────┤ Draws the counters line ├────────────
; r0 = screen position, r1 = plain char, r2 = color base (bits 11..8, 0 = no color)
; The char is mirrored into the working map so the level scroll shows the
; counters of the moment while the old room slides away.
hud_put:
	push r3
	loadn r3, #map
	add r3, r3, r0
	storei r3, r1
	loadn r3, #0
	cmp r2, r3
	jeq hud_put_plain
	add r1, r2, r1
	hud_put_plain:
	outchar r1, r0
	pop r3
	rts

draw_hud:
	push r0
	push r1
	push r2
	push r3
	push r4
	
	; Coins, three digits
	load r2, coin_count
	loadn r4, #100
	div r1, r2, r4
	loadn r3, #48
	add r1, r3, r1
	loadn r0, #1130
	loadn r2, #2816		; yellow
	call hud_put
	load r2, coin_count
	loadn r4, #10
	div r1, r2, r4
	mod r1, r1, r4
	loadn r3, #48
	add r1, r3, r1
	loadn r0, #1131
	loadn r2, #2816		; yellow
	call hud_put
	load r2, coin_count
	mod r1, r2, r4
	loadn r3, #48
	add r1, r3, r1
	loadn r0, #1132
	loadn r2, #2816		; yellow
	call hud_put
	
	; Keys, one digit
	load r2, key_count
	loadn r3, #48
	add r1, r3, r2
	loadn r0, #1136
	loadn r2, #1792		; silver
	call hud_put
	
	; Bombs, one digit
	load r2, bomb_count
	loadn r3, #48
	add r1, r3, r2
	loadn r0, #1140
	loadn r2, #2304		; red
	call hud_put
	
	; Shield state
	load r2, shield
	loadn r3, #0
	cmp r2, r3
	jeq draw_hud_no_shield
	loadn r1, #'^'
	loadn r2, #3584		; aqua
	jmp draw_hud_shield_done
	draw_hud_no_shield:
	loadn r1, #'-'
	loadn r2, #0
	draw_hud_shield_done:
	loadn r0, #1149
	call hud_put
	
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

; ────────────┤ Prints a message on the bottom line ├────────────
show_message:
	push r0
	push r1
	push r2
	push r3
	mov r3, r1		; Keep the message address
	
	; Clear the whole line first
	loadn r0, #1160
	loadn r2, #1200
	show_message_clear:
	cmp r0, r2
	jeq show_message_print
	loadn r1, #' '
	outchar r1, r0
	inc r0
	jmp show_message_clear
	
	show_message_print:
	loadn r0, #1160
	mov r1, r3
	call print_string
	
	pop r3
	pop r2
	pop r1
	pop r0
	rts

; ────────────┤ Restarts the current level ├────────────
restart_level:
	load r6, coin_record	; Coins go back to the level start value
	store coin_count, r6
	call load_level
	rts

; Uses one bomb and destroys the breakable walls around the player
use_bomb:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	
	load r4, bomb_count
	loadn r5, #0
	cmp r4, r5
	jne use_bomb_has
	loadn r1, #msg_nobomb
	call show_message
	jmp use_bomb_end		; No bombs in hand
	use_bomb_has:
	
	loadn r5, #0		; r5 = how many walls broke
	
	; Check the four neighbours around the player
	loadn r1, #40
	sub r2, r0, r1
	call bomb_hit
	add r2, r0, r1
	call bomb_hit
	loadn r1, #1
	sub r2, r0, r1
	call bomb_hit
	add r2, r0, r1
	call bomb_hit
	
	loadn r1, #0
	cmp r5, r1
	jne use_bomb_broke
	loadn r1, #msg_nothing
	call show_message
	jmp use_bomb_end		; Nothing to break, keep the bomb
	use_bomb_broke:
	load r4, bomb_count
	dec r4
	store bomb_count, r4
	call draw_hud
	
	use_bomb_end:
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

; Breaks a breakable wall at the position in r2
bomb_hit:
	push r1
	push r3
	push r4
	loadn r1, #map
	add r1, r1, r2
	loadi r3, r1
	loadn r4, #'|'
	cmp r3, r4
	jne bomb_hit_end
	loadn r3, #' '
	storei r1, r3		; Remove the wall from the map
	outchar r3, r2		; Clear the wall on the screen
	inc r5			; Count the broken wall
	bomb_hit_end:
	pop r4
	pop r3
	pop r1
	rts

; Toggles every tile in the current flip list
flip_layout:
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	load r1, flip_list_cur
	flip_layout_loop:
	loadi r2, r1		; r2 = next cell index
	loadn r3, #0
	cmp r2, r3
	jeq flip_layout_end	; End of the list
	inc r1
	
	loadn r4, #map
	add r4, r4, r2
	loadi r5, r4
	loadn r6, #'!'
	cmp r5, r6
	jeq flip_open
	
	; The cell closes
	loadn r5, #'!'
	storei r4, r5
	loadn r5, #'!'
	loadn r6, #1024		; Toggle wall color
	add r5, r5, r6
	outchar r5, r2
	jmp flip_layout_loop
	
	flip_open:
	loadn r5, #' '
	storei r4, r5
	outchar r5, r2
	jmp flip_layout_loop
	
	flip_layout_end:
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
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
	; Bomb key
	loadn r2, #'b'
	cmp r1, r2
	jne check_restart
	call use_bomb
	jmp read_direction
	
	check_restart:
	; Restart key
	loadn r2, #'r'
	cmp r1, r2
	jne check_quick_restart
	call restart_level
	jmp read_direction
	
	check_quick_restart:
	; Grave key ` (0x60) - quick restart of the current level
	loadn r2, #96
	cmp r1, r2
	jne check_help
	call restart_level
	jmp read_direction
	
	check_help:
	; Help overlay: H or Tab (Tab needs the patched simulator)
	loadn r2, #'h'
	cmp r1, r2
	jeq open_help
	loadn r2, #9
	cmp r1, r2
	jne check_movement
	open_help:
	call help_screen
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
	; ────┤ Boundary exit: dashed into the outer wall opening ├────
	load r4, exit_pos
	cmp r1, r4
	jeq exit_reached
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
	loadn r4, #'#'
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
	loadn r7, #'@'
	cmp r6, r7		; plate: the box presses it
	jeq push_box
	
	pop r3			; Restore the speed index
	loadn r6, #0
	call print_player
	jmp read_direction	; The box is blocked, stop the dash
	
	push_box:
	loadn r7, #'#'
	storei r4, r7		; Move the crate one tile ahead
	loadn r4, #'@'
	cmp r6, r4		; Was the box pushed onto a plate?
	jeq push_box_switch
	push_box_draw:
	loadn r7, #'#'
	loadn r6, #256		; Crate color
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
	loadn r4, #'$'
	cmp r6, r4
	jne no_key_hit
	
	call update_keys
	call move_player
	push r5
	rts			; Keep the dash moving
	; ────────────────────────────────────────
	
	no_key_hit:
	; ────┤ Bomb: add one bomb ├────
	loadn r4, #'&'
	cmp r6, r4
	jne no_bomb_hit
	
	load r4, bomb_count
	inc r4
	store bomb_count, r4
	call draw_hud
	call move_player
	push r5
	rts			; Keep the dash moving
	; ────────────────────────────────────────
	
	no_bomb_hit:
	; ────┤ Shield: absorb one trap hit ├────
	loadn r4, #'^'
	cmp r6, r4
	jne no_shield_hit
	
	; Already shielded? The pickup pays bonus coins instead of being wasted
	load r4, shield
	loadn r7, #0
	cmp r4, r7
	jeq shield_first
	load r4, coin_count
	loadn r7, #5
	add r4, r4, r7
	store coin_count, r4
	call move_player	; take the tile while r0/r1 are still the move registers
	call draw_hud
	loadn r1, #msg_shield_bonus
	call show_message
	push r5
	rts			; Keep the dash moving
	
	shield_first:
	loadn r4, #1
	store shield, r4
	call draw_hud
	call move_player
	push r5
	rts			; Keep the dash moving
	; ────────────────────────────────────────
	
	no_shield_hit:
	; ────┤ Lever: flip the layout tiles ├────
	loadn r4, #'<'
	cmp r6, r4
	jne no_lever_hit
	
	call flip_layout
	call move_player
	push r5
	rts			; Keep the dash moving
	; ────────────────────────────────────────
	
	no_lever_hit:
	; ────┤ Door: open with a key ├────
	loadn r4, #'='
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
	call draw_hud
	
	door_stop:
	loadn r6, #0
	call print_player
	jmp read_direction
	; ────────────────────────────────────────
	
	no_door_hit:
	; ────┤ Switch: press it ├────
	loadn r4, #'@'
	cmp r6, r4
	jne no_switch_hit
	
	call open_switch_door
	call move_player
	push r5
	rts			; Keep the dash moving
	; ────────────────────────────────────────
	
	no_switch_hit:
	; ────┤ Switch door: closed until the switch is pressed ├────
	loadn r4, #'%'
	cmp r6, r4
	jne no_gate_hit
	loadn r6, #0
	call print_player
	jmp read_direction
	; ────────────────────────────────────────
	
	no_gate_hit:
	; ────┤ Solid tiles: stop the dash ├────
	loadn r4, #'}'
	cmp r6, r4
	jeq wall_stop
	loadn r4, #'|'
	cmp r6, r4
	jeq wall_stop
	loadn r4, #'!'
	cmp r6, r4
	jeq wall_stop
	jmp no_wall_hit
	
	wall_stop:
	loadn r6, #0
	call print_player
	jmp read_direction
	
	no_wall_hit:
	; ────┤ Trap: a shield absorbs one hit ├────
	loadn r4, #'{'
	cmp r6, r4
	jne no_trap_hit
	load r4, shield
	loadn r7, #0
	cmp r4, r7
	jeq trap_death		; No shield, the run ends here
	
	; The shield absorbs the hit and the trap is removed
	push r3			; Keep the speed index
	loadn r3, #map
	add r3, r3, r1
	loadn r4, #' '
	storei r3, r4
	outchar r4, r1
	loadn r4, #0
	store shield, r4
	call draw_hud
	pop r3			; Restore the speed index
	call move_player
	push r5
	rts			; Keep the dash moving
	
	trap_death:
	loadn r1, #msg_trap
	call show_message
	loadn r6, #25
	trap_pause:
	call delay_clock
	dec r6
	jnz trap_pause
	call restart_level
	jmp read_direction
	
	no_trap_hit:
	; ────┤ Unknown tile: hold like a wall ├────
	loadn r6, #0
	call print_player
	jmp read_direction

; ────────────┤ Reached the boundary exit: clear the level ├────────────
exit_reached:
	call move_player	; step into the opening
	; ────┤ Level clear: congratulate, scroll to the next room ├────
level_clear_sequence:
	push r6
	push r7
	loadn r1, #msg_clear
	call show_message
	loadn r6, #12		; short pause before the transition
	clear_pause:
	call delay_clock
	dec r6
	jnz clear_pause
	load r6, level_index
	inc r6
	store level_index, r6
	loadn r7, #5
	cmp r6, r7
	jeq all_levels_done
	call scroll_to_next_level
	pop r7
	pop r6
	call start_level
	jmp read_direction
	
	all_levels_done:
	loadn r1, #msg_win
	call show_message
	win_wait:
	loadn r2, #13
	inchar r1
	cmp r1, r2
	jne win_wait
	pop r7
	pop r6
	jmp main

; ────────────┤ Scrolls the next room into view ├────────────
; The camera follows the player out of the exit: after a top exit the next
; room slides in from the top, after a side exit from the side.
scroll_to_next_level:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	call pick_level_data	; r1 = next level string (level_index already moved on)
	mov r7, r1		; r7 = next room data
	load r5, exit_pos
	loadn r6, #40
	cmp r5, r6
	jgr scroll_left_next	; exit on a side column -> slide from the left
	; fall through: exit on the top row -> slide from the top
scroll_up_next:
	loadn r5, #0		; r5 = cells already scrolled in (0..1200)
	scroll_up_step:
	loadn r6, #40
	add r5, r5, r6		; one more row
	; the rows of the next room enter from the top of the screen
	loadn r2, #scroll_buf
	loadn r3, #1200
	sub r3, r3, r5
	add r3, r3, r7
	mov r6, r5
	call scroll_copy
	; the old room is pushed down
	loadn r3, #map
	loadn r6, #1200
	sub r6, r6, r5
	call scroll_copy
	loadn r3, #0
	storei r2, r3		; string terminator
	loadn r0, #0
	loadn r1, #scroll_buf
	call print_string
	call delay_clock
	loadn r6, #1200
	cmp r5, r6
	jne scroll_up_step
	jmp scroll_done
	
scroll_left_next:
	loadn r5, #0		; r5 = columns already scrolled in (0..40)
	scroll_left_step:
	loadn r6, #1
	add r5, r5, r6
	loadn r0, #0		; r0 = row
	scroll_left_row:
	loadn r1, #40
	mul r1, r0, r1		; r1 = 40 * row
	loadn r2, #scroll_buf
	add r2, r2, r1		; destination row
	loadn r3, #40
	sub r3, r3, r5
	add r3, r3, r1
	add r3, r3, r7		; the next room part of this row
	mov r6, r5
	call scroll_copy
	loadn r3, #map
	add r3, r3, r1
	loadn r6, #40
	sub r6, r6, r5
	call scroll_copy	; the old room part of this row
	inc r0
	loadn r1, #30
	cmp r0, r1
	jne scroll_left_row
	loadn r3, #0
	storei r2, r3		; string terminator
	loadn r0, #0
	loadn r1, #scroll_buf
	call print_string
	call delay_clock
	loadn r1, #40
	cmp r5, r1
	jne scroll_left_step
	
scroll_done:
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

; ────────────┤ Copies r6 cells from r3 to r2 ├────────────
scroll_copy:
	loadn r1, #0
	cmp r6, r1
	jeq scroll_copy_end
	scroll_copy_loop:
	loadi r1, r3
	storei r2, r1
	inc r2
	inc r3
	dec r6
	jnz scroll_copy_loop
	scroll_copy_end:
	rts

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

; ────────────┤ Help overlay (H or Tab) ├────────────
; r0 holds the player position on entry and is preserved
help_screen:
	push r0
	push r1
	push r2
	loadn r0, #0
	loadn r1, #help_art
	call print_string
	help_wait:
	inchar r1
	loadn r2, #'h'
	cmp r1, r2
	jeq help_close
	loadn r2, #'H'
	cmp r1, r2
	jeq help_close
	loadn r2, #9
	cmp r1, r2
	jeq help_close
	loadn r2, #13
	cmp r1, r2
	jeq help_close
	jmp help_wait
	help_close:
	loadn r0, #0
	loadn r1, #map
	call print_string
	pop r2
	pop r1
	pop r0			; recover the player position
	call print_player
	call draw_hud
	loadn r1, #msg_blank
	call show_message
	rts

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
	
	loadn r5, #'#'
	cmp r4, r5		; sprite = crate
	loadn r2, #5
	jeq print_sprite
	
	loadn r5, #'$'
	cmp r4, r5		; sprite = key
	loadn r2, #6
	jeq print_sprite
	
	loadn r5, #'='
	cmp r4, r5		; sprite = door
	loadn r2, #7
	jeq print_sprite
	
	loadn r5, #'@'
	cmp r4, r5		; sprite = plate
	loadn r2, #8
	jeq print_sprite
	
	loadn r5, #'%'
	cmp r4, r5		; sprite = gate
	loadn r2, #9
	jeq print_sprite
	
	loadn r5, #'<'
	cmp r4, r5		; sprite = lever
	loadn r2, #10
	jeq print_sprite
	
	loadn r5, #'&'
	cmp r4, r5		; sprite = bomb
	loadn r2, #11
	jeq print_sprite
	
	loadn r5, #'^'
	cmp r4, r5		; sprite = shield
	loadn r2, #12
	jeq print_sprite
	
	loadn r5, #'|'
	cmp r4, r5		; sprite = breakable wall
	loadn r2, #13
	jeq print_sprite
	
	loadn r5, #'!'
	cmp r4, r5		; sprite = toggle wall
	loadn r2, #14
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
	push r2
	load r2, coin_count
	inc r2
	store coin_count, r2
	pop r2
	call draw_hud
	rts

update_keys:
	push r2
	load r2, key_count
	inc r2
	store key_count, r2
	pop r2
	call draw_hud
	rts

; Opens every gate in the working map, called when a plate is pressed
open_switch_door:
	push r1
	push r2
	push r3
	push r4
	push r5
	
	loadn r1, #map
	loadn r2, #1200
	open_switch_door_loop:
	loadi r3, r1
	loadn r4, #'%'
	cmp r3, r4
	jne open_switch_door_skip
	loadn r4, #' '
	storei r1, r4		; The gate opens in the map
	loadn r5, #map
	sub r3, r1, r5		; Screen position of this gate
	outchar r4, r3		; The gate is erased on the screen
	open_switch_door_skip:
	inc r1
	dec r2
	jnz open_switch_door_loop
	
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	rts


; Delay function: keeps the clock busy to pace the dash animation.
; The per-tile length is the tuning knob: loop_count * nops_per_loop rounds.
delay_clock:
	push r0
	push r1
	push r2
	
	load r0, loop_count	; number of loops
	loadn r2, #0
	
	delay_loop:
	load r1, nops_per_loop	; number of nops
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
