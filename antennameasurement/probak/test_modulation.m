clc
%clear all

% config it
VGate = linspace(0.4,0.8,10);  % V
Frequency = 360;  % GHz
ModFreq = 100;  % Hz
SampleTime = 1; % sec

if or(VGate < 0, VGate > 1.3)
   disp('Fatal error: vgate is out of range');
   errorcode = -1;
   return
end

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

for VGate_idx = 1:numel(VGate)
    ai = analoginput('nidaq','Dev1');

    % Data will be acquired from hardware channels 
    addchannel(ai,0);
    ai.Channel(1).HwChannel = 0;
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

    dactable(:,1) = dactable(:,1) * VFreq;
    dactable(:,2) = repmat(sintable, 100,1);
    dactable(:,3) = dactable(:,3) * 0;
    dactable(:,4) = dactable(:,4) * VGate(VGate_idx);


    putdata(ao, dactable);
    set(ao, 'RepeatOutput', 100000);

    start(ao);
    pause(1);

    %% get sample
    start(ai);
    trigger(ai);
    wait(ai,15);
    data = getdata(ai);

    %% finish
    stop(ao);
    %putsample(ao, 0);
    delete(ao);
    clear ao;
    delete(ai);
    clear ai;

    %% read out ModFreq peak
    abs_fft_data = abs(fft(data))/Samples*2/1500;
    %plot(abs_fft_data)
    %hold on;
    data_out(VGate_idx)=abs_fft_data(ModFreq+1);
    disp(data_out(VGate_idx));
end
plot(VGate,data_out)