clear;

limits = 0;
distortion = 1;

load step;

%t = 12;
t = 6;
T = 0.5;
D = length(s); N = 200; Nu = 200; lambda = 1;
Dz = length(sz);
Upp = 0; Ypp = 0; Zpp = 0;
Umin = 0.1; Umax = 1.5; dUmax = 0.2;

s(D+1:1000) = s(D);
sz(Dz+1:1000) = sz(Dz);

umin = Umin - Upp; umax = Umax - Upp; dumax = dUmax;

Yzad(1:20)=Ypp; Yzad(21:400)=Ypp+1;
%Z(1:400) = Zpp;
%Z(1:99) = Zpp; Z(100:400) = Zpp + 1; %zad 5
Z(1:99) = Zpp; Z(100:400) = Zpp + 0.2*sin(0:0.2:(300*0.2)); %zad 6


yzad = Yzad - Ypp;
z = Z - Zpp;
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

MPz = zeros(N,Dz);
for i = 1:Dz
    MPz(:,i) = sz((i+1):(i+N))-sz(i);
end;

K = (M'*M + lambda*eye(Nu))\M';
K1 = K(1,:);
Ku = K1 * MP;
Ke = sum(K1);

DUP = zeros(D-1,1);
DZP = zeros(Dz,1);

Y(1:t)=Ypp;
U(1:t)=Upp;

y(1:t) = Y(1:t) - Ypp;
u(1:t) = U(1:t) - Upp;

for k=t:kk
    
    Y(k) = symulacja_obiektu7y(U(k-4),U(k-5),Z(k-1),Z(k-2),Y(k-1),Y(k-2));
    y(k) = Y(k) - Ypp;
    
    DUP = [u(k-1) - u(k-2) ; DUP(1:D-2)];
    DZP = [z(k-1) - z(k-2) ; DZP(1:Dz-1)];
    
    e = yzad(k) - y(k);
    
%   vec_Y0 = y(k)*ones(N,1)+MP*DUP;
%   vec_Yzad = yzad(k)*ones(N,1);
%   du = K*(vec_Yzad-vec_Y0);
    
    du = Ke*e - Ku*DUP;
    
    if distortion ~= 0
        du = Ke*e - K1*MP*DUP - K1*MPz*DZP;
    end;
    
    u(k) = du(1)+u(k-1);
    U(k) = u(k)+Upp;
    %U(k)=1;
    
end;

e = (yzad-y)*(yzad-y)';
E = (Yzad-Y)*(Yzad-Y)';

figure;
subplot(3,1,1);
stairs(U,'b');
ylabel('U');
xlabel('k');
title(sprintf('D=%d,N=%d, N_u=%d, lambda =%f, E=%e',D,N,Nu,lambda,E));
%title(sprintf('D=%d,N=%d, N_u=%d, lambda =%f, Dz = %d, E=%e',D,N,Nu,lambda,Dz,E));

subplot(3,1,2);
stairs(Yzad,'--r');
hold on;
stairs(Y, 'b')
ylabel('Y, Yzad');
xlabel('k');

subplot(3,1,3);
stairs(Z,'b');
hold on;
ylabel('Z');
xlabel('k');

clear i k kk t

hold off;