{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
{+                                                                   +}
{+  Filename : TypDef.pas                                            +}
{+  Date     : 14.05.2004                                            +}
{+  Last Edit: 25.05.2004                                            +}
{+  Part of  : VierGewinnt in Pascal                                 +}
{+               Von Michael Contento und Florian Rubel              +}
{+                                                                   +}
{+  Author   : Michael Contento                                      +}
{+  Email    : MichaelContento (at) web (dot) de                     +}
{+                                                                   +}
{+                                                                   +}
{+  Info     : Typendefinition des Spielfeldes                       +}
{+                                                                   +}
{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
Unit TypDef;

{~~~~~~~~~~~}
{ Interface }
{~~~~~~~~~~~}
Interface
  { Units      }
    { Uses  }

  { Type       }
    Type SpielfeldArray    = array[1..6,1..7] of integer;
         HighscoreStruktur = record
                               Punkte    : integer;
                               Gewinner  : integer;
                               SpielArt  : string[20];
                             end;

  { Konstanten }
    { Const }

  { Variablen  }
    { Var   }

  { Prozeduren / Funktionen }
    { ...   }

{~~~~~~~~~~~~~~~~}
{ Implementation }
{~~~~~~~~~~~~~~~~}
Implementation

  {~~~~~~~~~~~~~~~~~~~~~~~~}
  { Hauptprogramm der Unit }
  {~~~~~~~~~~~~~~~~~~~~~~~~}
  begin
    { Leer da das hier nur die Auslagerung von Funktionen / Prozeduren ist +g+ }
  end.
