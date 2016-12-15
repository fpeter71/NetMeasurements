clc
%clear all

% config it
VGate = 0.35;  % V
Frequency = linspace(240,400,100);  % GHz
ModFreq = 100;  % Hz
SampleTime = 2; % sec

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
power_out = zeros(VGateNbr,1);

% Create an analog input object
Rate =   100000; % Hz for the NI
Samples = SampleTime*Rate; % darabszam

ai = analoginput('nidaq','Dev1');

% Data will be acquired from hardware channels 
addchannel(ai,0:1);
%ai.Channel(1).HwChannel = 1;
set(ai,'InputType','SingleEnded');

set(ai,'SampleRate',Rate);
set(ai,'SamplesPerTrigger',Samples);
set(ai,'TriggerType','Manual');
blocksize = get(ai,'SamplesPerTrigger');
%% Create an analog output object
ao = analogoutput('nidaq','Dev1');
addchannel(ao, 0:3);
set(ao,'SampleRate',Rate);

%% create sin and start
trainlength = Rate/ModFreq;
dactable = ones(100*trainlength,4);

sintable = (sin(linspace(0,2*pi - (2*pi/(Rate/ModFreq)), Rate/ModFreq)') + 1) * 2.5; % to be 0..5V

%% get zero
putsample(ao, [ 0 0 0 0 ]);
pause(4);

%% get sample
start(ai);
trigger(ai);
wait(ai,15);
data = getdata(ai);
zeropwr = mean(data(:,2))/10*2e-3;

for index = 1:numel(VFreq)
    VFrequency_idx = index;
        
    dactable = ones(100*trainlength,4);
    dactable(:,1) = dactable(:,1) * VFreq(VFrequency_idx);
    dactable(:,2) = repmat(sintable, 100,1);
    dactable(:,3) = dactable(:,3) * 0;
    dactable(:,4) = dactable(:,4) * VGate;

    putdata(ao, dactable);
    set(ao, 'RepeatOutput', 100000);
    start(ao);
 
    pause(2);

    %% get sample
    start(ai);
    trigger(ai);
    wait(ai,15);
    data = getdata(ai);

    %% read out ModFreq peak
    stop(ao);
    abs_fft_data = abs(fft(data(:,1)))/length(data)/1500/2;
    data_out(VFrequency_idx) = abs_fft_data(ModFreq+1);
            
    power_out(VFrequency_idx) = mean(data(:,2))/10*2e-3;
    
    disp(data_out(VFrequency_idx));
    subplot(221),plot(Frequency(1:VFrequency_idx),data_out(1:VFrequency_idx));
    subplot(222),plot(Frequency(1:VFrequency_idx),power_out(1:VFrequency_idx));
    
    snr = data_out(1:VFrequency_idx)./power_out(1:VFrequency_idx);
    subplot(223),plot(Frequency(1:VFrequency_idx),snr);
    
end

putsample(ao, [ 0 0 0 0 ]);
pause(2);

%% get final power
start(ai);
trigger(ai);
wait(ai,15);
data = getdata(ai);
zeropwrend = mean(data(:,2))/10*2e-3;

% correction
power_out_corr = power_out - linspace(zeropwr, zeropwrend, numel(VFreq));
snr = data_out./power_out_corr;
subplot(223)
hold on
plot(Frequency(1:VFrequency_idx),snr,'k');
hold off

subplot(222)
hold on
plot(Frequency,power_out_corr,'k');
hold off    

stop(ao);
delete(ao);
clear ao;
delete(ai);
clear ai;

