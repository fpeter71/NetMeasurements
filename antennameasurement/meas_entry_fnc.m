function [response, noise, power, aux_result] = meas_entry_fnc(bias, sweep, modulation, SampleTime, Rate, frequency_range)

% NI device settings
inputChannel = 0;           % input connected to ai0
outputChannels = 0:3;       % outputs connected to ao0, ao1, ao2, ao3

NI = config_NI(outputChannels, inputChannel, Rate, SampleTime);

% measurement
[response, noise] = meas_sweep( NI, bias, sweep, modulation, SampleTime, Rate, frequency_range);

% clear NI
clear_NI(NI);

% for now
power = [];
aux_result = [];

% display and plot data
disp('data, noise')
disp([response,noise]);

