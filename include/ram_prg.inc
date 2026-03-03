.ifndef __RAM_PRG_INC__
__RAM_PRG_INC__ = 1

.import Tile_Mem    ; $6000-$794F Space used to store the 16x16 "tiles" that make up the World Map or Level

.import Map_MoveRepeat    ; $7950-$7951 (Mario/Luigi) counts up to $18 and then you keep moving without pause
.import AScrlURDiag_OffsetX    ; When diagonal autoscroller is wrapping, this holds an X offset for Player/Objects to temporarily correct
.import AScrlURDiag_OffsetY    ; When diagonal autoscroller is wrapping, this holds an Y offset for Player/Objects to temporarily correct
.import StatusBar_UpdFl    ; Status bar Update Flag; toggles so to update status bar only every other frame
.import UpdSel_Disable    ; When set, disables the Update_Select routine during the NMI, which halts most activity due to no reported V-Blanking
.import Map_Objects_Itm    ; $7956-$795D, "Item given by" map objects

	; Item that will be given by treasure box; set by the object OBJ_TREASURESET by its row
	; Level_TreasureItem:
	; 0 = INVALID
	; 1 = Mushroom
	; 2 = Flower
	; 3 = Leaf
	; 4 = Frog
	; 5 = Tanooki
	; 6 = Hammer
	; 7 = Judgem's cloud
	; 8 = P-Wing
	; 9 = Star
	; A = Anchor
	; B = Hammer
	; C = Warp Whistle
	; D = Music Box
.import Level_TreasureItem
.import Reset_Latch    ; If this value is anything besides $5A, the reset is run (I assume this is considered a safe value in case of data corruption, e.g. from runaway generator)
.import Map_BonusType    ; 0 = No bonus, 1 = White Toad House, 2 = UNKNOWN WHITE THING (MAPOBJ_UNK0C)
.import Map_BonusCoinsReqd    ; Number of coins you need for White Toad House (or the MAPOBJ_UNK0C thing!); value ranges 0-127
.import Coins_ThisLevel    ; Internal counter of coins earned -this level- (so always starts at 0 and increments)

.import Map_NSpade_NextScore    ; $7968 (H)-$796A (L) treated as 3-byte integer

.import Map_BonusAppY    ; Map "white" bonus appearance Y (set to Player's last "succeeded" map position)
.import Map_BonusAppXHi    ; Map "white" bonus appearance XHi (set to Player's last "succeeded" map position)
.import Map_BonusAppX    ; Map "white" bonus appearance X (set to Player's last "succeeded" map position)

.import Map_NoLoseTurn    ; If set, Player does not lose turn after having completed a level (used for Toad House, pipeways, etc.)
.import Map_Got13Warp    ; Set non-zero if Player already got the 1-3 Warp Whistle
.import Map_Anchored    ; Set if anchor is set on this map
.import Map_WhiteHouse    ; Set if you have already earned the White Toad House for this world
.import Map_CoinShip    ; Set if you have already earned the Coin Ship for this world
.import Map_WasInPipeway    ; Set if you just came out of a pipeway
.import EndCard_Flag    ; Set when End Level card is hit (can determine when level has ended)
.import Map_PlyrSprOvrY    ; "Player Sprite Override Y"; If set to $F8 during warp, erases Player's map sprite; otherwise provides a Y to put it at
.import Map_Entered_Y    ; $7976-$7977 (Mario/Luigi) Stores the Y value when you enter a level; this is the Y used if you complete the level
.import Map_Entered_XHi    ; $7978-$7979 (Mario/Luigi) Hi byte for Map_Entered_X
.import Map_Entered_X    ; $797A-$797B (Mario/Luigi) Same as Map_Entered_Y, only for X
.import Map_Previous_UnusedPVal2    ; $797C-$797D (Mario/Luigi) Backup of Map_UnusedPlayerVal2
.import Map_Previous_Y    ; $797E-$797F (Mario/Luigi) Stores the previous Y you were "safe" at; this is the Y you go back to if you die
.import Map_Previous_XHi    ; $7980-$7981 (Mario/Luigi) Same as Map_Previous_Y, only for XHi
.import Map_Previous_X    ; $7982-$7983 (Mario/Luigi) Same as Map_Previous_Y, only for X
.import Map_Unused7984    ; $7984-$7985 (Mario/Luigi) Unused; cleared and never touched again
.import Map_Prev_XOff2    ; $7986-$7987 (Mario/Luigi) Holds a copy of Map_Prev_XOff, but I'm not sure why?
.import Map_Prev_XHi2    ; $7988-$7989 (Mario/Luigi) Holds a copy of Map_Prev_XHi, but I'm not sure why?
.import Map_Unused798A    ; $798A-$798B (Mario/Luigi) Unused; cleared and never touched again

	; These define values to use when you junction back
	; to the level you were before...
.import Level_Jct_HSHi    ; Level junction horizontal scroll high value
.import Level_Jct_HS    ; Level junction horizontal scroll value
.import Level_Jct_VSHi    ; Level junction vertical scroll high value
.import Level_Jct_VS    ; Level junction vertical scroll value

.import Map_Unused7992			; Value used in some dead code in PRG011; cleared elsewhere (NOT SURE if maybe it sometimes meant Bonus_DiePos?)
.import Bonus_DiePos    ; UNUSED Die in the lost bonus games, counts 0-5
.import Map_Previous_Dir    ; $7993-$7994 (Mario/Luigi) Backup movement dir (remember which way Player moved last) (8=Up, 4=Down, 2=Left, 1=Right)
.import Map_Unused7995    ; Unused; cleared but never used otherwise
.import Player_NoSlopeStick    ; If set, Player does not stick to slopes (noticeable running downhill)

	; Auto scroll effect variables -- everything to do with screens that aren't scrolling in the normal way
	; NOTE: Post-airship cinematic scene with Toad and King ONLY uses $7A01-$7A11 MMC3 SRAM (from Level_AScrlSelect to Level_AScrlHVelCarry)
.import AScroll_Anchor    ; Used as starting point for $7A00-$7A14 clear, but never actually used in Auto-Scroll
.import Level_AScrlSelect    ; Selects auto scroll routine to use (see PRG009_B922)

	; Values used in horizontal scrolling (Level_AScrlSelect = 0/1) only:
	; $00: World 3-6 / 1-4
	; $01: World 3 Airship
	; $02: World 6-2
	; $03: World 5 Airship
	; $04: World 2 Airship
	; $05: World 4 Airship
	; $06: World 6 Airship
	; $07: World 5-6
	; $0A: World 6-7
	; $0B: World 1 Airship
	; $0C: World 7 Airship
	; $0D: World 8 Airship
	; $0E: World 8 Battleship
	; $0F: World 7-4
	; $10: World 1 Coin Heaven
	; $11: Coin Ship
	; $13: World 8 Tank 1
	; $14: World 8 Tank 2
.import Level_AScrlLimitSel    ; "Limit Selector" for the auto scroll (typically selects an end or a start/end pair, depending on style)

	; Level_AScrlVar
	; Variable used for different things depending on the auto scroll style
	; In horizontal scroll style (Level_AScrlSelect = 0), it's the current "movement" (see table AScroll_Movement)
.import Level_AScrlVar

.import Level_AScrlLoopSel    ; Currently selected "movement loop" (horizontal only, see AScroll_MovementLoopStart; Just a var in others?)
.import Level_AScrlMoveRepeat    ; Repeat current move until zero (decrements each full expiration of Level_AScrlMoveTicks); $FF when on last move, passes control to movement loop
.import Level_AScrlLoopCurMove    ; Current "movement loop" index (into AScroll_MovementLoop)
.import Level_AScrlSclLastDir    ; Auto scroll "Scroll_LastDir" 
.import Level_AScrlMoveTicks    ; Counts down to zero, decrements Level_AScrlMoveRepeat (goes to next "movement")
.import Level_AScrlTimer    ; Auto scroll counter, decrements to zero
.import Level_AScrlPosHHi    ; Raster effect horizontal "high" position

.import Level_AScrlPosH    ; Raster effect horizontal position
.import Level_AScrlPosV    ; Raster effect vertical position
.import Level_AScrlHVel    ; Auto scroll horizontal "velocity"
.import Level_AScrlVVel    ; Auto scroll vertical "velocity"
.import Level_AScrlHVelFrac    ; Auto scroll horizontal velocity fractional accumulator 
.import Level_AScrlVVelFrac    ; Auto scroll vertical velocity fractional accumulator 
.import Level_AScrlHVelCarry    ; '1' when last auto scroll H Velocity fraction accumulation rolled over
.import Level_AScrlVVelCarry    ; '1' when last auto scroll V Velocity fraction accumulation rolled over
.import World8Tank_OnTank    ; Set when Player is standing on tank surface in Tank level (as opposed to ground); for the illusion the tank is moving through...
;;;;;;;;;;;;


; "Cannon Fire" are sort of objects that exist to repeatedly fire off cannon balls
; or other such armaments.  They are created by 

.import CannonFire_ID    ; $7A15-$7A1C ID of the cannon fire
.import CannonFire_YHi    ; $7A1D-$7A24 Cannon fire Y Hi
.import CannonFire_Y    ; $7A25-$7A2C Cannon fire Y
.import CannonFire_XHi    ; $7A2D-$7A34 Cannon fire X Hi
.import CannonFire_X    ; $7A35-$7A3C Cannon fire X
.import CannonFire_Parent    ; $7A3D-$7A44 Tie back to level object index of "parent" object

.import Splash_DisTimer    ; Player water splashes are disabled until decrements to zero; set when Player hits any bounce block

	; For that little "flash" that comes from the shell kill impact!
.import ShellKillFlash_Cnt    ; "Shell Kill Flash" counter
.import ShellKillFlash_Y    ; "Shell Kill Flash" Y
.import ShellKillFlash_X    ; "Shell Kill Flash" X

; NOTE!! Objects_DisPatChng for OBJECT SLOT 0 - 5 ONLY!
.import Objects_DisPatChng    ; $7A49-$7A4E If set, this object no longer enforces a pattern bank change

; NOTE!! These object vars are OBJECT SLOT 0 - 5 ONLY!
.import ObjSplash_DisTimer    ; $7A4F-$7A54 Object water/lava splashes are disabled until decrements to zero

.import PlayerProj_XVelFrac    ; $7A55-$7A56 Player Projectile X velocity fractional accumulator

.import CannonFire_Timer2    ; $7A57-$7A5E Cannon Fire timer (decrements to zero)

.import Roulette_Unused7A5F    ; Unused value in Roulette game
.import Roulette_Unused7A5F_Delta    ; Delta value added to Roulette_Unused7A5F

.import Bowser_Tiles    ; $7A61-$7A62 Bowser's detected tiles (to determine what to break)
.import Bowser_Counter1    ; A counter used by Bowser, decrements to zero
.import Bowser_Counter2    ; A counter used by Bowser, decrements to zero 
.import Bowser_Counter3    ; A counter used by Bowser, random setting, decrements to zero

.import CoinShip_CoinGlowIdx    ; Coin Ship only: Glowing coins palette color index
.import CoinShip_CoinGlowCnt    ; Coin Ship only: Glowing coins palette color counter

.import SObjBlooperKid_OutOfWater    ; $7A68-$7A6F Blooper kid only; if set, Blooper Kid is trying to go out of water

.import Object_SplashAlt    ; Used to alternate the "splash slots" 1 and 2 as objects hit the water

.import Music_Start    ; Music start index (beginning of this song)
.import Music_End    ; Music end index (inclusive last index to play before loop)
.import Music_Loop    ; Music loop index (index to start from when song reaches end)
.import Sound_Octave    ; Used for calculating octave
.import Music_Sq1Bend    ; Alters PAPU_FT1 for bend effects
.import Music_Sq2Bend    ; Alters PAPU_FT2 for bend effects
.import Music_RestH_Off    ; Offset added to Music_RestH_Base; typically $00 or $10 (for low time warning on compatible songs)
.import PAPU_MODCTL_Copy    ; Current PAPU_MODCTL register

.import Level_ObjIdxStartByScreen    ; $7B00-$7B0F Defines the starting index into Level_Objects for each "screen"

.import Level_ObjectsSpawned    ; $7B10-$7B3F When $80 set, object is already spawned, $00 means not

; Level_ObjPtr_AddrL is an array that defines the level objects to appear
; The first byte copied in has no apparent purpose
; The rest is a repeating series of 3 bytes -- ID, Column, Row (C/R of tile grid, multiply by 16 for pixel location), $FF for terminator
.import Level_Objects    ; $7B40-$7BCF


; For certain objects that require a buffer of X or Y values; only a couple are available.
; Each contains 32 bytes, intended for enemies that have "tails"; Buffer_Occupied determines
; which of the two buffers is free, if any at all.  The object will hold onto it then.
; Because of this, objects which employ it must also be hardcoded to release it; see
; "Object_Delete" for the hardcoded list of objects which must release this resource...
.import Object_BufferX    ; $7C20-$7C3F / $7C40-$7C5F
.import Object_BufferY    ; $7C60-$7C7F / $7C80-$7C9F

; Variables used by Chain Chomps ONLY -- manages the chain links 
.import ChainChomp_ChainX1    ; $7CA0-$7CA4 Chain Link 1 X
.import ChainChomp_ChainX2    ; $7CA5-$7CA9 Chain Link 2 X
.import ChainChomp_ChainX3    ; $7CAA-$7CAE Chain Link 3 X
.import ChainChomp_ChainX4    ; $7CAF-$7CB4 Chain Link 4 X

.import ChainChomp_ChainY1    ; $7CB4-$7CB8 Chain Link 1 Y
.import ChainChomp_ChainY2    ; $7CB9-$7CBD Chain Link 2 Y
.import ChainChomp_ChainY3    ; $7CBE-$7CC2 Chain Link 3 Y
.import ChainChomp_ChainY4    ; $7CC3-$7CC8 Chain Link 4 Y

; NOTE!! These object vars are OBJECT SLOT 0 - 4 ONLY!
.import Objects_Var10    ; $7CC8-$7CCC Generic object variable 10
.import Objects_Var11    ; $7CCD-$7CD1 Generic object variable 11
.import Objects_Var12    ; $7CD2-$7CD6 Generic object variable 12
.import Objects_Var13    ; $7CD7-$7CDB Generic object variable 13
.import Objects_Var14    ; $7CDC-$7CE0 Generic object variable 14

; Player's hammer/fireball
.import PlayerProj_ID    ; $7CE1-$7CE2 Player projectile ID (0 = not in use, 1 = fireball, 2 = hammer, 3+ = Fireball impact "Poof")
.import PlayerProj_Y    ; $7CE3-$7CE4 Player projectile Y
.import PlayerProj_X    ; $7CE5-$7CE6 Player projectile X
.import PlayerProj_YVel    ; $7CE7-$7CE8 Player projectile Y Velocity (NOTE: Integer, not 4.4FP)
.import PlayerProj_XVel    ; $7CE9-$7CEA Player projectile X Velocity (NOTE: Fireball is integer, 4.4FP for hammer ONLY)
.import Fireball_HitChkPass    ; $7CEB-$7CEC Count of times Player's fireball has gone through hit check; when it hits 2, fireball poofs
.import PlayerProj_Cnt    ; $7CED-$7CEE Player projectile counter

.import Temp_VarNP0    ; A temporary not on page 0

.import Lakitu_Active    ; Set while a Lakitu is active; keeps Lakitu "alive" even if off-screen etc.

.import LevelEvent_Cnt    ; General purpose counter used by a couple LevelEvents
.import Vert_Scroll_Off    ; Vertical scroll offset, used for "vibration" effects
.import Level_Vibration    ; While greater than zero, screen vibrates (from impact of heavy fellow)
.import Player_VibeDisable    ; While greater than zero, Player is unable to move (from impact of heavy fellow)
.import Player_TwisterSpin    ; While greater than zero, Player is twirling from sand twister

; NOTE!! This object var is OBJECT SLOT 0 - 4 ONLY!
.import Objects_HitCount    ; $7CF6-$7CFA Somewhat uncommon "HP" used generally for bosses only (e.g. they take so many fireballs)


.import RotatingColor_Cnt    ; When non-zero, causes rainbow palettes in the background; $80 bit is used by Koopaling wand grab

; Some variables used by the recovered magic wand
.import Wand_FrameCnt    ; A counter that overflows to increment Wand_Frame (added to by the wand's SpecialObj_Var1)
.import Wand_Frame    ; Wand frame
.import Wand_BounceFlag    ; Tracks the recovered wand bounce; odd on first bounce

.import Player_DebugNoHitFlag    ; UNUSED: (Old debug routine) When set, disables getting hurt (would be toggled by pressing SELECT; see PRG000 $C91B)

; Map_Completions:
; Stores "rows" of completed levels or other map alterations (e.g. rock break,
; mini-fortress lock removal, etc.) for a given column, from the leftmost.
; Rows 1-7 use decending bits from $80, and row 9 uses bit $01.  This makes row 8
; invalid for hosting a level panel ever!
; --------- TOP OF MAP
; $80
; $40
; $20
; $10
; $08
; $04
; $02
; INVALID
; $01
; --------- BOT OF MAP
.import Map_Completions    ; $7D00-$7D3F (Mario), $7D40-$7D7F (Luigi) Allows a MAX of 4 map screens (64 columns total each player, 16 columns per map screen)

	; Inventory_Items: 
	; 0 = Empty
	; 1 = Mushroom
	; 2 = Flower
	; 3 = Leaf
	; 4 = Frog
	; 5 = Tanooki
	; 6 = Hammer
	; 7 = Judgem's cloud
	; 8 = P-Wing
	; 9 = Star
	; A = Anchor
	; B = Hammer
	; C = Warp Whistle
	; D = Music Box
.import Inventory_Items    ; $7D80-$7D9B Mario, 4 rows of 7 items 
.import Inventory_Cards    ; $7D9C-$7D9E Mario, 3 cards
.import Inventory_Score    ; $7D9F-$7DA1 Mario, 3 byte score
.import Inventory_Coins    ; Mario's coins

.import Inventory_Items2    ; $7DA3-$7DBE Luigi, 4 rows of 7 items 
.import Inventory_Cards2    ; $7DBF-$7DC1 Luigi, 3 cards
.import Inventory_Score2    ; $7DC2-$7DC4 Luigi, 3 byte score
.import Inventory_Coins2    ; Luigi's coins
.import Map_Unused7DC6    ; $7DC6-$7DCA? Indexed by Map_Unused738, value used in dead routine in PRG011 @ $A2AF

.import Map_GameOver_CursorY    ; Game Over popup cursor Y ($60/$68)

.import Map_PrevMoveDir    ; Last SUCCESSFUL (allowed) movement direction on map R01 L02 D04 U08
.import Pal_Data    ; $7DDE-$7DFD Holds an entire bg/sprite palette (this is the MASTER palette, what fades target, and others may source for "original" colors!)

.import Level_AltLayout    ; $7DFE-$7DFF Pointer to level's "alternate" layout (when you go into bonus pipe, etc.)
.import Level_AltObjects    ; $7E00-$7E01 Pointer to level's "alternate" object set (when you go into bonus pipe, etc.)

.import Level_BlockGrabHitMem    ; $7E02-$7E81 Records coins and 1-ups grabbed, so they don't come back if you switch areas

CARD_MUSHROOM	= 0
CARD_FLOWER	= 1
CARD_STAR	= 2
CARD_1UP	= 3
CARD_10COIN	= 4
CARD_20COIN	= 5
CARD_WILD	= 8	; UNUSED Wild card (can match any other!)
.import Card_ActiveSet    ; $7E82-$7E93 Active set of N-Spade game cards

	; Tile_AttrTable:
	; On the world map, it's always the following:
	; [03 67 BF E9] [03 67 BF E9]
	; There's a usage of checking which "quadrant" of tile the Player is standing on ($00, $40, $80, or $C0)
	; and using that as an index (shifted right 6) into the second half of this table
	; TILE_PANEL1		= $03	; Level Panel 1




	; TILE_FORT		= $67	; Mini-Fortress
	; TILE_POOL		= $BF	; Pool / Oasis
	; TILE_WORLD5STAR	= $E9	; Star used on World 5 Sky map
	; The check follows with a "less than", as a quick failure check (if you're in this "range"
	; of tiles, but less than that value, you can't possibly be on an enterable tile)
	; The second half is not used on the world map
	;
	; In levels, both "halves" define the first tile of a quadrant to be solid
	; The first half is solid at the ground (i.e. Player can stand on it)
	; The second half is solid at the head and walls (i.e. Player bumps head on it, typically "full solidity" when combined above)
	; Interestingly, the Sonic the Hedgehog games implemented this same solidity pattern...
.import Tile_AttrTable    ; $7E94-$7E9B

.import Level_UnusedSlopesTS5    ; UNUSED; If set to 2, forces slopes to be enabled for Level_Tileset = 5 (plant infestation)
.import PlantInfest_ACnt_Max    ; Always set to $1A in plant infestation levels, sets max value for animation counter

.import LevelJctBQ_Flag    ; Set to '1' while in a Big Question block area, locks horizontal scrolling
.import Level_JctBackupTileset    ; Level Junction tileset backup
.import Level_AltTileset    ; Level's "alternate" tileset (when you go into bonus pipe, etc.)

	; The "ORIGINAL" series are so you can switch back after going to a level's "alternate"
.import Level_LayPtrOrig_AddrL    ; ORIGINAL Low byte of address to tile layout
.import Level_LayPtrOrig_AddrH    ; ORIGINAL High byte of address to tile layout
.import Level_ObjPtrOrig_AddrL    ; ORIGINAL Low byte of address to object set
.import Level_ObjPtrOrig_AddrH    ; ORIGINAL High byte of address to object set

.import Level_BG_Page1_2    ; Sets which bank the first and second page (2K / 64 8x8 tiles) of BG is using (see Level_BG_Pages1/2)

.import Map_BorderAttrFromTiles    ; $7EBE-$7EC8 (?) Attributes collected from map tiles that get overwritten by border FIXME SIZE UNCERTAIN

.import Map_Unused7EEA    ; Unused; Value retrieved from LUT at initialization of world, but never used otherwise
.import Map_Objects_Y    ; $7EEB-$7EF8, Y coordinate of all map objects
.import Map_Objects_XLo    ; $7EF9-$7F06, X coordinate lo byte of all map objects
.import Map_Objects_XHi    ; $7F07-$7F14, X coordinate hi byte of all map objects

; Map_Objects_IDs: ID of all 8 map objects 
MAPOBJ_EMPTY		= $00	; None
MAPOBJ_HELP		= $01	; HELP
MAPOBJ_AIRSHIP		= $02	; Airship
MAPOBJ_HAMMERBRO	= $03	; Hammer Bro
MAPOBJ_BOOMERANGBRO	= $04	; Boomerang Bro
MAPOBJ_HEAVYBRO		= $05	; Heavy Bro
MAPOBJ_FIREBRO		= $06	; Fire Bro
MAPOBJ_W7PLANT		= $07	; World 7 Plant
MAPOBJ_UNK08		= $08	; Unknown marching glitch object
MAPOBJ_NSPADE		= $09 	; N-Spade
MAPOBJ_WHITETOADHOUSE	= $0A	; White Toad House
MAPOBJ_COINSHIP		= $0B	; Coin Ship
MAPOBJ_UNK0C		= $0C	; Unknown white colorization of $0F (goes to World 7 level??)
MAPOBJ_BATTLESHIP	= $0D	; World 8 Battleship
MAPOBJ_TANK		= $0E	; World 8 Tank
MAPOBJ_W8AIRSHIP	= $0F	; World 8 Airship
MAPOBJ_CANOE		= $10	; Canoe

MAPOBJ_TOTALINIT	= $08	; Total number of map objects initialized per world
MAPOBJ_TOTAL		= $0E	; Total POSSIBLE map objects
.import Map_Objects_IDs    ; $7F15-$7F22

.import Map_SprRAMOffDistr    ; A free running counter on the map only which distributes Sprite_RAM offsets to ensure visibility

	; Map_2PVsGame
	; Sets which "style" of 2P Vs game will be played
	;  0: Spiny Only
	;  1: Fighter Fly Only
	;  2: Spiny and Fighter Fly
	;  3: Static coins
	;  4: Spiny and Sidestepper
	;  5: Fighter Fly and Sidestepper
	;  6: Sidestepper Only
	;  7: Coin Fountain
	;  8: Spiny Only
	;  9: Fighter Fly Only 
	; 10: Sidestepper Only
	; 11: Ladder and [?] blocks
.import Map_2PVsGame

.import Map_Airship_Dest    ; Airship travel destination; 6 X/Y map coordinates defined per world, after that it just sits still
.import THouse_OpenByID    ; $7F2E-$7F3D UNUSED would keep track of chests opened for a given Toad House ID (THouse_ID)
.import StatusBar_PMT    ; $7F3E-$7F45, tiles that currently make up the power meter >>>>>>[P]
.import StatusBar_CoinH    ; Status bar tile for coin MSD
.import StatusBar_CoinL    ; Status bar tile for coin LSD
.import StatusBar_LivesH    ; Status bar tile for lives MSD
.import StatusBar_LivesL    ; Status bar tile for lives LSD
.import StatusBar_Score    ; $7F4A-$7F4F Status bar tiles for score
.import StatusBar_Time    ; $7F50-$7F52 Status bar tiles for time remaining
.import Map_MusicBox_Cnt    ; Number of turns remaining until hammer brothers wake up (>= 1 and they're be asleep on the map)

	; Store arrays defined by level data as starts after an "alternate" level junction event
	; Level_JctXLHStart:
	;	Lower 4 bits: X Hi
	;	Upper 4 bits: X Lo
	; Level_JctYLHStart:
	;	Bits 0 - 3: Go into Level_PipeExitDir
	;	Bits 4 - 6: 0 to 7, selects start position from LevelJct_YLHStarts and sets proper vertical with LevelJct_VertStarts
	;	Bit      7: If set, entering in vertical mode (for "dirty" refresh purposes)
.import Level_JctYLHStart    ; $7F54-$7F63 Array of Y / YHi starts
.import Level_JctXLHStart    ; $7F64-$7F73 Array of X / XHi starts

.import Object_TileFeet2    ; ? Difference against Object_TileFeet?
.import Object_TileWall2    ; ? Difference against Object_TileWall?

.import ObjTile_DetYHi    ; Object tile detect Y Hi
.import ObjTile_DetYLo    ; Object tile detect Y Lo
.import ObjTile_DetXHi    ; Object tile detect X Hi
.import ObjTile_DetXLo    ; Object tile detect X Lo

.import Bubble_Cnt    ; $7F7A-$7F7C Bubble counter value (0 = no bubble)

; NOTE: Object_WatrHit* values are set only once, then WatrHit_IsSetFlag latches
; and they will never update again; seems it is leftover debug code or maybe
; an unused feature (that an object could respond to a splashdown)
.import WatrHit_IsSetFlag    ; Set when Object_WatrHit* values are stored (but never cleared, so only once!)
.import Bubble_YHi    ; $7F7E-$7F80 Water Bubble Y Hi
.import Object_WatrHitYHi    ; Y Hi of object that just hit water
.import Bubble_Y    ; $7F82-$7F84 Water Bubble Y
.import Object_WatrHitY    ; Y of object that just hit water
.import Bubble_XHi    ; $7F86-$7F88 Water Bubble X Hi
.import Object_WatrHitXHi    ; X Hi of object that just hit water
.import Bubble_X    ; $7F8A-$7F8C Water Bubble X
.import Object_WatrHitX    ; X of object that just hit water

.import Splash_Counter    ; $7F8E-$7F90 Water splash counter
.import Splash_Y    ; $7F91-$7F93 Water splash X
.import Splash_X    ; $7F94-$7F96 Water splash Y
.import Splash_NoScrollY    ; $7F97-$7F99 If set, flags this water splash to not display sprite Y as relative to screen scroll

.import BrickBust_En    ; $7F9A-$7F9C Brick bust "Enable" (0 = disable, 2 = brick debris, anything else = "poof" away)
.import BrickBust_YUpr    ; $7F9D-$7F9F Brick bust upper chunks Y
.import BrickBust_X    ; $7FA0-$7FA2 Brick bust base X
.import BrickBust_YVel    ; $7FA3-$7FA5 Brick bust Y velocity
.import BrickBust_XDist    ; $7FA6-$7FA8 Brick bust X split
.import BrickBust_YLwr    ; $7FA9-$7FAB Brick bust lower chunks Y
.import BrickBust_HEn    ; $7FAC-$7FAE Bits to hide chunks (Bit 0 = Right, 1 = Left, 2 = Lower, 3 = Upper) OR poof counter

.import CoinPUp_State    ; $7FB2-$7FB5 State of up to 4 "Power Up" coins (i.e. coins that come out of ? blocks and bricks)
.import CoinPUp_Y    ; $7FB6-$7FB9 Y of "Power Up" coins
.import CoinPUp_X    ; $7FBA-$7FBD X of "Power Up" coins
.import CoinPUp_YVel    ; $7FBE-$7FC1 Y velocity of "Power Up" coins
.import CoinPUp_Counter    ; $7FC2-$7FC5 Counter used by "Power Up" coins

.import SpecialObj_ID    ; $7FC6-$7FCD Special object spawn event IDs

.import Objects_Var3    ; $7FD0-$7FD4 Generic variable 3 for objects SLOT 0 - 4 ONLY

.import SpecialObj_YHi    ; $7FD5-$7FDC Special object Y high coordinate

.import Objects_LastTile    ; $7FDF-$7FE6 Last tile this object detected

.import Objects_SprAttr    ; $7FE7-$7FEE Object sprite attributes (only uses bit 6 for H-Flip and bits 0-1 for palette)
.import Objects_UseShortHTest    ; $7FEF-$7FF6 If set, object will use a short horizontal test to determine if it is off-screen

.import Roulette_Lives			; Number of lives you are rewarded from winning the Roulette (NOTE: Shared with first byte of Objects_IsGiant)
.import Objects_IsGiant    ; $7FF7-$7FFE Set mainly for World 4 "Giant" enemies (but some others, like Bowser, also use it)

.include "ram_prg_vs.inc"
.include "ram_prg_cineking.inc"

.endif ; include guard
