load labstep

global Y

e_min = Inf;


for delay = 1:30
    global delay
    X0=[2, 4, 2];
    A=[]; B=[]; Aeq=[]; Beq=[];
    LB=[0, 0, 0]; UB=[200, 200, 200];
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
