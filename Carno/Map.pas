unit Map;

interface
  uses
    sysutils, carno;
  type

   Cmap = class (TObject)
      public
        constructor create   (min, dont : tb);
        function    graycode (trm : integer) : tb;
      private
   end;

implementation
  uses
      Terms;
   var
      t   : Term;
      nbits : integer;
      col, row    : string;
      minterm, empty, grayrow, graycol : tb;
  constructor Cmap.create (min, dont : tb);
      var
          table_name   : string;
          i   : integer;
      begin
          col := '';
          row := '';
          minterm  := copy (min);
          empty := copy (dont);
          nbits := t.Get_nBits;
          for i := 0 to (nbits div 2) - 1 do begin
              col := col + char(ord('A') + i);
          end;
          for i := 1 to (nbits + 1) div 2 do begin
              row := row + char (ord(col[length(col)]) + i);
          end;

          carno.form1.maptable.rowcount :=  1 shl (nbits div 2) + 1;
          carno.form1.maptable.colcount := (1 shl nbits) div (carno.form1.maptable.rowcount - 1) + 1;

          carno.form1.maptable.colwidths [0] := 10*(nbits + 1);

          carno.form1.maptable.cells [0,0] := col + '/' + row;

        {
          rect := carno.form1.maptable.cellrect(0,0);
          rect.left   := rect.left   + carno.form1.maptable.left;
          rect.right  := rect.right  + carno.form1.maptable.left;
          rect.top    := rect.top    + carno.form1.maptable.top;
          rect.bottom := rect.bottom + carno.form1.maptable.top;

          carno.form1.row_name.left    := rect.left + 1;
          carno.form1.row_name.top     := rect.top + carno.form1.maptable.rowheights [0] div 2 + 1;
          carno.form1.row_name.width   := rect.right - rect.left + 1;
          carno.form1.row_name.height  := rect.bottom - carno.form1.row_name.top + 1;
          carno.form1.row_name.visible := true;
          carno.form1.row_name.setfocus;}

          graycol := graycode (nbits div 2);
          grayrow := graycode (nbits - nbits div 2);
          i:= 0;
          while (i <= length (graycol) - 1) do begin
            table_name := inttostr (graycol[i]);
            while (length(table_name) < length(col)) do begin
                table_name := '0' + table_name;
            end;
            carno.form1.maptable.cells[0, i + 1] := table_name;
            inc (i);
          end;
          i := 0;
          while (i <= length (grayrow) - 1) do begin
            table_name := inttostr (grayrow[i]);
            while (length(table_name) < length(row)) do begin
                table_name := '0' + table_name;
            end;
            carno.form1.maptable.cells[i + 1,0] := table_name;
            inc (i);
          end;
    end;

  function Cmap.graycode (trm : integer) : tb;
      var
          code    : tb;
          i : integer;
      begin
          setlength (code, 1 shl trm);
          i := 0;
          while (i < 1 shl trm) do begin
              code [i] := i xor (i shr 1);
              inc (i);
          end;
          for i := 0 to length(code)-1 do begin
            code [i] := t.Get_Binary (code[i]);
          end;
          result := code;
      end;



end.

