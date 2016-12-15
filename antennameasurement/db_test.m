% Also checked version and license of DB toolbox, such as :
% ver database
% which database
% org.postgresql.Driver
% https://www.mathworks.com/products/database/driver-installation.html
clear all
clc
% java 1.8
p = 'd:\postgreSQL\postgresql-9.4.1212.jre6.jar';
% java 

if ~ismember(p,javaclasspath)  
    javaaddpath(p)  
end
%{ 
matlab 2012
conn = database('postgres', 'postgres', 'mems0802', ...
                'Vendor', 'postgreSQL',...
                'Driver','org.postgresql.Driver',...
                'URL', 'jdbc:postgresql://localhost:5432/');
%}

% matlab 2009
conn = database('postgres', 'postgres', 'mems0802', ...
                'org.postgresql.Driver',...
                'jdbc:postgresql://localhost:5432/');
            
if isconnection(conn)
    disp('database connected')
else
    disp('cannot connect')
    disp(conn.message);
    return
end

setdbprefs('NullNumberRead','0')
setdbprefs('DataReturnFormat','structure')

% the functions
% create amplifier and hw description
ampsetting = struct('msg', 'Hello', 'chopping_freq', 250000, 'amplifier', [0,1,0,0,1,1,1,0,0,1]);
antenna = struct('ant_generation', 3, 'ant_serial', 2);
amplifier = struct('amp_used', 1, 'amp_generation', 1, 'amp_serial', 2);
power_meter_type = 'notused'; % 'notused', 'vdi', 'qmc', 'other'

db_setup_id = db_insert_setup(conn, 'hello', antenna, ampsetting, amplifier, power_meter_type);

% create a sweep and link to the setup
% type: 'vgate', 'frequency', 'other'
sweep = struct('type', 'frequency', 'start', 280, 'end', 420, 'step', 1);
bias = struct ('vgate', 0.4, 'frequency', 280);
temperature = 24.0; % celsius
modulation = 100; % hz
channel = 1; % 0-15
response = rand(10,1);
noise = rand(10,1);
power = [];
aux_result = rand(10,1);

db_insert_sweep (conn, 'Hello1', db_setup_id, modulation, temperature, channel, bias, sweep, response, noise, power, aux_result);

close(conn);

