function [Y,U,Yzad,E_wsk]=PID_simulation(params,Upp)
    Upp=0.8;
    Ypp=2.0;
    T=0.5;
    
    Yzad_val=[Ypp,1.3,2.5,1.8];
    
    K_init=12;
    simTime=1500;
    U=Upp*ones(K_init,1);
    Y=Ypp*ones(K_init,1);
    E=zeros(K_init,1);
    Yzad=Yzad_val(1)*ones(K_init,1);

    K=params(1); Ti=params(2); Td=params(3);
    r0=K*(1+T/(2*Ti)+Td/T);
    r1=K*(1+T/(2*Ti)+Td/T);
    r2=(K*Td)/T;
    
    E_wsk=0;
    for k=K_init+1:simTime+K_init
        if k<100
            Yzad(k)=Yzad_val(1);
        elseif k<500+K_init
            Yzad(k)=Yzad_val(2);
        elseif k<1000+K_init
            Yzad(k)=Yzad_val(3);
        else
            Yzad(k)=Yzad_val(4);
        end

        E(k)=Yzad(k)-Y(k-1);
        U(k)=PID(E,U,k,r0,r1,r2,Upp);
        Y(k)=symulacja_obiektu7Y(U(k-10),U(k-11),Y(k-1),Y(k-2));

        E_wsk=E_wsk+(E(k)*E(k));
    end
    
    Y=Y(K_init+1:simTime+K_init);
    U=U(K_init+1:simTime+K_init);
    Yzad=Yzad(K_init+1:simTime+K_init);
end