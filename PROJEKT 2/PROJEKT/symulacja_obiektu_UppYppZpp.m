function Y=symulacja_obiektu_UppYppZpp(Upp,Zpp,time,t)

    %alokacja pamieci
    U=zeros(time+16,1);
    Y=zeros(time+16,1);
    Z=zeros(time+16,1);
        
        for k=16:time+16
            U(k)=Upp;
            Z(k)=Zpp;
            %skok wejscia lub zaklocenia w zaleznosci od parametru t
            if (t == 1)
                Y(k)=symulacja_obiektu7y(U(k-4),U(k-5),Z(k-1),Z(k-2),Y(k-1),Y(k-2));
            end
            if (t == 2)
                Y(k)=symulacja_obiektu7y(0,0,Z(k-1),Z(k-2),Y(k-1),Y(k-2));
            end
        end
    Y=Y(16:time+16,1);
end