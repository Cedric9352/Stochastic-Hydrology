function varargout = SAR(varargin)
% SAR MATLAB code for SAR.fig
%      SAR, by itself, creates a new SAR or raises the existing
%      singleton*.
%
%      H = SAR returns the handle to a new SAR or the handle to
%      the existing singleton*.
%
%      SAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAR.M with the given input arguments.
%
%      SAR('Property','Value',...) creates a new SAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SAR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SAR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SAR

% Last Modified by GUIDE v2.5 24-May-2016 11:27:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SAR_OpeningFcn, ...
                   'gui_OutputFcn',  @SAR_OutputFcn, ...
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


% --- Executes just before SAR is made visible.
function SAR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SAR (see VARARGIN)

% Choose default command line output for SAR
handles.output = hObject;

% background-image
cData = imread('background.jpg');
axes(handles.bg_axes);
image(cData);
axis off;
% background-text
title = '欢迎使用SAR模型数据分析软件';
version = 'Version 1.0';
copyright = {'Copyright (c) 2016 程雨佳';'     All Rights Reserved'};
hTitle = text('string',title,'unit','normalized','position',[0.25 0.8],...
    'FontName','华文楷体','FontSize',14,'FontWeight','bold');
handles.hTitle = hTitle;
hVersion = text('string',version,'unit','normalized',...
    'Color','w','position',[0.77 0.11]);
handles.hVersion = hVersion;
hCopyright = text('string',copyright,'unit','normalized',...
    'Color','w','position',[0.7 0.05]);
handles.hCopyright = hCopyright;
movegui(hObject,'center');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SAR wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SAR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Read_Callback(hObject, eventdata, handles)
% hObject    handle to Read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, filepath] = uigetfile({'*.txt';'*.dat';'*.mat';...
    '*.xlsx';'*.*'},'File Selector');
if isnumeric(filename) || isnumeric(filepath)
    msgbox('No file selected, please try again!','Error','error');
else
    index = find(filename == '.');
    if strcmp(filename(index+1:end),'txt') || ...
            strcmp(filename(index+1:end),'dat')
        NumericalData = load([filepath, filename]);
        handles.NumericalData = NumericalData;
        setappdata(0,'Data',NumericalData);
        guidata(hObject, handles);
    elseif strcmp(filename(index+1:end),'mat')
        data = load([filepath, filename]);
        NumericalData = data.X;
        handles.NumericalData = NumericalData;
        setappdata(0,'Data',NumericalData);
        guidata(hObject, handles);
    elseif strcmp(filename(index+1:end),'xlsx');
        NumericalData = xlsread([filepath, filename]);
        handles.NumericalData = NumericalData;
        setappdata(0,'Data',NumericalData);
        guidata(hObject, handles);
    else
        msgbox('Wrong selection!','Error','error');
    end
    msgbox('Open and read files successfully!','Notice','warn');
end

% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = getappdata(0,'Result');
if isempty(x)
    msgbox('Please analysis before save result!','Error',...
        'error');
else
    cd(pwd)
    save('result.txt','x','-ASCII');
end

% --------------------------------------------------------------------
function Close_Callback(hObject, eventdata, handles)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rmappdata(0,'Result');
close(handles.figure1);

% --------------------------------------------------------------------
function Method_Callback(hObject, eventdata, handles)
% hObject    handle to Method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function normal_Callback(hObject, eventdata, handles)
% hObject    handle to normal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'NumericalData')
    current_method = 'normal';
    setappdata(0,'c_m',current_method);
    SAR_Method;
else
    msgbox('Please load data before analysis!','Error','error');
end
        
% --------------------------------------------------------------------
function lognormal_Callback(hObject, eventdata, handles)
% hObject    handle to lognormal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'NumericalData')
    current_method = 'lognormal';
    setappdata(0,'c_m',current_method);
    SAR_Method;
else
    msgbox('Please load data before analysis!','Error','error');
end

% --------------------------------------------------------------------
function idprandom_Callback(hObject, eventdata, handles)
% hObject    handle to idprandom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'NumericalData')
    current_method = 'idprandom';
    setappdata(0,'c_m',current_method);
    SAR_Method;
else
    msgbox('Please load data before analysis!','Error','error');
end

% --------------------------------------------------------------------
function W_H_Callback(hObject, eventdata, handles)
% hObject    handle to W_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'NumericalData')
    current_method = 'w_h';
    setappdata(0,'c_m',current_method);
    SAR_Method;
else
    msgbox('Please load data before analysis!','Error','error');
end


% --------------------------------------------------------------------
function Result_Callback(hObject, eventdata, handles)
% hObject    handle to Result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mean_Callback(hObject, eventdata, handles)
% hObject    handle to mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = getappdata(0,'Result');
if isempty(x)
    msgbox('Please analyse before checking result',...
        'Error','error');
else
    current_result = 'mean';
    setappdata(0,'c_r',current_result);
    SAR_Result;
end
    
% --------------------------------------------------------------------
function var_Callback(hObject, eventdata, handles)
% hObject    handle to var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = getappdata(0,'Result');
if isempty(x)
    msgbox('Please analyse before checking result',...
        'Error','error');
else
    current_result = 'var';
    setappdata(0,'c_r',current_result);
    SAR_Result;
end

% --------------------------------------------------------------------
function rho_Callback(hObject, eventdata, handles)
% hObject    handle to rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = getappdata(0,'Result');
if isempty(x)
    msgbox('Please analyse before checking result',...
        'Error','error');
else
    current_result = 'rho';
    setappdata(0,'c_r',current_result);
    SAR_Result;
end

% --------------------------------------------------------------------
function shewness_Callback(hObject, eventdata, handles)
% hObject    handle to shewness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = getappdata(0,'Result');
if isempty(x)
    msgbox('Please analyse before checking result',...
        'Error','error');
else
    current_result = 'cs';
    setappdata(0,'c_r',current_result);
    SAR_Result;
end
