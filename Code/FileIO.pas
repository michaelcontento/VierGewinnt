{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
{+                                                                   +}
{+  Filename : FileIO.pas                                            +}
{+  Date     : 18.05.2004                                            +}
{+  Last Edit: 26.05.2004                                            +}
{+  Part of  : VierGewinnt in Pascal                                 +}
{+               Von Michael Contento und Florian Rubel              +}
{+                                                                   +}
{+  Author   : Michael Contento                                      +}
{+  Email    : MichaelContento (at) web (dot) de                     +}
{+                                                                   +}
{+                                                                   +}
{+  Info     : Alle Programteile die auf Dateien zugreifen.          +}
{+                                                                   +}
{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
Unit FileIO;

{~~~~~~~~~~~}
{ Interface }
{~~~~~~~~~~~}
Interface
  { Units      }
    Uses TypDef;

  { Type       }
    { Type  }

  { Konstanten }
    { Const }

  { Variablen  }
    { Var   }

  { Prozeduren / Funktionen }
    Procedure SaveGame     (var Spielfeld  : SpielfeldArray;
                            var Spielmodus : string;
                            var Spieler    : integer        );
    Function  LoadGame     (var SpielArt  : string;
                            var Spielfeld : SpielfeldArray;
                            var Spieler   : integer        ) : boolean;
    Procedure SaveHighscore(var Punkte   : integer;
                            var Gewinner : integer;
                            var SpielArt : string  );
    {Function  LoadHighscore(Zeile : integer)                : HighscoreStruktur;}

{~~~~~~~~~~~~~~~~}
{ Implementation }
{~~~~~~~~~~~~~~~~}
Implementation
   {~~~~~~~~~~~~~~~~~~~~~~}
   { Spielstand Speichern }
   {~~~~~~~~~~~~~~~~~~~~~~}
   Procedure SaveGame (var Spielfeld  : SpielfeldArray;
                       var Spielmodus : string;
                       var Spieler    : integer        );
   var SaveFile : text; { Datei die gespeichert wird ist eine textdatei :) }
       x        : 1..7; { x Koordinate }
       y        : 1..6; { y Koordinate }
   begin
     { File init }
     assign(SaveFile, 'Game.sav');
     rewrite(SaveFile);

     { Daten Schreiben }
     writeln(SaveFile, Spielmodus);
     writeln(SaveFile, Spieler);

     for y := 1 to 6 do
       for x := 1 to 7 do
         writeln(SaveFile, Spielfeld[y,x]);

     { SEHR wichtigen Info Block ans SaveGame anhängen! ;) }
     writeln(SaveFile, '------------------------------------------------------------------');
     writeln(SaveFile, '                                                                  ');
     writeln(SaveFile, 'VierGewinnt 2004 von Michael Contento (Core) & Florian Rubel (Gui)');
     writeln(SaveFile, '                 - Danke fürs Spielen :) -                        ');
     writeln(SaveFile, '                                                                  ');
     writeln(SaveFile, 'Denkt dran! Cheater haben einen kleinen (oder keinen) Schwanz! ;) ');
     writeln(SaveFile, '                                                                  ');
     writeln(SaveFile, '                                         www.dazed-confused.de.vu ');

     { File Close }
     Close(SaveFile);
   end;

   {~~~~~~~~~~~~~~~~~~}
   { Spielstand Laden }
   {~~~~~~~~~~~~~~~~~~}
   Function  LoadGame (var SpielArt  : string;
                       var Spielfeld : SpielfeldArray;
                       var Spieler   : integer        ) : boolean;
   var SaveFile : text; { Datei die gespeichert wird ist eine textdatei :) }
       x        : 1..7; { x Koordinate }
       y        : 1..6; { y Koordinate }
   begin
     {$I-}
       { File init }
       assign(SaveFile, 'Game.sav');
       reset(SaveFile);

       { Daten Lesen }
       readln(SaveFile, SpielArt);
       readln(SaveFile, Spieler);

       for y := 1 to 6 do
         for x := 1 to 7 do
           readln(SaveFile, Spielfeld[y,x]);

       { File Close }
       Close(SaveFile);
     {$I+}

     { Wenn die Datei nicht existiert fehler ausgeben }
     if IOResult <> 0 then LoadGame := false
     else                  LoadGame := true;
   end;

   {~~~~~~~~~~~~~~~~~~~~~}
   { Highscore Speichern }
   {~~~~~~~~~~~~~~~~~~~~~}
   Procedure SaveHighscore (var Punkte   : integer;
                            var Gewinner : integer;
                            var SpielArt : string  );
   var SaveFile   : file of HighscoreStruktur;
       Highscore  : HighscoreStruktur;
   begin
     { Nur wenn ein Mensch mitspielt kommts in die Liste }
     if SpielArt <> 'ComputerVsComputer' then
       begin
         { File init }
         assign(SaveFile, 'Score.sav');
         {$I-}
           reset(SaveFile);
         {$I+}

         { Wann das öffnen fehlschlug neu erstellen }
         if IOResult <> 0 then
           rewrite(SaveFile);

         { Daten zum schreiben festlegen }
         Highscore.Punkte   := Punkte;   { Punkte   }
         Highscore.Gewinner := Gewinner; { Gewinner }
         Highscore.SpielArt := SpielArt; { Spielart }

         { Daten schreiben und zugriff beenden }
         write(SaveFile, Highscore);
         close(SaveFile);
       end;
   end;

   {~~~~~~~~~~~~~~~~~}
   { Highscore Laden }
   {~~~~~~~~~~~~~~~~~}
   {Function  LoadHighscore (Zeile : integer) : HighscoreStruktur;
   {var SaveFile  : file of HighscoreStruktur;
   {    Highscore : HighscoreStruktur;
   {begin
   {  {$I-}
   {    { File Init }
   {    assign(SaveFile, 'Score.sav');
   {    reset(SaveFile);
   {
   {    { Gewünschten eintrag suchen }
   {    seek(SaveFile, (Zeile - 1)); { Zeile - 1 weil seek bei 0 anfängt und nich bei 1 }
   {
   {    { Daten einlesen }
   {    read(SaveFile, Highscore);
   {
   {    { Datei schließen }
   {    close(SaveFile);
   {  {$I+}
   {
   {  { Wenns es einen Fehler gab "leer" zurückgeben }
   {  if IOResult <> 0 then
   {    begin
   {      Highscore.Punkte   := 0;
   {      Highscore.Gewinner := 0;
   {      Highscore.SpielArt := 'Leer';
   {    end;
   {
   {  { Und das feld zurückgeben }
   {  LoadHighscore := Highscore;
   {end;

  {~~~~~~~~~~~~~~~~~~~~~~~~}
  { Hauptprogramm der Unit }
  {~~~~~~~~~~~~~~~~~~~~~~~~}
  begin
    { Leer da dashier nur die Auslagerung von Funktionen / Prozeduren ist +g+ }
  end.
