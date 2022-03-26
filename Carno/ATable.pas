  unit ATable;
  interface
      uses
          SysUtils, Carno, Terms;
      type
          arrOfTerm = array of Term;
          PAT = class (TObject)
          public
              constructor Create (const min, dont : TB); overload;
              constructor Create (const p : PAT); overload;
              function Set_Applicant : arrOfTerm;
      end;

  implementation
      uses
          Func;
      var
          method : Call_func;
          minterm, insignif : tb;
          emplicant : arrOfTerm;

      constructor PAT.Create (const p : PAT);
          begin

          end;

      constructor PAT.Create (const min, dont : TB);
        //  var
          //    i : Cardinal;
          begin
              minterm := copy (min);
              insignif := copy (dont);
              emplicant := Set_Applicant;
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
                  p := method.Add(p,t);
                  inc (i);
              end;
              i := 0;
              while (i <= length(insignif)-1) do begin
                  t := Term.Create (insignif[i]);
                  p := method.Add(p, t);
                  inc (i);
              end;
              i := 0; j := 1;
              while (i <= length(p) - 1) do begin
                  while (j <= length(p) - 1) do begin
                      if p[i].Join_with(p[j]) then begin
                          d_t := Term.Create(p[i], p[j]);
                          p := method.Add(p, d_t);
                      end;
                      inc (j, i + 1);
                  end;
                  inc (i);
              end;
          end;
  end.
