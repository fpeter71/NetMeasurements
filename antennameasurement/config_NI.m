function [ NI ] = config_NI( outputChannels, inputChannel, Rate, SampleTime )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

    Samples = SampleTime*Rate;  % [db]

    %% output channels
    ao = analogoutput('nidaq','Dev1');
    addchannel(ao, outputChannels);
    set(ao,'SampleRate',Rate);

    %% input channel
    ai = analoginput('nidaq','Dev1');
    % Data will be acquired from hardware channels 
    addchannel(ai,inputChannel);
    ai.Channel(1).HwChannel = inputChannel;
    set(ai,'InputType','SingleEnded');


    set(ai,'SampleRate',Rate);
    set(ai,'SamplesPerTrigger',Samples);
    set(ai,'TriggerType','Manual');
    blocksize = get(ai,'SamplesPerTrigger');
    
    %% out NI
    NI = [ao, ai];
    
end

