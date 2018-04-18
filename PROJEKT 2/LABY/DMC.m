clear all;

addpath('F:\SerialCommunication'); % add a path to the functions
initSerialControl COM22; % initialise com port

limits = 1;
distortion = 0;

load step;

%t = 12;
t = 6;
T = 0.5;
D = length(s); N = 400; Nu = 100; lambda = 0.01;
%D = length(s); N = 200; Nu = 15; lambda = 1;
Dz = length(sz);
Upp = 32; Ypp = 36; Zpp = 0;
Umin = 0; Umax = 100; dUmax = 10;

s(D+1:1000) = s(D);
sz(Dz+1:1000) = sz(Dz);

umin = Umin - Upp; umax = Umax - Upp; dumax = dUmax;

Yzad(1:20)=Ypp; Yzad(21:380)=Ypp+3; Yzad(381:400)=Ypp;
%Z(1:60) = Zpp; Z(61:400) = Zpp + 0.4; %zad 5
%Z(1:60) = Zpp; Z(61:400) = Zpp + 0.2*sin(0:0.2:27.8); %zad 6
%Z(1:400) = Zpp;
Z(1:199)=0; Z(200:299)=30; Z(300:400)=45; 
U(1:400)=0;

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

K = inv(M'*M + lambda*eye(Nu))*M';
K1 = K(1,:);
Ku = K1 * MP;
Ke = sum(K1);

DUP = zeros(D-1,1);
DZP = zeros(Dz,1);

Y(1:t)=Ypp;
U(1:t)=Upp;

y(1:t) = Y(1:t) - Ypp;
u(1:t) = U(1:t) - Upp;

for k=3:400
    
    %Y(k) = symulacja_obiektu7y(U(k-4),U(k-5),Z(k-1),Z(k-2),Y(k-1),Y(k-2));
    Y(k)= readMeasurements(1);
    y(k) = Y(k) - Ypp;
    
    DUP = [u(k-1) - u(k-2) ; DUP(1:D-2)];
    DZP = [z(k-1) - z(k-2) ; DZP(1:Dz-1)];
    
    e = yzad(k) - y(k);
    
%     vec_Y0 = y(k)*ones(N,1)+MP*DUP;
%     vec_Yzad = yzad(k)*ones(N,1);
%     du = K*(vec_Yzad-vec_Y0);
    
    du = Ke*e - Ku*DUP;
    
    if distortion ~= 0
        du = Ke*e - K1*MP*DUP - K1*MPz*DZP;
    end;
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
        %u(k) = du+u(k-1);
        u(k) = du(1)+u(k-1);
    end;
    
    U(k) = u(k)+Upp;
    
    sendControls([ 1 ],   ... send for these elements
                   [ 50 ]);  % new corresponding control values
    
    sendControlsToG1AndDisturbance(U(k),Z(k));

    figure(1);
    subplot(3,1,1);
    stairs(Y,'r');
    hold on;
    grid on;
    stairs(Yzad,'--r');
    ylabel('Y');
    xlabel('k');
    title('Y(k)');
    
    subplot(3,1,2);
    stairs(U,'b');
    grid on;
    ylabel('U');
    xlabel('k');
    title('U(k)');
    
    subplot(3,1,3);
    stairs(Z,'r');
    grid on;
    ylabel('Z');
    xlabel('k');
    title('Z(k)');
    
    drawnow;
    
    waitForNewIteration();
end;

e = (yzad-y)*(yzad-y)';
E = (Yzad-Y)*(Yzad-Y)';
