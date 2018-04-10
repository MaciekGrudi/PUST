function Y=symulacja_obiektu_UppYppZpp(Upp,Ypp,Zpp,time,t)
    if t ==1
        k=6;
    end
    
    if t==2
        k=3;
    end
    U=zeros(time,1);
    Y=zeros(time,1);
    Z=zeros(time,1);
    for i=1:k-1
        U(i)=Upp;
        Y(i)=Ypp;
        Z(i)=Zpp;
    end
    if (t == 1)
        for k=6:time
            U(k)=Upp;
            Z(k)=Zpp;
            Y(k)=symulacja_obiektu7y(U(k-4),U(k-5),Z(k-1),Z(k-2),Y(k-1),Y(k-2));
        end
    end
    
    if (t == 2)
        for k=3:time
            U(k)=Upp;
            Z(k)=Zpp;
            Y(k)=symulacja_obiektu7y(0,0,Z(k-1),Z(k-2),Y(k-1),Y(k-2));
        end
    end
    
end