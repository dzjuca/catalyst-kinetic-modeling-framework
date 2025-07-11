function u0 = initialConditionsFcn(Global)
% -------------------------------------------------------------------------
    % initialConditionsFcn set up the initial values of Fi
    % ----------------------------| input |--------------------------------
    %  Global = constant values structure 
    % ----------------------------| output |-------------------------------  
    %  u0     = initial conditions vector
% ------------------------------------------------------------------------- 
    FCO2   = Global.FCO2_in; %                                   [mol/m2.s]
    FH2    = Global.FH2_in;  %                                   [mol/m2.s]
    FCH3OH = 1e-6;           %                                   [mol/m2.s]
    FCO    = 1e-6;           %                                   [mol/m2.s]
    FH2O   = 1e-6;           %                                   [mol/m2.s]
    FN2    = Global.FN2_in;  %                                   [mol/m2.s]
    P      = Global.P;       %                                        [Bar]
% -------------------------------------------------------------------------
    u0     = [FCO2;FH2;FCH3OH;FCO;FH2O;FN2;P];
% ------------------------------------------------------------------------- 
end