function x_CO2_x_H2 = g_conversion_Fcn(z, u, Global)
%--------------------------------------------------------------------------

    FCO2_in = Global.FCO2_in;
    FH2_in  = Global.FH2_in;

%--------------------------------------------------------------------------

    FCO2_z = u(:,1);
    FH2_z  = u(:,2);

%--------------------------------------------------------------------------

    X_CO2 = (FCO2_in - FCO2_z)./FCO2_in;
    X_H2  = (FH2_in - FH2_z)./FH2_in;

    x_CO2_x_H2 = [z, X_CO2, X_H2];

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

                    plot(z,X_CO2,'-*','MarkerSize',MZ1);
                    plot(z,X_H2,'-o','MarkerSize',MZ1);
    
                xlabel('$z\;\left( {m} \right)$',...
                       'FontSize',XLFZ,'interpreter','Latex')
                ylabel('$X_{i}$',...
                       'FontSize',YLFZ,'interpreter','Latex') 
    
                ley1 = {'$X_{C{O_2}}$','$X_{H_2}$'};
                legend(ley1,'Interpreter','Latex','Location','north',   ...
                            'Orientation','horizontal','FontSize',LFZ)
            hold off

        dir1 = strcat(dir,'/','Xi_', num2str(Global.ID));
        % print(fig1,'-dpdf','-r500',dir1)
    close all

end

