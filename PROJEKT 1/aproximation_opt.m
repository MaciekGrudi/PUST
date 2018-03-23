<<<<<<< HEAD
<<<<<<< HEAD
load labstep

global Y

e_min = 100;

for delay = 1:30
    global delay
    X0=[1, 1, 1, 1];
    A=[]; B=[]; Aeq=[]; Beq=[];
    LB=[-10, -10, -10, -10]; UB=[20, 20, 20, 20];
    [X,E] = fmincon(@aproximation_optimization,X0,A,B,Aeq,Beq,LB,UB);
    if E < e_min
        e_min = E;
        q = X';
        best_delay = delay;
    end
end

[e,step] = simulation(q,best_delay,Y)

hold off;
stairs(Y);
hold on;
stairs(step);

clear E X
=======
load labstep

global Y

e_min = 100;

for delay = 1:30
    global delay
    X0=[1, 1, 1, 1];
    A=[]; B=[]; Aeq=[]; Beq=[];
    LB=[-10, -10, -10, -10]; UB=[20, 20, 20, 20];
    [X,E] = fmincon(@aproximation_optimization,X0,A,B,Aeq,Beq,LB,UB);
    if E < e_min
        e_min = E;
        q = X';
        best_delay = delay;
    end
end

[e,step] = simulation(q,best_delay,Y)

hold off;
stairs(Y);
hold on;
stairs(step);

clear E X
>>>>>>> 1aa569faa9f60a46403ca971df9c995fe9adabf0
=======
load labstep

global Y

e_min = 100;

for delay = 1:30
    global delay
    X0=[1, 1, 1, 1];
    A=[]; B=[]; Aeq=[]; Beq=[];
    LB=[-10, -10, -10, -10]; UB=[20, 20, 20, 20];
    [X,E] = fmincon(@aproximation_optimization,X0,A,B,Aeq,Beq,LB,UB);
    if E < e_min
        e_min = E;
        q = X';
        best_delay = delay;
    end
end

[e,step] = simulation(q,best_delay,Y)

hold off;
stairs(Y);
hold on;
stairs(step);

clear E X
>>>>>>> 1aa569faa9f60a46403ca971df9c995fe9adabf0
