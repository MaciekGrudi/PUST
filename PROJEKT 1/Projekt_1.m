%PUST projekt 1
clear all;
close all;

save=0;

Upp=0.8;
Ypp=2;
simTime=100;
Y=symulacja_obiektu_UppYpp(0.8,2,simTime);
Y1=symulacja_obiektu_UppYpp(0.7,2,simTime);
Y2=symulacja_obiektu_UppYpp(0.9,2,simTime);
Y3=symulacja_obiektu_UppYpp(0.8,1.9,simTime);
Y4=symulacja_obiektu_UppYpp(0.8,2.1,simTime);

figure(1);
plot(Y,'r');
xlabel('k');
ylabel('Y(k)');
grid on;
hold on;
plot(Y1,'b--');
plot(Y2,'g--');
plot(Y3,'m--');
plot(Y4,'k--');
legend('Upp=0.8, Ypp=2.0','Upp=0.7, Ypp=2.0','Upp=0.9, Ypp=2.0','Upp=0.8, Ypp=1.9', 'Upp=0.8, Ypp=2.1');
title('Different Upp, Ypp values');

if save==1
    print('PLOTS/UppYpp', '-dpng', '-r500')
end

simTime=151;

Y1=stepResponse(0.2,simTime);
Y2=stepResponse(0.4,simTime);
Y3=stepResponse(0.6,simTime);
Y4=stepResponse(1.0,simTime);
Y5=stepResponse(1.2,simTime);
Y6=stepResponse(1.4,simTime);

xVal=[0:simTime-1];
figure(2);
plot(xVal,Y1,'r');
grid on;
xlabel('k');
ylabel('Y(k)');
hold on;
plot(xVal,Y2,'b');
plot(xVal,Y3,'g');
plot(xVal,Y4,'m');
plot(xVal,Y5,'k');
plot(xVal,Y6,'c');
legend('U=0.2','U=0.4','U=0.6','U=1.0','U=1.2','U=1.4');
title('Step response');

Y=[Y1(simTime),Y2(simTime),Y3(simTime),2.0,Y4(simTime),Y5(simTime),Y6(simTime)];
U=[0.2,0.4,0.6,0.8,1.0,1.2,1.4]
figure(3);
plot(U,Y,'r-o');
grid on;
xlabel('U');
ylabel('Y');
title('Static characteristics');


stepY=Y4;
stepY2=Y5;
%for i=1:simTime
    stepY=stepY*5.0;
    val=stepY(1);
    stepY=stepY-val;
    stepY2=stepY2*2.5;
    val=stepY2(1);
    stepY2=stepY2-val;
    %stepY=stepY-2.0;
%end

figure(4);
plot(stepY,'r');
hold on;
plot(stepY2,'b');
