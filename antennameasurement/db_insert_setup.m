%ampsetting = struct('msg', 'Hello', 'chopping_freq', 100000, 'amplifier', [1,1,0,0,1,1,1,0,0,1]);
%antenna = struct('ant_generation', 1, 'ant_serial', 1);
%amplifier = struct('amp_used', 1, 'amp_generation', 1, 'amp_serial', 3);
%power_meter_type = 'vdi'; % 'notused', 'vdi', 'qmc', 'other'
%db_insert_setup(conn, 'hello', antenna, ampsetting, amplifier, power_meter_type);
    
function id = db_insert_setup(conn, msg, antenna, ampsetting, amplifier, power_meter_type)

if ~isconnection(conn)
    disp('DB is not connected.')
    disp(conn.message);
    id = -1;
    return
end

% ampsetting = struct('msg', 'Hello', 'chopping_freq', 100000, 'amplifier', [1,1,0,0,1,1,1,0,0,1]);
ampsetting_db_key = db_insert_ampsetting (conn, ampsetting); 
if ampsetting_db_key == -1 
    id = -1;
    return
end

% insert
colnames = {'comment', 'ant_generation', 'ant_serial', ...
    'amp_used', 'amp_generation', 'amp_serial', 'amp_setting', ...
    'power_meter_type'};

data = {msg, antenna.ant_generation, antenna.ant_serial, ...
    amplifier.amp_used, amplifier.amp_generation, amplifier.amp_serial, ampsetting_db_key, ...
    power_meter_type};
tablename = 'setup_definition';

try
    net_insert(conn,tablename,colnames,data);
catch err
    disp('db_insert_setup, not happened, insert error');
    disp(err.message);
    id = -1;
    return
end

setdbprefs('NullNumberRead','0')
setdbprefs('DataReturnFormat','structure')

curs = exec(conn,'SELECT id FROM setup_definition ORDER BY id DESC LIMIT 1;');
curs = fetch(curs);
if rows(curs) == 0
    id = -1;
else
    id = double(curs.Data.id);
end

close(curs)

    




