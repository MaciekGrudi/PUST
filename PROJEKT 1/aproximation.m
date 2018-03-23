<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
function [q,step,e,U] = aproximation(Y,delay)
y = Y(3:length(Y));
N = length(y);
U = ones(length(Y),1);
U(1:delay) = 0;
M = [ -Y(2:N) -Y(1:N-1) U(2:N) U(1:N-1)];

y = y(1:N-1);

q = M\y;

step = zeros(2,1);
e = 0;
for i = 3:length(Y)
    step(i) = q(3)*U(i-1) + q(4)*U(i-2) - step(i-1)*q(1) - step(i-2)*q(2);
    e = e + (Y(i)-step(i))*(Y(i)-step(i));
end

hold off;
stairs(Y);
hold on;
stairs(step);



=======
function [q,step,e,U] = aproximation(Y,delay)
y = Y(3:length(Y));
N = length(y);
U = ones(length(Y),1);
U(1:delay) = 0;
M = [ -Y(2:N) -Y(1:N-1) U(2:N) U(1:N-1)];

y = y(1:N-1);

q = M\y;

step = zeros(2,1);
e = 0;
for i = 3:length(Y)
    step(i) = q(3)*U(i-1) + q(4)*U(i-2) - step(i-1)*q(1) - step(i-2)*q(2);
    e = e + (Y(i)-step(i))*(Y(i)-step(i));
end

hold off;
stairs(Y);
hold on;
stairs(step);



>>>>>>> 1aa569faa9f60a46403ca971df9c995fe9adabf0
=======
function [q,step,e,U] = aproximation(Y,delay)
y = Y(3:length(Y));
N = length(y);
U = ones(length(Y),1);
U(1:delay) = 0;
M = [ -Y(2:N) -Y(1:N-1) U(2:N) U(1:N-1)];

y = y(1:N-1);

q = M\y;

step = zeros(2,1);
e = 0;
for i = 3:length(Y)
    step(i) = q(3)*U(i-1) + q(4)*U(i-2) - step(i-1)*q(1) - step(i-2)*q(2);
    e = e + (Y(i)-step(i))*(Y(i)-step(i));
end

hold off;
stairs(Y);
hold on;
stairs(step);



>>>>>>> 1aa569faa9f60a46403ca971df9c995fe9adabf0
=======
function [q,step,e,U] = aproximation(Y,delay)
y = Y(3:length(Y));
N = length(y);
U = ones(length(Y),1);
U(1:delay) = 0;
M = [ -Y(2:N) -Y(1:N-1) U(2:N) U(1:N-1)];

y = y(1:N-1);

q = M\y;

step = zeros(2,1);
e = 0;
for i = 3:length(Y)
    step(i) = q(3)*U(i-1) + q(4)*U(i-2) - step(i-1)*q(1) - step(i-2)*q(2);
    e = e + (Y(i)-step(i))*(Y(i)-step(i));
end

hold off;
stairs(Y);
hold on;
stairs(step);



>>>>>>> 1aa569faa9f60a46403ca971df9c995fe9adabf0
end