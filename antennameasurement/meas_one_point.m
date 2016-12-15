function [ data_out, noise_out ] = meas_one_point( NI, Vgate, Frequency, ModFreq, SampleTime, Rate, frequency_range)
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
    switch frequency_range
        case 1, % WR4.3 170-260 GHz
            p = polyfit([18*9.4 18*14.5], [1.2 5.4],1);
        case 2, % WR2.8 260-400 GHz
            p = polyfit([27*9.6 14.8*27], [1.3 5.7],1);
        case 3, % WR2.2 330-550 GHz
            p = polyfit([36*9.1 36*13.9], [0.9 4.9],1);
        otherwise,
           disp('Fatal error: frequency_range is out of range');
           errorcode = -1;
           return 
    end
    
    VFreq = Frequency * p(1) + p(2);
    % freq error
    if or(VFreq < 0, VFreq > 6)
       disp('Fatal error: frequency is out of range');
       errorcode = -1;
       return
    end
          
    %% create output
    
    if ModFreq >0
        trainlength = Rate/ModFreq;     % points per 1 period
        dactable = ones(100*trainlength,4);
        sintable = (sin(linspace(0, 2*pi - (2*pi/(Rate/ModFreq)), trainlength)') + 1) * 2.5; % to be 0..5V
    else
        disp('modulation frequency error, ModFreq<=0 Hz');
        errorcode = -1;
        return
    end

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
    abs_fft_data = abs(fft(data))/Samples*2;    % no amplifier correction
    %plot(abs_fft_data)
    data_out = abs_fft_data(ModFreq/Rate*Samples+1);
    noise_out = (abs_fft_data(ModFreq-1)+abs_fft_data(ModFreq+0)+abs_fft_data(ModFreq+2)+abs_fft_data(ModFreq+3))/4;
    
end

