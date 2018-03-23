<<<<<<< HEAD
<<<<<<< HEAD
IntCon = 1:2;
X0=[200, 15, 1];
A=[]; B=[]; Aeq=[]; Beq=[];
LB=[1, 1, 1]; UB=[1500, 1500, 100]; Nonlcon = [];
X = ga(@DMC_optimization,3,A,B,Aeq,Beq,LB,UB,Nonlcon,IntCon);

Upp = 0.8;

[Y,U,Yzad,E] = DMC_simulation(X,Upp);

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
=======
IntCon = 1:2;
X0=[200, 15, 1];
A=[]; B=[]; Aeq=[]; Beq=[];
LB=[1, 1, 1]; UB=[1500, 1500, 100]; Nonlcon = [];
X = ga(@DMC_optimization,3,A,B,Aeq,Beq,LB,UB,Nonlcon,IntCon);

Upp = 0.8;

[Y,U,Yzad,E] = DMC_simulation(X,Upp);

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
>>>>>>> 1aa569faa9f60a46403ca971df9c995fe9adabf0
=======
IntCon = 1:2;
X0=[200, 15, 1];
A=[]; B=[]; Aeq=[]; Beq=[];
LB=[1, 1, 1]; UB=[1500, 1500, 100]; Nonlcon = [];
X = ga(@DMC_optimization,3,A,B,Aeq,Beq,LB,UB,Nonlcon,IntCon);

Upp = 0.8;

[Y,U,Yzad,E] = DMC_simulation(X,Upp);

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
>>>>>>> 1aa569faa9f60a46403ca971df9c995fe9adabf0
xlabel('k');