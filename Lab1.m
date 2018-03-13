clear step;

G=30;
time=600;

%step=StepResponse(G,time);

[Y,U]=PID(6,63.5,15.875,30.0);