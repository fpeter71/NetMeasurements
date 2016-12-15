function [ data_out ] = meas_one_data( NI, Vgate, Frequency, ModFreq, SampleTime, Rate)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

    Samples = SampleTime*Rate;  % [db]
    
    %% NI
    ao = NI(1);
    ai = NI(2);
    
    
    %% Vgate error
    if or(Vgate < 0, Vgate > 1.3)
       disp('Fatal error: Vgate is out of range');
       errorcode = -1;
       return
    end    
    
    %% calculate freq
    p = polyfit([27*9.6 14.8*27], [1.3 5.7],1);
    VFreq = Frequency * p(1) + p(2);
    % freq error
    if or(VFreq < 0, VFreq > 6)
       disp('Fatal error: frequency is out of range');
       errorcode = -1;
       return
    end
          
    %% create output
    
    trainlength = Rate/ModFreq;
    dactable = ones(100*trainlength,4);

    sintable = (sin(linspace(0,2*pi - (2*pi/(Rate/ModFreq)), Rate/ModFreq)') + 1) * 2.5; % to be 0..5V

    dactable(:,1) = dactable(:,1) * VFreq;
    dactable(:,2) = repmat(sintable, 100,1);
    dactable(:,3) = dactable(:,3) * 0;
    dactable(:,4) = dactable(:,4) * Vgate;

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
    
    %% read out ModFreq peak
    abs_fft_data = abs(fft(data))/Samples*2/1500;           %% ??????????????????? ez mi ez az 1500? ???????????????????????????????????????????????????????????????
    data_out = abs_fft_data(ModFreq+1);

end

