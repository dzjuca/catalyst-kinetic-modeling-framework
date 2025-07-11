function [a, ghsv_1_ref, x_GHSV] = x_ghsv_Fcn(z, u, Global)

%--------------------------------------------------------------------------

    T         = Global.T;
    P         = Global.P;
    R         = Global.R_1;
    X_CO2_exp = Global.X_CO2_exp;
    ghsv_exp  = Global.GHSV_exp;


    FacConv_1 = R*T/P; % Factor Convertion                     [m3 / 1 mol]
    FacConv_2 = (P/1.01325)*(273.15/T);

%--------------------------------------------------------------------------

    FCO2_in   = Global.FCO2_in;
    FH2_in    = Global.FH2_in;

%--------------------------------------------------------------------------

    FCO2_z    = u(:,1);
    FH2_z     = u(:,2);

    X_CO2     = (FCO2_in - FCO2_z)./FCO2_in;
    X_H2      = (FH2_in  - FH2_z) ./FH2_in;
    y_lim_max = max(X_CO2(end), X_CO2_exp);

%--------------------------------------------------------------------------

    FH2_FCO2_in = FCO2_in + FH2_in;           %                  [mol/m2.s]
    FH2_FCO2_in = FH2_FCO2_in*3600*FacConv_1; %                   [m3/m2.h]
    FH2_FCO2_in = FH2_FCO2_in*FacConv_2;      %               [m3 STP/m2.h]
    ghsv        = FH2_FCO2_in./z;             %                       [h-1]
    ghsv_1      = (ghsv).^(-1);               %                         [h]

    x_GHSV   = [ghsv, ghsv_1, X_CO2, X_H2];

%--------------------------------------------------------------------------

    if X_CO2(end) > X_CO2_exp

            [fitresult_1, gof_1] = createFit(X_CO2, ghsv_1);

    else
        
            [fitresult_1, gof_1] = createFit(X_CO2(2:end), ghsv_1(2:end));


    end


%--------------------------------------------------------------------------

    % [fitresult_1, gof_1] = createFit(X_CO2, ghsv_1);
    ghsv_1_exp           = ghsv_exp^(-1);


    if X_CO2(end) > X_CO2_exp

        ghsv_1_ref = fitresult_1(X_CO2_exp);
        line_y_ref = ghsv_1_ref*ones(size(X_CO2));
        % a        = ghsv_1_exp/ghsv_1_ref;
          a        = ghsv_1_ref/ghsv_1_exp;

    else

        ghsv_1_ref = NaN;
        a = NaN;

    end


%--------------------------------------------------------------------------

    line_x_exp = X_CO2_exp   * ones(size(ghsv_1)); 
    line_y_exp = ghsv_1_exp  * ones(size(X_CO2));

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

                plot(ghsv_1, line_x_exp, 'k-.');
                plot(line_y_exp, X_CO2, 'b-.');

                if X_CO2(end) > X_CO2_exp

                     plot(line_y_ref, X_CO2,  'r-.');

                end 

%--------------------------------------------------------------------------
                p = plot(ghsv_1, X_CO2,'-*','MarkerSize',MZ1);
    
                xlabel('$\frac{1}{GHSV}$',...
                       'FontSize',XLFZ,'interpreter','Latex')
                ylabel('$X_{CO_2}$',...
                       'FontSize',YLFZ,'interpreter','Latex') 

                ylim([0, y_lim_max*1.2])
                x_lim = xlim; 
                y_lim = ylim; 
                
                x_center = (x_lim(1) + x_lim(2));
                y_center = (y_lim(1) + y_lim(2));

                if X_CO2(end) > X_CO2_exp

                    txt_1 = '$a=\\frac{GHSV_ {r}^{-1}}{GHSV_{i}^{-1}}=\\frac{%.2e}{%.2e}=%.2f$';
                    txt_2 = sprintf(txt_1', ghsv_1_ref,  ghsv_1_exp, a);
                else

                    txt_2 = '$X_{CO_{2}-exp}>X_{CO_{2}-ref}$';

                end

                text(x_center*0.5, y_center*0.3, txt_2, ...
                         'HorizontalAlignment', 'center',     ...
                         'VerticalAlignment', 'middle', ...
                         'Interpreter', 'latex');

                txt_3 = [Global.Reference, ', ', ...
                         Global.Catalyst];

                text(x_center*0.5, y_center*0.2, txt_3, ...
                         'HorizontalAlignment', 'center',     ...
                         'VerticalAlignment', 'middle');

            hold off

        dir1 = strcat(dir, '/', num2str(Global.ID), '_x_GHSV');
        print(fig1,'-dpdf','-r500',dir1)
    close all


end