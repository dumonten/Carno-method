unit ATable;
interface
    uses
        SysUtils, Carno, Terms;
    type
        arrOfTerm = array of Term;
        ttab = array of array of boolean;
        PAT  = class (TObject)
        private
            minterm, insignif : tb;
            emplicant : arrOfTerm;
            table : ttab;
        public
            constructor Create (const min, dont : TB); overload;
    //        constructor Create (const p : PAT); overload;
            function Set_Applicant : arrOfTerm;
    end;

implementation
    uses
        Func;

    constructor PAT.Create (const min, dont : TB);
        var
            i, j : cardinal;
        begin
            minterm := copy (min);
            insignif := copy (dont);
            emplicant := Set_Applicant;
            SetLength (table, length(emplicant), length(minterm));

            for i := Low(emplicant) to High(emplicant) do
               for j := Low(minterm) to High(minterm) do
                  table[i][j] := emplicant[i].Overlay(minterm[j]);
            SetLength (minterm,0);
        end;

   function PAT.Set_Applicant : arrOfTerm;
        var
            p : arrOfTerm;
            t, d_t : Term;
            i, j : integer;
        begin
            i := 0;
            while (i <= length(minterm)-1) do begin
                t := Term.Create (minterm[i]);
                Call_method.Add(p,t);
                inc (i);
            end;
            i := 0;
            while (i <= length(insignif)-1) do begin
                t := Term.Create (insignif[i]);
                Call_method.Add(p, t);
                inc (i);
            end;
            i := 0; j := 1;
            while (i <= length(p) - 1) do begin
                while (j <= length(p) - 1) do begin
                    if p[i].Join_with(p[j]) then begin
                        d_t := Term.Create (p[i], p[j]);
                        Call_method.Add (p, d_t);
                    end;
                    inc (j);
                end;
                inc (i);
                j := i + 1;
            end;

            p := Call_method.Delete_dups(p);
            result := p;
        end;
end.
