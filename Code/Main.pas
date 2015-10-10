program VierGewinnt;

uses crt,graph,game,InOut;

var
 hmreturn : integer; {Gibt das Ergebnis vom Hauptmenü an.}
 nsreturn : integer; {Gibt das Ergebnis vom Untermenü 'Neues Spiel' an.}
 sireturn : integer; {Gibt das Ergebnis vom Untermenü 'Spielinfos an.}

begin
  clrscr;
  start;
  grafikein(VGAlo,2,'');
  while hmreturn <> 5 do
   begin
    hmreturn := hauptmenu;
    if hmreturn = 1 then
       begin
         nsreturn :=NeuesSpiel;
         if nsreturn = 1 then
            begin
             {SpielfeldZeichnen(dummyarray,0);}
             SpielfeldHintergrund;
             spielen('MenschVsComputer');
            end;
         if nsreturn = 2 then
            begin
             {SpielfeldZeichnen(dummyarray,0);}
             SpielfeldHintergrund;
             spielen('MenschVsMensch');
            end;
         if nsreturn = 3 then
            begin
             {SpielfeldZeichnen(dummyarray,0);}
             SpielfeldHintergrund;
             spielen('ComputerVsComputer');
            end;
       end;
    if hmreturn = 2 then
      begin
       SpielfeldHintergrund;
       spielen('LoadGame');
      end;
    if hmreturn = 3 then {ShowHighscore};
    if hmreturn = 4 then
       begin
        sireturn := Spielinfo;
        if sireturn = 1 then spielanleitung;
        if sireturn = 2 then programminfos;
       end;
   end;{Schleife}
 closegraph;
end.