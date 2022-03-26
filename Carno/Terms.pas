unit Terms;

interface
  uses
    Windows, Messages, SysUtils, Carno, Map;

  type
    Term = class (TObject)
      private
        perf_monomial : cardinal;
        arr_bit  : array of boolean;
        bitCount : cardinal;
        dnf, knf : string;
      public
        class var
          nBits : cardinal;
        constructor Create  (const bit : integer); overload;
        constructor Create  (const t1, t2 : Term); overload;
        function  Get_bitAmount (const value : cardinal) : cardinal;
        function  Get_Binary (const value : cardinal) : cardinal;
        function  Find_dnf  : string;
        function  Find_knf  (const dnf : string)  : string;
        function  Join_with (const t2 : Term) : boolean;
        class procedure Set_nBits (const n : integer);
        class function  Get_nBits : integer;
        property  Bits: integer read Get_nBits write Set_nBits;
   end;

implementation

    constructor Term.Create(const bit : integer);
        var
            i : cardinal;
        begin
            SetLength (arr_bit, nBits);
            bitCount := 0;
            perf_monomial := bit;
            for i := 0 to nBits - 2 do begin
                arr_bit[nBits - 2 - i] := (perf_monomial and (1 shl i)) = (1 shl i);
                if (arr_bit[i]) then inc(bitCount);
            end;

            dnf := Find_dnf;
            knf := Find_knf (dnf);
        end;

    constructor Term.Create(const t1, t2 : Term);
        begin

        end;


    function  Get_nBits : integer;
        begin
            result := nBits;
        end;


    procedure Set_nBits(const n : integer);
        begin
           nBits := n;
        end;


    function  Term.Get_Binary (const value : cardinal) : cardinal;
        var
            n   : cardinal;
            binary : string;
        begin
            result := 0;
            n := value;
            binary := '';
            while (n <> 0) do begin
              binary := inttostr (n mod 2) + binary;
              n := n shr 1;
            end;
            if (binary <> '') then result := strtoint(binary);
        end;

    function Term.Find_dnf : string;
        var
            i : cardinal;
            dnf : string;
        begin
            {arr_bit}
            dnf := '';
            for i := 0 to nbits - 2 do
                if (arr_bit[i]) then dnf := dnf + char (ord('A') + i)
                    else dnf := dnf + char (ord('a') + i);
            result := dnf;
        end;


    function Term.Find_knf (const dnf : string) : string;
        var
            i   : integer;
            knf : string;
        begin
            {dnf}
            knf := '(';
            i := 1;
            while (i <= length(dnf)) do begin
               knf := knf + char (ord(dnf[i]) xor 32) + ' + ';
               inc (i);
            end;
            {knf}
            delete (knf, length(knf) - 2, 3);
            knf := knf + ')';
            result := knf;
        end;

    function  Term.Join_with (const t2 : Term) : boolean;
        begin
            result := false;
            if (Get_bitAmount(perf_monomial xor t2.perf_monomial) <> 1) then result := false;

        end;


    function Term.Get_bitAmount (const value : cardinal) : cardinal;
        var
            temp   : cardinal;
            amount : cardinal;
        begin
            amount := 0;
            temp := value;
            while (temp <> 0) do begin
                if ( (temp and (1 shl 0) ) = (1 shl 0) ) then inc (amount);
                temp := temp shr 1;
            end;
            result := amount;
        end;

end.
