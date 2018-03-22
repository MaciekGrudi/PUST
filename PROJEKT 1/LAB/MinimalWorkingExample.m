function skokowa = MinimalWorkingExample()
    addpath('F:\SerialCommunication'); % add a path to the functions
    initSerialControl COM3 % initialise com port
    
    
    while(1)
        %% obtaining measurements
        measurements = readMeasurements(1); % read measurements from 1 to 7
        
        %% processing of the measurements and new control values calculation
        disp(measurements); % process measurements
        
        sendControls([ 1, 5], ... send for these elements
                     [ 0, 0]);  % new corresponding control values
        %% synchronising with the control process
        waitForNewIteration(); % wait for new batch of measurements to be ready
    end
end