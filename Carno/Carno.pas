unit Carno;

interface

uses
  windows, messages, sysutils, variants, classes, graphics, controls, forms,
  dialogs, stdctrls, extctrls, grids;

type
      tb = array of word;
      ta = array [1..2] of tb;
      tform1 = class(tform)
          ttable: tstringgrid;
          start: tbutton;
          varcount: tradiogroup;
      maptable: TStringGrid;
          funcvalue: tcombobox;
          col_name: tstatictext;
          row_name: tstatictext;
          procedure formcreate(sender: tobject);
          procedure varcountclick(sender: tobject);
          procedure ttableselectcell(sender: tobject; acol, arow: integer; var canselect: boolean);
          procedure funcvalueexit(sender: tobject);
          procedure startclick(sender: tobject);
      private
        { private declarations }
      public
        { public declarations }
      end;

    var
      form1: tform1;

    implementation

    {$r *.dfm}
    uses
      Map, Atable, Terms;


    procedure tform1.formcreate(sender: tobject);
      begin
          ttable.defaultrowheight := funcvalue.height;
          funcvalue.visible := false;
          col_name.visible := false;
          row_name.visible := false;
      end;

    procedure tform1.varcountclick(sender: tobject);
      var
          i, j, n, t: word;
          trm : Term;
      begin
        randomize;
        with ttable do
          for i := 0 to colcount-1 do
              for j := 0 to rowcount-1 do
                  cells[i, j] := '';
        ttable.cells[0,0] := 'Минтермы';
        if (varcount.itemindex = 0) then n := random (7) + 2
          else n := varcount.itemindex + 1;
        {!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!}
        trm.Set_nBits(n);
        ttable.rowcount := round (exp(ln(2)*n)) + 1;
        ttable.cells[1,0] := 'A  B ';
        for  i := 3 to n do ttable.cells[1,0]:= ttable.cells[1,0] + chr(ord('A') + i - 1) + '  ';
        for  i := 0 to (1 shl n) - 1 do begin
          ttable.cells [0, i + 1] := inttostr (i);
          ttable.cells [2, i + 1] := '0';
          t := i;
          for j := 1 to n do begin
              ttable.cells [1, i + 1] := inttostr(t mod 2)+ '  ' + ttable.cells [1, i + 1];
              t := t div 2;
          end;
        end;
    end;

    procedure tform1.TTableselectcell(sender: tobject; acol, arow: integer; var canselect: boolean);
      var
          r: trect;
      begin
      if ((acol = 2) and (arow <> 0)) then
        begin
           r := ttable.cellrect(acol, arow);
           r.left   := r.left   + ttable.left;
           r.right  := r.right  + ttable.left;
           r.top    := r.top    + ttable.top;
           r.bottom := r.bottom + ttable.top;

           funcvalue.left    := r.left + 1;
           funcvalue.top     := r.top  + 1;
           funcvalue.width   := (r.right  + 1) - r.left;
           funcvalue.height  := (r.bottom + 1) - r.top;
           funcvalue.visible := true;
           funcvalue.setfocus;
           canselect := true;
          end;
       end;


    procedure tform1.funcvalueexit(sender: tobject);
      begin
        ttable.cells[ttable.col, ttable.row] := funcvalue.items[funcvalue.itemindex];
        funcvalue.visible := false;
        ttable.setfocus;
      end;

    procedure tform1.startclick(sender: tobject);
      var
        i : word;
        a       : ta;
        cm1     : cmap;
        p       : pat;
      begin
        for i := 1  to ttable.rowcount do begin
          if (ttable.cells[2, i] = '1') then begin
              setlength(a[1], length(a[1])+1);
              a[1][high(a[1])] := i-1;
          end
          else if (ttable.cells[2, i] = 'x') then begin
              setlength (a[2], length(a[2])+1);
              a[2][high(a[2])] := i-1;
          end;
        end;
        cm1 := cmap.create(a[1], a[2]);
        p   := pat.create (a[1], a[2]);



      end;
end.

