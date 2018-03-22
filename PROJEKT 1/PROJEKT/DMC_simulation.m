function [Y,U,Yzad,E_wsk]=DMC_simulation(params,Upp)

    %Upp=0.8;
    Ypp=2.0;
    
    Yzad_val=[Ypp,1.3,2.5,1.8];
    
    K_init=12;
    simTime=1500;
    U=Upp*ones(1,K_init);
    Y=Ypp*ones(1,K_init);
    E=zeros(1,K_init);
    Yzad=Yzad_val(1)*ones(1,K_init);
    
    load step;
    s = DMCstep - DMCstep(1); %to nale¿a³o zrobiæ


    D = length(s); N = params(1); Nu = params(2); lambda = params(3);
    s(D+1:D+N+2) = s(D);
    
    M = zeros(N,Nu);
    M(:,1) = s(1:N);
    for i = 2:Nu
        M(i:N,i)=M(1:N-i+1,1);
    end;

    MP = zeros(N,D-1);
    for i = 1:D-1
        MP(:,i) = s((i+1):(i+N))-s(i);
    end;

    K = inv(M'*M + lambda*eye(Nu))*M';

    DUP = zeros(D-1,1);
    
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
        Y(k)=symulacja_obiektu7Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
        [U(k),DUP] = DMC(K,MP,DUP,U,Y,Yzad,k,Upp);
        
        E_wsk=E_wsk+(E(k)*E(k));
    end
    
    Y=Y(K_init+1:simTime+K_init);
    U=U(K_init+1:simTime+K_init);
    Yzad=Yzad(K_init+1:simTime+K_init);
end