function varargout = net_amp_gui(varargin)
% NET_AMP_GUI M-file for net_amp_gui.fig
%      NET_AMP_GUI, by itself, creates a new NET_AMP_GUI or raises the existing
%      singleton*.
%
%      H = NET_AMP_GUI returns the handle to a new NET_AMP_GUI or the handle to
%      the existing singleton*.
%
%      NET_AMP_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NET_AMP_GUI.M with the given input arguments.
%
%      NET_AMP_GUI('Property','Value',...) creates a new NET_AMP_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before net_amp_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to net_amp_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help net_amp_gui



% Last Modified by GUIDE v2.5 26-May-2016 14:26:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @net_amp_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @net_amp_gui_OutputFcn, ...
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


% --- Executes just before net_amp_gui is made visible.
function net_amp_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to net_amp_gui (see VARARGIN)

global led;

% Choose default command line output for net_amp_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes net_amp_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
led = 0;
%s.ReadAsyncMode='Continuous'; % mode of reading

% --- Outputs from this function are returned to the command line.
function varargout = net_amp_gui_OutputFcn(hObject, eventdata, handles) 
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

s = serial('COM6');
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
s = serial('COM6');
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


% --- Executes on button press in updatebutton.
function updatebutton_Callback(hObject, eventdata, handles)
% hObject    handle to updatebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
msg = 'A000000000000';

if chopper
    msg(2) = '1';
end
if outchop
    msg(8) = '1';
end
if groundinput
    msg(3) = '1';
end
if mult520
    msg(6) = '1';
end
if mult50100
    msg(7) = '1';
end
if bypasslpf
    msg(10) = '1';
end
if groundplus
    msg(4) = '1';
end
if groundnegative
    msg(5) = '1';
end
if usecalib
    msg(11) = '1';
end

msg(end+1)=13;

disp(msg);

s = serial('COM6');
set(s,'BaudRate',9600,'DataBits',8,'Parity','none','StopBits',1,'FlowControl','none','InputBufferSize',102400) % serial port properties
fopen(s); % connecting to a device using fopen
fwrite(s,msg);
fclose(s);


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

s = serial('COM6');
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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% clock
msg = sprintf('K%s', get(findobj('Tag', 'clk'), 'String'));
msg(end+1)=13;
disp(msg);
s = serial('COM6');
set(s,'BaudRate',9600,'DataBits',8,'Parity','none','StopBits',1,'FlowControl','none','InputBufferSize',102400) % serial port properties
fopen(s); % connecting to a device using fopen
fwrite(s,msg)
fclose(s);

% --- Executes during object creation, after setting all properties.
function pushbutton5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
