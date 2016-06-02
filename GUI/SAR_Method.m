function varargout = SAR_Method(varargin)
% SAR_METHOD MATLAB code for SAR_Method.fig
%      SAR_METHOD, by itself, creates a new SAR_METHOD or raises the existing
%      singleton*.
%
%      H = SAR_METHOD returns the handle to a new SAR_METHOD or the handle to
%      the existing singleton*.
%
%      SAR_METHOD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAR_METHOD.M with the given input arguments.
%
%      SAR_METHOD('Property','Value',...) creates a new SAR_METHOD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SAR_Method_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SAR_Method_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SAR_Method

% Last Modified by GUIDE v2.5 27-May-2016 15:38:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SAR_Method_OpeningFcn, ...
                   'gui_OutputFcn',  @SAR_Method_OutputFcn, ...
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


% --- Executes just before SAR_Method is made visible.
function SAR_Method_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SAR_Method (see VARARGIN)

% Choose default command line output for SAR_Method
handles.output = hObject;

% background-image
cData = imread('background.jpg');
axes(handles.axes1);
image(cData);
axis off;

%judge the method chosed
switch getappdata(0,'c_m')
    case 'normal',
        handles.title = text('string','Normal','Color','r',...
            'unit','normalized','position',[0.41 0.9],...
            'FontSize',20');
        guidata(hObject,handles)
    case 'lognormal',
        handles.title = text('string','Lognormal','Color','r',...
            'unit','normalized','position',[0.38 0.9],...
            'FontSize',20');
        guidata(hObject,handles)
    case 'idprandom',
        handles.title = text('string','IDPrandom','Color','r',...
            'unit','normalized','position',[0.38 0.9],...
            'FontSize',20');
        guidata(hObject,handles)
    case 'w_h',
        handles.title = text('string','W-H','Color','r',...
            'unit','normalized','position',[0.44 0.9],...
            'FontSize',20');
        guidata(hObject,handles)
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SAR_Method wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SAR_Method_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_p_Callback(hObject, eventdata, handles)
% hObject    handle to edit_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_p as text
%        str2double(get(hObject,'String')) returns contents of edit_p as a double
NumStr = get(handles.edit_p,'string');
handles.p = str2double(NumStr);
guidata(hObject,handles);
setappdata(0,'p',str2double(NumStr));

% --- Executes during object creation, after setting all properties.
function edit_p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.p = 1;
guidata(hObject,handles);
setappdata(0,'p',handles.p);

function edit_w_Callback(hObject, eventdata, handles)
% hObject    handle to edit_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_w as text
%        str2double(get(hObject,'String')) returns contents of edit_w as a double
NumStr = get(handles.edit_w,'string');
handles.w = str2double(NumStr);
guidata(hObject,handles);
setappdata(0,'w',str2double(NumStr));

% --- Executes during object creation, after setting all properties.
function edit_w_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.w = 12;
guidata(hObject,handles);
setappdata(0,'w',handles.w);

function edit_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_y as text
%        str2double(get(hObject,'String')) returns contents of edit_y as a double
NumStr = get(handles.edit_y,'string');
handles.y = str2double(NumStr);
guidata(hObject,handles);
setappdata(0,'y',str2double(NumStr));

% --- Executes during object creation, after setting all properties.
function edit_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.y = 1000;
guidata(hObject,handles);
setappdata(0,'y',handles.y);

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
X = getappdata(0,'Data');
title = get(handles.title,'string');
switch title
    case 'Normal',
        x = SARnormseq(handles.p,X,handles.y,handles.w);
        if(~isreal(x))
            msgbox('Wrong order for SAR model, please input again',...
                'Error','error');
        elseif(isnan(x))
            msgbox('Wrong length for original sequence, please load again',...
                'Error','error');
        else
            msgbox('Calculate successfully!','Notice','warn');
            setappdata(0,'Result',x);
        end
    case 'Lognormal',
        x = SARlgnseq(handles.p,X,handles.y,handles.w);
        if(~isreal(x))
            msgbox('Wrong order for SAR model, please input again',...
                'Error','error');
        elseif(isnan(x))
            msgbox('Wrong length for original sequence, please load again',...
                'Error','error');
        else
            msgbox('Calculate successfully!','Notice','warn');
            setappdata(0,'Result',x);
        end
    case 'IDPrandom',
        x = SARidrndseq(handles.p,X,handles.y,handles.w);
        if(~isreal(x))
            msgbox('Wrong order for SAR model, please input again',...
                'Error','error');
        elseif(isnan(x))
            msgbox('Wrong length for original sequence, please load again',...
                'Error','error');
        else
            msgbox('Calculate successfully!','Notice','warn');
            setappdata(0,'Result',x);
        end
    case 'W-H',
        x = SARW_Hseq(handles.p,X,handles.y,handles.w);
        if(~isreal(x))
            msgbox('Wrong order for SAR model, please input again',...
                'Error','error');
        elseif(isnan(x))
            msgbox('Wrong length for original sequence, please load again',...
                'Error','error');
        else
            msgbox('Calculate successfully!','Notice','warn');
            setappdata(0,'Result',x);
        end
end


function text_p_Callback(hObject, eventdata, handles)
% hObject    handle to text_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text_p as text
%        str2double(get(hObject,'String')) returns contents of text_p as a double


% --- Executes during object creation, after setting all properties.
function text_p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function text_w_Callback(hObject, eventdata, handles)
% hObject    handle to text_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text_w as text
%        str2double(get(hObject,'String')) returns contents of text_w as a double


% --- Executes during object creation, after setting all properties.
function text_w_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function text_y_Callback(hObject, eventdata, handles)
% hObject    handle to text_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text_y as text
%        str2double(get(hObject,'String')) returns contents of text_y as a double


% --- Executes during object creation, after setting all properties.
function text_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double
NumStr = get(handles.edit8,'string');
handles.wp = str2double(NumStr);
guidata(hObject,handles);
setappdata(0,'wp',str2double(NumStr));

    
% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.wp = 50;
guidata(hObject,handles);
setappdata(0,'wp',handles.wp);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = getappdata(0,'Result');
if isempty(x)
    msgbox('Please analyse before warm-up',...
        'Error','error');
else
    x = x(handles.wp+1:end,:);
    setappdata(0,'Result',x);
    msgbox('Warm-up successfully!','Notice','warn');
end
