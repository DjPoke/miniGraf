   10 REM ******************************
   20 REM *         miniGraf           *
   30 REM * (for interactive fictions) *
   40 REM * by Bruno Vignoli, 2023 MIT *
   50 REM ******************************
   60 :
   70 MODE 8:VDU 26:COLOUR 140:CLS:VDU 23,1,0:VDU 23,0,&C0,0
   80 minx%=80:maxx%=239:miny%=10:maxy%=129:maxcmd%=2000:paper%=0:pen%=15:xc%=160:yc%=65:stp%=1:tool$="p":cpt%=0
   90 DIM cmd maxcmd%:DIM x maxcmd%:DIM y maxcmd%:DIM c maxcmd%
  100 oldtool$="":oldxc%=0:oldyc%=0
  110 COLOUR 14:PRINT TAB(15,4);"miniGraf"
  120 PRINT TAB(15,5);STRING$(8,"=")
  130 PRINT TAB(5,8);"a graphic tool by B. Vignoli"
  140 COLOUR 11:PRINT TAB(0,10);STRING$(40,"=")
  150 COLOUR 9:PRINT TAB(7,20);"Press [RETURN] to start !"
  160 IF GET$<>CHR$(13) THEN GOTO 160
  170 :
  180 :
  190 REM ********** menu
  200 GOSUB 2150:GOSUB 2000
  210 *FX 19
  220 IF INKEY(-58) THEN yc%=yc%-stp%:IF yc%<miny% THEN yc%=miny%
  230 IF INKEY(-42) THEN yc%=yc%+stp%:IF yc%>maxy% THEN yc%=maxy%
  240 IF INKEY(-26) THEN xc%=xc%-stp%:IF xc%<minx% THEN xc%=minx%
  250 IF INKEY(-122) THEN xc%=xc%+stp%:IF xc%>maxx% THEN xc%=maxx%
  260 IF INKEY(-56) THEN tool$="p":GOSUB 2120:PRINT TAB(0,17);"Plot tool":GOSUB 7150
  270 IF INKEY(-51) THEN tool$="d":GOSUB 2120:PRINT TAB(0,17);"Draw tool":GOSUB 7150
  280 IF INKEY(-85) THEN GOSUB 2030:GOSUB 7120:GOSUB 7150
  290 IF INKEY(-94) AND NOT INKEY(-5) AND NOT INKEY(-6) THEN GOSUB 7120:pen%=(pen%+1) MOD 64:GOSUB 2000:GOSUB 7120
  300 IF INKEY(-24) AND NOT INKEY(-5) AND NOT INKEY(-6) THEN GOSUB 7120:pen%=(pen%-1):GOSUB 2230:GOSUB 2000:GOSUB 7120
  310 IF INKEY(-94) AND NOT INKEY(-5) AND INKEY(-6) THEN GOSUB 7120:paper%=(paper%+1) MOD 64:GOSUB 2370:GOSUB 2290:GOSUB 7120
  320 IF INKEY(-24) AND NOT INKEY(-5) AND INKEY(-6) THEN GOSUB 7120:paper%=(paper%-1):GOSUB 2260:GOSUB 2370:GOSUB 2290:GOSUB 7120
  330 IF INKEY(-94) AND INKEY(-5) AND NOT INKEY(-6) THEN GOSUB 7120:stp%=stp%*2:GOSUB 2320:GOSUB 7120
  340 IF INKEY(-24) AND INKEY(-5) AND NOT INKEY(-6) THEN GOSUB 7120:stp%=stp%/2:GOSUB 2320:GOSUB 7120
  350 IF INKEY(-82) AND INKEY(-4) THEN GOSUB 3000:GOSUB 7150
  360 IF INKEY(-87) AND INKEY(-4) THEN GOSUB 4000:GOSUB 7150
  370 IF INKEY(-35) AND INKEY(-4) THEN GOSUB 5000:GOSUB 7150
  380 IF INKEY(-102) THEN tool$="m":GOSUB 2120:PRINT TAB(0,17);"Move tool":GOSUB 7150
  390 IF INKEY(-68) THEN tool$="f":GOSUB 2120:PRINT TAB(0,17);"Fill tool":GOSUB 7150
  400 IF INKEY(-99) AND NOT INKEY(-58) AND NOT INKEY(-42) AND NOT INKEY(-26) AND NOT INKEY(-122) THEN GOSUB 6000:GOSUB 2290:key%=-99:GOSUB 2210
  410 IF INKEY(-54) THEN GOSUB 7000:GOSUB 2120:PRINT TAB(0,17);"Undone":GOSUB 7150
  420 IF INKEY(-90) THEN cpt%=0:GOSUB 2370:GOSUB 7030:GOSUB 7150
  430 IF INKEY(-30) THEN VDU 23,1,1:VDU 23,0,&C0,1:MODE 1:CLS:PRINT"Done!":GOSUB 7150:END
  440 memc%=POINT(xc%,yc%):FOR i%=1 TO 63:GCOL 0,i%:PLOT 69,xc%,yc%:NEXT i%:GCOL 0,memc%:PLOT 69,xc%,yc%
  450 GOTO 210
 2000 REM ********** change pen
 2010 GCOL 0,pen%:COLOUR 15:GOSUB 2120:GOSUB 2290
 2020 RETURN
 2030 REM ********** help
 2040 GOSUB 2120:COLOUR 11:PRINT TAB(0,17);"HELP:"
 2050 COLOUR 11:PRINT TAB(0,19);"             move,     plot":COLOUR 14:PRINT TAB(0,19);"[Arrow keys]":PRINT TAB(19,19);"[p]":
 2060 COLOUR 11:PRINT TAB(0,20);"    draw line,       change pen":COLOUR 14:PRINT TAB(0,20);"[d]":PRINT TAB(15,20);"[+/-]":
 2070 COLOUR 11:PRINT TAB(0,21);"           change paper,     move":COLOUR 14:PRINT TAB(0,21);"[alt][+/-]":PRINT TAB(25,21);"[m]":
 2080 COLOUR 11:PRINT TAB(0,22);"    save,     load,     export BASIC":COLOUR 14:PRINT TAB(0,22);"[S]":PRINT TAB(10,22);"[L]":PRINT TAB(20,22);"[E]"
 2090 COLOUR 11:PRINT TAB(0,23);"               inc/dec cursor speed":COLOUR 14:PRINT TAB(0,23);"[control][+/-]"
 2100 COLOUR 11:PRINT TAB(0,24);"    fill,         to draw,     help":COLOUR 14:PRINT TAB(0,24);"[f]":PRINT TAB(10,24);"[space]":PRINT TAB(27,24);"[h]"
 2105 COLOUR 11:PRINT TAB(0,25);"    undo,       new,       quit":COLOUR 14:PRINT TAB(0,25);"[u]":PRINT TAB(10,25);"[del]":PRINT TAB(21,25);"[f12]"
 2110 COLOUR 15:RETURN
 2120 REM ********** clear text area
 2130 FOR i%=17 TO 25:PRINT TAB(0,i%);STRING$(40," ");:NEXT i%
 2140 RETURN
 2150 REM ********** clear all
 2160 COLOUR 128+paper%:CLS:?(cmd+0)=ASC("c"):?(c+0)=paper%
 2170 GCOL 0,15:PLOT 4,minx%-1,miny%-1:PLOT 5,maxx%+1,miny%-1
 2180 PLOT 5,maxx%+1,maxy%+1:PLOT 5,minx%-1,maxy%+1:PLOT 5,minx%-1,miny%-1
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
 2300 GOSUB 2120:PRINT TAB(0,17);STR$(cpt%);" dots - Pen:";STR$(pen%)+" - Paper:";STR$(paper%);" - Steps:"+STR$(stp%):PRINT TAB(0,19);"[h] for Help"
 2305 GCOL 0,pen%:PLOT 4,20,45:PLOT 101,60,85
 2310 RETURN
 2320 REM ********** limit steps
 2330 IF stp%>8 THEN stp%=8
 2340 IF stp%<1 THEN stp%=1
 2350 GOSUB 2290
 2360 RETURN
 2370 REM clear drawing area
 2380 GCOL 0,paper%:PLOT 4,minx%,miny%:PLOT 101,maxx%,maxy%:?(cmd+0)=ASC("c"):?(c+0)=paper%
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
 4050 IF file=0 THEN PRINT "No data !": CLOSE#file:RETURN
 4060 INPUT#file,cpt%
 4070 FOR i%=0 TO cpt%
 4080 INPUT#file,?(cmd+i%),?(c+i%),?(x+i%),?(y+i%)
 4090 NEXT i%:GOSUB 7030
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
 5080 a$=STR$(ln%):ln%=ln%+st%:GOSUB 5190:a$=a$+" "
 5090 IF ?(cmd+i%)=ASC("c") THEN a$=a$+"COLOUR 128+"+STR$(?(c+i%))
 5100 IF ?(cmd+i%)=ASC("m") THEN a$=a$+"GCOL 0,"+STR$(?(c+i%))+":":a$=a$+"PLOT 4,"+STR$(?(x+i%)-80+xo%)+","+STR$(?(y+i%)-10+yo%)
 5110 IF ?(cmd+i%)=ASC("p") THEN a$=a$+"GCOL 0,"+STR$(?(c+i%))+":":a$=a$+"PLOT 69,"+STR$(?(x+i%)-80+xo%)+","+STR$(?(y+i%)-10+yo%)
 5120 IF ?(cmd+i%)=ASC("d") THEN a$=a$+"GCOL 0,"+STR$(?(c+i%))+":":a$=a$+"PLOT 4,"+STR$(?(x+i%-1)-80+xo%)+","+STR$(?(y+i%-1)-10+yo%):a$=a$+":PLOT 5,"+STR$(?(x+i%)-80+xo%)+","+STR$(?(y+i%)-10+yo%)
 5130 IF ?(cmd+i%)=ASC("f") THEN a$=a$+"GCOL 0,"+STR$(?(c+i%))+":":a$=a$+"PLOT 128,"+STR$(?(x+i%)-80+xo%)+","+STR$(?(y+i%)-10+yo%)
 5140 FOR j%=1 TO LEN(a$):BPUT#file,ASC(MID$(a$,j%,1)):NEXT j%:BPUT#file,13:BPUT#file,10
 5150 NEXT i%
 5160 CLOSE#file
 5170 GOSUB 2120:PRINT TAB(0,17);"File exported !"
 5180 RETURN
 5190 REPEAT
 5200 IF LEN(a$)<5 THEN a$ =" "+a$
 5210 UNTIL LEN(a$)=5
 5220 RETURN
 6000 REM ********** draw action
 6010 IF cpt%=0 THEN GOSUB 6080:GOTO 6030:RETURN
 6015 IF cpt%<maxcmd% AND (oldtool$<>tool$ OR xc%<>?(x+cpt%-1) OR yc%<>?(y+cpt%-1)) THEN GOSUB 6080:GOTO 6030:RETURN
 6020 IF cpt%=maxcmd% THEN VDU 7:RETURN
 6030 IF tool$="m" THEN GCOL 0,pen%:PLOT 4,xc%,yc%
 6040 IF tool$="p" THEN GCOL 0,pen%:PLOT 69,xc%,yc%
 6050 IF tool$="d" THEN GCOL 0,pen%:PLOT 4,oldxc%,oldyc%:PLOT 5,xc%,yc%
 6060 IF tool$="f" THEN GCOL 0,pen%:PLOT 128,xc%,yc%
 6070 oldxc%=xc%:oldyc%=yc%:RETURN
 6080 cpt%=cpt%+1:?(cmd+cpt%)=ASC(tool$):?(x+cpt%)=xc%:?(y+cpt%)=yc%:?(c+cpt%)=pen%
 6090 oldtool$=tool$:RETURN
 7000 REM ********** undo
 7010 IF cpt%>0 THEN cpt%=cpt%-1:GOSUB 2150:GOSUB 7030:RETURN
 7020 RETURN
 7030 REM ********** redraw image
 7040 FOR i%=0 TO cpt%
 7050 IF ?(cmd+i%)=ASC("c") THEN GCOL 0,128+?(c+i%)
 7060 IF ?(cmd+i%)=ASC("m") THEN GCOL 0,?(c+i%):PLOT 4,?(x+i%),?(y+i%)
 7070 IF ?(cmd+i%)=ASC("p") THEN GCOL 0,?(c+i%):PLOT 69,?(x+i%),?(y+i%)
 7080 IF ?(cmd+i%)=ASC("d") THEN PLOT 4,?(x+i%-1),?(y+i%-1):GCOL 0,?(c+i%):PLOT 5,?(x+i%),?(y+i%)
 7090 IF ?(cmd+i%)=ASC("f") THEN GCOL 0,?(c+i%):PLOT 128,?(x+i%),?(y+i%)
 7100 NEXT i%:GOSUB 2000
 7110 RETURN
 7120 REM ********** wait a short time
 7130 FOR i%=1 TO 800:NEXT i%
 7140 RETURN
 7150 REM ********** wait key
 7160 a$=GET$
 7170 RETURN
