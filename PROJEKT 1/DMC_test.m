clear all

limits = 1;
Upp = 0.8;
params = [200 15 1];

[Y,U,Yzad,E] = DMC_simulation(params,Upp);

figure;
subplot(2,1,1);
stairs(U,'b');
ylabel('U');
xlabel('k');
title(sprintf('DMC, E=%e',E));

subplot(2,1,2);
stairs(Yzad,'--r');
hold on;
stairs(Y, 'b')
ylabel('Y, Yzad');
xlabel('k');

