function z_Flow = g_flow_Fcn(z, u, Global)
%--------------------------------------------------------------------------
     FZ1  = 14;
     MZ1  = 3;
     XLFZ = 14;
     YLFZ = 14;
     LFZ  = 5; % LEYNEDA
     M = {'-o','-s','-p','-*','-h','-d'};
%--------------------------------------------------------------------------

    z_Flow = [z, u(:,1:6)];

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

                for i = 1:6
                    plot(z,u(:,i),M{i},'MarkerSize',MZ1);
                end
    
                xlabel('$z\;\left( {m} \right)$',...
                       'FontSize',XLFZ,'interpreter','Latex')
                ylabel('$Flow\;(\frac{mol}{m^{2}s})$',...
                       'FontSize',YLFZ,'interpreter','Latex') 
    
                ley1 = {'$C{O_2}$','${H_2}$','$C{H_3}OH$','${CO}$',     ...
                        '${H_2}O$','${N_2}$'};
                legend(ley1,'Interpreter','Latex','Location','north',   ...
                            'Orientation','horizontal','FontSize',LFZ)
            hold off

        dir1 = strcat(dir,'/','Fi_', num2str(Global.ID));
        % print(fig1,'-dpdf','-r500',dir1)
    close all

end

