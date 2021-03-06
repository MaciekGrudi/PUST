function [e,step] = simulation(params,delay,Y)
    
    p = zeros(4,1);
    
    if(params(1) == params(2))
        e = Inf;
        step = zeros(2,1);
        return;
    end
    
    a1 = exp(-1/params(1));
    a2 = exp(-1/params(2));
    K = params(3)/(params(1)-params(2));
    K1 = params(1)*(1-a1);
    K2 = params(2)*(1-a2);
    
    p(1) = -a1-a2;
    p(2) = a1*a2;
    p(3) = K*(K1-K2);
    p(4) = K*(a1*K2 - a2*K1);
    
    

    e = 0;
    step = zeros(2,1);
    for i = 3:length(Y)
        u1 = 1;
        u2 = 1;
        if i-delay-1 < 0
            u1 = 0;
        end
        if i-delay-2 < 0
            u2 = 0;
        end

        step(i) = p(3)*u1 + p(4)*u2 - step(i-1)*p(1) - step(i-2)*p(2);

        e = e + (Y(i)-step(i))*(Y(i)-step(i));
    end

end