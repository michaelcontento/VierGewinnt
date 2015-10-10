{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
{+                                                                   +}
{+  Filename : Game.pas                                              +}
{+  Date     : 14.04.2004                                            +}
{+  Last Edit: 26.05.2004                                            +}
{+  Part of  : VierGewinnt in Pascal                                 +}
{+               Von Michael Contento und Florian Rubel              +}
{+                                                                   +}
{+  Author   : Michael Contento                                      +}
{+  Email    : MichaelContento (at) web (dot) de                     +}
{+                                                                   +}
{+                                                                   +}
{+  Info     : Steuerung und Koordination des Spielablaufes der      +}
{+             einzelnen Spielmodi.                                  +}
{+                                                                   +}
{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
Unit Game;

{~~~~~~~~~~~}
{ Interface }
{~~~~~~~~~~~}
Interface
  { Units      }
    Uses crt, Core, Ki, InOut, TypDef, FileIO;

  { Type       }
    { Type  }

  { Konstanten }
    { Const }

  { Variablen  }
    { Var   }

  { Prozeduren / Funktionen }
    Procedure Spielen(SpielArt : string);

{~~~~~~~~~~~~~~~~}
{ Implementation }
{~~~~~~~~~~~~~~~~}
Implementation

  {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
  { Koordination des Spielablaufes }
  {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
  Procedure Spielen (SpielArt : string);
  var                                      { ## Normale Variablen ## }
      AktuellerSpieler : integer;          { Der Aktuelle Spieler }
      x                : 1..7;             { x Koordinate des Spielfeldes }
      y                : 1..6;             { y Koordinate des Spielfeldes }
      Spielfeld        : SpielfeldArray;   { Spielfeld }
      SpielDran        : boolean;          { Ist das Spiel noch am Laufen? }
      ZugGemacht       : boolean;          { Ist der Aktuelle Zug gemacht gemacht worden? }
      Punkte           : integer;          { Punkte die das Spiel nachher erreicht hat (für Highscore) }

                                           { ## Return Variablen ## }
      SpielerRead      : 0..10;            { Return vom SpielerEinlesen }
      SetzVersuch      : string[20];       { Return vom SetzVersuch (ZugGemacht, SpielfeldVoll, ...) }

                                           { ## Variablen für die KI ## }
      ErsterStein      : 0..7;             { Poistionen für die ersten Steinen }
      KiAnfang         : 0..2;             { Welcher Spieler Anfangen darf }

  begin
    { Variablen Initialisierung }
    AktuellerSpieler := 1;
    SpielDran        := true;
    ZugGemacht       := false;

    { Spielfeld auf 0 setzen }
     for y := 6 downto 1 do
       for x := 7 downto 1 do
         Spielfeld[y,x] := 0;

    { Wenn die Highscore angezeigt werden soll }
    if SpielArt = 'Highscore' then
      {ShowHighscore}
    else
      begin
        { Wenn ein Spiel geladen werden soll Default werte ändern }
        if SpielArt = 'LoadGame' then
          begin
            { Wenn das Savegame nicht vorhanden ist fehler ausgeben }
            if LoadGame (SpielArt, Spielfeld, AktuellerSpieler) = false then
              ErrorNoSaveGame;
          end;

        {~~~~~~~~~~~~~~~~~~~~~}
        { Mensch gegen Mensch }
        {~~~~~~~~~~~~~~~~~~~~~}
        if SpielArt = 'MenschVsMensch' then
          begin

            { Solang das Spiel noch dran ist }
            while SpielDran = true do
              begin
                { Spielfeld Zeichnen (AktuellerSpieler für die Anzeige Oben) }
                SpielfeldZeichnen(Spielfeld, AktuellerSpieler);

                { Spieler Einlesen }
                SpielerRead := SpielerEinlesen;

                { Wenn gespeichert werden soll }
                if SpielerRead = 8 then  { 8 -> Taste 's' }
                  begin
                    { SaveGame Schreiben }
                    SaveGame(Spielfeld, SpielArt, AktuellerSpieler);

                    { Info Ausgeben und Spiel abbrechen }
                    GameSavedInfo;
                    Spieldran := false;
                  end;

                { Wenn das Spiel abgebrochen werden soll }
                if SpielerRead = 9 then  { 9 -> Taste 'x' }
                  begin
                    Spieldran := false;
                  end

                { Sonst sollte nicht gespeichert werden... }
                else
                  { Und der Stein wird gesetzt :) }
                  SetzVersuch := SteinSetzen(Spielfeld, SpielerRead, AktuellerSpieler);

                  { SetzVersuch Auswerten }
                  { ~~~~~~~~~~~~~~~~~ }
                  { Wenn der Zug gemacht wurde }
                  if SetzVersuch = 'ZugGemacht' then
                    begin

                  { Wenn der Spieler mit dem Zug nicht Gewinnt, User wechseln }
                  if GewinnCheck(Spielfeld, AktuellerSpieler) = false then
                    begin
                      if AktuellerSpieler = 1 then AktuellerSpieler := 2
                      else                         AktuellerSpieler := 1;
                    end

                  { Sonnst Gewinner Ausgeben }
                  else
                    begin
                      SpielDran := false;
                      GewinnerAusgabe(Spielfeld, AktuellerSpieler);
                    end;
                end

              { Sonst Rückgaben Auswerten }
              else
                begin
                  { Wenn das Feld Voll war }
                  if SetzVersuch = 'SpielfeldVoll' then
                    begin
                      SpielDran := false;
                      ErrorFeldVoll (Spielfeld, AktuellerSpieler);
                    end;

                  { Wenn Reihe Voll war }
                  if SetzVersuch = 'ReiheVoll' then
                    begin
                      ErrorSpalteVoll (Spielfeld, AktuellerSpieler);
                    end;
                end;
            end;
          end;

        {~~~~~~~~~~~~~~~~~~~~~~~~~~~}
        { Bei Mensch gegen Computer }
        {~~~~~~~~~~~~~~~~~~~~~~~~~~~}
        if SpielArt = 'MenschVsComputer' then
          begin

            { Solang das Spiel noch dran ist }
            while SpielDran = true do
              begin
                { Spielfeld Zeichnen (AktuellerSpieler für die Anzeige Oben) }
                SpielfeldZeichnen(Spielfeld, AktuellerSpieler);

                { Zug Machen... }
                if AktuellerSpieler = 1 then
                  begin
                    { Spieler Einlesen }
                    SpielerRead := SpielerEinlesen;

                    { Wenn gespeichert werden soll }
                    if SpielerRead = 8 then  { 8 -> Taste 's' }
                      begin
                        { SaveGame Schreiben }
                        SaveGame(Spielfeld, SpielArt, AktuellerSpieler);

                        { Info Ausgeben und Spiel abbrechen }
                        GameSavedInfo;
                        Spieldran := false;
                      end;

                    { Wenn das Spiel abgebrochen werden soll }
                    if SpielerRead = 9 then  { 9 -> Taste 'x' }
                      begin
                        Spieldran := false;
                      end

                    { Sonst sollte nicht gespeichert werden... }
                    else
                      begin
                        { Und der Stein wird gesetzt :) }
                        SetzVersuch := SteinSetzen(Spielfeld, SpielerRead, AktuellerSpieler);
                      end;
                  end
                { Bzw von der KI berechnen lassen... }
                else
                  SetzVersuch := KiGo(Spielfeld, AktuellerSpieler);

                { SetzVersuch Auswerten }
                { ~~~~~~~~~~~~~~~~~~~~~ }
                { Wenn der Zug gemacht wurde }
                if SetzVersuch = 'ZugGemacht' then
                  begin

                    { Wenn der Spieler mit dem Zug nicht Gewinnt, User wechseln }
                    if GewinnCheck(Spielfeld, AktuellerSpieler) = false then
                      begin
                        if AktuellerSpieler = 1 then AktuellerSpieler := 2
                        else                         AktuellerSpieler := 1;
                      end

                    { Sonnst Gewinner Ausgeben }
                    else
                      begin
                        SpielDran := false;
                        GewinnerAusgabe(Spielfeld, AktuellerSpieler);
                      end;
                  end

                { Sonst Rückgaben Auswerten }
                else
                  begin
                    { Wenn das Feld Voll war }
                    if SetzVersuch = 'SpielfeldVoll' then
                      begin
                        SpielDran := false;
                        ErrorFeldVoll (Spielfeld, AktuellerSpieler);
                      end;

                    { Wenn Reihe Voll war }
                    if SetzVersuch = 'ReiheVoll' then
                      begin
                        ErrorSpalteVoll (Spielfeld, AktuellerSpieler);
                      end;
                  end;
              end;
          end;

        {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
        { Bei Computer gegen Computer }
        {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
        if SpielArt = 'ComputerVsComputer' then
          begin

            { Wenn KiAnfang auf 2 steht geht das Spiel erst richtig los}
            KiAnfang         := 0;
            AktuellerSpieler := 0;

            { Also erst 2 Steine Random setzen }
            while KiAnfang <> 2 do
              begin
                { Solang die Position 0 ergibt neue Zahl generieren }
                ErsterStein := 0;
                while ErsterStein = 0 do
                  ErsterStein := random (7);

                { Spieler festlegen }
                if AktuellerSpieler = 1 then AktuellerSpieler := 2
                else                         AktuellerSpieler := 1;

                { Stein dan ins Feld setzen }
                Spielfeld[6,ErsterStein] := AktuellerSpieler;

                { Ki Anfang erhöhen und Spielfeld zeichnen }
                KiAnfang := KiAnfang + 1;
                SpielfeldZeichnen(Spielfeld, AktuellerSpieler);
              end;

            { Solang das Spiel noch dran ist }
            while SpielDran = true do
              begin
                { Etwas warten damit man das Spiel Verfolgen kann }
                delay(400);

                { Spielfeld Zeichnen (AktuellerSpieler für die Anzeige Oben) }
                SpielfeldZeichnen(Spielfeld, AktuellerSpieler);

                { Zug Machen... }
                SetzVersuch := KiGo(Spielfeld, AktuellerSpieler);

                { ... und Auswerten }
                { ~~~~~~~~~~~~~~~~~ }
                { Wenn der Zug gemacht wurde }
                if SetzVersuch = 'ZugGemacht' then
                  begin

                    { Wenn der Spieler mit dem Zug nicht Gewinnt, User wechseln }
                    if GewinnCheck(Spielfeld, AktuellerSpieler) = false then
                      begin
                        if AktuellerSpieler = 1 then AktuellerSpieler := 2
                        else                         AktuellerSpieler := 1;
                      end

                    { Sonnst Gewinner Ausgeben }
                    else
                      begin
                        SpielDran := false;
                        GewinnerAusgabe(Spielfeld, AktuellerSpieler);
                      end;
                  end

                { Sonst Rückgaben Auswerten }
                else
                  begin
                    { Wenn das Feld Voll war }
                    if SetzVersuch = 'SpielfeldVoll' then
                      begin
                        { Spiel abbrechen und Meldung Ausgeben }
                        SpielDran := false;
                        ErrorFeldVoll (Spielfeld, AktuellerSpieler);
                      end;
                  end;
              end;
          end;
        { Highscore erstellen / erweitern }
        Punkte := GetScore(Spielfeld, AktuellerSpieler);
        SaveHighscore(Punkte, AktuellerSpieler, SpielArt);
      end;
  end;

  {~~~~~~~~~~~~~~~~~~~~~~~~}
  { Hauptprogramm der Unit }
  {~~~~~~~~~~~~~~~~~~~~~~~~}
  begin
    { Leer da dashier nur die Auslagerung von Funktionen / Prozeduren ist +g+ }
  end.
