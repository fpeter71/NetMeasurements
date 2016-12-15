%% input parameters
% amplifier and hw description
% antenna = struct('ant_generation', 3, 'ant_serial', 2);
% amplifier = struct('amp_used', 1, 'amp_generation', 1, 'amp_serial', 2);
% power_meter_type = 'notused'; % 'notused', 'vdi', 'qmc', 'other'


% measure settings
% structures
bias = struct ('vgate', 0.4, 'frequency', 280);
sweep = struct('type', 'frequency', 'start', 290, 'end', 320, 'step', 5);  % type: 'vgate', 'frequency', 'other'
temperature = 24.0; % celsius
modulation = 100; % hz
channel = 1; % 0-15
response = rand(10,1);
noise = rand(10,1);
power = [];
aux_result = rand(10,1);


% NI device settings
inputChannel = 0;           % input connected to ai0
outputChannels = 0:3;       % outputs connected to ao0, ao1, ao2, ao3

% sampling parameters
Rate =   100000;            % measure and output rate for the NI [Hz]
SampleTime = 0.2;             % measure time at one point [sec]


% amplifier board settings
% ampsetting = struct('msg', 'Hello', 'chopping_freq', 250000, 'amplifier', [0,1,0,0,1,1,1,0,0,1]);
%???
%???



%% measure
% config NI
NI = config_NI(outputChannels, inputChannel, Rate, SampleTime);

% measurement
[response, noise] = meas_sweep( NI, bias, sweep, modulation, SampleTime, Rate);

% clear NI
clear_NI(NI);

% display and plot data
disp('data, noise')
disp([response,noise]);

%sweep_vector = linspace(sweep.start, sweep.end,(sweep.end-sweep.start)/sweep.step+1);
%plot(sweep_vector,response)
%figure
%errorbar(sweep_vector,response,noise)
%title(sweep.type)

