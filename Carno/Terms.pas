unit Terms;

interface
  uses
    Windows, Messages, SysUtils, Carno, Map;

  type
    Term = class (TObject)
      private
        splice   : boolean;
        perf_monomial : cardinal;
        arr_gap  : array of boolean;
        arr_bit  : array of boolean;
        bitCount : cardinal;
        dnf, knf : string;
        gapCount : cardinal;
      public
        constructor Create  (const bit : word); overload;
        constructor Create  (const t1, t2 : Term); overload;
        
        procedure Set_nBits (const n : word);
        function  Get_nBits : word;
        property  Bits : word read Get_nBits write Set_nBits;

        procedure Set_splice;
        function  Get_splice : boolean;

        function  Find_number : word; 
        function  Get_bitAmount (const value : word) : cardinal;
        function  Get_gapAmount : cardinal;
        function  Get_Binary (const value : word)    : cardinal;
        function  Find_dnf  : string;
        function  Find_knf  (const dnf : string)  : string;
        function  Join_with (const t2 : Term)     : boolean;
        function  Overlay (const n : word) : boolean;
   end;

implementation
    var
            nBits    : word;

    constructor Term.Create(const bit : word);
        var
            i : cardinal;
        begin
            SetLength (arr_bit, nBits);
            SetLength (arr_gap, nBits);
            bitCount := 0;
            perf_monomial := bit;
            for i := low (arr_bit) to high(arr_bit) do begin
                arr_bit[i] := (perf_monomial and (1 shl i)) = (1 shl i);
                if (arr_bit[i]) then inc(bitCount);
                arr_gap[i] := false;
            end;

            gapCount := Get_gapAmount;
            splice := false;
            dnf := Find_dnf;
            knf := Find_knf (dnf);
        end;

    procedure Term.Set_splice;
        begin
            splice := true;
        end;

    function Term.Get_splice : boolean;
        begin
            result := splice;
        end;


    constructor Term.Create(const t1, t2 : Term);
        var
                i: cardinal;
        begin
            bitCount := 0;
            SetLength (arr_bit, nBits);
            SetLength (arr_gap, nBits);
            for i := Low(arr_gap) to High(arr_gap) do begin
              if  (t1.arr_gap[i]) then arr_gap[i] := true
                else arr_gap[i] := t1.arr_bit[i] xor t2.arr_bit[i];
              if (not arr_gap[i]) then arr_bit[i] := t1.arr_bit[i]
                else arr_bit[i] := false;
              if arr_bit[i] then inc (bitCount);
            end;

            t1.Set_splice;
            t2.Set_splice;

            perf_monomial := Find_number;
            splice := false;
            gapCount := Get_gapAmount;
            dnf := Find_dnf;
            knf := Find_knf(dnf);

        end;

    function Term.Find_number : word;
        var
            res : word;
            i : cardinal;
        begin
            res := 0;
            for i:= Low(arr_bit) to High(arr_bit) do begin
                if (arr_bit[i]) then res := 1 shl i + res;
            end;
            result := res;
        end;

    function  Term.Get_nBits : word;
        begin
            result := nBits;
        end;


    procedure Term.Set_nBits(const n : word);
        begin
           nBits := n;
        end;


    function  Term.Get_Binary (const value : word) : cardinal;
        var
            n   : word;
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
            i   : cardinal;
            dnf : string;
        begin
            {arr_bit}
            dnf := '';
            for i := Low(arr_bit) to High (arr_bit) do
                if (not arr_gap[nBits-i-1]) then
                    if (arr_bit[nBits-i-1]) then dnf := dnf + char (ord('A') + i)
                        else dnf := dnf + char (ord('a') + i);
            result := dnf;
        end;


    function Term.Find_knf (const dnf : string) : string;
        var
            i   : cardinal;
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
        var
            i : cardinal;
        begin
            result := true;
            for i := Low(arr_gap) to High(arr_gap) do
                if (arr_gap[i] <> t2.arr_gap[i]) then result := false;
            if (Get_bitAmount(perf_monomial xor t2.perf_monomial) <> 1) then result := false;

        end;


    function Term.Get_bitAmount (const value : word) : cardinal;
        var
            temp   : word;
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



    function Term.Get_gapAmount : cardinal;
        var
            i      : word;
            amount : cardinal;
        begin
            amount := 0;
            for i := 0 to nBits-1 do
                if (arr_gap[i]) then inc (amount);
            result := amount;
        end;


   function Term.Overlay (const n : word) : boolean;
        var
            m, res: word;
            i: Integer;
        begin
            m := 0;
            for i := 0 to Length(arr_gap) - 1 do begin
                if (not arr_gap[i]) then m := 1 shl i + m;
            end;
            result := (m and n) = (m and perf_monomial);
        end;




end.
