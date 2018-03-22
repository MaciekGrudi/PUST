clear all;

limits = 1;

load step;
s = DMCstep - DMCstep(1); %to nale¿a³o zrobiæ


T = 0.5;
D = length(s); N = 200; Nu = 15; lambda = 1;
Upp = 0.8; Ypp = 2;
Umin = 0.1; Umax = 1.5; dUmax = 0.2;

s(D+1:500) = s(D);

umin = Umin - Upp; umax = Umax - Upp; dumax = dUmax;

Yzad(1:11)=Ypp; Yzad(12:200)=Ypp+0.3;
yzad = Yzad - Ypp;
kk = length(Yzad);

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

Y(1:11)=Ypp;
U(1:11)=Upp;

y(1:11) = Y(1:11) - Ypp;
u(1:11) = U(1:11) - Upp;

for k=12:kk
    
    Y(k) = symulacja_obiektu7Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
    y(k) = Y(k) - Ypp;
    
    DUP = [u(k-1) - u(k-2) ; DUP(1:D-2)];
    
    vec_Y0 = y(k)*ones(N,1)+MP*DUP;
    vec_Yzad = yzad(k)*ones(N,1);
    
    du = K*(vec_Yzad-vec_Y0);
    if limits ~= 0
        if du(1) < -dumax
            du(1) = -dumax;
        end;
        if du(1) > dumax
            du(1) = dumax;
        end;
        u(k) = du(1) + u(k-1);
        if u(k) < umin
            u(k) = umin;
        end;
        if u(k) > umax
            u(k) = umax;
        end;
        
    else
        u(k) = du(1)+u(k-1);
    end;
    
    U(k) = u(k)+Upp;
    
end;

e = (yzad-y)*(yzad-y)';
E = (Yzad-Y)*(Yzad-Y)';

figure;
subplot(2,1,1);
stairs(U,'b');
ylabel('U');
xlabel('k');
title(sprintf('DMC, E=%e',E));

subplot(2,1,2);
stairs(Yzad,'--r');
hold on;
stairs(Y, 'b')
ylabel('Y, Yzad');
xlabel('k');