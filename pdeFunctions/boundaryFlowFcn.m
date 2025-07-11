function Global = boundaryFlowFcn(Global, factor)

      GHSV                 = Global.GHSV;
      z_id_ratio           = Global.z_id_ratio;
      r_id                 = Global.r_id;
      PRESSURE             = Global.P;
      TEMPERATURE          = Global.T;
      UNIVERSAL_CONSTANT_1 = Global.R_1;
      H2_CO2_ratio         = Global.H2_CO2_ratio;

      if factor >= 1

          GHSV = GHSV*factor;

      else

          GHSV = GHSV*(1 - factor);

      end

      z             = (z_id_ratio*r_id);%                               [m]
      area          = pi*(r_id/2)^2;    %                              [m2]
      V_reactor     = z*area;         %                                [m3]
      FTotal_STP_in = GHSV*V_reactor; %                          [m3 STP/h]

      FacConv_1       = (1.01325/PRESSURE)*(TEMPERATURE/273.15);
      FacConv_2     = (UNIVERSAL_CONSTANT_1*TEMPERATURE/PRESSURE);%[m3/mol]

      FTotal_in     = FTotal_STP_in*FacConv_1;%                      [m3/h]
      FTotal_in     = FTotal_in/FacConv_2;    %                     [mol/h]

      FCO2_in       = FTotal_in/(H2_CO2_ratio + 1);%                [mol/h]
      FH2_in        = FTotal_in - FCO2_in;         %                [mol/h]

      FCO2_mol_in   = FCO2_in/3600;%                                [mol/s]
      FH2_mol_in    = FH2_in/3600; %                                [mol/s]

      FCO2_in       = FCO2_mol_in/(area);          %             [mol/m2.s]
      FH2_in        = FH2_mol_in/(area);           %             [mol/m2.s]
      FN2_in        = 0.00;                        %             [mol/m2.s]


      Global.area       = area; 
      Global.FCO2_in    = FCO2_in;
      Global.FH2_in     = FH2_in;
      Global.FN2_in     = FN2_in;
      Global.z          = z;
      Global.GHSV       = GHSV;




end