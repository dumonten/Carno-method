program Cover;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const
        dontCare : array [0..3] of boolean = (false, true, false, false);
var
    mask : Integer;
    i, b    : ShortInt;
    n, value : ShortInt;
    ans : boolean;
begin
    //0101
    //01-1
    //n - тот, кого покрываем
    //value - тот, кто покрывает
    n := 7;
    value := 5;
    mask := 0;
    for  i := 0 to 3 do begin
        if (not DontCare[i]) then mask := 1 shl i + mask;
    end;
    writeln (mask);
    readln;
end.
