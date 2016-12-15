% Also checked version and license of DB toolbox, such as :
% ver database
% which database
% org.postgresql.Driver
% https://www.mathworks.com/products/database/driver-installation.html
clear variables
clc
p = 'd:\FoldesyPeter\antennameasurement\install\postgreSQL\postgresql-9.4.1212.jre6.jar';
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

% list all sweeps
disp('All sweeps');
[db_sweep_id, comment] = db_list_sweep(conn, '');
for i=1:length(comment)
    fprintf('%d - %s\n', db_sweep_id(i), comment{i});
end

%{
% with sql selection
disp('Sweeps with sql selection');
[db_sweep_id, comment] = db_list_sweep(conn, 'where sweep = ''vgate''');
for i=1:length(comment)
    fprintf('%d - %s\n', db_sweep_id(i), comment{i});
end
%}
% get a single sweep with id
% e.g. the last
disp('the last sweep`s data');
sweep_db_key = db_sweep_id(end);
[db_setup_id, comment, channel, sweep, bias, modulation, temperature, datetime, response, noise, power, aux_response] = db_get_sweep(conn, sweep_db_key);
comment, channel, sweep, bias, modulation, temperature, datetime

[comment, antenna, ampsetting, amplifier, power_meter_type] = db_get_setup(conn, db_setup_id);
comment, antenna, ampsetting, amplifier, power_meter_type
%}

close(conn);

