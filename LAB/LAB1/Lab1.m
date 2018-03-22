clear step;

G=30;
time=600;

%step=StepResponse(G,time);

[Y,U,Yzad]=PID(9.0,45.0,0.02);

%params=[400,200,1.0];
%[Y,U,Yzad,E_wsk]=DMC_simulation(params,0,DMCstep);