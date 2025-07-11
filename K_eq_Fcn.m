function [K_eq_T, K_eq_Aprox, K_eq_R] = K_eq_Fcn(z, u, Global)

    X          = Global.X_CO2_exp;
    S          = Global.S_CH3OH_exp;
    RH2CO2     = Global.H2_CO2_ratio;
    
    Y_CH3OH    = S*X/(RH2CO2 + 1 - 2*X*S);
    Y_H2O      = X/(RH2CO2 + 1 - 2*X*S);
    Y_CO2      = (1 - X)/(RH2CO2 + 1 - 2*X*S);
    Y_H2       = (RH2CO2 - (2*S + 1)*X)/(RH2CO2 + 1 - 2*X*S);
    PT         = u(end,end);
    
    constants  = kineticConstantsFcn(Global);
    K_eq_T     = constants.KP3;
    K_eq_Aprox = ((PT^2)*Y_CH3OH*Y_H2O)/((PT^4)*Y_CO2*Y_H2^3);
    K_eq_R     = K_eq_Aprox/K_eq_T;

end