function Uout=PID(E,U,k,r0,r1,r2)
    deltaMax_U=0.2;
    max_U=1.5;
    min_U=0.1;
    Upp=0.8;
    
%     K=0.01; Ti=0.5; Td=0.0; T=0.5;
%     r0=K*(1+T/(2*Ti)+Td/T);
%     r1=K*(1+T/(2*Ti)+Td/T);
%     r2=(K*Td)/T;

    u=U(k-1)-Upp;
    u_out=r2*E(k-2)+r1*E(k-1)+r0*E(k)+u;
    Uout=u_out+Upp;
    
    deltaU=Uout-U(k-1);
    
    if deltaU>deltaMax_U
        deltaU=deltaMax_U;
    elseif deltaU<-deltaMax_U
        deltaU=-deltaMax_U;
    end
    
    Uout=U(k-1)+deltaU;
    if Uout>max_U
        Uout=max_U;
    elseif Uout<min_U
        Uout=min_U;
    end
    
end