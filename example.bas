   10 REM **********************************
   20 REM * vectorial image loader example *
   30 REM * by Bruno Vignoli, 2023-24 MIT  *
   40 REM **********************************
   50 :
   60 MODE 8:VDU 26:COLOUR 128:CLS:VDU 23,1,0:VDU 23,0,&C0,0
   80 minx%=80:maxx%=239:miny%=10:maxy%=129:centx%=160:centy%=65:maxcmd%=2000:paper%=0:pen%=15:xc%=centx%:yc%=centy%:stp%=8:tool$="p":cpt%=0
   90 DIM cmd maxcmd%:DIM x maxcmd%:DIM y maxcmd%:DIM c maxcmd%
  100 oldxc%=xc%:oldyc%=yc%
  170 :
  180 f$="test.mng":GOSUB 10250
  190 IF GET$<>CHR$(13) THEN GOTO 190
  200 END
  210 :
10000 REM ********** draw an image
10010 GOSUB 10350:VDU 24,minx%;maxy%;maxx%;miny%;
10020 FOR i%=0 TO cpt%
10030 IF ?(cmd+i%)=ASC("c") THEN GCOL 0,?(c+i%):PLOT 4,minx%,miny%:PLOT 101,maxx%,maxy%
10040 IF ?(cmd+i%)=ASC("m") THEN GCOL 0,?(c+i%):PLOT 4,?(x+i%),?(y+i%)
10050 IF ?(cmd+i%)=ASC("p") THEN GCOL 0,?(c+i%):PLOT 69,?(x+i%),?(y+i%)
10060 IF ?(cmd+i%)=ASC("l") THEN GOSUB 10130
10070 IF ?(cmd+i%)=ASC("t") THEN GOSUB 10160
10080 IF ?(cmd+i%)=ASC("r") THEN GOSUB 10190
10090 IF ?(cmd+i%)=ASC("d") THEN GOSUB 10220
10100 IF ?(cmd+i%)=ASC("f") THEN GCOL 0,?(c+i%):PLOT 128,?(x+i%),?(y+i%)
10110 NEXT i%:GCOL 0,pen%:VDU 26
10120 RETURN
10130 REM ********** draw a line
10140 GCOL 0,?(c+i%):PLOT 4,?(x+i%-1),?(y+i%-1):PLOT 5,?(x+i%),?(y+i%)
10150 RETURN
10160 REM ********** draw a triangle
10170 GCOL 0,?(c+i%):PLOT 4,?(x+i%-2),?(y+i%-2):PLOT 4,?(x+i%-1),?(y+i%-1):PLOT 85,?(x+i%),?(y+i%)
10180 RETURN
10190 REM ********** draw a rectangle
10200 GCOL 0,?(c+i%):PLOT 4,?(x+i%-1),?(y+i%-1):PLOT 101,?(x+i%),?(y+i%)
10210 RETURN
10220 REM ********** draw a disc
10230 GCOL 0,?(c+i%):PLOT 4,?(x+i%-1),?(y+i%-1):PLOT 157,?(x+i%),?(y+i%)
10240 RETURN
10250 REM ********** load data
10260 IF f$="" THEN RETURN
10270 file=OPENIN f$
10280 IF file=0 THEN PRINT "File missing !": CLOSE#file:RETURN
10290 INPUT#file,cpt%
10300 FOR i%=0 TO cpt%
10310 INPUT#file,?(cmd+i%),?(c+i%),?(x+i%),?(y+i%)
10320 NEXT i%:paper%=?(c+0):GOSUB 10000
10330 CLOSE#file
10340 RETURN
10350 REM ********** clear area
10360 ?(cmd+0)=ASC("c"):?(c+0)=paper%:?(x+0)=centx%:?(y+0)=centy%
10370 GCOL 0,15:PLOT 4,minx%-1,miny%-1:PLOT 5,maxx%+1,miny%-1
10380 PLOT 5,maxx%+1,maxy%+1:PLOT 5,minx%-1,maxy%+1:PLOT 5,minx%-1,miny%-1
10390 GCOL 0,paper%:PLOT 4,minx%,miny%:PLOT 101,maxx%,maxy%
10400 RETURN
