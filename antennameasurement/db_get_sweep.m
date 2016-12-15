function [db_setup_id, comment, amp_channel, sweep, bias, modulation, temperature, datetime, response, noise, power, aux_response] = db_get_sweep(conn, sweep_db_key)

if ~isconnection(conn)
    disp('DB is not connected.')
    disp(conn.message);
    comment = [];
    sweep = [];
    bias = [];
    db_setup_id = 0;
    amp_channel = [];
    modulation = [];
    temperature = [];
    datetime = [];
    response = []; noise = []; power = []; aux_response = [];
    return
end
setdbprefs('NullNumberRead','0')
setdbprefs('DataReturnFormat','structure')

curs = exec(conn,['SELECT * FROM sweep WHERE id = ' num2str( sweep_db_key ) ]);
curs = fetch(curs);

if rows(curs) == 0
    disp('Sweep not found in the database');
    comment = [];
    sweep = [];
    bias = [];
    db_setup_id = 0;
    amp_channel = [];
    modulation = [];
    temperature = [];
    datetime = [];
    response = []; noise = []; power = []; aux_response = [];
else
    db_setup_id = curs.Data.setup;
    comment = curs.Data.comment;
    amp_channel = curs.Data.amp_channel;

    sweep = struct('type', curs.Data.sweep, 'start', curs.Data.sweep_start, ...
        'end', curs.Data.sweep_end, 'step', curs.Data.sweep_step);
    bias = struct ('vgate', curs.Data.vgate, 'frequency', curs.Data.frequency);
    
    modulation = curs.Data.modulation;
    temperature = curs.Data.temperature;
    datetime = curs.Data.date_prod;
    
    response = getarray(curs.Data.response);
    noise = getarray(curs.Data.noise);
    power = getarray(curs.Data.power);
    aux_response = getarray(curs.Data.aux_response);
end

close(curs)

% helper
function array = getarray(cDarray)

if strcmp(cDarray,'null')
    array = [];
else
    array = zeros(size(cDarray,1), size(cDarray{1}.getArray,1));
    for i=1:size(cDarray,1)
        array(i,:) = double(cDarray{i}.getArray);
    end
end




