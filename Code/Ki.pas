{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
{+                                                                   +}
{+  Filename : Ki.pas                                                +}
{+  Date     : 22.04.2004                                            +}
{+  Last Edit: 05.05.2004                                            +}
{+  Part of  : VierGewinnt in Pascal                                 +}
{+               Von Michael Contento und Florian Rubel              +}
{+                                                                   +}
{+  Author   : Michael Contento                                      +}
{+  Email    : MichaelContento (at) web (dot) de                     +}
{+                                                                   +}
{+                                                                   +}
{+  Info     : Steuerung und Koordination der Kuenstlichen           +}
{+             Intelligenz von unserem Spiel VierGewinnt.            +}
{+                                                                   +}
{++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
Unit KI;

{~~~~~~~~~~~}
{ Interface }
{~~~~~~~~~~~}
Interface
  { Units      }
    Uses Core, InOut, TypDef;

  { Type       }
    { Type  }

  { Konstanten }
    { Const }

  { Variablen  }
    { Var   }

  { Prozeduren / Funktionen }
    Function KiGo (var Spielfeld : SpielfeldArray;
                   var Spieler : integer          ) : string;

{~~~~~~~~~~~~~~~~}
{ Implementation }
{~~~~~~~~~~~~~~~~}
Implementation

  {+++++++++++++++++++++++++++++++++++++++++++++++++++++}
  {+ Funktions Block:                                  +}
  {+ ~~~~~~~~~~~~~~~~                                  +}
  {+ Funktionen die Rekrusiv die Anzahl der gesuchten  +}
  {+ Steine in einer Richtung zählt.                   +}
  {+++++++++++++++++++++++++++++++++++++++++++++++++++++}
  {~~~~~~~~~~~~~~~~~~~~~~~~~}
  {~ \/ ~ Nach Unten Suchen }
  {~~~~~~~~~~~~~~~~~~~~~~~~~}
  Function GoDown (var Spielfeld  : SpielfeldArray;
                   var SuchenNach : integer;
                       x          : integer;
                       y          : integer        ) : integer;
  begin
    { Wenn man noch in die Richtung gehen kann }
    if y < 6 then
      begin

        { In die Richtung gehen }
        y := y + 1;

        { Wenn das Feld auf die Suche passt }
        if Spielfeld[y,x] = SuchenNach then
          { Punkte setzten und weitergucken }
          GoDown := 1 + GoDown(Spielfeld, SuchenNach, x, y)

        { Sonst 0 als Punkt geben }
        else
          GoDown := 0;
      end

    { Wenn man nicht mehr weitergehen kann }
    else
      begin

        { Passt das feld auf die Suche !? }
        if Spielfeld[y,x] = SuchenNach then
          { Einen Punkte geben }
          GoDown := 1

        { Sonst keinen Punkt geben }
        else
          GoDown := 0;
      end;
  end;

  {~~~~~~~~~~~~~~~~~~~~~~~~~~}
  {~ -> ~ Nach Rechts Suchen }
  {~~~~~~~~~~~~~~~~~~~~~~~~~~}
  Function GoRechts (var Spielfeld  : SpielfeldArray;
                     var SuchenNach : integer;
                         x          : integer;
                         y          : integer        ) : integer;
  begin
    { Wenn man noch in die Richtung gehen kann }
    if x < 6 then
      begin

        { In die Richtung gehen }
        x := x + 1;

        { Wenn das Feld auf die Suche passt }
        if Spielfeld[y,x] = SuchenNach then
          { Punkte setzten und weitergucken }
          GoRechts := 1 + GoRechts(Spielfeld, SuchenNach, x, y)

        { Sonst 0 als Punkt geben }
        else
          GoRechts := 0;
      end

    { Wenn man nicht mehr weitergehen kann }
    else
      begin

        { Passt das feld auf die Suche !? }
        if Spielfeld[y,x] = SuchenNach then
          { Einen Punkte geben }
          GoRechts := 1

        { Sonst keinen Punkt geben }
        else
          GoRechts := 0;
      end;
  end;

  {~~~~~~~~~~~~~~~~~~~~~~~~~}
  {~ <- ~ Nach Links Suchen }
  {~~~~~~~~~~~~~~~~~~~~~~~~~}
  Function GoLinks (var Spielfeld  : SpielfeldArray;
                    var SuchenNach : integer;
                        x          : integer;
                        y          : integer        ) : integer;
  begin
    { Wenn man noch in die Richtung gehen kann }
    if x > 1 then
      begin

        { In die Richtung gehen }
        x := x - 1;

        { Wenn das Feld auf die Suche passt }
        if Spielfeld[y,x] = SuchenNach then
          { Punkte setzten und weitergucken }
          GoLinks := 1 + GoLinks(Spielfeld, SuchenNach, x, y)

        { Sonst 0 als Punkt geben }
        else
          GoLinks := 0;
      end

    { Wenn man nicht mehr weitergehen kann }
    else
      begin

        { Passt das feld auf die Suche !? }
        if Spielfeld[y,x] = SuchenNach then
          { Einen Punkte geben }
          GoLinks := 1

        { Sonst keinen Punkt geben }
        else
          GoLinks := 0;
      end;
  end;

  {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
  {~ \ ~ Diagonal nach Links Suchen }
  {          ++  NACH OBEN ++       }
  {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
  Function DiaLinksUp (var Spielfeld  : SpielfeldArray;
                       var SuchenNach : integer;
                           x          : integer;
                           y          : integer        ) : integer;
  begin
    { Wenn man noch in die Richtung gehen kann }
    if (x > 1) and (y > 1) then
      begin

        { In die Richtung gehen }
        x := x - 1;
        y := y - 1;

        { Wenn das Feld auf die Suche passt }
        if Spielfeld[y,x] = SuchenNach then
          { Punkte setzten und weitergucken }
          DiaLinksUp := 1 + DiaLinksUp(Spielfeld, SuchenNach, x, y)

        { Sonst 0 als Punkt geben }
        else
          DiaLinksUp := 0;
      end

    { Wenn man nicht mehr weitergehen kann }
    else
      begin

        { Passt das feld auf die Suche !? }
        if Spielfeld[y,x] = SuchenNach then
          { Einen Punkte geben }
          DiaLinksUp := 1

        { Sonst keinen Punkt geben }
        else
          DiaLinksUp := 0;
      end;
  end;

  {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
  {~ \ ~ Diagonal nach Links Suchen }
  {          ++ NACH UNTEN ++       }
  {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
  Function DiaLinksDown (var Spielfeld  : SpielfeldArray;
                         var SuchenNach : integer;
                             x          : integer;
                             y          : integer        ) : integer;
  begin
    { Wenn man noch in die Richtung gehen kann }
    if (x < 7) and (y < 6) then
      begin

        { In die Richtung gehen }
        x := x + 1;
        y := y + 1;

        { Wenn das Feld auf die Suche passt }
        if Spielfeld[y,x] = SuchenNach then
          { Punkte setzten und weitergucken }
          DiaLinksDown := 1 + DiaLinksDown(Spielfeld, SuchenNach, x, y)

        { Sonst 0 als Punkt geben }
        else
          DiaLinksDown := 0;
      end

    { Wenn man nicht mehr weitergehen kann }
    else
      begin

        { Passt das feld auf die Suche !? }
        if Spielfeld[y,x] = SuchenNach then
          { Einen Punkte geben }
          DiaLinksDown := 1

        { Sonst keinen Punkt geben }
        else
          DiaLinksDown := 0;
      end;
  end;

  {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
  {~ / ~ Diagonal nach Rechts Suchen }
  {          ++ NACH OBEN ++         }
  {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
  Function DiaRechtsUp (var Spielfeld  : SpielfeldArray;
                        var SuchenNach : integer;
                            x          : integer;
                            y          : integer        ) : integer;
  begin
    { Wenn man noch in die Richtung gehen kann }
    if (x < 7) and (y < 1) then
      begin

        { In die Richtung gehen }
        x := x + 1;
        y := y - 1;

        { Wenn das Feld auf die Suche passt }
        if Spielfeld[y,x] = SuchenNach then
          { Punkte setzten und weitergucken }
          DiaRechtsUp := 1 + DiaRechtsUp(Spielfeld, SuchenNach, x, y)

        { Sonst 0 als Punkt geben }
        else
          DiaRechtsUp := 0;
      end

    { Wenn man nicht mehr weitergehen kann }
    else
      begin

        { Passt das feld auf die Suche !? }
        if Spielfeld[y,x] = SuchenNach then
          { Einen Punkte geben }
          DiaRechtsUp := 1

        { Sonst keinen Punkt geben }
        else
          DiaRechtsUp := 0;
      end;
  end;

  {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
  {~ / ~ Diagonal nach Rechts Suchen }
  {          ++ NACH UNTEN ++        }
  {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
  Function DiaRechtsDown (var Spielfeld  : SpielfeldArray;
                          var SuchenNach : integer;
                              x          : integer;
                              y          : integer        ) : integer;
  begin
    { Wenn man noch in die Richtung gehen kann }
    if (x > 1) and (y < 6) then
      begin

        { In die Richtung gehen }
        x := x - 1;
        y := y + 1;

        { Wenn das Feld auf die Suche passt }
        if Spielfeld[y,x] = SuchenNach then
          { Punkte setzten und weitergucken }
          DiaRechtsDown := 1 + DiaRechtsDown(Spielfeld, SuchenNach, x, y)

        { Sonst 0 als Punkt geben }
        else
          DiaRechtsDown := 0;
      end

    { Wenn man nicht mehr weitergehen kann }
    else
      begin

        { Passt das feld auf die Suche !? }
        if Spielfeld[y,x] = SuchenNach then
          { Einen Punkte geben }
          DiaRechtsDown := 1

        { Sonst keinen Punkt geben }
        else
          DiaRechtsDown := 0;
      end;
  end;
  {+++++++++++++++++++++++++++++++++++++++++++++++++++++}
  {+                                                   +}
  {+ FUNKTIONSBLOCK ENDE                               +}
  {+                                                   +}
  {+++++++++++++++++++++++++++++++++++++++++++++++++++++}

  {~~~~~~~~~~~~~~~~~~~~}
  { Spielfeld Bewerten }
  {~~~~~~~~~~~~~~~~~~~~}
  Procedure FeldBewertung (var Bewertungsfeld : SpielfeldArray;
                           var Spielfeld      : SpielfeldArray;
                               GegenSpieler   : integer;
                           var Spieler        : integer        );
  var x        : 1..7;    { x Koordinate }
      y        : 1..6;    { y Koordinate }
      Ergebnis : 0..30;   { Punkte ergebnis }
  begin

    { Spielfeld durchgehen }
    for y := 6 downto 1 do
      begin
        for x := 7 downto 1 do
          begin
            { Feld auf 0 Setzen }
            Bewertungsfeld[y,x] := 0;

            { Wenn das Feld besetzt ist... }
            if Spielfeld[y,x] <> 0 then
              Bewertungsfeld[y,x] := -5;

            { Bewertet wird ausgehend von leeren Feldern }
            if Spielfeld[y,x] = 0 then
              begin
                {#################################################################}
                {# AUFBAU ERKLÄRUNG:                                             #}
                {# *****************                                             #}
                {#                                                               #}
                {# Punkte = Suchen ( In welchem Array Suchen?, Nach was Suchen?, #}
                {#                   Koordinate X und Koordinate y)              #}
                {#                                                               #}
                {# Bei 3 Punkte ergit das Feld einen Gewinner!                   #}
                {#   ==> Das Feld *HOCH* bewerten                                #}
                {#                                                               #}
                {#################################################################}
                {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
                { Leere Felder bekommen eh 1 Punkt }
                {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
                Bewertungsfeld[y,x] := 1;

                {++++++++++++++++++++++++++++++++++++++++++++++++}
                {++                                            ++}
                {++ NACH GEGNERSTEINEN SUCHEN - GEGNER BLOCKEN ++}
                {++                                            ++}
                {++++++++++++++++++++++++++++++++++++++++++++++++}
                {~~~~~~~~~~~~~~~~~~~}
                { Nach Unten Testen }
                {~~~~~~~~~~~~~~~~~~~}
                Ergebnis := GoDown        (Spielfeld, GegenSpieler, x, y);
                if Ergebnis = 2 then Ergebnis := 5 ; { 1 Stein  Gefunden }
                if Ergebnis = 3 then Ergebnis := 10; { 2 Steine Gefunden }
                if Ergebnis = 4 then Ergebnis := 25; { 3 Steine Gefunden }
                Bewertungsfeld[y,x] := Bewertungsfeld[y,x] + Ergebnis;

                {~~~~~~~~~~~~~~~~~~~}
                { Nach Links Testen }
                {~~~~~~~~~~~~~~~~~~~}
                Ergebnis := GoLinks       (Spielfeld,GegenSpieler, x, y);
                if Ergebnis = 2 then Ergebnis := 5 ; { 1 Stein  Gefunden }
                if Ergebnis = 3 then Ergebnis := 10; { 2 Steine Gefunden }
                if Ergebnis = 4 then Ergebnis := 25; { 3 Steine Gefunden }
                Bewertungsfeld[y,x] := Bewertungsfeld[y,x] + Ergebnis;

                {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
                { Nach Diagonal Links Hoch Testen }
                {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
                Ergebnis := DiaLinksUp    (Spielfeld,GegenSpieler, x, y);
                if Ergebnis = 2 then Ergebnis := 5 ; { 1 Stein  Gefunden }
                if Ergebnis = 3 then Ergebnis := 10; { 2 Steine Gefunden }
                if Ergebnis = 4 then Ergebnis := 25; { 3 Steine Gefunden }
                Bewertungsfeld[y,x] := Bewertungsfeld[y,x] + Ergebnis;

                {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
                { Nach Diagonal Links Unten Testen }
                {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
                Ergebnis := DiaLinksDown  (Spielfeld, GegenSpieler, x, y);
                if Ergebnis = 2 then Ergebnis := 5 ; { 1 Stein  Gefunden }
                if Ergebnis = 3 then Ergebnis := 10; { 2 Steine Gefunden }
                if Ergebnis = 4 then Ergebnis := 25; { 3 Steine Gefunden }
                Bewertungsfeld[y,x] := Bewertungsfeld[y,x] + Ergebnis;

                {~~~~~~~~~~~~~~~~~~~~}
                { Nach Rechts Testen }
                {~~~~~~~~~~~~~~~~~~~~}
                Ergebnis := GoRechts      (Spielfeld, GegenSpieler, x, y);
                if Ergebnis = 2 then Ergebnis := 5 ; { 1 Stein  Gefunden }
                if Ergebnis = 3 then Ergebnis := 10; { 2 Steine Gefunden }
                if Ergebnis = 4 then Ergebnis := 25; { 3 Steine Gefunden }
                Bewertungsfeld[y,x] := Bewertungsfeld[y,x] + Ergebnis;

                {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
                { Nach Diagonal Rechts Hoch Testen }
                {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
                Ergebnis := DiaRechtsUp   (Spielfeld, GegenSpieler, x, y);
                if Ergebnis = 2 then Ergebnis := 5 ; { 1 Stein  Gefunden }
                if Ergebnis = 3 then Ergebnis := 10; { 2 Steine Gefunden }
                if Ergebnis = 4 then Ergebnis := 25; { 3 Steine Gefunden }
                Bewertungsfeld[y,x] := Bewertungsfeld[y,x] + Ergebnis;

                {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
                { Nach Diagonal Rechts Unten Testen }
                {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
                Ergebnis := DiaRechtsDown (Spielfeld, GegenSpieler, x, y);
                if Ergebnis = 2 then Ergebnis := 5 ; { 1 Stein  Gefunden }
                if Ergebnis = 3 then Ergebnis := 10; { 2 Steine Gefunden }
                if Ergebnis = 4 then Ergebnis := 25; { 3 Steine Gefunden }
                Bewertungsfeld[y,x] := Bewertungsfeld[y,x] + Ergebnis;


                {++++++++++++++++++++++++++++++++++}
                {++                              ++}
                {++ NACH EIGENEN STEINEN SUCHEN  ++}
                {++                              ++}
                {++++++++++++++++++++++++++++++++++}
                {~~~~~~~~~~~~~~~~~~~}
                { Nach Unten Testen }
                {~~~~~~~~~~~~~~~~~~~}
                Ergebnis := GoDown        (Spielfeld, Spieler, x, y);
                if Ergebnis = 2 then Ergebnis := 0 ; { 1 Stein  Gefunden }
                if Ergebnis = 3 then Ergebnis := 10 ; { 2 Steine Gefunden }
                if Ergebnis = 4 then Ergebnis := 30; { 3 Steine Gefunden }
                Bewertungsfeld[y,x] := Bewertungsfeld[y,x] + Ergebnis;

                {~~~~~~~~~~~~~~~~~~~}
                { Nach Links Testen }
                {~~~~~~~~~~~~~~~~~~~}
                Ergebnis := GoLinks       (Spielfeld, Spieler, x, y);
                if Ergebnis = 2 then Ergebnis := 0 ; { 1 Stein  Gefunden }
                if Ergebnis = 3 then Ergebnis := 10 ; { 2 Steine Gefunden }
                if Ergebnis = 4 then Ergebnis := 30; { 3 Steine Gefunden }
                Bewertungsfeld[y,x] := Bewertungsfeld[y,x] + Ergebnis;

                {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
                { Nach Diagonal Links Hoch Testen }
                {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
                Ergebnis := DiaLinksUp    (Spielfeld, Spieler, x, y);
                if Ergebnis = 2 then Ergebnis := 0 ; { 1 Stein  Gefunden }
                if Ergebnis = 3 then Ergebnis := 10 ; { 2 Steine Gefunden }
                if Ergebnis = 4 then Ergebnis := 30; { 3 Steine Gefunden }
                Bewertungsfeld[y,x] := Bewertungsfeld[y,x] + Ergebnis;

                {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
                { Nach Diagonal Links Unten Testen }
                {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
                Ergebnis := DiaLinksDown  (Spielfeld, Spieler, x, y);
                if Ergebnis = 2 then Ergebnis := 0 ; { 1 Stein  Gefunden }
                if Ergebnis = 3 then Ergebnis := 10 ; { 2 Steine Gefunden }
                if Ergebnis = 4 then Ergebnis := 30; { 3 Steine Gefunden }
                Bewertungsfeld[y,x] := Bewertungsfeld[y,x] + Ergebnis;

                {~~~~~~~~~~~~~~~~~~~~}
                { Nach Rechts Testen }
                {~~~~~~~~~~~~~~~~~~~~}
                Ergebnis := GoRechts      (Spielfeld, Spieler, x, y);
                if Ergebnis = 2 then Ergebnis := 0 ; { 1 Stein  Gefunden }
                if Ergebnis = 3 then Ergebnis := 10 ; { 2 Steine Gefunden }
                if Ergebnis = 4 then Ergebnis := 30; { 3 Steine Gefunden }
                Bewertungsfeld[y,x] := Bewertungsfeld[y,x] + Ergebnis;

                {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
                { Nach Diagonal Rechts Hoch Testen }
                {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
                Ergebnis := DiaRechtsUp   (Spielfeld, Spieler, x, y);
                if Ergebnis = 2 then Ergebnis := 0 ; { 1 Stein  Gefunden }
                if Ergebnis = 3 then Ergebnis := 10 ; { 2 Steine Gefunden }
                if Ergebnis = 4 then Ergebnis := 30; { 3 Steine Gefunden }
                Bewertungsfeld[y,x] := Bewertungsfeld[y,x] + Ergebnis;

                {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
                { Nach Diagonal Rechts Unten Testen }
                {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
                Ergebnis := DiaRechtsDown (Spielfeld, Spieler, x, y);
                if Ergebnis = 2 then Ergebnis := 0 ; { 1 Stein  Gefunden }
                if Ergebnis = 3 then Ergebnis := 10 ; { 2 Steine Gefunden }
                if Ergebnis = 4 then Ergebnis := 30; { 3 Steine Gefunden }
                Bewertungsfeld[y,x] := Bewertungsfeld[y,x] + Ergebnis;
              end;
          end;
        end;
  end;

  {~~~~~~~~~~~~~~~~~~~~~~~~~}
  { Beste Reihe Feststellen }
  {~~~~~~~~~~~~~~~~~~~~~~~~~}
  Function TopReihe(var Bewertungsfeld : SpielfeldArray) : integer;
  var Reihe  : 1..7;    { Die Reihe die die meisten Punkte hat }
      x      : 1..7;    { x Koordinate }
      y      : 1..6;    { y Koordinate }
      Punkte : integer; { Punktestand um das Feld mit den meisten Punkten zu bestimmen }
  begin
    { Variablen Initialisierung }
    Reihe  := 1;
    Punkte := 0;

    { Feld durchgehen }
    for y := 6 downto 1 do
      for x := 7 downto 1 do
        begin
          { Wenn die Punkte jetzt größer sind als die letzen}
          if Punkte < Bewertungsfeld[y,x] then
            begin
              { Punktestand (funktionsintern aktualisieren) ... }
              Punkte := Bewertungsfeld[y,x];
              { ... und aktuelle Reihe speichern }
              Reihe := x;
            end;
        end;

    { Beste Reihe zurückgeben }
    TopReihe := Reihe;
  end;

  {~~~~~~~~~~~~~~~~~~~~~~~~~}
  { Beste Zeile Feststellen }
  {~~~~~~~~~~~~~~~~~~~~~~~~~}
  Function TopZeile(var Bewertungsfeld : SpielfeldArray) : integer;
  var Zeile  : 1..7;    { Die Zeile die die meisten Punkte hat }
      x      : 1..7;    { x Koordinate }
      y      : 1..6;    { y Koordinate }
      Punkte : integer; { Punktestand um das Feld mit den meisten Punkten zu bestimmen }
  begin
    { Variablen Initialisierung }
    Zeile  := 1;
    Punkte := 0;

    { Feld durchgehen }
    for y := 6 downto 1 do
      for x := 7 downto 1 do
        begin
          { Wenn die Punkte jetzt größer sind als die letzen}
          if Punkte < Bewertungsfeld[y,x] then
            begin
              { Punktestand (funktionsintern aktualisieren) ... }
              Punkte := Bewertungsfeld[y,x];
              { ... und aktuelle Reihe speichern }
              Zeile := y;
            end;
        end;

    { Beste Reihe zurückgeben }
    TopZeile := Zeile;
  end;

  {~~~~~~~~~~~~~~~~~~}
  { Steuerung der KI }
  {~~~~~~~~~~~~~~~~~~}
  Function KiGo (var Spielfeld : SpielfeldArray;
                 var Spieler   : integer        ) : string;
  var Status         : string[20];     { Status der nachher zurückgegeben wird (ZugGemacht, SpielfeldVoll, ... }
      TZeile         : 1..7;           { Brauch ich nur weil die Zeile sonst zu lang ist *lol* }
      TReihe         : 1..7;           { Brauch ich nur weil die Zeile sonst zu lang ist *lol* }
      GegenSpieler   : 1..2;           { Der Gegenspieler -> zum Bewerten der Felder wichtig }
      Bewertungsfeld : SpielfeldArray; { Das Bewertungsfeld }
  begin
    {Variablen initialisieren }
    Status := 'OnTheRun'; { DAZED & CONFUSED 4 EVER ! +g+ }

    { GegenSpieler bestimmen }
    if Spieler = 1 then GegenSpieler := 2
    else                GegenSpieler := 1;

    { Spielfeld Bewerten lassen }
    FeldBewertung(Bewertungsfeld, Spielfeld, GegenSpieler, Spieler);

    { Solang das Spiel noch läuft (Stein nicht gesetzt) }
    while Status = 'OnTheRun' do
      begin
        if SpielfeldVoll(Spielfeld) = false then
          begin
            { Wenn man nicht in der ersten Zeile ist }
            if TopZeile(Bewertungsfeld)  < 6 then
              begin

                { Wenn man unter die beste stelle noch setzen kann... }
                if Spielfeld[(TopZeile(Bewertungsfeld) + 1),TopReihe(Bewertungsfeld)] = 0 then
                  begin

                    { .. einen Punkt abziehen und wieder von oben in die while .. }
                    TZeile := TopZeile(Bewertungsfeld);
                    TReihe := TopReihe(Bewertungsfeld);
                    Bewertungsfeld[TZeile,TReihe] := Bewertungsfeld[TZeile,TReihe] - 1;
                  end

                { Andernfalls den Stein setzen und die KI ist durch ^-^ }
                else
                  begin
                    Spielfeld[TopZeile(Bewertungsfeld),TopReihe(Bewertungsfeld)] := Spieler;
                    Status := 'ZugGemacht';
                  end;
              end

            { Ansonsten ist man schon unten }
            else
               begin
                { dann setzten und fertig ^-^ }
                Spielfeld[TopZeile(Bewertungsfeld),TopReihe(Bewertungsfeld)] := Spieler;
                Status := 'ZugGemacht';
              end;
           end

        { Ansonsten ist das Feld Voll }
        else
          Status := 'SpielfeldVoll';
      end;

    { Status Zurückgeben das die KI durch ist :) }
    KiGo := Status;
  end;

  {~~~~~~~~~~~~~~~~~~~~~~~~}
  { Hauptprogramm der Unit }
  {~~~~~~~~~~~~~~~~~~~~~~~~}
  begin
    { Leer da dashier nur die Auslagerung von Funktionen / Prozeduren ist +g+ }
  end.