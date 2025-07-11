function constants = kineticConstantsFcn(Global)
%--------------------------------------------------------------------------
    R     = Global.R_2;
    T     = Global.T;
    T_ref = Global.T_ref;

    k1_0  = Global.k1_0;
    Ea_1  = Global.Ea_1;
    k2_0  = Global.k2_0;
    Ea_2  = Global.Ea_2;
    k3_0  = Global.k3_0;
    Ea_3  = Global.Ea_3;

    KCO_0      = Global.KCO_0;
    DH_CO      = Global.DH_CO;
    KCO2_0     = Global.KCO2_0;
    DH_CO2     = Global.DH_CO2;
    KH2O_KH2_0 = Global.KH2O_KH2_0;
    DH_H2O_H2  = Global.DH_H2O_H2;

    a1 = 7.44140E+4;
    a2 = 1.89260E+2; 
    a3 = 3.2443E-2;
    a4 = 7.0432E-6; 
    a5 = -5.6053E-9; 
    a6 = 1.0344E-12;
    a7 = -6.4364E+1;

    b1 = -3.94121E+4; 
    b2 = -5.41516E+1; 
    b3 = -5.5642E-2; 
    b4 = 2.5760E-5; 
    b5 = -7.6594E-9; 
    b6 = 1.0161E-12; 
    b7 = 1.8429E+1;

%--------------------------------------------------------------------------
    k1 = k1_0*exp(((1/T) - (1/T_ref))*(Ea_1/R));
    k2 = k2_0*exp(((1/T) - (1/T_ref))*(Ea_2/R));
    k3 = k3_0*exp(((1/T) - (1/T_ref))*(Ea_3/R));

    KCO  = KCO_0*exp(((1/T)  - (1/T_ref))*(DH_CO/R));
    KCO2 = KCO2_0*exp(((1/T) - (1/T_ref))*(DH_CO2/R));
    KH2O_KH2 = KH2O_KH2_0*exp(((1/T) - (1/T_ref))*(DH_H2O_H2/R));

    KP1 = exp((a1+a2*T+a3*T^2+a4*T^3+a5*T^4+a6*T^5+a7*T*log(T))/(R*T));
    KP2 = exp((b1+b2*T+b3*T^2+b4*T^3+b5*T^4+b6*T^5+b7*T*log(T))/(R*T));
    KP3 = KP1*KP2;
%--------------------------------------------------------------------------
    constants.k1 = k1;
    constants.k2 = k2;
    constants.k3 = k3;

    constants.KCO  = KCO;
    constants.KCO2 = KCO2;
    constants.KH2O_KH2 = KH2O_KH2;

    constants.KP1 = KP1;
    constants.KP2 = KP2;
    constants.KP3 = KP3;
%--------------------------------------------------------------------------
end