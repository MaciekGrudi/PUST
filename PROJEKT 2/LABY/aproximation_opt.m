global Y;
Y=stepResp;

e_min = 100;

for delay = 1:30
    global delay
    X0=[1, 2, 1, 1];
    A=[]; B=[]; Aeq=[]; Beq=[];
    LB=[-10, -10, -10, -10]; UB=[100, 100, 100, 100];
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