.ifndef __RAM_PRG_VS_INC__
__RAM_PRG_VS_INC__ = 1

.import Vs_MemStart ; Should be at "top"; this point and 512 bytes forward are cleared at start of 2P Vs

; Vs_PlayerFrame
; 0/1: Standing (0) / walking (0/1) / falling-not-jumped (1) frames
; 2: Skidding turnaround
; 3: Jumping/Falling-jumped
; 4: Dizzy
; 5: Kicking
; 6: Dying
; 7: Climbing
.import Vs_PlayerFrame    ; $6800-$6801 Mario/Luigi Frame
.import Vs_PlayerState    ; $6802-$6803 Mario/Luigi State (0=Init, 1=Normal, 2=Dying, 3=Ladder climbing)
.import Vs_ObjectState    ; $6804-$680F Objects State (0=Dead/empty, 1=Normal, 2=Flipped over, 3=Dying)

.import Vs_PlayerBlkHitCnt    ; $6811-$6812 Mario/Luigi Hit block counter value
.import Vs_PlayerY    ; $6813-$6814 Mario/Luigi Y
.import Vs_ObjectsY    ; $6815-$6820 Objects Y

.import Vs_PlayerBlkHitY    ; $6822-$6823 Mario/Luigi Aligned Y position where block was hit
.import Vs_PlayerX    ; $6824-$6825 Mario/Luigi X
.import Vs_ObjectsX    ; $6826-$6831 Objects X

.import Vs_PlayerBlkHitX    ; $6833-$6834 Mario/Luigi Aligned Y position where block was hit
.import Vs_PlayerYVel    ; $6835-$6836 Mario/Luigi Y Velocity
.import Vs_ObjectYVel    ; $6837-$6842 Objects Y Velocity

.import Vs_PlayerBlkHitYVel    ; $6844-$6845 Mario/Luigi Hit block Y velocity
.import Vs_PlayerXVel    ; $6846-$6847 Mario/Luigi X Velocity
.import Vs_ObjectXVel    ; $6848-$6853 Objects X Velocity

.import Vs_PlayerClimbFrame    ; $6857-$6858 incremented as Player climbs
.import Vs_ObjectAnimCnt    ; $6859-$6864 A continuous counter per object for animating (typically 2 frames)

.import Vs_PlayerDir    ; $6866-$6867 Mario/Luigi direction (1=Right, 2=Left)
.import Vs_ObjectDir    ; $6868-$6873 Objects direction (1=Right, 2=Left)

.import Vs_PlayerYVelFrac    ; $6875-$6876 Mario/Luigi Y velocity fractional accumulator
.import Vs_ObjectYVelFrac    ; $6877-$6882

.import Vs_PlayerXVelFrac    ; $6886-$6887 Mario/Luigi X velocity fractional accumulator
.import Vs_ObjectXVelFrac    ; $6888-$6893

.import Vs_PlayerDetStat    ; $6897-$6898 Mario/Luigi detection status
.import Vs_ObjectDetStat    ; $6899-$68A4 Objects detection status

.import Vs_ObjectVar1    ; $68A8-$68B3 General variable 1

.import Vs_PlayerKick    ; $68B5-$68B6 Mario/Luigi Player is kicking until decrements to zero
.import Vs_PlayerDizzy    ; $68B7-$68B8 Mario/Luigi Player "dizzy" face until decrements to zero
.import Vs_PlayerStick    ; $68B9-$68BA Mario/Luigi Mario/Luigi Player "sticking" to ceiling; decrements to zero
.import Vs_PlayerBumpTimer    ; Mario/Luigi Players bumped off eachother (and can't again until zero); decrements to zero
.import Vs_POWBlockCnt    ; POW block counter; decrements to zero; until then, POW shaking!

	; 2P Vs Object IDs
VSOBJID_SPINY		= 0	; Spiny
VSOBJID_SIDESTEPPER	= 2	; Sidestepper
VSOBJID_FIGHTERFLY	= 3	; Fighter Fly
VSOBJID_FIREBALL_HORZ	= 4	; Horizontal Fireball that spawns to keep Players from hiding down at the bottom
VSOBJID_FIREBALL_ENDER	= 5	; Game Ender Fireball (bounces around, attempts to kill Players who've stuck around too long!)
VSOBJID_FIREBALL_FOUNTAIN= 6	; Fountain Fireball
VSOBJID_COIN		= 7	; Coin (from [?] block)
VSOBJID_MUSHROOMCARD	= 8	; Mushroom card
VSOBJID_FLOWERCARD	= 9	; Flower card
VSOBJID_STARCARD	= 10	; Star card
VSOBJID_KICKEDBLOCK	= 11	; Kicked block (from [?] block match)
.import Vs_ObjectId    ; $68BD-$68C8 Objects ID

.import Vs_ObjectSprRAMOff    ; Current object Sprite RAM offset
.import Vs_ObjectSprRAMSel    ; Counter that runs $D to $0 (inclusive) and helps distribute Sprite RAM offsets among the objects
.import Vs_EnemyCount    ; Number of spawned enemies (in the typical game)
.import Vs_PlayerHaltTimer    ; $68CD-$68CE Mario/Luigi timer which halts gameplay; decrements to zero
.import Vs_ObjHaltTimer    ; $68CF-$68DA Object timer which halts object when greater than zero; decrements to zero

.import Vs_ObjectTimer3    ; $68DC-$68E7

.import Vs_PlayerCnt    ; $68E9-$68EA Mario/Luigi "counter" value; decrements to zero
.import Vs_EnemyGetUpTimer    ; $68EB-$68F6 Timer for flipped-over enemy; decrements to zero

.import Vs_PlayerJumped    ; $68F8-$68F9 Set to 1 if Player jumped; prevents Player from jumping again until they hit floor
.import Vs_PlayerTileL    ; $68FA-$68FB Mario/Luigi Tile detected at Player's feet
.import Vs_ObjectTileL    ; $68FC-$6907

.import Vs_PlayerBlkHit    ; $690A-$690B Mario/Luigi Holds Tile_Mem offset to bounce block they hit
.import Vs_PlayerFlashInv    ; $690C-$690D Mario/Luigi Flashing invicibility (?)
.import Vs_SpawnCnt2    ; FIXME describe better
.import Vs_TooLongCnt    ; Increments after each round of spawning; if it overflows, "game ender" fireballs are spawned 
.import Vs_CurIndex    ; Current index (Player or object)
.import Vs_PlayerTileU    ; $6911-$6912 Mario/Luigi Tile detected above Player's feet

.import Vs_ObjectPipeTimer    ; $6920-$692B Timer used for enemies to exit and emerge from pipes; decrements to zero

.import Vs_Random    ; $692D-$692F Random generator for 2P Vs mode
.import Vs_PlayerCoins    ; $6930-$6931 Player's coins (in 2P Vs); 5 wins the match
.import Vs_TimeToExit    ; Decrements to zero then exits the 2P Vs
.import Vs_ObjectIsLast    ; $6933-$693E Set if this is the last object (turns blue, move fast)

.import Vs_POWHits    ; Number of times POW block has been hit (disabled on 3)
.import Vs_PlayerYOff    ; $6941-$6942 Mario/Luigi Y offset applied
.import Vs_UNKGAMECnt    ; Unknown "game" counter; after overflow, we exit
.import Vs_PlayerYHi    ; $6944-$6945 Mario/Luigi Y Hi
.import Vs_ObjectYHi    ; $6946-$6951 Object Y Hi

.import Vs_ObjectIsAngry    ; $6955-$6960 Set when Sidestepper is angry (not used for anything else)

.import Vs_AngrySidesteppers    ; When greater than zero, and spawning a Sidestepper, next one is an "angry" Sidestepper (then decrement)

.import Vs_ObjectVDir    ; $6964-$696F Objects vertical direction (4=Down, 8=Up)

.import Vs_ObjectRestoreXVel    ; $6971-$697C Flipped over object restore X velocity

.import Vs_ObjTimer2    ; $697E-$6989 Object timer; decrements to zero

.import Vs_CardFlash    ; $698B-$698C Mario/Luigi Cycles color for card (when picked up from another Player)
.import Vs_HaltTimerBackup    ; $698D-$699B Backs up all halt timers
.import Vs_EnemySet    ; Specifies an index of active enemy set, selecting one of the quintuples from Vs_5EnemySets
.import Vs_ObjectXOff    ; A one-shot X offset for display of object FIXME: When?
.import Vs_PlayerWalkCnt    ; $699E-$699F Mario/Luigi counts up and overflows to toggle walk frames
.import Vs_PlayerWalkFrame    ; $69A0-$69A1 Mario/Luigi incremented when Vs_PlayerWalkCnt overflows
.import Vs_NextObjectIsLast    ; If there are 5 enemies and this is set, next enemy out is the "last" (turns blue, moves fast)

	; Display of "x Up" after getting 3 cards
.import Vs_xUpCnt    ; $69A3-$69A4 Mario/Luigi "x Up" counter
.import Vs_xUpY    ; $69A5-$69A6 Mario/Luigi "x Up" Y pos
.import Vs_xUpX    ; $69A7-$69A8 Mario/Luigi "x Up" X pos
.import Vs_xUpLives    ; $69A9-$69AA Mario/Luigi "x Up" Lives amount (1, 2, 3, 5)
.import Vs_SpawnCnt    ; Spawn counter; increments and triggers spawning

.endif ; include guard
