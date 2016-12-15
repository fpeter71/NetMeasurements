function [ data_vector_out, noise_vector_out ] = meas_Freq_sweep( NI, Vgate, Frequency, ModFreq, SampleTime,Rate, fhandle, frequency_range)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    
    Samples = SampleTime*Rate;  % [db]
    
    FreqNbr = length(Frequency);               % nbr of points?
    data_vector_out = zeros(FreqNbr,1);    % generate the empty output vector
    noise_vector_out = zeros(FreqNbr,1);   % generate the empty output vector

    for Freq_idx = 1:numel(Frequency)
        [data_vector_out(Freq_idx), noise_vector_out(Freq_idx)] = meas_one_point(NI, Vgate, Frequency(Freq_idx), ModFreq, SampleTime, Rate, frequency_range);
        
        figure(fhandle);
        cla;
        errorbar(Frequency(1:Freq_idx),data_vector_out(1:Freq_idx), noise_vector_out(1:Freq_idx),'-o');
    
    end

end

