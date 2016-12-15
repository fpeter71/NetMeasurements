function [ response, noise ] = meas_sweep( NI, bias, sweep, modulation, SampleTime, Rate, frequency_range)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    
    Vgate = bias.vgate;
    Frequency = bias.frequency;
    ModFreq = modulation;
    sweep_width = sweep.end-sweep.start;
    sweep_vector = linspace(sweep.start, sweep.end, (sweep_width)/sweep.step+1);
    
    fhandle = figure('Name', 'Sweep measurement, live...','NumberTitle','off');
    hold on;
    title(strcat('Sweep type: ',sweep.type));
    ylabel('Sense voltage (V)');
    axis([sweep.start-sweep_width*0.1 sweep.end+sweep_width*0.1 -inf inf]);
    
    if strcmp(sweep.type,'vgate')
        disp('Vgate sweep');
        xlabel('Vgate (V)');
        Vgate = sweep_vector;
        [response, noise] = meas_Vgate_sweep( NI, Vgate, Frequency, ModFreq, SampleTime, Rate, fhandle, frequency_range);
    elseif strcmp(sweep.type,'frequency')
        disp('Frequency sweep');
        xlabel('Frequency (GHz)');
        Frequency = sweep_vector;
        [response, noise] = meas_Freq_sweep( NI, Vgate, Frequency, ModFreq, SampleTime, Rate, fhandle, frequency_range);
    else
        disp('unknown sweep type');
    end
    hold off;
end

