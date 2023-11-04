;
; flood fill
;

.ASSUME ADL=0
.ORG $FC00
	
	JP fill
	
; MOS header
.ALIGN 64
.DB "MOS",0,0

	include "mos_api.inc"

; flood fill function
fill:
	LD IX,xc
	LD E,(IX+0)
	LD D,(IX+1)
	
	LD IY,yc
	LD L,(IY+0)
	LD H,(IY+1)

	LD IX,target_col
	LD C,(IX+0)

fill_loop:
	PUSH DE
	PUSH HL

	CALL get_pixel
	CP C
	RET NZ ; exit if already painted
	
	; paint pixel
	CALL put_pixel

	; flood fill x-1,y
	DEC DE
	CALL fill_loop
	
	; flood fill x+1,y
	INC DE
	INC DE
	CALL fill_loop
	
	; flood fill x,y-1
	DEC DE
	DEC HL
	CALL fill_loop
	
	; flood fill x,y+1
	INC HL
	INC HL
	CALL fill_loop
		
	POP HL
	POP DE
	RET

put_pixel:
	PUSH AF

	LD A,18
	RST.LIL $10
	LD A,0
	RST.LIL $10
	LD A,(col)
	RST.LIS $10
	
	LD A,25
	RST.LIL $10
	LD A,69
	RST.LIL $10
	LD E,A
	RST.LIL $10
	LD D,A
	RST.LIL $10
	LD L,A
	RST.LIL $10
	LD H,A
	RST.LIL $10
	
	POP AF
	RET

get_pixel:
	moscall mos_sysvars
	RES.LIL 2,(IX+sysvar_vpd_pflags)
	
	LD A,23
	RST.LIL $10
	LD A,0
	RST.LIL $10
	LD A,vdp_scrpixel
	RST.LIL $10
	LD E,A ; x
	RST.LIL $10
	LD D,A
	RST.LIL $10
	LD L,A ; y
	RST.LIL $10
	LD H,A
	RST.LIL $10

gp_loop:
	BIT.LIL 2,(IX+sysvar_vpd_pflags)
	JR Z,gp_loop

	LD.LIL	A,(IX+sysvar_scrpixelIndex)
	RET

xc:	DW 0
yc:	DW 0
target_col: DB 0
col: DB 15
