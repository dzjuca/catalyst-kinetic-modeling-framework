function uz = odeFcn(z,u,Global)
% -------------------------------------------------------------------------
    % odeFcn define the ODEs for the numerical solution with MatLab Solvers 
    % ----------------------------| input |--------------------------------
    %       z = interval of integration, specified as a vector
    %       u = time-dependent terms, specified as a vector
    %  Global = constant values structure 
    % ----------------------------| output |-------------------------------
    %      uz =  space-dependent terms variation, specified as a vector
    % ---------------------------------------------------------------------
% --------------------| constants values |---------------------------------
    ncall    = Global.iterations;
    rho_cat  = Global.rho_cat;
    E_t      = Global.E_t;
    u(u < 0) = 0;
%--------------------------------------------------------------------------
    dfCO2_dz   = rho_cat*E_t*kineticFcn(Global, u, 'CO2');
    dfH2_dz    = rho_cat*E_t*kineticFcn(Global, u, 'H2');
    dfCH3OH_dz = rho_cat*E_t*kineticFcn(Global, u, 'CH3OH');
    dfCO_dz    = rho_cat*E_t*kineticFcn(Global, u, 'CO');
    dfH2O_dz   = rho_cat*E_t*kineticFcn(Global, u, 'H2O');
    dfN2_dz    = rho_cat*E_t*kineticFcn(Global, u, 'N2');
    dP_dz      = pressureFcn(Global, u);
% --------------------| Spatial Variation Vector dzdt |--------------------
    uz = [dfCO2_dz; dfH2_dz; dfCH3OH_dz; dfCO_dz; dfH2O_dz; dfN2_dz;dP_dz];
% --------------------| Number Calls To pdeFcn |---------------------------
    disp([ncall.getNcall, z]);
    ncall.incrementNcall();
%--------------------------------------------------------------------------
end