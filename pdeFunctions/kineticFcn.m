function kinetic = kineticFcn(Global, u, id)
% -------------------------------------------------------------------------

    [r1, r2, r3] = reactionVelocityFcn(Global, u);

% -------------------------------------------------------------------------
    if     strcmp(id, 'CO2')
            kinetic = -r2 - r3;
    elseif strcmp(id, 'H2')
            kinetic = -2*r1 - r2 - 3*r3;
    elseif strcmp(id, 'CH3OH')
            kinetic = r1 + r3;
    elseif strcmp(id, 'CO')
            kinetic = -r1 + r2;
    elseif strcmp(id, 'H2O')
            kinetic = r2 + r3;
    elseif strcmp(id, 'N2')
            kinetic = 0;
    else
           disp('CineticaFcn.m error')
    end  
% -------------------------------------------------------------------------
end