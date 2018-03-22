function skokowa = StepResponse(G1,time)
    addpath('F:\SerialCommunication'); % add a path to the functions
    initSerialControl COM3 % initialise com port
    
    for k=1:time
        %% obtaining measurements
        skokowa(k) = readMeasurements(1); % read measurements from 1 to 7
        
        %% processing of the measurements and new control values calculation
        %disp(measurements); % process measurements
        disp(skokowa(k));
        disp(k);
        
        sendControls([ 1, 5], ... send for these elements
                     [ 50, G1]);  % new corresponding control values
        %% synchronising with the control process
        waitForNewIteration(); % wait for new batch of measurements to be ready
    end
end