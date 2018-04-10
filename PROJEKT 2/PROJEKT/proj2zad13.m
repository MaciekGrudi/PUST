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
    Y=symulacja_obiektu_UppYppZpp(0,0,0,simTime,1);

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
    figure(1);
    stairs(Y);
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

    figure(2);
    stairs(Y);
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

    %charakterystyka statyczna y(u,z)
    Y=[Y1(simTime);Y2(simTime);Y3(simTime);Y4(simTime);Y5(simTime);Y6(simTime);Y7(simTime);Y8(simTime);Y9(simTime);Y10(simTime);Y11(simTime);Y12(simTime)];
    U=[0.5;0.9;1.5;1.9;2.3;2.9;0;0;0;0;0;0];
    Z=[0;0;0;0;0;0;0.4;0.8;1.4;1.7;2.1;2.6];


    figure(3);
    stem3(U,Z,Y);
    xlabel('U');
    ylabel('Z');
    zlabel('Y');
    title('Charakterystyka statyczna');

    %odpowiedz skokowa dla DMC
    figure(4);
    stairs(odpDMCU);
    hold on;
    stairs(odpDMCZ);
    title('Odpowiedzi skokowe dla DMC');
    legend('Skok jednostkowy sterowania', 'Skok jednostkowy zaklocenia');

    clear Y Y1 Y2 Y3 Y4 Y5 Y6 Y7 Y8 Y9 Y10 Y11 Y12 simTime;
end