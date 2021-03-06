%PUST projekt 2
function [odpDMCU, odpDMCZ] = proj2zad13()
    clear all;
    close all;

    save=1;

    Upp=0;
    Ypp=0;
    Zpp=0;

    simTime=200;
    %sprawdzenie poprawnosci punktu pracy
    Ypp=symulacja_obiektu_UppYppZpp(Upp,Zpp,simTime,1);
    figure(1);
    stairs(Ypp);
    title('Warto�� sygna�u wyj�ciowego w punkcie pracy u=z=0');
    xlabel('k');
    ylabel('Y(k)');
    hold on;
    if save==1
        print('PLOTS/ppracy', '-dpng', '-r500')
        matlab2tikz('PLOTS/ppracy.tex','showInfo',false);
    end
    
    %odpowiedzi skokowe dla roznych skokow sterowania i zaklocenia
    Y1=skok_sterowania(0.5,simTime);
    Y2=skok_sterowania(0.9,simTime);
    Y3=skok_sterowania(1.5,simTime);
    Y4=skok_sterowania(1.9,simTime);
    Y5=skok_sterowania(2.3,simTime);
    Y6=skok_sterowania(2.7,simTime);

    Y7=skok_zaklocenia(0.4,simTime);
    Y8=skok_zaklocenia(0.8,simTime);
    Y9=skok_zaklocenia(1.4,simTime);
    Y10=skok_zaklocenia(1.7,simTime);
    Y11=skok_zaklocenia(2.1,simTime);
    Y12=skok_zaklocenia(2.6,simTime);

    [odpDMCU, odpDMCZ] = skokowa_DMC(simTime);

    %wykresy
    figure(2);
    stairs(Ypp);
    hold on;

    stairs(Y1);
    stairs(Y2);
    stairs(Y3);
    stairs(Y4);
    stairs(Y5);
    stairs(Y6);

    legend('Punkt pracy','Skok 0.5','Skok 0.9','Skok 1.5','Skok 1.9','Skok 2.3', 'Skok 2.7');
    title('Skok wartosci sterowania');
    xlabel('k');
    ylabel('Y(k)');
    grid on;
    if save==1
        print('PLOTS/osu', '-dpng', '-r500')
        matlab2tikz('PLOTS/osu.tex','showInfo',false);
    end
    
    figure(3);
    stairs(Ypp);
    hold on;
    stairs(Y7);
    stairs(Y8);
    stairs(Y9);
    stairs(Y10);
    stairs(Y11);
    stairs(Y12);

    legend('Punkt pracy','Skok 0.4', 'Skok 0.8', 'Skok 1.4', 'Skok 1.7','Skok 2.1','Skok 2.6');
    title('Skok wartosci zaklocenia');
    xlabel('k');
    ylabel('Y(k)');
    grid on;

    if save==1
        print('PLOTS/osz', '-dpng', '-r500')
        matlab2tikz('PLOTS/osz.tex','showInfo',false);
    end
    
    %charakterystyka statyczna y(u,z)
    simTime=simTime-15;
    Y=[Y1(simTime);Y2(simTime);Y3(simTime);Y4(simTime);Y5(simTime);Y6(simTime);Y7(simTime);Y8(simTime);Y9(simTime);Y10(simTime);Y11(simTime);Y12(simTime)];
    U=[0.5;0.9;1.5;1.9;2.3;2.9;0;0;0;0;0;0];
    Z=[0;0;0;0;0;0;0.4;0.8;1.4;1.7;2.1;2.6];


    figure(4);
    stem3(U,Z,Y);
    xlabel('U');
    ylabel('Z');
    zlabel('Y');
    title('Charakterystyka statyczna');

    if save==1
        print('PLOTS/statyczna_proj', '-dpng', '-r500')
        matlab2tikz('PLOTS/statyczna_proj.tex','showInfo',false);
    end
    
    figure(5);
    stem(U(1:6),Y(1:6));
    xlabel('U');
    ylabel('Y');
    title('Charakterystyka statyczna - Y(U)');
    
    if save==1
        print('PLOTS/statyczna_proj_yu', '-dpng', '-r500')
        matlab2tikz('PLOTS/statyczna_proj_yu.tex','showInfo',false);
    end
        
    figure(6);
    stem(Z(7:12),Y(7:12));
    xlabel('Z');
    ylabel('Y');
    title('Charakterystyka statyczna - Y(Z)');
    
    if save==1
        print('PLOTS/statyczna_proj_yz', '-dpng', '-r500')
        matlab2tikz('PLOTS/statyczna_proj_yz.tex','showInfo',false);
    end
        
    %odpowiedz skokowa dla DMC
    figure(7);
    stairs(odpDMCU);
    hold on;
    stairs(odpDMCZ);
    title('Odpowiedzi skokowe dla DMC');
    legend('Skok jednostkowy sterowania', 'Skok jednostkowy zaklocenia');

    if save==1
        print('PLOTS/skokDMC', '-dpng', '-r500')
        matlab2tikz('PLOTS/skokDMC.tex','showInfo',false);
    end
    clear Y Y1 Y2 Y3 Y4 Y5 Y6 Y7 Y8 Y9 Y10 Y11 Y12 simTime;
end