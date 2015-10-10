{***************************************************************************
 Programm:      Vier Gewinnt
 Dateiname:     Anzeige.pas

 Funktion:      Zum spielen von dem Spiel 4 Gewinnt.

 Autor:         Michael Contento, Florian Rubel

 erstellt am:   15.03.03

***************************************************************************}

Unit InOut;

{***************************************************************************}
{Interface}

 Interface
 {Units}
  uses
   crt,graph,dos,typdef,fileio;

 {Konstanten}
  {const}

 {Variablen}
  var
   dummyarray : SpielfeldArray;

  procedure start;
  Function ErrorSpalteVoll(var Spielfeld:Spielfeldarray;Spieler:integer):integer;
  function ErrorFeldVoll(var Spielfeld:Spielfeldarray;Spieler:integer):integer;
  function GewinnerAusgabe(var Spielfeld:Spielfeldarray;Spieler:integer):integer;
  function SpielfeldZeichnen(var Spielfeld:Spielfeldarray;Spieler:integer):integer;
  function SpielerEinlesen : integer;
  function GameSavedInfo : integer;

  function hauptmenu : integer;
  function NeuesSpiel : integer;
  function Spielinfo:integer;
  function Programminfos:integer;
  procedure Spielanleitung;
  function Tastenerkennung:integer;
  procedure grafikein(grdriver,grmode:integer;pathtodriver:string);
  function SpielfeldHintergrund : integer;
  procedure errornosavegame;

 implementation

{***************************************************************************}
{Funktionen}

{Grafikmodus einschalten----------------------------------------------------
                    16Farben,640*480 =>  grafikein(VGAlo,2);
                   256Fraben,320*200 =>  grafikein(*****,*);
 ---------------------------------------------------------------------------}
 procedure grafikein(grdriver,grmode:integer;pathtodriver:string);
  var
    ErrCode: Integer;
 begin
  {pathtodriver := 'H:\pascal~1\vier\';}
  InitGraph(grDriver, grMode,pathtodriver);
  ErrCode := GraphResult;
  if ErrCode = grOk then
     begin  { Do graphics }
     end
  else
     begin
      Writeln('Graphics error:', GraphErrorMsg(ErrCode));
      readln;
     end;
 end;{function}
{Ende Grafikein-----------------------------------------------------------}

{Anfang ErrorSpalteVoll---------------------------------------------------}
function ErrorSpalteVoll(var Spielfeld:Spielfeldarray;Spieler:integer):integer;
 begin
  outtextxy(320,120,'Spalte voll!');
 end;

{Anfang ErrorFeldVoll-----------------------------------------------------}
function ErrorFeldVoll(var Spielfeld:Spielfeldarray;Spieler:integer):integer;
 begin
  outtextxy(320,120,'Feld voll - Enter drÅcken');
  readkey;
 end;

{Anfang GameSavedInfo-----------------------------------------------------}
function GameSavedInfo : integer;
 begin
  outtextxy(320,120,'Spiel gespeichert - Enter drÅcken');
  readkey;
 end;

{Anfang Spielereinlesen---------------------------------------------------
  Funktion zum Steuern des Spielablaufes, die einen Steuerindex zur¸ckgibt.
	1 = 1 - Spalte 1
	2 = 2 - Spalte 2
	3 = 3 - Spalte 3
	4 = 4 - Spalte 4
	5 = 5 - Spalte 5
	6 = 6 - Spalte 6
	7 = 7 - Spalte 7
	8 = S - Speichern
	9 = B - Beenden
--------------------------------------------------------------------------}

 function SpielerEinlesen : integer;
 var taste : char;
     ok : char;

 begin
  SpielerEinlesen := 0;
  ok := 'n';
  While ok = 'n' do
   begin
    taste := readkey;
       if taste = '1' then
          begin
           SpielerEinlesen := 1;
           ok:= 'j';
          end;
       if taste = '2' then
          begin
           SpielerEinlesen := 2;
           ok := 'j';
          end;
       if taste = '3' then
          begin
           SpielerEinlesen := 3;
           ok := 'j';
          end;
       if taste = '4' then
          begin
           SpielerEinlesen := 4;
           ok := 'j';
          end;
       if taste = '5' then
          begin
           SpielerEinlesen := 5;
           ok := 'j';
          end;
       if taste = '6' then
          begin
           SpielerEinlesen := 6;
           ok := 'j';
          end;
       if taste = '7' then
          begin
           SpielerEinlesen := 7;
           ok := 'j';
          end;
       if (taste = 's') or (taste = 'S') then
          begin
           SpielerEinlesen := 8;
           ok := 'j';
          end;
       if (taste = 'b') or (taste = 'B') then
          begin
           SpielerEinlesen := 9;
           ok := 'j';
          end;
    if taste = 'z' then {Zum schnellen beenden (Cheat)}
     begin
      exit
     end;
    {Spiel- und Fehlerinformationen Åberzeichnen}
    setfillstyle(6,magenta);
    bar(320,120,450,130);
   end; {Schleife}

end; {Function}
{Ende SpielerEinlesen-----------------------------------------------------}

{Anfang SpielfeldHintergrund----------------------------------------------}
function SpielfeldHintergrund : integer;
 begin
  setfillstyle(6,magenta);
  bar(0,0,getmaxx,getmaxy);
  SetFillStyle(SolidFill, green);
  bar3d(80,150,getmaxx-140,getmaxy-10,20,true);
 end;
{Ende SpielfeldHintergrund------------------------------------------------}

{anfang SpielfeldZeichnen------------------------------------------------
	Zeichnet das Spielfeld
--------------------------------------------------------------------------}
function SpielfeldZeichnen(var SpielFeld: SpielFeldArray;Spieler:integer) : integer;
 var
    i: integer;
    a: integer;
    cx,cy : integer;

 begin
  cy := 0;
  cx := 90;
  for a := 1 to 7 do
     begin
      cx := cx + 50;
      cy := 140;
      for i := 1 to 6 do
         begin
          cy:= cy+50;
          setcolor(0);
          case spielfeld[i,a] of
           0:begin
              setfillstyle(solidfill,0);{schwarz}
             end;{0}
           1:begin
              setfillstyle(solidfill,4);{rot}
             end;{1}
           2:begin
              setfillstyle(solidfill,1);{blau}
             end;{2}
          end;{case}
          fillellipse(cx,cy,20,20);
         end; {i}
     end; {a}
  setcolor(15);
  settextstyle(defaultfont,0,1);
  outtextxy(80,80,'1-7 - Stein setzen    S - Speichern    B - Spiel beenden');
  {taste := steuerung;}
 end;{function}

{Ende Spielfeld------------------------------------------------------------}


{Tastenerkennung--------------------------------------------------------
     Returnt 1 fÅr Cursor hoch
             2 fÅr Cursor runter
             3 fÅr Return-Taste
	Wiederholt sich, solange weder hoch, noch runter oder
	Return gedr¸ckt wurde.
 --------------------------------------------------------------------- }
function Tastenerkennung : integer;
 var taste : char;
     ok : char;

 begin
  Tastenerkennung := 0;
  ok := 'n';
  While ok = 'n' do
   begin
    taste := readkey;
    if ord(taste) = 0 then
      begin
       taste := readkey;
       if ord(taste) = 72 then
          begin
           Tastenerkennung := 1;
           ok:= 'j';
          end;
       if ord(taste) = 80 then
          begin
           Tastenerkennung := 2;
           ok := 'j';
          end;
      end;
       if ord(taste) = 13 then
          begin
           Tastenerkennung := 3;
           ok := 'j';
          end;
   end; {Schleife}
end; {Function}

{Ende Tastenerkennung--------------------------------------------------}

{Spielanleitung--------------------------------------------------------
	Zeigt den Spielanleitungsbildschirm an
-----------------------------------------------------------------------}
procedure spielanleitung;
 begin
  setfillstyle(10,6);
  bar(0,0,getmaxx,getmaxy);
  settextstyle(defaultfont,0,2);
  outtextxy(50,56+10,'Anleitung zu Vier Gewinnt');
  outtextxy(50,64+30,'In diesem Spiel geht es darum');
  outtextxy(50,72+40,'4 Steine der eigenen Farbe neben');
  outtextxy(50,80+50,'einander zu bekommen. Dies kann');
  outtextxy(50,88+60,'entweder horizontal, vertikal oder');
  outtextxy(50,96+70,'auch diagonal erreicht werden. Die');
  outtextxy(50,104+80,'Steine werden von oben in die Slots');
  outtextxy(50,112+90,'geworfen. Benutzen Sie dazu die');
  outtextxy(50,120+100,'Tasten 1 bis 7. Der erste Spieler,');
  outtextxy(50,128+110,'der seine 4 Steine nebeneinander');
  outtextxy(50,136+120,'bekommt, gewinnt das Spiel.');
  delay(1000);
  outtextxy(50,150+150,'Eingabetaste drÅcken...');
  readkey;
 end; {procedure}
{Ende Spielanleitung---------------------------------------------------}

{Anfang GewinnerAusgabe------------------------------------------------
        Gibt einen Gewinnbildschirm aus.
        1 - Spieler 1 hat gewonnen.
        2 - Spieler 2 hat gewonnen.
        0 - Unentschieden.
-----------------------------------------------------------------------}
 function GewinnerAusgabe(var Spielfeld:Spielfeldarray;Spieler:integer) : integer;
  var i : integer;

  begin
     spielfeldzeichnen(Spielfeld,Spieler);
   for i := 15 downto 1 do
     begin
      {settextstyle(defaultfont,0 ,2);}
      setfillstyle(solidfill,i);
      bar(220,30,420,70);
      if Spieler = 1 then outtextxy(230,40,'Spieler 1 hat gewonnen.');
      if Spieler = 2 then outtextxy(230,40,'Spieler 2 hat gewonnen.');
      Delay(100);
     end;{for}
     outtextxy(270,50,'Enter drÅcken');
     readkey;
  end;{function}
{Ende GewinnerAusgabe--------------------------------------------------}

{Anfang Programminfos---------------------------------------------------
	Zeigt Programminfos an.
-----------------------------------------------------------------------}

function programminfos : integer;
 begin
  setfillstyle(9,8);
  bar(0,0,getmaxx,getmaxy);
  outtextxy(70,40,'Vier Gewinnt');
  delay(2000);
  settextstyle(defaultfont,0,1);
  outtextxy(20,160,'Copyright by Florian Rubel and Michael Contento.');
  outtextxy(20,190,'Version 1.00 beta');
  outtextxy(30,300,'Press Enter');
  readkey;
 end;
{Ende Programminfos----------------------------------------------------}

{Spieleinfo--UntermenÅ-------------------------------------------------
	Untermen¸ der Spieleinfos wird angezeigt.
-----------------------------------------------------------------------}
function Spielinfo : integer;
  var case1 : integer;
      taste: integer;
      x1,x2,y1,y2 : integer;


  begin
   case1 := 1;
   taste := 0;
   x1:= 150;
   y1:= 200;
   x2:= 440;
   y2:= 240;
   while taste <> 3 do
    begin
     setfillstyle(solidfill,2);
     bar(0,0,getmaxx,getmaxy);
     case case1 of
       1:begin
          setfillstyle(solidfill,9);
          setcolor(15);
          settextstyle(DefaultFont,0,2);
          bar3d(x1,y1,x2,y2,10,true);
          outtextxy(x1+10,y1+10,'Spielanleitung');

          setfillstyle(solidfill,1);
          setcolor(7);
          settextstyle(defaultfont,0,2);
          bar3d(x1,y1+(y2-y1)+15,x2,y2+(y2-y1)+15,5,true);
          outtextxy(x1+10,y1+10+(y2-y1)+15,'Programminfos');

          setfillstyle(solidfill,1);
          settextstyle(defaultfont,0,2);
          setcolor(7);
          bar3d(x1,y1+2*(y2-y1)+30,x2,y2+2*(y2-y1)+30,5,true);
          outtextxy(x1+10,y1+10+2*(y2-y1)+30, '<== ZurÅck');
         end;{1}

       2:begin
          setfillstyle(solidfill,1);
          setcolor(7);
          settextstyle(DefaultFont,0,2);
          bar3d(x1,y1,x2,y2,5,true);
          outtextxy(x1+10,y1+10,'Spielanleitung');

          setfillstyle(solidfill,9);
          setcolor(15);
          settextstyle(defaultfont,0,2);
          bar3d(x1,y1+(y2-y1)+15,x2,y2+(y2-y1)+15,10,true);
          outtextxy(x1+10,y1+10+(y2-y1)+15,'Programminfos');

          setfillstyle(solidfill,1);
          settextstyle(defaultfont,0,2);
          setcolor(7);
          bar3d(x1,y1+2*(y2-y1)+30,x2,y2+2*(y2-y1)+30,5,true);
          outtextxy(x1+10,y1+10+2*(y2-y1)+30, '<== ZurÅck');
         end;{2}

       3:begin
          setfillstyle(solidfill,1);
          setcolor(7);
          settextstyle(DefaultFont,0,2);
          bar3d(x1,y1,x2,y2,5,true);
          outtextxy(x1+10,y1+10,'Spielanleitung');

          setfillstyle(solidfill,1);
          setcolor(7);
          settextstyle(defaultfont,0,2);
          bar3d(x1,y1+(y2-y1)+15,x2,y2+(y2-y1)+15,5,true);
          outtextxy(x1+10,y1+10+(y2-y1)+15,'Programminfos');

          setfillstyle(solidfill,9);
          setcolor(15);
          settextstyle(defaultfont,0,2);
          bar3d(x1,y1+2*(y2-y1)+30,x2,y2+2*(y2-y1)+30,10,true);
          outtextxy(x1+10,y1+10+2*(y2-y1)+30, '<== ZurÅck');
         end;{3}
     end; {Case of}
     textcolor(15);
     taste := Tastenerkennung;

     case taste of

      1:begin
         dec(case1);
         if case1 < 1 then case1 := 3;
        end;

      2:begin
         inc(case1);
         if case1 > 3 then case1 := 1;
        end;

      3:begin
         Spielinfo := case1;
        end;
     end; {Case of}
    end; {While Schleife}


  end; {Spielinfo}
{Ende Spielinfo--------------------------------------------------------}

{Neues Spiel-----------------------------------------------------------
	Men¸ wird angezeigt, wenn 'Neues Spiel' ausgew‰hlt wurde
-----------------------------------------------------------------------}
 function NeuesSpiel : integer;
  var case1 : integer;
      taste: integer;
      x1,x2,y1,y2 : integer;

  begin
   case1 := 1;
   taste := 0;
   x1:= 150;
   y1:= 200;
   x2:= 440;
   y2:= 240;
   setfillstyle(9,1);
   bar(0,0,getmaxx,getmaxy);
   while taste <> 3 do
    begin
    setfillstyle(9,1);
    bar(120,170,x2+50,380);
      case case1 of
       1:begin
          setfillstyle(solidfill,4);
          setcolor(15);
          settextstyle(DefaultFont,0,2);
          bar3d(x1,y1,x2,y2,10,true);
          outtextxy(x1+10,y1+10,'Mensch vs PC');

          setfillstyle(solidfill,12);
          setcolor(7);
          settextstyle(defaultfont,0,2);
          bar3d(x1,y1+(y2-y1)+15,x2,y2+(y2-y1)+15,5,true);
          outtextxy(x1+10,y1+10+(y2-y1)+15,'Mensch vs Mensch');

          setfillstyle(solidfill,12);
          settextstyle(defaultfont,0,2);
          setcolor(7);
          bar3d(x1,y1+2*(y2-y1)+30,x2,y2+2*(y2-y1)+30,5,true);
          outtextxy(x1+10,y1+10+2*(y2-y1)+30, 'PC vs PC');

          setfillstyle(solidfill,12);
          settextstyle(defaultfont,0,2);
          setcolor(7);
          bar3d(x1,y1+3*(y2-y1)+45,x2,y2+3*(y2-y1)+45,5,true);
          outtextxy(x1+10,y1+10+3*(y2-y1)+45, '<== ZurÅck');
         end;{1}

       2:begin
          setfillstyle(solidfill,12);
          setcolor(7);
          settextstyle(DefaultFont,0,2);
          bar3d(x1,y1,x2,y2,5,true);
          outtextxy(x1+10,y1+10,'Mensch vs PC');

          setfillstyle(solidfill,4);
          setcolor(15);
          settextstyle(defaultfont,0,2);
          bar3d(x1,y1+(y2-y1)+15,x2,y2+(y2-y1)+15,10,true);
          outtextxy(x1+10,y1+10+(y2-y1)+15,'Mensch vs Mensch');

          setfillstyle(solidfill,12);
          settextstyle(defaultfont,0,2);
          setcolor(7);
          bar3d(x1,y1+2*(y2-y1)+30,x2,y2+2*(y2-y1)+30,5,true);
          outtextxy(x1+10,y1+10+2*(y2-y1)+30, 'PC vs PC');

          setfillstyle(solidfill,12);
          settextstyle(defaultfont,0,2);
          setcolor(7);
          bar3d(x1,y1+3*(y2-y1)+45,x2,y2+3*(y2-y1)+45,5,true);
          outtextxy(x1+10,y1+10+3*(y2-y1)+45, '<== ZurÅck');
         end;{2}

       3:begin
          setfillstyle(solidfill,12);
          setcolor(7);
          settextstyle(DefaultFont,0,2);
          bar3d(x1,y1,x2,y2,5,true);
          outtextxy(x1+10,y1+10,'Mensch vs PC');

          setfillstyle(solidfill,12);
          setcolor(7);
          settextstyle(defaultfont,0,2);
          bar3d(x1,y1+(y2-y1)+15,x2,y2+(y2-y1)+15,5,true);
          outtextxy(x1+10,y1+10+(y2-y1)+15,'Mensch vs Mensch');

          setfillstyle(solidfill,4);
          setcolor(15);
          settextstyle(defaultfont,0,2);
          bar3d(x1,y1+2*(y2-y1)+30,x2,y2+2*(y2-y1)+30,5,true);
          outtextxy(x1+10,y1+10+2*(y2-y1)+30, 'PC vs PC');

          setfillstyle(solidfill,12);
          settextstyle(defaultfont,0,2);
          setcolor(7);
          bar3d(x1,y1+3*(y2-y1)+45,x2,y2+3*(y2-y1)+45,5,true);
          outtextxy(x1+10,y1+10+3*(y2-y1)+45, '<== ZurÅck');
         end;{3}
       4:begin
          setfillstyle(solidfill,12);
          setcolor(7);
          settextstyle(DefaultFont,0,2);
          bar3d(x1,y1,x2,y2,5,true);
          outtextxy(x1+10,y1+10,'Mensch vs PC');

          setfillstyle(solidfill,12);
          setcolor(7);
          settextstyle(defaultfont,0,2);
          bar3d(x1,y1+(y2-y1)+15,x2,y2+(y2-y1)+15,5,true);
          outtextxy(x1+10,y1+10+(y2-y1)+15,'Mensch vs Mensch');

          setfillstyle(solidfill,12);
          setcolor(7);
          settextstyle(defaultfont,0,2);
          bar3d(x1,y1+2*(y2-y1)+30,x2,y2+2*(y2-y1)+30,5,true);
          outtextxy(x1+10,y1+10+2*(y2-y1)+30, 'PC vs PC');

          setfillstyle(solidfill,4);
          settextstyle(defaultfont,0,2);
          setcolor(15);
          bar3d(x1,y1+3*(y2-y1)+45,x2,y2+3*(y2-y1)+45,5,true);
          outtextxy(x1+10,y1+10+3*(y2-y1)+45, '<== ZurÅck');
         end;{4}

      end;{Case}


      taste := Tastenerkennung;

      case taste of

       1:begin
          dec(case1);
          if case1 < 1 then case1 := 4;
         end;

       2:begin
          inc(case1);
          if case1 > 4 then case1 := 1;
         end;

       3:begin
          NeuesSpiel := case1;
         end;
      end; {Case of}
    end; {While Schleife}


  end; {NeuesSpiel}
{Ende NeuesSpiel-------------------------------------------------------}


{HauptmenÅ----------------------------------------------------------------
    Gibt den Index vom HauptmenÅ zurÅck, wenn mit Enter  ausgewÑhlt wurde
    und zeigt das Hauptmen¸ an.
 -------------------------------------------------------------------------}
 function hauptmenu : integer;
  var case1 : integer;
      taste: integer;
      x1,x2,y1,y2 : integer;

  begin
   case1 := 1;
   taste := 0;
   x1:= 150;
   y1:= 150;
   x2:= 440;
   y2:= 190;
   setfillstyle(6,red);
   bar(0,0,getmaxx,getmaxy);
   while taste <> 3 do
    begin
     setfillstyle(6,red);
     bar(150,140,450,410);
      case case1 of
       1:begin
          setfillstyle(solidfill,blue);
          setcolor(15);
          settextstyle(DefaultFont,0,2);
          bar3d(150,150,440,190,10,true);
          outtextxy(160,160,'Neues Spiel');

          setfillstyle(solidfill,12);
          setcolor(darkgray);
          settextstyle(defaultfont,0,2);
          bar3d(150,205,440,245,5,true);
          outtextxy(160,215,'Spiel Laden');

          setfillstyle(solidfill,12);
          settextstyle(defaultfont,0,2);
          setcolor(darkgray);
          bar3d(150,260,440,300,5,true);
          outtextxy(160,270, 'Highscore');

          setfillstyle(solidfill,12);
          settextstyle(defaultfont,0,2);
          setcolor(darkgray);
          bar3d(150,315,440,355,5,true);
          outtextxy(160,y1+10+3*(y2-y1)+45, 'Spielinfos');

          setfillstyle(solidfill,12);
          settextstyle(defaultfont,0,2);
          setcolor(darkgray);
          bar3d(150,370,440,410,5,true);
          outtextxy(160,y1+10+4*(y2-y1)+60, 'Beenden');
         end;{1}

       2:begin
          setfillstyle(solidfill,12);
          setcolor(darkgray);
          settextstyle(DefaultFont,0,2);
          bar3d(150,150,440,190,5,true);
          outtextxy(x1+10,y1+10,'Neues Spiel');

          setfillstyle(solidfill,blue);
          setcolor(15);
          settextstyle(defaultfont,0,2);
          bar3d(150,205,440,245,10,true);
          outtextxy(x1+10,y1+10+(y2-y1)+15,'Spiel Laden');

          setfillstyle(solidfill,12);
          settextstyle(defaultfont,0,2);
          setcolor(darkgray);
          bar3d(150,260,440,300,5,true);
          outtextxy(x1+10,y1+10+2*(y2-y1)+30, 'Highscore');

          setfillstyle(solidfill,12);
          settextstyle(defaultfont,0,2);
          setcolor(darkgray);
          bar3d(150,315,440,355,5,true);
          outtextxy(x1+10,y1+10+3*(y2-y1)+45, 'Spielinfos');

          setfillstyle(solidfill,12);
          settextstyle(defaultfont,0,2);
          setcolor(darkgray);
          bar3d(150,370,440,410,5,true);
          outtextxy(x1+10,y1+10+4*(y2-y1)+60, 'Beenden');
         end;{2}

       3:begin
          setfillstyle(solidfill,12);
          setcolor(darkgray);
          settextstyle(DefaultFont,0,2);
          bar3d(150,150,440,190,5,true);
          outtextxy(x1+10,y1+10,'Neues Spiel');

          setfillstyle(solidfill,12);
          setcolor(darkgray);
          settextstyle(defaultfont,0,2);
          bar3d(150,205,440,245,5,true);
          outtextxy(x1+10,y1+10+(y2-y1)+15,'Spiel Laden');

          setfillstyle(solidfill,blue);
          setcolor(15);
          settextstyle(defaultfont,0,2);
          bar3d(150,260,440,300,10,true);
          outtextxy(x1+10,y1+10+2*(y2-y1)+30, 'Highscore');

          setfillstyle(solidfill,12);
          settextstyle(defaultfont,0,2);
          setcolor(darkgray);
          bar3d(150,315,440,355,5,true);
          outtextxy(x1+10,y1+10+3*(y2-y1)+45, 'Spielinfos');

          setfillstyle(solidfill,12);
          settextstyle(defaultfont,0,2);
          setcolor(darkgray);
          bar3d(150,370,440,410,5,true);
          outtextxy(x1+10,y1+10+4*(y2-y1)+60, 'Beenden');

         end;{3}

       4:begin
          setfillstyle(solidfill,12);
          setcolor(darkgray);
          settextstyle(DefaultFont,0,2);
          bar3d(150,150,440,190,5,true);
          outtextxy(x1+10,y1+10,'Neues Spiel');

          setfillstyle(solidfill,12);
          setcolor(darkgray);
          settextstyle(defaultfont,0,2);
          bar3d(150,205,440,245,5,true);
          outtextxy(x1+10,y1+10+(y2-y1)+15,'Spiel Laden');

          setfillstyle(solidfill,12);
          setcolor(darkgray);
          settextstyle(defaultfont,0,2);
          bar3d(150,260,440,300,5,true);
          outtextxy(x1+10,y1+10+2*(y2-y1)+30, 'Highscore');

          setfillstyle(solidfill,blue);
          settextstyle(defaultfont,0,2);
          setcolor(15);
          bar3d(150,315,440,355,10,true);
          outtextxy(x1+10,y1+10+3*(y2-y1)+45, 'Spielinfos');

          setfillstyle(solidfill,12);
          settextstyle(defaultfont,0,2);
          setcolor(darkgray);
          bar3d(150,370,440,410,5,true);
          outtextxy(x1+10,y1+10+4*(y2-y1)+60, 'Beenden');
         end;{4}

       5:begin
          setfillstyle(solidfill,12);
          setcolor(darkgray);
          settextstyle(DefaultFont,0,2);
          bar3d(150,150,440,190,5,true);
          outtextxy(x1+10,y1+10,'Neues Spiel');

          setfillstyle(solidfill,12);
          setcolor(darkgray);
          settextstyle(defaultfont,0,2);
          bar3d(150,205,440,245,5,true);
          outtextxy(x1+10,y1+10+(y2-y1)+15,'Spiel Laden');

          setfillstyle(solidfill,12);
          setcolor(darkgray);
          settextstyle(defaultfont,0,2);
          bar3d(150,260,440,300,5,true);
          outtextxy(x1+10,y1+10+2*(y2-y1)+30, 'Highscore');

          setfillstyle(solidfill,12);
          settextstyle(defaultfont,0,2);
          setcolor(darkgray);
          bar3d(150,315,440,355,5,true);
          outtextxy(x1+10,y1+10+3*(y2-y1)+45, 'Spielinfos');

          setfillstyle(solidfill,blue);
          settextstyle(defaultfont,0,2);
          setcolor(15);
          bar3d(150,370,440,410,10,true);
          outtextxy(x1+10,y1+10+4*(y2-y1)+60, 'Beenden');
         end;{5}
      end;{Case}

      taste := Tastenerkennung;

      case taste of

       1:begin
          dec(case1);
          if case1 < 1 then case1 := 5;
         end;

       2:begin
          inc(case1);
          if case1 > 5 then case1 := 1;
         end;

       3:begin
          hauptmenu := case1;
         end;
      end; {Case of}
    end; {While Schleife}
  end; {HauptmenÅ}

{Start------------------------------------------------------------------}
 procedure start; {erzeugt einen Startscreen}
  var
    x,y : integer;
    cpu : registers;{Struktur der Prozessorregister}
    puffer : byte;
    rot,gruen,blau : byte;
    f : file  of byte;

  begin {start}
   clrscr;
   assign(f,'a.bmp');
   {$I-}
   reset(f);
   {$I+}
   if ioresult <> 0 then readkey;
   for y := 1 to 54 do read(f,puffer);   {Header Åberlesen}

   cpu.ah := 0;   {Funktion, Grafikmodus wÑhlen}
   cpu.al := $13; {Hexzahl, 19 in Dezimal, Wert fÅr den Grafikmodus}
   intr($10,cpu); {Schaltet in Grafik um, 320*200 und 256 Farben}

   for y := 0 to 255 do   {Paletteninformationen der Bitmap lesen}
    begin
     read(f,blau);  {Farben werden vorgegebenen Reihenfolge eingelesen}
     read(f,gruen);
     read(f,rot);
     read(f,puffer);

     gruen := gruen shr 2; {verhindert, dass Werte die 64er Grenze...}
     rot := rot shr 2;     {...Åberschritten wird, welche vom Interrupt}
     blau := blau shr 2;   {festgelegt sind}

     cpu.ax := $1010;{Kennung fÅr Interrupt $10 fÅr die Funktion setpalette(Kennung Hex10)}
     cpu.bx := y;  {Palettenindex 0 bis 255}
     cpu.ch := gruen; {CPU-Register mit den Farbwerten fÅllen}
     cpu.cl := blau; {-"-}
     cpu.dh := rot;   {-"-}

     intr($10,cpu); {ruft den Software-Interrupt Hex10($10) auf, setzt definierte Palette}
    end;

    for y := 199 downto 0 do
     begin
      for x := 0 to 319 do
       begin
        cpu.ah := $0C; {Setpixel-function}
        read(f,puffer);
        cpu.al := (puffer); {Setzt die Farbe}
        cpu.bh := 0; {Benutzt nur die 0. Seite des Grafikkartenspeichers}
        cpu.cx := x; {Columns}
        cpu.dx := y; {Rows}
        intr($10,cpu); {ruft den SoftwareInterrupt mit den gegeb Werten auf};
       end;
     end;
    readkey; {Benutzereingabe erforderlich}
    cpu.ah := 0;   {Funktion 0}
    cpu.al := $03; {Wert $03, Hexzahl, 3 in Dezimal}
    intr($10,cpu); {Textmodus}
    close(f);
  end; {start}

  procedure errornosavegame;
  begin
  end;
{---------------------------------------------------------------------}

{*********************************************************************}
begin
end.