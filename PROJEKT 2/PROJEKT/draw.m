figure;
hold on;
stairs(wY(1,1:100));
stairs(wY(2,1:100));
stairs(wY(3,1:100));
stairs(wY(4,1:100));
legend('{\lambda}=\num{1.0}','{\lambda}=\num{0.5}','{\lambda}=\num{0.25}','{\lambda}=\num{2.0}');
ylabel('Y');
xlabel('k');