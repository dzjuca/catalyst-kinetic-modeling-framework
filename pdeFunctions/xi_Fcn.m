function [X_CO2, X_H2] = xi_Fcn(z, u, Global)

    FCO2_in   = Global.FCO2_in;
    FH2_in    = Global.FH2_in;

    FCO2_z   = u(:,1);
    FH2_z    = u(:,2);

    X_CO2  = (FCO2_in - FCO2_z)./FCO2_in;
    X_H2   = (FH2_in  - FH2_z) ./FH2_in;

end