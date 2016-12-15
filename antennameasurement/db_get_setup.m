function [msg, antenna, ampsetting, amplifier, power_meter_type] = db_get_setup(conn, ampsetting_db_key)

if not(isempty(conn.message))
    disp('DB is not connected.')
    disp(conn.message);
    msg = [];
    antenna = [];
    ampsetting = [];
    amplifier = [];
    power_meter_type = [];
    return
end
setdbprefs('NullNumberRead','0')
setdbprefs('DataReturnFormat','structure')

% SELECT id, date, comment, ant_generation, ant_serial,
% amp_used, amp_generation, amp_serial, name, input_chopping, calibration_input_grounded,
% positive_grounded, negative_grounded, multiplication_5x_20x, multiplication_50x_100x, output_demodulation, %
%output_polarity, bypass_lpf, enable_input_offset, power_meter_type FROM public.setup_read;

curs = exec(conn,['SELECT * FROM setup_read WHERE id = ' num2str( ampsetting_db_key ) ]);
curs = fetch(curs);

if rows(curs) == 0
    disp('Setup not found in the database');
    msg = 'Setup not found in the database';
    antenna = [];
    ampsetting = [];
    amplifier = [];
    power_meter_type = [];
else
    msg = curs.Data.comment;
    antenna = struct('ant_generation', curs.Data.ant_generation, 'ant_serial', curs.Data.ant_serial);
    amplifier = struct('amp_used', curs.Data.amp_used, 'amp_generation', curs.Data.amp_generation, ...
        'amp_serial', curs.Data.amp_serial);
    power_meter_type = curs.Data.power_meter_type;
    ampsetting = struct('msg', curs.Data.name, 'chopping_freq', curs.Data.chopping_freq, ...
        'amplifier', [curs.Data.input_chopping, curs.Data.calibration_input_grounded, ...
    curs.Data.positive_grounded, curs.Data.negative_grounded, curs.Data.multiplication_5x_20x, ...
    curs.Data.multiplication_50x_100x, curs.Data.output_demodulation, curs.Data.output_polarity, ...
    curs.Data.bypass_lpf, curs.Data.enable_input_offset ]);

end

close(curs)


