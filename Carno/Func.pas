unit Func;

interface
    uses
        Windows, SysUtils, ATable, Terms;
    type
        Call_func = class (TObject)
        private
       //     nBits : integer;
            public
                function Add (var p : arrOfTerm; const t : Term) : arrOfTerm;
    end;

implementation

    function Call_func.Add (var p : arrOfTerm; const t : Term) : arrOfTerm;
        begin
            setLength (p, length(p) + 1);
            p[High(p)] := t;
            result := p; 
        end;

end.
