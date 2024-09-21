   10 REM *********************************
   20 REM *         miniGraf              *
   30 REM * (for interactive fictions)    *
   40 REM * by Bruno Vignoli, 2023-24 MIT *
   50 REM *********************************
   60 :
   70 MODE 8:VDU 26:COLOUR 140:CLS:VDU 23,1,0:VDU 23,0,&C0,0
   80 minx%=80:maxx%=239:miny%=10:maxy%=129:centx%=160:centy%=65:maxcmd%=2000:paper%=0:pen%=15:xc%=centx%:yc%=centy%:stp%=8:tool$="p":cpt%=0
   90 DIM cmd maxcmd%:DIM x maxcmd%:DIM y maxcmd%:DIM c maxcmd%
  100 oldxc%=xc%:oldyc%=yc%
  110 COLOUR 14:PRINT TAB(15,4);"miniGraf"
  120 PRINT TAB(15,5);STRING$(8,"=")
  130 PRINT TAB(1,8);"a vectorial graphic tool by B.Vignoli"
  140 COLOUR 11:PRINT TAB(0,10);STRING$(40,"=")
  150 COLOUR 9:PRINT TAB(7,20);"Press [RETURN] to start !"
  160 IF GET$<>CHR$(13) THEN GOTO 160
  170 :
  190 REM ********** menu
  200 GOSUB 2150:GOSUB 2000
  210 *FX 19
  220 IF INKEY(-58) THEN GOSUB 7180:yc%=yc%-stp%:IF yc%<miny% THEN yc%=miny%
  230 IF INKEY(-42) THEN GOSUB 7180:yc%=yc%+stp%:IF yc%>maxy% THEN yc%=maxy%
  240 IF INKEY(-26) THEN GOSUB 7180:xc%=xc%-stp%:IF xc%<minx% THEN xc%=minx%
  250 IF INKEY(-122) THEN GOSUB 7180:xc%=xc%+stp%:IF xc%>maxx% THEN xc%=maxx%
  260 IF INKEY(-56) THEN tool$="p":GOSUB 6000:GOSUB 2290:key%=-56:GOSUB 2210
  270 IF INKEY(-87) AND NOT INKEY(-5) THEN tool$="l":GOSUB 6000:GOSUB 2290:key%=-87:GOSUB 2210
  280 IF INKEY(-85) THEN GOSUB 2030:GOSUB 7120:key%=-85:GOSUB 2210
  290 IF INKEY(-94) AND NOT INKEY(-5) AND NOT INKEY(-6) THEN GOSUB 7120:pen%=(pen%+1) MOD 64:GOSUB 2000:GOSUB 7120
  300 IF INKEY(-24) AND NOT INKEY(-5) AND NOT INKEY(-6) THEN GOSUB 7120:pen%=(pen%-1):GOSUB 2230:GOSUB 2000:GOSUB 7120
  310 IF INKEY(-94) AND NOT INKEY(-5) AND INKEY(-6) THEN GOSUB 7120:paper%=(paper%+1) MOD 64:GOSUB 2370:GOSUB 2290:GOSUB 7030:GOSUB 7120
  320 IF INKEY(-24) AND NOT INKEY(-5) AND INKEY(-6) THEN GOSUB 7120:paper%=(paper%-1):GOSUB 2260:GOSUB 2370:GOSUB 2290:GOSUB 7030:GOSUB 7120
  330 IF INKEY(-94) AND INKEY(-5) AND NOT INKEY(-6) THEN GOSUB 7120:stp%=stp%*2:GOSUB 2320:GOSUB 7120
  340 IF INKEY(-24) AND INKEY(-5) AND NOT INKEY(-6) THEN GOSUB 7120:stp%=stp%/2:GOSUB 2320:GOSUB 7120
  350 IF INKEY(-82) AND INKEY(-5) THEN GOSUB 3000:key%=-82:GOSUB 2210
  360 IF INKEY(-87) AND INKEY(-5) THEN GOSUB 4000:key%=-87:GOSUB 2210
  370 IF INKEY(-35) AND INKEY(-5) THEN GOSUB 5000:key%=-35:GOSUB 2210
  380 IF INKEY(-102) THEN tool$="m":GOSUB 6000:GOSUB 2290:key%=-102:GOSUB 2210
  390 IF INKEY(-68) THEN tool$="f":GOSUB 6000:GOSUB 2290:key%=-68:GOSUB 2210
  410 IF INKEY(-54) THEN GOSUB 7000:GOSUB 2120:PRINT TAB(0,17);"Undone":GOSUB 7120
  420 IF INKEY(-90) THEN cpt%=0:GOSUB 2370:GOSUB 7030:key%=-90:GOSUB 2210:oldxc%=centx%:oldyc%=centy%:PLOT 4,oldxc%,oldyc%
  430 IF INKEY(-30) THEN VDU 23,1,1:VDU 23,0,&C0,1:MODE 1:CLS:PRINT"Done!":GOSUB 7120:END
  440 IF INKEY(-36) THEN tool$="t":GOSUB 6000:GOSUB 2290:key%=-36:GOSUB 2210
  450 IF INKEY(-52) THEN tool$="r":GOSUB 6000:GOSUB 2290:key%=-52:GOSUB 2210
  460 IF INKEY(-51) THEN tool$="d":GOSUB 6000:GOSUB 2290:key%=-51:GOSUB 2210
  470 GOSUB 7150
  480 GOTO 210
 2000 REM ********** change pen
 2010 GCOL 0,pen%:COLOUR 15:GOSUB 2120:GOSUB 2290
 2020 RETURN
 2030 REM ********** help
 2040 GOSUB 2120:COLOUR 11:PRINT TAB(0,17);"HELP:"
 2050 rt%=18:RESTORE 8000
 2060 READ a$
 2065 IF a$="STP" THEN GOTO 2090
 2070 IF a$="RET" THEN rt%=rt%+1:PRINT TAB(0,rt%);:GOTO 2060
 2075 IF a$="C11" THEN COLOUR 11:GOTO 2060
 2080 IF a$="C14" THEN COLOUR 14:GOTO 2060
 2085 PRINT a$;:GOTO 2060
 2090 COLOUR 15
 2100 RETURN
 2120 REM ********** clear text area
 2130 FOR i%=17 TO 28:PRINT TAB(0,i%);STRING$(40," ");:NEXT i%
 2140 RETURN
 2150 REM ********** clear all
 2160 COLOUR 128:CLS:?(cmd+0)=ASC("c"):?(c+0)=paper%:?(x+0)=centx%:?(y+0)=centy%
 2170 GCOL 0,15:PLOT 4,minx%-1,miny%-1:PLOT 5,maxx%+1,miny%-1
 2180 PLOT 5,maxx%+1,maxy%+1:PLOT 5,minx%-1,maxy%+1:PLOT 5,minx%-1,miny%-1
 2185 GCOL 0,paper%:PLOT 4,minx%,miny%:PLOT 101,maxx%,maxy%
 2190 RETURN
 2200 REM ********** wait key released
 2210 REPEAT:UNTIL NOT INKEY(key%)
 2220 RETURN
 2230 REM ********** limit pen
 2240 IF pen%<0 THEN pen%=pen%+64
 2250 RETURN
 2260 REM ********** limit paper
 2270 IF paper%<0 THEN paper%=paper%+64
 2280 RETURN
 2290 REM ********** show infos
 2300 GOSUB 2120:GOSUB 7330
 2302 PRINT TAB(0,19);STR$(cpt%);" dots - Pen:";STR$(pen%)+" - Paper:";STR$(paper%);" - Steps:"+STR$(stp%):PRINT TAB(0,21);"[h] for Help"
 2305 GCOL 0,pen%:PLOT 4,20,45:PLOT 101,60,85
 2310 RETURN
 2320 REM ********** limit steps
 2330 IF stp%>32 THEN stp%=32
 2340 IF stp%<1 THEN stp%=1
 2350 GOSUB 2290
 2360 RETURN
 2370 REM clear drawing area
 2380 GCOL 0,paper%:PLOT 4,minx%,miny%:PLOT 101,maxx%,maxy%:?(cmd+0)=ASC("c"):?(c+0)=paper%:?(x+0)=centx%:?(y+0)=centy%
 2390 RETURN
 3000 REM ********** save data
 3010 GOSUB 2120:PRINT TAB(0,17);:INPUT"Save filename (no ext):",f$
 3020 IF f$="" THEN GOSUB 2120:RETURN
 3030 f$=f$+".mng"
 3040 file=OPENOUT f$
 3050 PRINT#file,cpt%:FOR i%=0 TO cpt%
 3060 PRINT#file,?(cmd+i%),?(c+i%),?(x+i%),?(y+i%)
 3070 NEXT i%
 3080 CLOSE#file
 3090 GOSUB 2120:PRINT TAB(0,17);"File saved !"
 3100 RETURN 
 4000 REM ********** load data
 4010 GOSUB 2120:PRINT TAB(0,17);:INPUT"Load filename (no ext):",f$
 4020 IF f$="" THEN GOSUB 2120:RETURN
 4030 f$=f$+".mng"
 4040 file=OPENIN f$
 4050 IF file=0 THEN PRINT "File missing !": CLOSE#file:RETURN
 4060 INPUT#file,cpt%
 4070 FOR i%=0 TO cpt%
 4080 INPUT#file,?(cmd+i%),?(c+i%),?(x+i%),?(y+i%)
 4090 NEXT i%:paper%=?(c+0):GOSUB 7030
 4100 CLOSE#file
 4110 GOSUB 2120:PRINT TAB(0,17);"File loaded !"
 4120 RETURN
 5000 REM ********** export BASIC
 5010 GOSUB 2120:PRINT TAB(0,17);:INPUT"Export BASIC filename (no ext):",f$
 5020 IF f$="" THEN GOSUB 2120:RETURN
 5030 f$=f$+".bas"
 5040 INPUT"Start line number:",ln%:INPUT"Line's step:",st%
 5050 INPUT"Origin x:",xo%:INPUT"Origin y:",yo%
 5060 file=OPENOUT f$
 5070 FOR i%=0 TO cpt%
 5080 a$=STR$(ln%):ln%=ln%+st%:GOSUB 5210:a$=a$+" "
 5090 IF ?(cmd+i%)=ASC("c") THEN a$=a$+"GCOL 0,"+STR$(?(c+i%))+":PLOT 4,"+STR$(xo%)+","+STR$(yo%)+":PLOT 101,"+STR$(xo%+maxx%-minx%)+","+STR$(yo%+maxy%-miny%)
 5100 IF ?(cmd+i%)=ASC("m") THEN a$=a$+"GCOL 0,"+STR$(?(c+i%))+":":a$=a$+"PLOT 4,"+STR$(?(x+i%)-minx%+xo%)+","+STR$(?(y+i%)-miny%+yo%)
 5110 IF ?(cmd+i%)=ASC("p") THEN a$=a$+"GCOL 0,"+STR$(?(c+i%))+":":a$=a$+"PLOT 69,"+STR$(?(x+i%)-minx%+xo%)+","+STR$(?(y+i%)-miny%+yo%)
 5120 IF ?(cmd+i%)=ASC("l") THEN a$=a$+"GCOL 0,"+STR$(?(c+i%))+":":a$=a$+"PLOT 4,"+STR$(?(x+i%-1)-minx%+xo%)+","+STR$(?(y+i%-1)-miny%+yo%):a$=a$+":PLOT 5,"+STR$(?(x+i%)-minx%+xo%)+","+STR$(?(y+i%)-miny%+yo%)
 5130 IF ?(cmd+i%)=ASC("f") THEN a$=a$+"GCOL 0,"+STR$(?(c+i%))+":":a$=a$+"PLOT 128,"+STR$(?(x+i%)-minx%+xo%)+","+STR$(?(y+i%)-miny%+yo%)
 5140 IF ?(cmd+i%)=ASC("t") THEN a$=a$+"GCOL 0,"+STR$(?(c+i%))+":":a$=a$+"PLOT 4,"+STR$(?(x+i%-2)-minx%+xo%)+","+STR$(?(y+i%-2)-miny%+yo%)
 5145 IF ?(cmd+i%)=ASC("t") THEN a$=a$+":PLOT 4,"+STR$(?(x+i%-1)-minx%+xo%)+","+STR$(?(y+i%-1)-miny%+yo%):a$=a$+":PLOT 85,"+STR$(?(x+i%)-minx%+xo%)+","+STR$(?(y+i%)-miny%+yo%)
 5150 IF ?(cmd+i%)=ASC("r") THEN a$=a$+"GCOL 0,"+STR$(?(c+i%))+":":a$=a$+"PLOT 4,"+STR$(?(x+i%-1)-minx%+xo%)+","+STR$(?(y+i%-1)-miny%+yo%):a$=a$+":PLOT 101,"+STR$(?(x+i%)-minx%+xo%)+","+STR$(?(y+i%)-miny%+yo%)
 5155 IF ?(cmd+i%)=ASC("d") THEN a$=a$+"GCOL 0,"+STR$(?(c+i%))+":":a$=a$+"PLOT 4,"+STR$(?(x+i%-1)-minx%+xo%)+","+STR$(?(y+i%-1)-miny%+yo%):a$=a$+":PLOT 157,"+STR$(?(x+i%)-minx%+xo%)+","+STR$(?(y+i%)-miny%+yo%)
 5160 FOR j%=1 TO LEN(a$):BPUT#file,ASC(MID$(a$,j%,1)):NEXT j%:BPUT#file,13:BPUT#file,10
 5170 NEXT i%
 5180 CLOSE#file
 5190 GOSUB 2120:PRINT TAB(0,17);"File exported !"
 5200 RETURN
 5210 REPEAT
 5220 IF LEN(a$)<5 THEN a$ =" "+a$
 5230 UNTIL LEN(a$)=5
 5240 RETURN
 6000 REM ********** drawing
 6010 IF cpt%=maxcmd% THEN VDU 7:RETURN
 6020 cpt%=cpt%+1:VDU 24,minx%;maxy%;maxx%;miny%;
 6030 IF tool$="m" THEN GCOL 0,pen%:PLOT 4,xc%,yc%
 6040 IF tool$="p" THEN GCOL 0,pen%:PLOT 69,xc%,yc%
 6050 IF tool$="l" THEN GCOL 0,pen%:PLOT 4,oldxc%,oldyc%:PLOT 5,xc%,yc%
 6060 IF tool$="f" THEN GCOL 0,pen%:PLOT 128,xc%,yc%
 6070 IF tool$="t" AND cpt%>2 THEN GCOL 0,pen%:PLOT 4,?(x+cpt%-2),?(y+cpt%-2):PLOT 4,?(x+cpt%-1),?(y+cpt%-1):PLOT 85,xc%,yc%
 6080 IF tool$="r" AND cpt%>1 THEN GCOL 0,pen%:PLOT 4,oldxc%,oldyc%:PLOT 101,xc%,yc%
 6085 IF tool$="d" AND cpt%>1 THEN GCOL 0,pen%:PLOT 4,oldxc%,oldyc%:PLOT 157,xc%,yc%
 6090 IF tool$="t" AND cpt%<=2 THEN cpt%=cpt%-1:VDU 7:RETURN
 6100 IF tool$="r" AND cpt%<=1 THEN cpt%=cpt%-1:VDU 7:RETURN
 6105 IF tool$="d" AND cpt%<=1 THEN cpt%=cpt%-1:VDU 7:RETURN
 6110 oldxc%=xc%:oldyc%=yc%
 6120 ?(cmd+cpt%)=ASC(tool$):?(x+cpt%)=xc%:?(y+cpt%)=yc%:?(c+cpt%)=pen%
 6130 VDU 26:RETURN
 7000 REM ********** undo
 7010 IF cpt%>0 THEN cpt%=cpt%-1
 7011 IF cpt%=0 THEN GOSUB 2150:oldxc%=centx%:oldyc%=centy%
 7012 IF cpt%>0 THEN oldxc%=?(x+cpt%):oldyc%=?(y+cpt%)
 7020 GOSUB 7030:RETURN
 7030 REM ********** redraw image
 7040 VDU 24,minx%;maxy%;maxx%;miny%;
 7045 FOR i%=0 TO cpt%
 7050 IF ?(cmd+i%)=ASC("c") THEN GCOL 0,?(c+i%):PLOT 4,minx%,miny%:PLOT 101,maxx%,maxy%
 7060 IF ?(cmd+i%)=ASC("m") THEN GCOL 0,?(c+i%):PLOT 4,?(x+i%),?(y+i%)
 7070 IF ?(cmd+i%)=ASC("p") THEN GCOL 0,?(c+i%):PLOT 69,?(x+i%),?(y+i%)
 7080 IF ?(cmd+i%)=ASC("l") THEN GOSUB 7210
 7084 IF ?(cmd+i%)=ASC("t") THEN GOSUB 7240
 7086 IF ?(cmd+i%)=ASC("r") THEN GOSUB 7270
 7088 IF ?(cmd+i%)=ASC("d") THEN GOSUB 7300
 7090 IF ?(cmd+i%)=ASC("f") THEN GCOL 0,?(c+i%):PLOT 128,?(x+i%),?(y+i%)
 7100 NEXT i%:GOSUB 2000:VDU 26
 7110 RETURN
 7120 REM ********** wait a short time
 7130 FOR t%=1 TO 1000:NEXT t%
 7140 RETURN
 7150 REM ********** show pixel pen
 7160 memc%=POINT(xc%,yc%):FOR i%=1 TO 63:GCOL 0,i%:PLOT 69,xc%,yc%:NEXT i%:GCOL 0,memc%:PLOT 69,xc%,yc%
 7170 RETURN
 7180 REM ********** wait a long time showing pixel pen
 7190 FOR j%=1 TO 3:GOSUB 7150:NEXT j%
 7200 RETURN
 7210 REM ********** draw a line
 7220 GCOL 0,?(c+i%):PLOT 4,?(x+i%-1),?(y+i%-1):PLOT 5,?(x+i%),?(y+i%)
 7230 RETURN
 7240 REM ********** draw a triangle
 7250 GCOL 0,?(c+i%):PLOT 4,?(x+i%-2),?(y+i%-2):PLOT 4,?(x+i%-1),?(y+i%-1):PLOT 85,?(x+i%),?(y+i%)
 7260 RETURN
 7270 REM ********** draw a rectangle
 7280 GCOL 0,?(c+i%):PLOT 4,?(x+i%-1),?(y+i%-1):PLOT 101,?(x+i%),?(y+i%)
 7290 RETURN
 7300 REM ********** draw a disc
 7310 GCOL 0,?(c+i%):PLOT 4,?(x+i%-1),?(y+i%-1):PLOT 157,?(x+i%),?(y+i%)
 7320 RETURN
 7330 REM ********** show tool info
 7340 IF tool$="m" THEN PRINT TAB(0,17);"Move Tool"
 7350 IF tool$="p" THEN PRINT TAB(0,17);"Plot Tool"
 7360 IF tool$="l" THEN PRINT TAB(0,17);"Line Tool"
 7370 IF tool$="t" THEN PRINT TAB(0,17);"Triangle Tool"
 7380 IF tool$="r" THEN PRINT TAB(0,17);"Rectangle Tool"
 7390 IF tool$="f" THEN PRINT TAB(0,17);"Fill Tool"
 7400 IF tool$="d" THEN PRINT TAB(0,17);"Disc Tool"
 7410 RETURN
 8000 REM ********** data's
 8010 DATA "RET","C11","[Arrows]","C14"," to position the cursor"
 8020 DATA "RET","C11","[m]","C14","ove ","C11","[p]","C14","lot ","C11","[l]","C14","ine"
 8030 DATA "RET","C11","[d]","C14","isc ","C11","[t]","C14","riangle ","C11","[r]","C14","ectangle"
 8040 DATA "RET","C11","[+/-]","C14"," to set pen ","C11","[Alt +/-]","C14"," to set paper"
 8050 DATA "RET","C11","[CTRL+S]","C14","ave image ","C11","[CTRL+L]","C14","oad an image "
 8060 DATA "RET","C11","[CTRL+E]","C14","xport ","C11","[u]","C14","ndo"
 8070 DATA "RET","C11","[CTRL +/-]","C14"," set cursor speed"
 8080 DATA "RET","C11","[DEL]","C14"," clear image","C11","[F12]","C14"," quit",
 8090 DATA "STP"
