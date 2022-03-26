program dkd;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var
    n, i : Cardinal;
    bit_count : cardinal;
begin
    bit_count := 0;
    i := 0;
    n := 255;
    while (n <> 0) do begin
        if ( (n and (1 shl 0) ) = (1 shl 0) ) then inc (bit_count);
                n := n shr 1;
        inc (i);
    end;
    writeln (bit_count);
    readln;
end.
