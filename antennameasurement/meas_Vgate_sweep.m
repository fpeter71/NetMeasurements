function [ data_vector_out, noise_vector_out ] = meas_Vgate_sweep( NI, Vgate, Frequency, ModFreq, SampleTime, Rate, fhandle, frequency_range)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    
    Samples = SampleTime*Rate;  % [db]

    VgateNbr = length(Vgate);               % nbr of points?
    data_vector_out = zeros(VgateNbr,1);    % generate the empty output vector
    noise_vector_out = zeros(VgateNbr,1);   % generate the empty output vector
    
    for Vgate_idx = 1:numel(Vgate)
        [data_vector_out(Vgate_idx), noise_vector_out(Vgate_idx)]  = meas_one_point(NI, Vgate(Vgate_idx), Frequency, ModFreq, SampleTime, Rate, frequency_range);
        
        figure(fhandle);
        cla;
        errorbar(Vgate(1:Vgate_idx),data_vector_out(1:Vgate_idx), noise_vector_out(1:Vgate_idx),'-o');
    
    end

end

