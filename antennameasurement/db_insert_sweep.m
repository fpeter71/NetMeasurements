
% type: 'vgate', 'frequency', 'other'
%sweep = struct('type', 'vgate', 'start', 0.0, 'end', 0.0, 'step', 0.01);
%bias = struct ('vgate', 0, 'frequency', 250);

function id = db_insert_sweep (conn, msg, db_setup_id, modulation, temperature, amp_channel, bias, sweep, response, noise, power, aux_result)

if ~isconnection(conn)
    disp('DB is not connected.')
    disp(conn.message);
    id = -1;
    return
end

%sweep = struct('type', 'vgate', 'start', 0.0, 'end', 0.0, 'step', 0.01);
% insert
colnames = {'comment', 'temperature', 'setup', 'modulation', ...
    'amp_channel', 'vgate', 'frequency',  ...
    'sweep', 'sweep_start', 'sweep_end', 'sweep_step', ...
    'response', 'noise', 'power', 'aux_response' };

data = {msg, temperature , db_setup_id, modulation, ...
    amp_channel, bias.vgate, bias.frequency, ...
    sweep.type, sweep.start, sweep.end, sweep.step, ...
    array2str(response), array2str(noise), array2str(power), array2str(aux_result)};
tablename = 'sweep';

try
    net_insert(conn,tablename,colnames,data);
catch err
    disp('db_insert_sweep, not happened, insert error');
    disp(err.message);
    id = -1;
    return
end

id = 1;

% helper to create from array a '{-1.0, -2.1, -3.2}'
function txt = array2str(array) 

if isempty(array)
    txt = [];
else
    if length(array) == 1
        txt = mat2str(array);
    else
        if size(array,2) > size(array,1)
            txt = strrep(mat2str(array),' ', ',');
        else
            txt = strrep(mat2str(array),';', ',');
        end
        txt = ['{' txt(2:end-1) '}'];
    end
end





    
    
    