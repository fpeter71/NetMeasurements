function varargout = gui_measurement_setup(varargin)
% GUI_MEASUREMENT_SETUP M-file for gui_measurement_setup.fig
%      GUI_MEASUREMENT_SETUP, by itself, creates a new GUI_MEASUREMENT_SETUP or raises the existing
%      singleton*.
%
%      H = GUI_MEASUREMENT_SETUP returns the handle to a new GUI_MEASUREMENT_SETUP or the handle to
%      the existing singleton*.
%
%      GUI_MEASUREMENT_SETUP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_MEASUREMENT_SETUP.M with the given input arguments.
%
%      GUI_MEASUREMENT_SETUP('Property','Value',...) creates a new GUI_MEASUREMENT_SETUP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_measurement_setup_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_measurement_setup_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_measurement_setup



% Last Modified by GUIDE v2.5 06-Dec-2016 11:09:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_measurement_setup_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_measurement_setup_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui_measurement_setup is made visible.
function gui_measurement_setup_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_measurement_setup (see VARARGIN)

global led;

global ampsetting;
global antenna;
global amplifier;
global power_meter_type;
global sweep;
global bias;
global temperature;
global modulation;
global channel;
global response;
global noise;
global power;
global aux_response;


% Choose default command line output for gui_measurement_setup
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_measurement_setup wait for user response (see UIRESUME)
% uiwait(handles.figure1);
led = 0;
%s.ReadAsyncMode='Continuous'; % mode of reading

% --- Outputs from this function are returned to the command line.
function varargout = gui_measurement_setup_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in resetbutton.
function resetbutton_Callback(hObject, eventdata, handles)
% hObject    handle to resetbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

msg = 'R';
msg(end+1)=13;

comport_name =  get(findobj('Tag', 'comport'), 'String');
comport = char(comport_name(get(findobj('Tag', 'comport'), 'Value'))); s = serial(comport);
set(s,'BaudRate',9600,'DataBits',8,'Parity','none','StopBits',1,'FlowControl','none','InputBufferSize',102400) % serial port properties
fopen(s); % connecting to a device using fopen
fwrite(s,msg);
fclose(s);

% --- Executes on button press in calibratebutton.
function calibratebutton_Callback(hObject, eventdata, handles)
% hObject    handle to calibratebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

msg = 'C';

msg(end+1)=13;
comport_name =  get(findobj('Tag', 'comport'), 'String');
comport = char(comport_name(get(findobj('Tag', 'comport'), 'Value'))); s = serial(comport);
set(s,'BaudRate',9600,'DataBits',8,'Parity','none','StopBits',1,'FlowControl','none','InputBufferSize',102400) % serial port properties
fopen(s); % connecting to a device using fopen
fwrite(s,msg);
fclose(s);

% --- Executes on button press in chopper.
function chopper_Callback(hObject, eventdata, handles)
% hObject    handle to chopper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chopper


% --- Executes on button press in groundinput.
function groundinput_Callback(hObject, eventdata, handles)
% hObject    handle to groundinput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of groundinput


% --- Executes on button press in groundplus.
function groundplus_Callback(hObject, eventdata, handles)
% hObject    handle to groundplus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of groundplus


% --- Executes on button press in groundnegative.
function groundnegative_Callback(hObject, eventdata, handles)
% hObject    handle to groundnegative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of groundnegative


% --- Executes on button press in mult520.
function mult520_Callback(hObject, eventdata, handles)
% hObject    handle to mult520 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mult520


% --- Executes on button press in mult50100.
function mult50100_Callback(hObject, eventdata, handles)
% hObject    handle to mult50100 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mult50100


% --- Executes on button press in bypasslpf.
function bypasslpf_Callback(hObject, eventdata, handles)
% hObject    handle to bypasslpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bypasslpf



% --- Executes on key press with focus on updatebutton and none of its controls.
function updatebutton_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to updatebutton (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure


delete(hObject);


% --- Executes on button press in usecalib.
function usecalib_Callback(hObject, eventdata, handles)
% hObject    handle to usecalib (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of usecalib


% --- Executes on button press in led.
function led_Callback(hObject, eventdata, handles)
% hObject    handle to led (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global led;

msg = sprintf('L%s', sprintf('%i',bitget(led, 1:4)));

msg(end+1)=13;

comport_name =  get(findobj('Tag', 'comport'), 'String');
comport = char(comport_name(get(findobj('Tag', 'comport'), 'Value'))); s = serial(comport);
set(s,'BaudRate',9600,'DataBits',8,'Parity','none','StopBits',1,'FlowControl','none','InputBufferSize',102400) % serial port properties
fopen(s); % connecting to a device using fopen
fwrite(s,msg);
fclose(s);
led = led + 1;

function clk_Callback(hObject, eventdata, handles)
% hObject    handle to clk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of clk as text
%        str2double(get(hObject,'String')) returns contents of clk as a double


% --- Executes during object creation, after setting all properties.
function clk_CreateFcn(hObject, eventdata, handles)
% hObject    handle to clk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in outchop.
function outchop_Callback(hObject, eventdata, handles)
% hObject    handle to outchop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of outchop

% --- Executes during object creation, after setting all properties.
function pushbutton5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function channelselect_Callback(hObject, eventdata, handles)
% hObject    handle to channelselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of channelselect as text
%        str2double(get(hObject,'String')) returns contents of channelselect as a double


% --- Executes during object creation, after setting all properties.
function channelselect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channelselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ant_generation_Callback(hObject, eventdata, handles)
% hObject    handle to ant_generation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ant_generation as text
%        str2double(get(hObject,'String')) returns contents of ant_generation as a double


% --- Executes during object creation, after setting all properties.
function ant_generation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ant_generation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ant_serial_Callback(hObject, eventdata, handles)
% hObject    handle to ant_serial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ant_serial as text
%        str2double(get(hObject,'String')) returns contents of ant_serial as a double


% --- Executes during object creation, after setting all properties.
function ant_serial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ant_serial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function amp_generation_Callback(hObject, eventdata, handles)
% hObject    handle to amp_generation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amp_generation as text
%        str2double(get(hObject,'String')) returns contents of amp_generation as a double


% --- Executes during object creation, after setting all properties.
function amp_generation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amp_generation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function amp_serial_Callback(hObject, eventdata, handles)
% hObject    handle to amp_serial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amp_serial as text
%        str2double(get(hObject,'String')) returns contents of amp_serial as a double


% --- Executes during object creation, after setting all properties.
function amp_serial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amp_serial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in amplifier_used.
function amplifier_used_Callback(hObject, eventdata, handles)
% hObject    handle to amplifier_used (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of amplifier_used



function amp_msg_Callback(hObject, eventdata, handles)
% hObject    handle to amp_msg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amp_msg as text
%        str2double(get(hObject,'String')) returns contents of amp_msg as a double


% --- Executes during object creation, after setting all properties.
function amp_msg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amp_msg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox11.
function checkbox11_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox11


% --- Executes on selection change in power_meter_type.
function power_meter_type_Callback(hObject, eventdata, handles)
% hObject    handle to power_meter_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns power_meter_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from power_meter_type


% --- Executes during object creation, after setting all properties.
function power_meter_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to power_meter_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sweep_type.
function sweep_type_Callback(hObject, eventdata, handles)
% hObject    handle to sweep_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns sweep_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sweep_type


% --- Executes during object creation, after setting all properties.
function sweep_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweep_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sweep_start_Callback(hObject, eventdata, handles)
% hObject    handle to sweep_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sweep_start as text
%        str2double(get(hObject,'String')) returns contents of sweep_start as a double


% --- Executes during object creation, after setting all properties.
function sweep_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweep_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sweep_step_Callback(hObject, eventdata, handles)
% hObject    handle to sweep_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sweep_step as text
%        str2double(get(hObject,'String')) returns contents of sweep_step as a double


% --- Executes during object creation, after setting all properties.
function sweep_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweep_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sweep_end_Callback(hObject, eventdata, handles)
% hObject    handle to sweep_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sweep_end as text
%        str2double(get(hObject,'String')) returns contents of sweep_end as a double


% --- Executes during object creation, after setting all properties.
function sweep_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweep_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function modulation_Callback(hObject, eventdata, handles)
% hObject    handle to modulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of modulation as text
%        str2double(get(hObject,'String')) returns contents of modulation as a double


% --- Executes during object creation, after setting all properties.
function modulation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to modulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dothemeasurement.
function dothemeasurement_Callback(hObject, eventdata, handles)
% hObject    handle to dothemeasurement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ampsetting;
global antenna;
global amplifier;
global power_meter_type;
global sweep;
global bias;
global temperature;
global modulation;
global channel;
global response;
global noise;
global power;
global aux_response;

% na, bellitjuk a boardon az osszes vackot soros vonalon, ha kell
clc

% amplifier
chopper = get(findobj('Tag', 'chopper'), 'Value');
outchop = get(findobj('Tag', 'outchop'), 'Value');
groundinput = get(findobj('Tag', 'groundinput'), 'Value');
mult520 = get(findobj('Tag', 'mult520'), 'Value');
mult50100 = get(findobj('Tag', 'mult50100'), 'Value');
bypasslpf = get(findobj('Tag', 'bypasslpf'), 'Value');
groundplus = get(findobj('Tag', 'groundplus'), 'Value');
groundnegative = get(findobj('Tag', 'groundnegative'), 'Value');
usecalib = get(findobj('Tag', 'usecalib'), 'Value');

% create code
ampcode = 'A000000000000';

if chopper
    ampcode(2) = '1';
end
if outchop
    ampcode(8) = '1';
end
if groundinput
    ampcode(3) = '1';
end
if mult520
    ampcode(6) = '1';
end
if mult50100
    ampcode(7) = '1';
end
if bypasslpf
    ampcode(10) = '1';
end
if groundplus
    ampcode(4) = '1';
end
if groundnegative
    ampcode(5) = '1';
end
if usecalib
    ampcode(11) = '1';
end

ampcode(end+1)=13;

if and(~get(findobj('Tag', 'offline'), 'Value'), get(findobj('Tag', 'amplifier_used'), 'Value'))
    % open channel
    comport_name =  get(findobj('Tag', 'comport'), 'String');
    comport = char(comport_name(get(findobj('Tag', 'comport'), 'Value'))); s = serial(comport);
    set(s,'BaudRate',9600,'DataBits',8,'Parity','none','StopBits',1,'FlowControl','none','InputBufferSize',102400) % serial port properties
    try
        fopen(s); % connecting to a device using fopen
    catch err
        disp(['Serial port bad, not open: ' err.message]);
    end
    
    if strcmp(s.Status, 'closed') == 0
        % write out commands
        fwrite(s,ampcode);

        % chopper clock
        msg = sprintf('K%s', get(findobj('Tag', 'clk'), 'String'));
        msg(end+1)=13;
        disp(msg);
        fwrite(s,msg)

        % channel
        msg = sprintf('X%s', get(findobj('Tag', 'channelselect'), 'String'));
        msg(end+1)=13;
        disp(msg);
        fwrite(s,msg)

        fclose(s);
    end % serial openned correctly
end % amplifier setting

ampsetting = struct('msg', get(findobj('Tag', 'amp_msg'), 'String'), ...
    'chopping_freq', str2double(get(findobj('Tag', 'clk'), 'String')), ...
    'amplifier', ampcode(2:end-1)-48); % nagyon gaz, de a msg mar osszeallt korabban
antenna = struct('ant_generation', str2double(get(findobj('Tag', 'ant_generation'), 'String')), ...
    'ant_serial', str2double(get(findobj('Tag', 'ant_serial'), 'String')));

amplifier = struct('amp_used', get(findobj('Tag', 'amplifier_used'), 'Value'),...
    'amp_generation', str2double(get(findobj('Tag', 'amp_generation'), 'String')), ...
    'amp_serial',  str2double(get(findobj('Tag', 'amp_serial'), 'String')));

pmt =  get(findobj('Tag', 'power_meter_type'), 'String');
pmt = char(pmt(get(findobj('Tag', 'power_meter_type'), 'Value')));
power_meter_type = pmt; % 'notused', 'vdi', 'qmc', 'other'

% db_setup_id = db_insert_setup(conn, 'hello', antenna, ampsetting, amplifier, power_meter_type);

sp =  get(findobj('Tag', 'sweep_type'), 'String');
sp = char(sp(get(findobj('Tag', 'sweep_type'), 'Value')));
sweep = struct('type', sp, ...
    'start', str2double(get(findobj('Tag', 'sweep_start'), 'String')), ...
    'end', str2double(get(findobj('Tag', 'sweep_end'), 'String')), ...
    'step', str2double(get(findobj('Tag', 'sweep_step'), 'String')));

bias = struct ('vgate', str2double(get(findobj('Tag', 'vgate'), 'String')), ...
    'frequency', str2double(get(findobj('Tag', 'frequency'), 'String')));

temperature = str2double(get(findobj('Tag', 'temperature'), 'String')); % celsius
modulation = str2double(get(findobj('Tag', 'modulation'), 'String')); % hz
channel = str2double(get(findobj('Tag', 'channelselect'), 'String')); % 0-15

%data acq parameters
SampleTime = str2double(get(findobj('Tag', 'sampletime'), 'String'));
SampleRate = 1000*str2double(get(findobj('Tag', 'samplerate'), 'String'));

% rf stuff
frequency_range = get(findobj('Tag', 'frequency_range'), 'Value');

if ~get(findobj('Tag', 'offline'), 'Value')
    % measure
    [response, noise, power, aux_response] = meas_entry_fnc(bias, sweep, modulation, SampleTime, SampleRate, frequency_range);
   
    set(findobj('Tag', 'save_db'), 'Enable','on')
else
    % dummy
    response = sin( sweep.start:sweep.step:sweep.end );
    noise = randn(size(response));
    power = sweep.start:sweep.step:sweep.end;
    aux_response = [];
    
    set(findobj('Tag', 'save_db'), 'Enable','on')
    
    disp('ok');
end

% --- Executes on button press in save_db.
function save_db_Callback(hObject, eventdata, handles)
% hObject    handle to save_db (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ampsetting;
global antenna;
global amplifier;
global power_meter_type;
global sweep;
global bias;
global temperature;
global modulation;
global channel;
global response;
global noise;
global power;
global aux_response;
clc
p = 'd:\FoldesyPeter\antennameasurement\install\postgreSQL\postgresql-9.4.1212.jre6.jar';
% java 

if ~ismember(p,javaclasspath)  
    javaaddpath(p)  
end
conn = database('postgres', 'postgres', 'mems0802', ...
                'org.postgresql.Driver',...
                'jdbc:postgresql://localhost:5432/');

if isconnection(conn)
    disp('database connected')
    db_setup_id = db_insert_setup(conn, get(findobj('Tag', 'sweep_msg'), 'String'), ...
        antenna, ampsetting, amplifier, power_meter_type);

    db_insert_sweep (conn, get(findobj('Tag', 'sweep_msg'), 'String'), ...
        db_setup_id, modulation, temperature, channel, bias, sweep, response, noise, power, aux_response);
    close(conn);
    
    set(findobj('Tag', 'save_db'), 'Enable','off')
else
    disp('cannot connect')
    disp(conn.message);
end

function sweep_msg_Callback(hObject, eventdata, handles)
% hObject    handle to sweep_msg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sweep_msg as text
%        str2double(get(hObject,'String')) returns contents of sweep_msg as a double


% --- Executes during object creation, after setting all properties.
function sweep_msg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweep_msg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function samplerate_Callback(hObject, eventdata, handles)
% hObject    handle to samplerate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of samplerate as text
%        str2double(get(hObject,'String')) returns contents of samplerate as a double


% --- Executes during object creation, after setting all properties.
function samplerate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to samplerate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sampletime_Callback(hObject, eventdata, handles)
% hObject    handle to sampletime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sampletime as text
%        str2double(get(hObject,'String')) returns contents of sampletime as a double


% --- Executes during object creation, after setting all properties.
function sampletime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sampletime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in frequency_range.
function frequency_range_Callback(hObject, eventdata, handles)
% hObject    handle to frequency_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns frequency_range contents as cell array
%        contents{get(hObject,'Value')} returns selected item from frequency_range


% --- Executes during object creation, after setting all properties.
function frequency_range_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequency_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vgate_Callback(hObject, eventdata, handles)
% hObject    handle to vgate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vgate as text
%        str2double(get(hObject,'String')) returns contents of vgate as a double


% --- Executes during object creation, after setting all properties.
function vgate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vgate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frequency_Callback(hObject, eventdata, handles)
% hObject    handle to frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frequency as text
%        str2double(get(hObject,'String')) returns contents of frequency as a double


% --- Executes during object creation, after setting all properties.
function frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close


% --- Executes on button press in checkbox12.
function checkbox12_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox12


% --- Executes on selection change in comport.
function comport_Callback(hObject, eventdata, handles)
% hObject    handle to comport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns comport contents as cell array
%        contents{get(hObject,'Value')} returns selected item from comport


% --- Executes during object creation, after setting all properties.
function comport_CreateFcn(hObject, eventdata, handles)
% hObject    handle to comport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temperature_Callback(hObject, eventdata, handles)
% hObject    handle to temperature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temperature as text
%        str2double(get(hObject,'String')) returns contents of temperature as a double


% --- Executes during object creation, after setting all properties.
function temperature_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temperature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in offline.
function offline_Callback(hObject, eventdata, handles)
% hObject    handle to offline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of offline
