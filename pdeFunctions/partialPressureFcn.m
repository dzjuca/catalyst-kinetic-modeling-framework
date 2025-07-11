function partialPressure = partialPressureFcn(u)
%--------------------------------------------------------------------------
    FCO2   = u(1);
    FH2    = u(2);
    FCH3OH = u(3);
    FCO    = u(4);
    FH2O   = u(5);
    FN2    = u(6);
    P      = u(7);
%--------------------------------------------------------------------------
    F_total = FCO2 + FH2 + FCH3OH + FCO + FH2O + FN2;
%--------------------------------------------------------------------------
    PCO2    = P*(FCO2  /F_total);
    PH2     = P*(FH2   /F_total);
    PH2O    = P*(FH2O  /F_total);
    PCH3OH  = P*(FCH3OH/F_total);
    PCO     = P*(FCO   /F_total);
    PN2     = P*(FN2   /F_total);
    partialPressure.PCO2   = PCO2;
    partialPressure.PH2    = PH2;
    partialPressure.PH2O   = PH2O;
    partialPressure.PCH3OH = PCH3OH;
    partialPressure.PCO    = PCO;
    partialPressure.PN2    = PN2;
%--------------------------------------------------------------------------
end
