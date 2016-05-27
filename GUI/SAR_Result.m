function varargout = SAR_Result(varargin)
% SAR_RESULT MATLAB code for SAR_Result.fig
%      SAR_RESULT, by itself, creates a new SAR_RESULT or raises the existing
%      singleton*.
%
%      H = SAR_RESULT returns the handle to a new SAR_RESULT or the handle to
%      the existing singleton*.
%
%      SAR_RESULT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAR_RESULT.M with the given input arguments.
%
%      SAR_RESULT('Property','Value',...) creates a new SAR_RESULT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SAR_Result_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SAR_Result_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SAR_Result

% Last Modified by GUIDE v2.5 27-May-2016 10:49:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SAR_Result_OpeningFcn, ...
                   'gui_OutputFcn',  @SAR_Result_OutputFcn, ...
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


% --- Executes just before SAR_Result is made visible.
function SAR_Result_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SAR_Result (see VARARGIN)

% Choose default command line output for SAR_Result
handles.output = hObject;

% background-image
cData = imread('background.jpg');
axes(handles.axes1);
image(cData);
axis off;

%judge the result chosed
cname = cell(1,getappdata(0,'w'));
for i = 1:getappdata(0,'w')
    cname{i} = i;
end

column_width = num2cell(50*ones(1,getappdata(0,'w')));

switch getappdata(0,'c_r')
    case 'mean',
        text('string','Mean','Color','r',...
            'unit','normalized','position',[0.43 0.9],...
            'FontSize',20');
        rname = {'ori-Mean','sim-Mean'};
        meanX = mean(getappdata(0,'Data'));
        meanx = mean(getappdata(0,'Result'));
        data = [meanX;meanx];
        uitable('Data',data,'ColumnName',cname,'RowName',rname,...
            'ColumnWidth',column_width,'unit','normalized',...
            'position',[0.1 0.3,0.8,0.2]);
    case 'var',
        text('string','Variance','Color','r',...
            'unit','normalized','position',[0.40 0.9],...
            'FontSize',20');
        rname = {'ori-Var','sim-Var'};
        varX = sqrt(var(getappdata(0,'Data')));
        varx = sqrt(var(getappdata(0,'Result')));
        data = [varX;varx];
        uitable('Data',data,'ColumnName',cname,'RowName',rname,...
            'ColumnWidth',column_width,'unit','normalized',...
            'position',[0.1 0.3,0.8,0.2]);
    case 'rho',
        text('string','Rho','Color','r',...
            'unit','normalized','position',[0.45 0.9],...
            'FontSize',20');
        rhoX = paraEst(getappdata(0,'Data'));
        rhox = paraEst(getappdata(0,'Result'));
        p = getappdata(0,'p');
        rname = cell(1,2*p);
        data = zeros(2*p,getappdata(0,'w'));
        for i = 1:p
            rname{2*i-1} = strcat('ori-',num2str(i));
            rname{2*i} = strcat('sim-',num2str(i));
            data(2*i-1,:) = rhoX(i,:);
            data(2*i,:) = rhox(i,:);
        end
        uitable('Data',data,'ColumnName',cname,'RowName',rname,...
            'ColumnWidth',column_width,'unit','normalized',...
            'position',[0.1 0.3,0.8,0.2]);
    case 'cs',
        text('string','Cs','Color','r',...
            'unit','normalized','position',[0.47 0.9],...
            'FontSize',20');
        rname = {'ori-Cs','sim-Cs'};
        CsX = skewness(getappdata(0,'Data'));
        Csx = skewness(getappdata(0,'Result'));
        data = [CsX;Csx];
        uitable('Data',data,'ColumnName',cname,'RowName',rname,...
            'ColumnWidth',column_width,'unit','normalized',...
            'position',[0.1 0.3,0.8,0.2]);
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SAR_Result wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SAR_Result_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
