%PUST projekt 1
clear all;
close all;

Upp=0.8;
Ypp=2;

% 1. Sprawdzenie Upp i Ypp 

save=0; % 1 - zapis wykresów
optimization=0; % 1 - wywo³anie optymalizacji

simTime=100;
Y=symulacja_obiektu_UppYpp(0.8,2,simTime);
Y1=symulacja_obiektu_UppYpp(0.7,2,simTime);
Y2=symulacja_obiektu_UppYpp(0.9,2,simTime);
Y3=symulacja_obiektu_UppYpp(0.8,1.9,simTime);
Y4=symulacja_obiektu_UppYpp(0.8,2.1,simTime);

%wykresy
figure(1);
stairs(Y,'r');
hold on;
stairs(Y1,'b--');
stairs(Y2,'g--');
stairs(Y3,'m--');
stairs(Y4,'k--');
legend('Upp=0.8, Ypp=2.0','Upp=0.7, Ypp=2.0','Upp=0.9, Ypp=2.0','Upp=0.8, Ypp=1.9', 'Upp=0.8, Ypp=2.1');
title('Ró¿ne wartoœci Upp, Ypp');
xlabel('k');
ylabel('Y(k)');
grid on;

if save==1
    print('PLOTS/UppYpp', '-dpng', '-r500')
end

clear Y Y1 Y2 Y3 Y4 simTime

% 2. Odpowiedzi skokowe dla Upp=0.8

simTime=151;

Y1=stepResponse(0.2,simTime,Upp,Ypp);
Y2=stepResponse(0.4,simTime,Upp,Ypp);
Y3=stepResponse(0.6,simTime,Upp,Ypp);
Y4=stepResponse(1.0,simTime,Upp,Ypp);
Y5=stepResponse(1.2,simTime,Upp,Ypp);
Y6=stepResponse(1.4,simTime,Upp,Ypp);

%wykresy
xVal=[0:simTime-1];
figure(2);
stairs(xVal,Y1,'r');
hold on;
stairs(xVal,Y2,'b');
stairs(xVal,Y3,'g');
stairs(xVal,Y4,'m');
stairs(xVal,Y5,'k');
stairs(xVal,Y6,'c');
grid on;
xlabel('k');
ylabel('Y(k)');
legend('U=0.2','U=0.4','U=0.6','U=1.0','U=1.2','U=1.4');
title('Odpowiedzi skokowe dla Upp=0.8');

if save==1
    print('PLOTS/step_response_Upp_0_8', '-dpng', '-r500')
end

Y=[Y1(simTime);Y2(simTime);Y3(simTime);2.0;Y4(simTime);Y5(simTime);Y6(simTime)];
U=[0.2;0.4;0.6;0.8;1.0;1.2;1.4];
U2=[U ones(7,1)];

A=U2\Y;
xVal=[0:0.1:1.6];

Y0=A(2); % wartoœæ sygna³u dla U=0

%wykresy
figure(3);
plot(xVal,polyval(A,xVal),'r');
hold on;
plot(U,Y,'bo');
grid on;
xlabel('U');
ylabel('Y');
title('Charackterystyka statyczna');
legend('prosta najlepszego dopasowania','dane z modelu');

if save==1
    print('PLOTS/static_characteristics', '-dpng', '-r500')
end

clear Y1 Y2 Y3 Y5 Y6 xVal Y U U2

% 3. OdpowiedŸ skokowa dla DMC

val=Y4(1);
DMCstep=(Y4-val)*5.0;
DMCstep=DMCstep+Y0;

%wykresy
xVal=[0:simTime-1];
figure(4);
stairs(xVal,DMCstep,'r');
grid on;
xlabel('k');
ylabel('Y(k)');
title('OdpowiedŸ skokowa dla DMC');

if save==1
    print('PLOTS/DMC_step_response', '-dpng', '-r500')
end

clear Y4 Y0 val xVal simTime 

%4. PID

%nastawa rêczna
params=[0.01,100000.0,0.0];  %parametry [K,Ti,Td]
[Y,U,Yzad,E_wsk,simTime]=PID_simulation(params,Upp);

xVal=[0:simTime-1];

%wykresy
figure(5);
stairs(xVal,Y,'r');
hold on;
stairs(xVal,Yzad,'b');
grid on;
xlabel('k');
ylabel('Y(k)');
params_str=strcat('K=',num2str(params(1)),', Ti=',num2str(params(2)),', Td=',num2str(params(3)));
title(strcat('Nastawa rêczna [',params_str,']: E=',num2str(E_wsk)));

if save==1
    print('PLOTS/nastawa_reczna_Y', '-dpng', '-r500')
end

figure(6);
stairs(xVal,U,'m');
xlabel('k');
ylabel('U(k)');
title('Nastawa rêczna');
grid on;

if save==1
    print('PLOTS/nastawa_reczna_U', '-dpng', '-r500')
end

%optymalizacja

if optimization==1
    %paramtery dla optymalizacji
    X0=[0.01, 100000.0, 0.001];
    A=[]; B=[]; Aeq=[]; Beq=[];
    LB=[0.0001, 0.1, 0.0001]; UB=[1.0, 1000, 10];
    X=fmincon(@PID_optimization,X0,A,B,Aeq,Beq,LB,UB);

    [Y,U,Yzad,E_wsk,simTime]=PID_simulation(X,Upp);
    
    %wykresy
    figure(7);
    stairs(xVal,Y,'r');
    hold on;
    stairs(xVal,Yzad,'b');
    grid on;
    xlabel('k');
    ylabel('Y(k)');
    params_str=strcat('K=',num2str(X(1)),', Ti=',num2str(X(2)),', Td=',num2str(X(3)));
    title(strcat('Optymalizacja [',params_str,']: E=',num2str(E_wsk)));
    
    if save==1
        print('PLOTS/optymalizacja_Y', '-dpng', '-r500')
    end
    
    figure(8);
    stairs(xVal,U,'m');
    grid on;
    xlabel('k');
    ylabel('U(k)');
    title('Optymalizacja');
    
    if save==1
        print('PLOTS/optymalizacja_U', '-dpng', '-r500')
    end

    params_optimization=X;
end

clear A Aeq B Beq E_wsk LB U UB X X0 Y Yzad X params_str xVal