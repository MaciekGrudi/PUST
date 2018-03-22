function [Y,U,Yzad] = PID(K,Ti,Td)
    addpath('F:\SerialCommunication'); % add a path to the functions
    initSerialControl COM3 % initialise com port
    
    simTime=400;
    
    T=1.0;
    r0=K*(1+T/(2*Ti)+Td/T);
    r1=K*(T/(2*Ti)-2.0*Td/T-1);
    r2=(K*Td)/T;
    
    min_U=0.0;
    max_U=100.0;
    Upp=0;
    Ypp=24;
    y_zad=26;
    
    E=zeros(2,1);
    U=Upp*ones(2,1);
    Y=Ypp*ones(2,1);
    Yzad=y_zad*ones(2,1);
    
    k=3;
    
    time_buf=200;
    U_buf=zeros(time_buf,1);
    Y_buf=Ypp*ones(time_buf,1);
    Yzad_buf=y_zad*ones(time_buf,1);
    
    %while(1)
    for k=3:simTime
        
        if k<200
            Yzad(k)=26;
        else 
            Yzad(k)=28;
        end
        
        E(k)=Yzad(k)-Y(k-1);
        
        U(k)=r2*E(k-2)+r1*E(k-1)+r0*E(k)+U(k-1);
        
        if U(k) > max_U
            U(k)=max_U;
        elseif U(k)<min_U
            U(k)=min_U;
        end
        
        sendControls([ 1, 5], ...
                     [ 50, U(k)]);  
        
        Y(k) = readMeasurements(1); % read measurements from 1 to 7              
        
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
        
         %k=k+1;
        
        %% synchronising with the control process
        waitForNewIteration(); % wait for new batch of measurements to be ready
    end
end