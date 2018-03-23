clear all;
close all;

save_=1;

load DMCstep;
figure(1)
stairs(DMCstep);
xlabel('k');
ylabel('Y');
title('Przekszta≥cona odpowiedü skokowa obiektu');
grid on;
legend('Y(k)');
if save_==1
     print('PLOTS_DIR/DMC_step_resp', '-dpng', '-r500');
     matlab2tikz('PLOTS_DIR/DMC_step_resp.tex','showInfo',false);
end

clear step G;
load step6;
G6=G;
step6=step;
clear step G;
load step3;
G3=G;
step3=step;
clear step G;
load step2;
G2=G;
step2=step;
clear step G;

Y6=step6(350);
Y3=step3(250);
Y2=step2(250);

figure(7);
plot([10 20 30],[Y3 Y2 Y6]);
grid on;
xlabel('U');
ylabel('Y');
title('Charakterystyka statyczna obiektu');
legend('Y(U)');

if save_==1
    print('PLOTS_DIR/static_char', '-dpng', '-r500');
    matlab2tikz('PLOTS_DIR/static_char.tex','showInfo',false);
end

figure(2)
stairs(step6,'r');
hold on;
stairs(step3,'b');
stairs(step2,'g');
grid on;
xlabel('k');
ylabel('Y');
title('Odpowiedzi skokowe obiektu dla Upp=0, Ypp=24');
leg_G6=strcat('U=',num2str(G6));
leg_G3=strcat('U=',num2str(G3));
leg_G2=strcat('U=',num2str(G2));
legend(leg_G6,leg_G3,leg_G2);
axis([0 400 22 36]);

if save_==1
    print('PLOTS_DIR/raw_step_resp', '-dpng', '-r500');
    matlab2tikz('PLOTS_DIR/raw_step_resp.tex','showInfo',false);
end

clear step6 step3 step2 G6 G3 G2 leg_G6 leg_G3 leg_G2 DMCstep;
load PID_9_45_0_02;

E_wsk=0;
for i=1:length(Y)
    E_wsk=E_wsk+(Yzad(i)-Y(i))^2;
end

figure(3);
stairs(Y,'b');
hold on;
stairs(Yzad,'r');
xlabel('k');
ylabel('Y');
legend('Y(k)','Yzad(k)');
title(strcat('Regulator PID, E=',num2str(E_wsk)));
grid on;
axis([0 400 24 31]);

if save_==1
    print('PLOTS_DIR/PID_9_45_0_02_Y','-dpng','-r500');
    matlab2tikz('PLOTS_dir/PID_9_45_0_02_Y.tex','showInfo',false);
end

figure(4);
stairs(U,'b');
xlabel('k');
ylabel('U');
legend('U(k)');
title('Regulator PID');
grid on;
axis([0 400 0 70]);

if save_==1
    print('PLOTS_DIR/PID_9_45_0_02_U','-dpng','-r500');
    matlab2tikz('PLOTS_dir/PID_9_45_0_02_U.tex','showInfo',false);
end

clear Y U Yzad E_wsk;

load DMC_400_200_1_0;

Y_1_0=Y;
U_1_0=U;

E_wsk_1_0=0;
for i=1:length(Y)
    E_wsk_1_0=E_wsk_1_0+(Yzad(i)-Y(i))^2;
end

% figure(5);
% stairs(Y,'b');
% hold on;
% stairs(Yzad,'r');
% xlabel('k');
% ylabel('Y');
% title(strcat('DMC, lambda=1.0, E=',num2str(E_wsk)));
% legend('Y(k)','Yzad(k)');
% grid on;
% axis([0 400 24 31]);
% 
% if save_==1
%     print('PLOTS_DIR/DMC_400_200_1_0_Y','-dpng','-r500');
%     matlab2tikz('PLOTS_dir/DMC_400_200_1_0_Y.tex','showInfo',false);
% end
% 
% figure(6);
% stairs(U,'b');
% xlabel('k');
% ylabel('U');
% title('DMC, lambda=1.0');
% legend('U(k)');
% grid on;
% axis([0 400 0 70]);
% 
% if save_==1
%     print('PLOTS_DIR/DMC_400_200_1_0_U','-dpng','-r500');
%     matlab2tikz('PLOTS_dir/DMC_400_200_1_0_U.tex','showInfo',false);
% end

clear Y Yzad U;

load DMC_400_200_0_1;

Y_0_1=Y;
U_0_1=U;

E_wsk_0_1=0;
for i=1:length(Y)
    E_wsk_0_1=E_wsk_0_1+(Yzad(i)-Y(i))^2;
end

figure(5);
stairs(Y_1_0,'b');
hold on;
stairs(Y_0_1,'g');
stairs(Yzad,'r');
xlabel('k');
ylabel('Y');
title('Regulator DMC, Y(k)');
legend('lambda=1.0','lambda=0.1','Yzad');
grid on;
axis([0 400 24 31]);

if save_==1
    print('PLOTS_DIR/DMC_Y','-dpng','-r500');
    matlab2tikz('PLOTS_dir/DMC_Y.tex','showInfo',false);
end

figure(6);
stairs(U_1_0,'b');
hold on;
stairs(U_0_1,'g');
xlabel('k');
ylabel('U');
title('Regulator DMC, U(k)');
legend('lambda=1.0','lambda=0.1');
grid on;
axis([0 400 0 70]);

if save_==1
    print('PLOTS_DIR/DMC_U','-dpng','-r500');
    matlab2tikz('PLOTS_dir/DMC_U.tex','showInfo',false);
end

clear Y Yzad U E_wsk;
