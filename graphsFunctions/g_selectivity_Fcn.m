function s_CH3OH = g_selectivity_Fcn(z, u, Global)
%--------------------------------------------------------------------------

    FCO2_in = Global.FCO2_in;

%--------------------------------------------------------------------------
    
    FCO2_z   = u(:,1);
    FCH3OH_z = u(:,3);

%--------------------------------------------------------------------------

    S_CH3OH = FCH3OH_z./(FCO2_in - FCO2_z);
    S_CH3OH(isnan(S_CH3OH)) = 0;

    s_CH3OH = [z, S_CH3OH];

%--------------------------------------------------------------------------
    FZ1  = 14;
    MZ1  = 3;
    XLFZ = 14;
    YLFZ = 14;
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

                    plot(z,S_CH3OH,'-*','MarkerSize',MZ1);
    
                xlabel('$z\;\left( {m} \right)$',...
                       'FontSize',XLFZ,'interpreter','Latex')
                ylabel('$S_{CH_{3}OH}$',...
                       'FontSize',YLFZ,'interpreter','Latex') 
    
            hold off

        dir1 = strcat(dir,'/','SCH3OH_', num2str(Global.ID));
        % print(fig1,'-dpdf','-r500',dir1)
    close all

end

