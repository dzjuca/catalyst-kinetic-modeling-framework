function [r1, r2, r3] = reactionVelocityFcn(Global, u)
%--------------------------------------------------------------------------
    constants   = kineticConstantsFcn(Global);

    k1 = constants.k1;
    k2 = constants.k2;
    k3 = constants.k3;

    KCO  = constants.KCO;
    KCO2 = constants.KCO2;
    KH2O_KH2 = constants.KH2O_KH2;

    KP1 = constants.KP1;
    KP2 = constants.KP2;
    KP3 = constants.KP3;
%--------------------------------------------------------------------------
    pp     = partialPressureFcn(u);
    PCO2   = pp.PCO2;
    PH2    = pp.PH2;
    PCH3OH = pp.PCH3OH;
    PCO    = pp.PCO;
    PH2O   = pp.PH2O;
%--------------------------------------------------------------------------
    tmp_1 = k1*KCO;
    tmp_2 = (1 + KCO*PCO + KCO2*PCO2)*((PH2)^(0.5) + KH2O_KH2*PH2O);
    tmp_3 = ((PCO*(PH2)^(1.5)) - (PCH3OH/(PH2^(0.5)*KP1)));
    r1    = (tmp_1/tmp_2)*tmp_3;
%--------------------------------------------------------------------------
    tmp_1 = k2*KCO2;
    tmp_3 = ((PCO2*PH2) - ((PH2O*PCO)/(KP2)));
    r2    = (tmp_1/tmp_2)*tmp_3;
%--------------------------------------------------------------------------
    tmp_1 = k3*KCO2;
    tmp_3 = ((PCO2*(PH2)^(1.5)) - ((PCH3OH*PH2O)/((PH2^(1.5))*KP3)));
    r3    = (tmp_1/tmp_2)*tmp_3;
%--------------------------------------------------------------------------
    r1(isnan(r1) | isinf(r1) | ~isreal(r1)) = 0;
    r2(isnan(r2) | isinf(r2) | ~isreal(r2)) = 0;
    r3(isnan(r3) | isinf(r3) | ~isreal(r3)) = 0;
%--------------------------------------------------------------------------
end