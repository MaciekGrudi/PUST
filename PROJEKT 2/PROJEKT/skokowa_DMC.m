function [YDMCU, YDMCZ] = skokowa_DMC(simTime)
    YDMCU=symulacja_obiektu_UppYppZpp(1,0,0,simTime);
    YDMCZ=symulacja_obiektu_UppYppZpp(0,0,1,simTime);
end