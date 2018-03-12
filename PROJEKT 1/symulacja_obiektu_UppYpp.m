function Y=symulacja_obiektu_UppYpp(Upp,Ypp,time)
k=12;
U=zeros(k,1);
Y=zeros(k,1);
for i=1:k-1
    U(i)=Upp;
    Y(i)=Ypp;
end

for k=12:time
    U(k)=Upp;
    Y(k)=symulacja_obiektu7Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
end

end