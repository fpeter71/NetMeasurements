%ampsetting = struct('msg', 'Hello', 'chopping_freq', 100000, 'amplifier', [1,1,0,0,1,1,1,0,0,1]);

function id = db_insert_ampsetting (conn, ampsetting)

if ~isconnection(conn)
    disp('DB is not connected.')
    disp(conn.message);
    id = -1;
    return
end

% just of the readablity
input_chopping =  ampsetting.amplifier(1);
calibration_input_grounded =  ampsetting.amplifier(2);
positive_grounded = ampsetting.amplifier(3);
negative_grounded =  ampsetting.amplifier(4);
multiplication_5x_20x = ampsetting.amplifier(5);
multiplication_50x_100x = ampsetting.amplifier(6);
output_demodulation = ampsetting.amplifier(7);
output_polarity = ampsetting.amplifier(8);
bypass_lpf = ampsetting.amplifier(9);
enable_input_offset = ampsetting.amplifier(10);

% insert
colnames = {'name', 'chopping_freq', 'input_chopping', 'calibration_input_grounded', ...
    'positive_grounded', 'negative_grounded', 'multiplication_5x_20x', ...
    'multiplication_50x_100x', 'output_demodulation', 'output_polarity', ...
    'bypass_lpf', 'enable_input_offset'};
data = {ampsetting.msg, ampsetting.chopping_freq, ...
    input_chopping, calibration_input_grounded, ...
    positive_grounded, negative_grounded, multiplication_5x_20x, ...
    multiplication_50x_100x, output_demodulation, output_polarity, ...
    bypass_lpf, enable_input_offset};
tablename = 'amp_settings';

try
    myinsert(conn,tablename,colnames,data);
catch err
    disp('db_insert_ampsetting, not happened, insert error');
    id = -1;
    return
end

% get the id as the last of them
setdbprefs('NullNumberRead','0')
setdbprefs('DataReturnFormat','structure')

curs = exec(conn,'SELECT id FROM amp_settings  ORDER BY id DESC LIMIT 1;');
curs = fetch(curs);

if rows(curs) == 0
    id = -1;
else
    id = double(curs.Data.id);
end

close(curs)

    




