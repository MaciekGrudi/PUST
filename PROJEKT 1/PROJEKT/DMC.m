function [Uout,DUP] = DMC(K,MP,DUP,U,Y,Yzad,k,Upp)

    global limits

    Ypp = 2;
    Umin = 0.1;
    Umax = 1.5;
    dUmax = 0.2;

    u = U - Upp;
    y = Y - Ypp;
    yzad = Yzad - Ypp;
    umin = Umin - Upp;
    umax = Umax - Upp;
    dumax = dUmax;
    
    D = length(DUP) + 1;
    N = size(MP,1);
    
    DUP = [u(k-1) - u(k-2) ; DUP(1:D-2)];

    vec_Y0 = y(k)*ones(N,1)+MP*DUP;
    vec_Yzad = yzad(k)*ones(N,1);

    du = K*(vec_Yzad-vec_Y0);
    if limits ~= 0
        if du(1) < -dumax
            du(1) = -dumax;
        end;
        if du(1) > dumax
            du(1) = dumax;
        end;
        u(k) = du(1) + u(k-1);
        if u(k) < umin
            u(k) = umin;
        end;
        if u(k) > umax
            u(k) = umax;
        end;

    else
        u(k) = du(1)+u(k-1);
    end;

    Uout = u(k)+Upp;
end