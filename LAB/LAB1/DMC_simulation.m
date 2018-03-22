function [Y,U,Yzad,E_wsk]=DMC_simulation(params,Upp,DMCstep)
    addpath('F:\SerialCommunication'); % add a path to the functions
    initSerialControl COM3 % initialise com port

    %Upp=0.8;
    Ypp=24.0;
    
    Yzad_val=[26,30,28,25];
    
    K_init=12;
    simTime=400;
    U=Upp*ones(1,K_init);
    Y=Ypp*ones(1,K_init);
    E=zeros(1,K_init);
    Yzad=Yzad_val(1)*ones(1,K_init);
    
    %wykresy
    time_buf=200;
    U_buf=zeros(time_buf,1);
    Y_buf=Ypp*ones(time_buf,1);
    Yzad_buf=Yzad(1)*ones(time_buf,1);
    
    %load step;
    %s = DMCstep - DMCstep(1); %to nale?a?o zrobi?
    s=DMCstep;

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
        if k<150
            Yzad(k)=Yzad_val(1);
        elseif k<250+K_init
            Yzad(k)=Yzad_val(2);
        elseif k<800+K_init
            Yzad(k)=Yzad_val(3);
        else
            Yzad(k)=Yzad_val(4);
        end

        E(k)=Yzad(k)-Y(k-1);
        %Y(k)=symulacja_obiektu7Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
        Y(k) = readMeasurements(1);
        [U(k),DUP] = DMC(K,MP,DUP,U,Y,Yzad,k,Upp);
        
        E_wsk=E_wsk+(E(k)*E(k));
        
        sendControls([ 1, 5], ...
                     [ 50, U(k)]);  
      
        %wykresy
        Y_buf(1:time_buf-1)=Y_buf(2:time_buf);
        Y_buf(time_buf)=Y(k);
        Yzad_buf(1:time_buf-1)=Yzad_buf(2:time_buf);
        Yzad_buf(time_buf)=Yzad(k);
        U_buf(1:time_buf-1)=U_buf(2:time_buf);
        U_buf(time_buf)=U(k);
        
        figure(1);
        subplot(2,1,1);
        stairs(U_buf,'b');
        ylabel('U');
        xlabel('k');
        title('U(k)');
        subplot(2,1,2);
        stairs(Yzad_buf,'--r');
        hold on;
        stairs(Y_buf, 'b');
        ylabel('Y');
        xlabel('k');
        title('Y(k)');
        hold off;
        drawnow;
        
        waitForNewIteration();
    end
    
    Y=Y(K_init+1:simTime+K_init);
    U=U(K_init+1:simTime+K_init);
    Yzad=Yzad(K_init+1:simTime+K_init);
    
end