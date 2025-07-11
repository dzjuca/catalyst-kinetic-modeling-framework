function z_y = g_yield_Fcn(z, u, Global)
%--------------------------------------------------------------------------

    FCO2_in = Global.FCO2_in;

%--------------------------------------------------------------------------
    
    FCH3OH_z = u(:,3);

%--------------------------------------------------------------------------

    Y_CH3OH = FCH3OH_z/FCO2_in;
    z_y = [z, Y_CH3OH];

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

                    plot(z,Y_CH3OH,'-*','MarkerSize',MZ1);
    
                xlabel('$z\;\left( {m} \right)$',...
                       'FontSize',XLFZ,'interpreter','Latex')
                ylabel('$Y_{CH_{3}OH}$',...
                       'FontSize',YLFZ,'interpreter','Latex') 
    
            hold off

        dir1 = strcat(dir,'/','YCH3OH_', num2str(Global.ID));
        % print(fig1,'-dpdf','-r500',dir1)
    close all

end

