function g_pressure_Fcn(z, u, Global)
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

                plot(z,u(:,7),'-*','MarkerSize',MZ1);

                xlabel('$z\;\left( {m} \right)$',...
                       'FontSize',XLFZ,'interpreter','Latex')
                ylabel('$P\;(bar)$',...
                       'FontSize',YLFZ,'interpreter','Latex') 
                
                max_2_1 = max(u(:,7));
                ylim([0 max_2_1*1.5])

            hold off

        dir1 = strcat(dir,'/','P_', num2str(Global.ID));
        % print(fig1,'-dpdf','-r500',dir1)
    close all

end

