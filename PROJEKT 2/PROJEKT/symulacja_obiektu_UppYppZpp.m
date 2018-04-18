function Y=symulacja_obiektu_UppYppZpp(Upp,Ypp,Zpp,time,t)
    if t ==1
        k=16;
    end
    
    if t==2
        k=16;
    end
    U=zeros(time,1);
    Y=zeros(time,1);
    Z=zeros(time,1);
    if (t == 1)
        for k=16:time+16
            U(k)=Upp;
            Z(k)=Zpp;
            Y(k)=symulacja_obiektu7y(U(k-4),U(k-5),Z(k-1),Z(k-2),Y(k-1),Y(k-2));
        end
        Y=Y(16:time+16,1);
    end
    
    if (t == 2)
        for k=16:time+16
            U(k)=Upp;
            Z(k)=Zpp;
            Y(k)=symulacja_obiektu7y(0,0,Z(k-1),Z(k-2),Y(k-1),Y(k-2));
        end
        Y=Y(16:time+16,1);
    end
end