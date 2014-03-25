function varargout = monitor1(varargin)
% MONITOR1 M-file for monitor1.fig
%      MONITOR1, by itself, creates a new MONITOR1 or raises the existing
%      singleton*.
%
%      H = MONITOR1 returns the handle to a new MONITOR1 or the handle to
%      the existing singleton*.
%
%      MONITOR1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MONITOR1.M with the given input arguments.
%
%      MONITOR1('Property','Value',...) creates a new MONITOR1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before monitor1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to monitor1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help monitor1

% Last Modified by GUIDE v2.5 17-Apr-2011 10:34:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @monitor1_OpeningFcn, ...
                   'gui_OutputFcn',  @monitor1_OutputFcn, ...
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


% --- Executes just before monitor1 is made visible.
function monitor1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to monitor1 (see VARARGIN)

% Choose default command line output for monitor1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes monitor1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = monitor1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
h = waitbar(0.1,'Please wait, check hardware......');
global vid
vid = videoinput('winvideo',1,'I420_160x120');
set(vid,'ReturnedColorSpace','rgb');
vid_src=getselectedsource(vid);
data = getsnapshot(vid);
waitbar(0.5,h,'Please wait, initialize the window');
set(vid,'TriggerRepeat',Inf);
set(vid,'FramesPerTrigger',1);
set(vid,'FrameGrabInterval',1);
vidRes = get(vid, 'VideoResolution');
nBands = get(vid, 'NumberOfBands');
axes(handles.axes1);
waitbar(0.8,h,'Please wait, initialize the window');


hImage = image( zeros(vidRes(2), vidRes(1), nBands) );
% Display the video data in your GUI.
axes(handles.axes1);
waitbar(1.0,h,'Please wait, initialize the window');
close(h);
preview(vid, hImage);
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
set(hObject,'xTick',[]);
set(hObject,'ytick',[]);
set(hObject,'box','on');
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
period=str2double(get(handles.timeperiod,'string'));
t = timer('TimerFcn', {@timerCallback,handles}, 'ExecutionMode', 'fixedDelay', 'Period', period);
handles.t=t;
guidata(hObject,handles);
start(t);
axes(handles.axes3);
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function timerCallback(hObject, eventdata, handles)
global vid
if (vid==-1)
    msgbox('Prview First      ','www.matlabgui.cn','icon','error');
    return;
end
frame = getsnapshot(vid);
axes(handles.axes3);
imshow(frame);
str=datestr(now);
str=strrep(str,':','_');
str=strrep(str,' ','_');
str=strrep(str,'-','_');
str=strcat(str,'.jpg');
imwrite(frame,str,'jpg');

function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
try
stop(handles.t);
catch
end
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
try
stop(handles.t);
catch
end
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
global vid
if (vid==-1)
    msgbox('Prview First      ','www.matlabgui.cn','icon','error');
    return;
end
frame = getsnapshot(vid);
figure(2);
imshow(frame);
str=datestr(now);
str=strrep(str,':','_');
str=strrep(str,' ','_');
str=strrep(str,'-','_');
str=strcat(str,'.jpg');
imwrite(frame,str,'jpg');
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function timeperiod_Callback(hObject, eventdata, handles)
% hObject    handle to timeperiod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of timeperiod as text
%        str2double(get(hObject,'String')) returns contents of timeperiod as a double


% --- Executes during object creation, after setting all properties.
function timeperiod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timeperiod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text3.
