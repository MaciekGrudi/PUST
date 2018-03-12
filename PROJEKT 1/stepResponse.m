function Yout=stepResponse(newU,time)
Upp=0.8;
Ypp=2.0;

k=12;
Y=Ypp*ones(k-1,1);
U=Upp*ones(k-1,1);

for k=12:time+11
    U(k)=newU;
    Y(k)=symulacja_obiektu7Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
end

Yout=Y(12:time+11);

end