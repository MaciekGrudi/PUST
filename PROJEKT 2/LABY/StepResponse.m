function T1 = StepResponse(G1,Z,t)
    addpath('F:\SerialCommunication'); % add a path to the functions
    initSerialControl COM22 % initialise com port
    T1=zeros(t,1);
    
    for i=1:t
        %% obtaining measurements
        T1(i) = readMeasurements(1); % read measurements from 1 to 7
        
        %% processing of the measurements and new control values calculation
        disp([T1(i), i]); % process measurements
        
        sendControls([ 1 ],   ... send for these elements
                     [ 50]);  % new corresponding control values
                 
        sendControlsToG1AndDisturbance(G1,Z);
        %% synchronising with the control process
        waitForNewIteration(); % wait for new batch of measurements to be ready
    end
end