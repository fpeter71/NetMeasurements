clc
%clear all

% config it
VGate = 0;  % V
Frequency = linspace(240,400,20);  % GHz
ModFreq = 100;  % Hz
SampleTime = 1; % sec

% freq
p = polyfit([27*9.6 14.8*27], [1.3 5.7],1);
VFreq = Frequency * p(1) + p(2);

if or(VFreq < 0, VFreq > 6)
   disp('Fatal error: frequency is out of range');
   errorcode = -1;
   return
end


VGateNbr = length(VGate);
data_out = zeros(VGateNbr,1);

% Create an analog input object
Rate =   100000; % Hz for the NI
Samples = SampleTime*Rate; % darabszam

ai = analoginput('nidaq','Dev1');

% Data will be acquired from hardware channels 
addchannel(ai,0);
ai.Channel(1).HwChannel = 1;
set(ai,'InputType','SingleEnded');

set(ai,'SampleRate',Rate);
set(ai,'SamplesPerTrigger',Samples);
set(ai,'TriggerType','Manual');
blocksize = get(ai,'SamplesPerTrigger');
%% Create an analog output object
ao = analogoutput('nidaq','Dev1');
addchannel(ao, 0:3);
set(ao,'SampleRate',Rate);

for VFrequency_idx = 1:numel(VFreq)
    putsample(ao, [ VFreq(VFrequency_idx) 0 0 0 ]);
    pause(1);

    %% get sample
    start(ai);
    trigger(ai);
    wait(ai,15);
    data = getdata(ai);

    %% read out ModFreq peak
    data_out(VFrequency_idx)=mean(data)/10*2e-3;
    disp(data_out(VFrequency_idx));
    plot(Frequency(1:VFrequency_idx),data_out(1:VFrequency_idx));
end
plot(Frequency,data_out)
putsample(ao, [ 0 0 0 0 ]);


stop(ao);
delete(ao);
clear ao;
delete(ai);
clear ai;

