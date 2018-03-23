function [e,step] = simulation(q,delay,Y)

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

        step(i) = q(3)*u1 + q(4)*u2 - step(i-1)*q(1) - step(i-2)*q(2);

        e = e + (Y(i)-step(i))*(Y(i)-step(i));
    end

end
