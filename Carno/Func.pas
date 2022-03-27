unit Func;

interface
uses
  Windows, SysUtils, ATable, Terms;
type
  Call_method = class (TObject)
public
    class procedure Add (var p : arrOfTerm; const t : Term);
    class function  Delete_dups (var p : arrOfTerm) : arrOfTerm;
    class function  IsIn (const p : arrOfTerm; const t : Term) : boolean;
end;

implementation

    class procedure Call_method.Add (var p : arrOfTerm; const t : Term);
       begin
          setLength (p, length(p) + 1);
          p[High(p)] := t;
        end;

    class function  Call_method.IsIn (const p : arrOfTerm; const t : Term) : boolean;
       var
            i : cardinal;
       begin
            result := false;
            i := 0;
            while (i < length(p)) do begin
                if (p[i].Find_dnf = t.Find_dnf) then result := true;
                inc (i);
            end; 
       end;

    class function Call_method.Delete_dups (var p : arrOfTerm) : arrOfTerm;
       var
            temp : arrOfTerm;
            i : cardinal;
       begin
            //minimaizing of terms
            for i := Low(p) to High(p) do
                if (not p[i].Get_splice) then Call_method.Add(temp, p[i]);

            SetLength (p,0);
                
            for i := Low(temp) to High(temp) do
                if (not Call_method.IsIn(p, temp[i])) then Call_method.Add(p, temp[i]);
            result := p;
       end;


end.


