% ----------| Main Program |-----------------------------------------------
%     Chemical Engineering Department
%     University of Zaragoza
%     Author: Daniel Zambrano Juca
% ------------------------ | init | ---------------------------------------
    close all
    clear
    clear Iterations
    clc
    format shortG
% ---------- global constants ---------------------------------------------
load('dataCat.mat')
[m, n] = size(dataCat);

% Inicializa una tabla vacía
resultsTable = table();

for i = 1:m
% -------------------------------------------------------------------------

    ref_cat = table2array(dataCat(i,["REF","CAT"]));
    data    = table2array(dataCat(i,["ID", "PMPa","TC", ...
                                           "RH2_CO2", "GHSVh1", ...
                                           "X",   "S"]));

% ------------------------------------------------------------------------- 
    if any(isnan(data))

        a          = NaN;
        s          = NaN;
        K_eq_T     = NaN;
        K_eq_Aprox = NaN;
        K_eq_R     = NaN;

    else

        [a, s, K_eq_T, K_eq_Aprox, K_eq_R] = catPerfEvalFcn(ref_cat, data);

    end
% -------------------------------------------------------------------------
    newRow = table(K_eq_T, K_eq_Aprox, K_eq_R, a, s, 'VariableNames', ...
                   {'K_eq_T', 'K_eq_Aprox', 'K_eq_R' ,'Activity','Selectivity'});
    resultsTable = [resultsTable; newRow];

end

% -------------------------------------------------------------------------

    combinedTable = horzcat(dataCat, resultsTable);

% -------------------------------------------------------------------------
    writetable(combinedTable, 'results.xlsx');
% -------------------------------------------------------------------------
