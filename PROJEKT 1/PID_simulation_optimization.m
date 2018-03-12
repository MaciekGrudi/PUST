function E_wsk=PID_simulation_optimization(params)
    Upp=0.8;
    Ypp=2.0;
    T=0.5;
    
    K_init=12;
    simTime=1500;
    U=Upp*ones(K_init-1,1);
    Y=Ypp*ones(K_init-1,1);
    E=zeros(K_init-1,1);

    K=params(1); Ti=params(2); Td=params(3);
    r0=K*(1+T/(2*Ti)+Td/T);
    r1=K*(1+T/(2*Ti)+Td/T);
    r2=(K*Td)/T;
    
    E_wsk=0;
    for k=K_init:simTime+K_init
        if k<500
            Yzad=1.3;
        elseif k<1000
            Yzad=2.5;
        else
            Yzad=1.8;
        end

        E(k)=Yzad-Y(k-1);
        U(k)=PID(E,U,k,r0,r1,r2);
        Y(k)=symulacja_obiektu7Y(U(k-10),U(k-11),Y(k-1),Y(k-2));

        E_wsk=E_wsk+(E(k)*E(k));
    end
    
%     str=num2str(E_wsk);

%     figure(5)
%     stairs(Y,'r');
%     title(strcat('E=',str));
%     xlabel('k');
%     ylabel('Y(k)');
%     grid on;
% 
%     figure(6)
%     stairs(U);
%     xlabel('k');
%     ylabel('U(k)');
%     grid on;
end