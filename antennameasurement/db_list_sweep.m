function [db_sweep_id, comment] = db_list_sweep(conn, sqlfilter)

if ~isconnection(conn)
    disp('DB is not connected.')
    disp(conn.message);
    comment = [];
    db_sweep_id = [];
    return
end
setdbprefs('NullNumberRead','0')
setdbprefs('DataReturnFormat','structure')

curs = exec(conn,['SELECT * FROM sweep ' sqlfilter]);
curs = fetch(curs);

if rows(curs) == 0
    disp('No sweeps in the database');
    comment = [];
    db_sweep_id = [];
else
    db_sweep_id = curs.Data.id;
    comment = curs.Data.comment;
end

close(curs)


