function [s, S_CH3OH_ref, s_x] = s_x_Fcn(z, u, Global)
%--------------------------------------------------------------------------

    FCO2_in     = Global.FCO2_in;
    FH2_in      = Global.FH2_in;
    X_CO2_exp   = Global.X_CO2_exp;
    S_CH3OH_exp = Global.S_CH3OH_exp;

%--------------------------------------------------------------------------

    FCO2_z   = u(2:end,1);
    FH2_z    = u(2:end,2);
    FCH3OH_z = u(2:end,3);

%--------------------------------------------------------------------------

    X_CO2 = (FCO2_in - FCO2_z)./FCO2_in;
    X_H2  = (FH2_in - FH2_z)./FH2_in;


    S_CH3OH = FCH3OH_z./(FCO2_in - FCO2_z);
    S_CH3OH(isnan(S_CH3OH)) = 0;
    S_CH3OH(isinf(S_CH3OH)) = 0;



    s_x       = [X_CO2, X_H2, S_CH3OH];
    y_lim_max = max(max(S_CH3OH),S_CH3OH_exp);
    y_lim_min = min(S_CH3OH);

%--------------------------------------------------------------------------
%xxxxx

% Crear la matriz combinada para los pares [X_CO2, S_CH3OH]
data = [X_CO2(:), S_CH3OH(:)];

% Par a verificar
checkPair = [0, 0];

% Verificar si el par existe
if ~ismember(checkPair, data, 'rows')
    % Si no existe, agregarlo
    data = [checkPair; data];
end

% Separar de nuevo en vectores si es necesario
X_CO2 = data(:, 1);
S_CH3OH = data(:, 2);

%xxxxx

    % [fitresult_1, gof_2] = createFit(S_CH3OH, X_CO2);
    [fitresult_1, ~] = createFit(X_CO2, S_CH3OH);

    if X_CO2(end) > X_CO2_exp

        S_CH3OH_ref = fitresult_1(X_CO2_exp);
        s           = S_CH3OH_exp/S_CH3OH_ref;

    else

        S_CH3OH_ref = NaN;
        s           = NaN;

    end
    
%--------------------------------------------------------------------------
    line_y_exp = X_CO2_exp   * ones(size(S_CH3OH));
    line_x_exp = S_CH3OH_exp * ones(size(X_CO2)); 
    line_x_ref = S_CH3OH_ref * ones(size(X_CO2));
    

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
    FZ1  = 14;
    MZ1  = 3;
    XLFZ = 14;
    YLFZ = 14;
    LFZ  = 5; % LEYNEDA
    M = {'-o','-s','-p','-*','-h','-d'};
%--------------------------------------------------------------------------

    id = exist('results','file');
        if id == 7
           dir = strcat(pwd,'/','results');
        else
            mkdir('results')
           dir = strcat(pwd,'/','results');
        end

        fig1 = figure;
        set(fig1,'Units','centimeters',...
               'PaperPosition',[0 0 15 15],...
               'PaperSize', [15,15]);
        axes('Parent',fig1,'FontSize',FZ1,'XGrid','off',...
                'YGrid','off','visible','on','Box', 'on',...
                'TickLabelInterpreter','latex');
                set(fig1, 'Color', 'w') 

            hold on

%--------------------------------------------------------------------------

                plot(line_y_exp, S_CH3OH,  'k-.');
                plot(X_CO2, line_x_exp, 'b-.');
      
                if X_CO2(end) > X_CO2_exp
                    
                    plot(X_CO2, line_x_ref, 'r-.');

                end 

%--------------------------------------------------------------------------

                plot(X_CO2(1:end),S_CH3OH(1:end),'-*','MarkerSize',MZ1);
    
                xlabel('$X_{CO_2}$',...
                       'FontSize',XLFZ,'interpreter','Latex')
                ylabel('$S_{CH_{3}OH}$',...
                       'FontSize',YLFZ,'interpreter','Latex') 

%                 ylim([y_lim_min, y_lim_max*1.02])
               ylim([0, y_lim_max*1.02])
%--------------------------------------------------------------------------

                x_lim = xlim; 
                y_lim = ylim; 
                
                x_center   = (x_lim(1) + x_lim(2))/2;
                diff_y_lim = abs(y_lim(1) - y_lim(2));

                if X_CO2(end) > X_CO2_exp

                    txt_1 = '$s=\\frac{S_{CH_{3}OH-i}}{S_{CH_{3}OH-r}}=\\frac{%.3e}{%.3e}=%.3f$';
                    txt_2 = sprintf(txt_1', S_CH3OH_exp, S_CH3OH_ref, s);
                else

                    txt_2 = '$X_{CO_{2}-exp}>X_{CO_{2}-ref}$';

                end

                text(x_center, y_lim(1) + diff_y_lim*0.3, txt_2, ...
                         'HorizontalAlignment', 'center',     ...
                         'VerticalAlignment', 'middle', ...
                         'Interpreter', 'latex');

                txt_3 = [Global.Reference, ', ', ...
                         Global.Catalyst];

                text(x_center, y_lim(1) + diff_y_lim*0.2, txt_3, ...
                         'HorizontalAlignment', 'center',     ...
                         'VerticalAlignment', 'middle');

%--------------------------------------------------------------------------

            hold off

        dir1 = strcat(dir,'/', num2str(Global.ID),'_s_XCO2');
        print(fig1,'-dpdf','-r500',dir1)
    close all

end