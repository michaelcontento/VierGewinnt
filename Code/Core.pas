{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
{+                                                                   +}
{+  Filename : Core.pas                                              +}
{+  Date     : 18.04.2004                                            +}
{+  Last Edit: 26.05.2004                                            +}
{+  Part of  : VierGewinnt in Pascal                                 +}
{+               Von Michael Contento und Florian Rubel              +}
{+                                                                   +}
{+  Author   : Michael Contento                                      +}
{+  Email    : MichaelContento (at) web (dot) de                     +}
{+                                                                   +}
{+                                                                   +}
{+  Info     : Alle wichtigen Funktionen und Prozeduren für 4Gewinnt.+}
{+                                                                   +}
{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
Unit Core;

{~~~~~~~~~~~}
{ Interface }
{~~~~~~~~~~~}
Interface
  { Units      }
    Uses InOut, TypDef;

  { Type       }
    { Type  }

  { Konstanten }
    { Const }

  { Variablen  }
    { Var   }

  { Prozeduren / Funktionen }
    Function SteinSetzen   (var Spielfeld        : SpielfeldArray;
                                SetzSpalte       : integer;
                                AktuellerSpieler : integer        ) : string;
    Function GewinnCheck   (var Spielfeld        : SpielfeldArray;
                                AktuellerSpieler : integer        ) : boolean;
    Function SpielfeldVoll (var Spielfeld        : SpielfeldArray ) : boolean;
   Function GetScore       (var Spielfeld        : SpielfeldArray;
                            var Spieler          : integer        ) : integer;

{~~~~~~~~~~~~~~~~}
{ Implementation }
{~~~~~~~~~~~~~~~~}
Implementation

  {+++++++++++++++++++++++++++++++++++++++++++++++++++++}
  {+ Funktions Block:                                  +}
  {+ ~~~~~~~~~~~~~~~~                                  +}
  {+ Funktionen die Rekrusiv die Steine zählen, die    +}
  {+ zum Gewinnen richtig liegen.                      +}
  {+++++++++++++++++++++++++++++++++++++++++++++++++++++}
  {~~~~~~~~~~~~~~~~~~~~~~~~~}
  {~ <- ~ Nach Links Suchen }
  {~~~~~~~~~~~~~~~~~~~~~~~~~}
  Function TestNachLinks (var Spielfeld        : SpielfeldArray;             { Rekrusiv im Spielfeld nach feldern die }
                              AktuellerSpieler : integer       ;             { dem Aktuellen Spieler gehören suchen.  }
                              x                : integer       ;             { X-Koordinate im Spielfeld              }
                              y                : integer        ) : integer; { Y-Koordinate im Spielfeld              }
  begin
    { Gehört das feld dem Aktuellen Spieler? }
    if Spielfeld[y,x] = AktuellerSpieler then
      begin
        { Solang noch nicht am Rand des Arrays }
        if x > 1 then
          begin
            { Eins nach Links gehen }
            x := x - 1;

            { Und wieder Testen }
            TestNachLinks := 1 + TestNachLinks(Spielfeld, AktuellerSpieler, x, y);
          end
        { Sonst nicht weiter gehen.. }
        else
          TestNachLinks := 1;
      end
    { Sonst 0 zurück geben }
    else
        TestNachLinks := 0;
  end;

  {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
  {~ \ ~ Diagonal nach Links Suchen }
  {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
  Function TestNachDiagonalLinks (var Spielfeld        : SpielfeldArray;             { Rekrusiv im Spielfeld nach feldern die }
                                      AktuellerSpieler : integer       ;             { dem Aktuellen Spieler gehören suchen.  }
                                      x                : integer       ;             { X-Koordinate im Spielfeld              }
                                      y                : integer        ) : integer; { Y-Koordinate im Spielfeld              }
  begin
    { Gehört das feld dem Aktuellen Spieler? }
    if Spielfeld[y,x] = AktuellerSpieler then
      begin
        { Solang noch nicht am Rand des Arrays }
        if (x > 1) and (y > 1) then
          begin
            { Diagonal nach Links gehen }
            x := x - 1;
            y := y - 1;

            { Und wieder Testen }
            TestNachDiagonalLinks := 1 + TestNachDiagonalLinks(Spielfeld, AktuellerSpieler, x, y);
          end
        { Sonst nicht weiter gehen.. }
        else
          TestnachDiagonalLinks := 1;
      end
    { Sonst 0 zurück geben }
    else
      TestNachDiagonalLinks := 0;
  end;

  {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
  {~ / ~ Diagonal nach Rechts Suchen }
  {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
  Function TestNachDiagonalRechts(var Spielfeld        : SpielfeldArray;             { Rekrusiv im Spielfeld nach feldern die }
                                      AktuellerSpieler : integer       ;             { dem Aktuellen Spieler gehören suchen.  }
                                      x                : integer       ;             { X-Koordinate im Spielfeld              }
                                      y                : integer        ) : integer; { Y-Koordinate im Spielfeld              }
  begin
    { Gehört das feld dem Aktuellen Spieler? }
    if Spielfeld[y,x] = AktuellerSpieler then
      begin
        { Solange nicht am Rand des Arrays }
        if (x < 7) and (y > 1) then
          begin
            { Diagonal nach Rechts gehen }
            x := x + 1;
            y := y - 1;

            { Und wieder Testen }
            TestNachDiagonalRechts := 1 + TestNachDiagonalRechts(Spielfeld, AktuellerSpieler, x, y);
          end
        { Sonst nicht weiter gehen.. }
        else
          TestNachDiagonalRechts := 1;
      end
    { Sonst 0 zurück geben }
    else
      TestNachDiagonalRechts := 0;
  end;

  {~~~~~~~~~~~~~~~~~~~~~~~~}
  {~ /\ ~ Nach Oben Suchen }
  {~~~~~~~~~~~~~~~~~~~~~~~~}
  Function TestNachOben (var  Spielfeld        : SpielfeldArray;             { Rekrusiv im Spielfeld nach feldern die }
                              AktuellerSpieler : integer       ;             { dem Aktuellen Spieler gehören suchen.  }
                              x                : integer       ;             { X-Koordinate im Spielfeld              }
                              y                : integer        ) : integer; { Y-Koordinate im Spielfeld              }
  begin
    { Gehört das feld dem Aktuellen Spieler? }
    if Spielfeld[y,x] = AktuellerSpieler then
      begin
        { Solange noch nicht am Rand des Arrays }
        if y > 1 then
          begin
            { Nach Oben gehen }
            y := y - 1;

            { Und wieder Testen }
            TestNachOben := 1 + TestNachOben(Spielfeld, AktuellerSpieler, x, y);
          end
        { Sonst nicht weiter gehen.. }
        else
          TestNachOben := 1;
      end
    { Sonst 0 zurück geben }
    else
      TestNachOben := 0;
  end;
  {+++++++++++++++++++++++++++++++++++++++++++++++++++++}
  {+                                                   +}
  {+ FUNKTIONSBLOCK ENDE                               +}
  {+                                                   +}
  {+++++++++++++++++++++++++++++++++++++++++++++++++++++}

  {~~~~~~~~~~~~~~~~~~~~~~~~~~}
  { Testen ob es Vierer gibt }
  {~~~~~~~~~~~~~~~~~~~~~~~~~~}
  Function GewinnCheck (var Spielfeld        : SpielfeldArray;
                            AktuellerSpieler : integer        ) : boolean;
  Var x        : 1..7; { x Koordinate }
      y        : 1..6; { y Koordinate }
      Ergebnis : 0..4; { Ergebnis ob es 4 Steine hintereinander gibt }
  begin
    { Feld komplett durchtesten }
    for y := 6 downto 1 do
      begin
        for x := 7 downto 1 do
          begin
            { In alle Möglichen Richtungen suchen }
            Ergebnis := TestNachLinks          (Spielfeld, AktuellerSpieler, x, y);
            if Ergebnis = 4 then break;

            Ergebnis := TestNachDiagonalLinks  (Spielfeld, AktuellerSpieler, x, y);
            if Ergebnis = 4 then break;

            Ergebnis := TestNachDiagonalRechts (Spielfeld, AktuellerSpieler, x, y);
            if Ergebnis = 4 then break;

            Ergebnis := TestNachOben           (Spielfeld, AktuellerSpieler, x, y);
            if Ergebnis = 4 then break;
          end;
        if Ergebnis = 4 then break;
      end;

    { Wenn 4 mal die Selben da sind dan 1 zurück geben }
    if Ergebnis = 4 then  GewinnCheck := true
    else                  GewinnCheck := false;
  end;

  {~~~~~~~~~~~~~~~~}
  { Spielfeld Voll }
  {~~~~~~~~~~~~~~~~}
  Function SpielfeldVoll (var Spielfeld : SpielfeldArray) : boolean;
  var x         : 1..7;    { x Koordinate }
      y         : 1..6;    { y Koordinate }
      AllesVoll : boolean; { Rückgabe Variable }
  begin
    AllesVoll := true;

    { Felder durchgehen }
    for y := 6 downto 1 do
      for x := 7 downto 1 do
        begin
          { Sobald noch 1 Feld frei ist auf 1 Setzen }
          if Spielfeld[y,x] = 0 then
            AllesVoll := false;
        end;

    SpielfeldVoll := AllesVoll;
  end;

  {~~~~~~~~~~~~}
  { Reihe Voll }
  {~~~~~~~~~~~~}
  Function SpalteVoll (var Spielfeld  : SpielfeldArray;
                       var SetzSpalte : integer        ) : boolean;
  begin
    { Erste Positition leer? }
    if Spielfeld[1,SetzSpalte] = 0 then
      { Dann  --> falsch }
      SpalteVoll := false
    else
      { Sonst --> richtig }
      SpalteVoll := true;
    { Feddisch :P }
  end;

  {~~~~~~~~~~~~~~}
  { Stein Setzen }
  {~~~~~~~~~~~~~~}
  Function SteinSetzen (var Spielfeld        : SpielfeldArray;
                            SetzSpalte       : integer;
                            AktuellerSpieler : integer        ) : string;
  var Status    : string[20]; { Rückgabe wert (FeldBesetzt, FeldVoll, ...) }
      SetzZeile : 1..6;       { Die Zeile in die gesetzt werden soll }
  begin
    { Variablen Initialisierung }
    Status    := 'Unfertig';
    SetzZeile := 6;

    { Solang noch platz auf dem Spielfeld ist }
    if SpielfeldVoll(Spielfeld) = false then
      begin

        { Soland noch platz in der Reihe ist }
        if SpalteVoll(Spielfeld, SetzSpalte) = false then
          begin

            { Solange Zug nicht Erfolgreich war }
            while Status <> 'ZugGemacht' do
              begin

                { Wenn Feld frei -> Stein setzen }
                if Spielfeld[SetzZeile,SetzSpalte] = 0 then
                  begin
                    Spielfeld[SetzZeile,SetzSpalte] := AktuellerSpieler;
                    Status := 'ZugGemacht';
                  end
                { Sonst Zeile drüber Testen }
                else
                  begin
                    SetzZeile := SetzZeile - 1;
                    Status := 'FeldBesetzt';
                  end;
              end;

          end

        { Sonst Statuscode Setzen }
        else
          Status := 'ReiheVoll';
      end

    { Sonst Statuscode Setzen }
    else
      Status := 'SpielfeldVoll';

    SteinSetzen := Status;
  end;

   {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
   { Punkte des Spiels ermitteln }
   {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
   Function GetScore (var Spielfeld : SpielfeldArray;
                      var Spieler   : integer        ) : integer;
   var x           : 1..7;
       y           : 1..6;
       Punktestand : integer;
       Ergebnis    : 1..4;
   begin
    { Variablen initielisieren }
    Punktestand := 0;

    { Feld komplett durchtesten }
    for y := 1 to 6 do
      begin
        for x := 1 to 7 do
          begin
            { In alle Möglichen Richtungen suchen }
            Ergebnis := TestNachLinks          (Spielfeld, Spieler, x, y);
            Punktestand := Punktestand + Ergebnis;

            Ergebnis := TestNachDiagonalLinks  (Spielfeld, Spieler, x, y);
            Punktestand := Punktestand + Ergebnis;

            Ergebnis := TestNachDiagonalRechts (Spielfeld, Spieler, x, y);
            Punktestand := Punktestand + Ergebnis;

            Ergebnis := TestNachOben           (Spielfeld, Spieler, x, y);
            Punktestand := Punktestand + Ergebnis;
          end;
      end;

     { Ermittelten Punkte Zurückgeben }
     GetScore := Punktestand;
   end;

  {~~~~~~~~~~~~~~~~~~~~~~~~}
  { Hauptprogramm der Unit }
  {~~~~~~~~~~~~~~~~~~~~~~~~}
  begin
    { Leer da dashier nur die Auslagerung von Funktionen / Prozeduren ist +g+ }
  end.
