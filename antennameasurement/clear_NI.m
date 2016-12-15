function [  ] = clear_NI( NI )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    
    ao=NI(1);
    ai=NI(2);
    
    delete(ao);
    clear ao;
    delete(ai);
    clear ai;
    

end

