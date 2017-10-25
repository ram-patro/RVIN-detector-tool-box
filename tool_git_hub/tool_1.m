function varargout = tool_1(varargin)
% TOOL_1 MATLAB code for tool_1.fig
%      TOOL_1, by itself, creates a new TOOL_1 or raises the existing
%      singleton*.
%
%      H = TOOL_1 returns the handle to a new TOOL_1 or the handle to
%      the existing singleton*.
%
%      TOOL_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TOOL_1.M with the given input arguments.
%
%      TOOL_1('Property','Value',...) creates a new TOOL_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tool_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tool_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tool_1

% Last Modified by GUIDE v2.5 25-Oct-2017 18:53:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tool_1_OpeningFcn, ...
                   'gui_OutputFcn',  @tool_1_OutputFcn, ...
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


% --- Executes just before tool_1 is made visible.
function tool_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tool_1 (see VARARGIN)

% Choose default command line output for tool_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tool_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tool_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_select_image.
function pushbutton_select_image_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_select_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.curr_dir=pwd;
[handles.filename,pathname] = uigetfile({'*.png';'*.jpg';'*.bmp'},'File Selector');
handles.S = imread(strcat(pathname, handles.filename));
axes(handles.axes1);
imshow(handles.S);title('input image S');
guidata(hObject,handles);

% --- Executes on button press in pushbutton_snap.
function pushbutton_snap_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_snap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
name=strcat('m_',num2str(handles.m),'_p_',num2str(handles.p),'_',handles.filename,'.jpg');
path=strcat(pwd,'\snap_shot\',name);
fig=gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 11 5];
saveas(fig,path);
guidata(hObject,handles);
% --- Executes on selection change in popupmenu_select_algo.
function popupmenu_select_algo_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_select_algo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_select_algo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_select_algo
contents = cellstr(get(hObject,'String'));
path=contents{get(hObject,'Value')};
cd(strcat('all_algo\',path));
handles.N1=noise_extract(handles.X);
cd(handles.curr_dir);
axes(handles.axes5);imshow(~handles.N1);title('Noise Mask NM^1');
cd('noise_model_ground_truth_performance_measure');
[handles.n1_ACC,handles.n1_DPR,handles.n1_FDDR,handles.n1_FA,handles.n1_MD]=measure_param(handles.M,handles.N1,handles.S,handles.X);
cd(handles.curr_dir);
set(handles.text_n1_fa, 'String',handles.n1_FA);
set(handles.text_n1_md, 'String',handles.n1_MD);
set(handles.text_n1_dpr, 'String',handles.n1_DPR);
set(handles.text_n1_fddr, 'String',handles.n1_FDDR);
set(handles.text_n1_acc, 'String',handles.n1_ACC);
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function popupmenu_select_algo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_select_algo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);

% --- Executes on slider movement.
function slider_p_Callback(hObject, eventdata, handles)
% hObject    handle to slider_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.p=get(hObject,'Value')*0.9;
set(handles.text_p, 'String', strcat('p=',num2str(handles.p)));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function slider_p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
handles.p=get(hObject,'Value')*0.9;
guidata(hObject,handles);


% --- Executes on slider movement.
function slider_m_Callback(hObject, eventdata, handles)
% hObject    handle to slider_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.m=round(get(hObject,'Value')*120);
set(handles.text_m, 'String', strcat('m=',num2str(handles.m)));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function slider_m_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
handles.m=round(get(hObject,'Value')*120);
guidata(hObject,handles);


% --- Executes on button press in pushbutton_add_noise.
function pushbutton_add_noise_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_add_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cd('noise_model_ground_truth_performance_measure');
handles.X=noise_model(handles.S,[0 handles.m],[255-handles.m 255],handles.p/2,handles.p/2);
cd(handles.curr_dir);
axes(handles.axes2);
imshow(handles.X);title('Noisy image X');
axes(handles.axes3);
h1=plot(imhist(handles.S),'LineWidth',2);hold on;h2=plot(imhist(handles.X),'r','LineWidth',2);legend([h1,h2],'original','noised');axis([0 256 0 max([imhist(handles.X);imhist(handles.S)])]);title('Histogram');hold off;
axes(handles.axes4);
cd('noise_model_ground_truth_performance_measure');
handles.M=ground_truth_extract(handles.S,handles.X);
cd(handles.curr_dir);
imshow(~handles.M);title('ground truth M = S # X')
guidata(hObject,handles);


% --- Executes on selection change in popupmenu_NHP.
function popupmenu_NHP_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_NHP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_NHP contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_NHP
contents = cellstr(get(hObject,'String'));
if(strcmp(contents{get(hObject,'Value')},'NHP-Yes'))
    cd('all_algo\nhp');
    [handles.N2,handles.N,handles.nh,handles.nhd,handles.b1,handles.b2]=noise_hist_process(handles.X,handles.N1);
    cd(handles.curr_dir);
    axes(handles.axes6);imshow(~handles.N2);title('Noise Mask NM^2');
    axes(handles.axes7);
    max_limit=max([handles.nh;handles.nhd']);
    min_limit=min([handles.nh;handles.nhd']);
    h1=plot(handles.nh,'LineWidth',2);hold on;h2=plot(handles.nhd,'r','LineWidth',2);h3=plot(handles.b1,0,'y*','LineWidth',5);h4=plot(handles.b2,0,'g*','LineWidth',5);legend([h1,h2,h3,h4],'nh','nh''','b1','b2');axis([0 256 min_limit max_limit]);title({'Noise Histogram','& Derivative'});hold off;
    axes(handles.axes8);imshow(~handles.N);title('Final mask :: NM');
    axes(handles.axes9);imshow(handles.N~=handles.M);title('Deviation :: NM # M');
    axes(handles.axes3);
    max_limit=max([imhist(handles.X);imhist(handles.S)]);
    h1=plot(imhist(handles.S),'LineWidth',2);hold on;h2=plot(imhist(handles.X),'r','LineWidth',2);h3=stem(handles.b1,max_limit,'y','LineWidth',1);h4=stem(handles.b2,max_limit,'g','LineWidth',1);legend([h1,h2,h3,h4],'input','noised','b1','b2');axis([0 256 0 max_limit]);title('Histogram');hold off;
    cd('all_algo\bdnd');
    handles.F=filter_image(handles.X,handles.N);
    axes(handles.axes19);imshow(handles.F);title({strcat('PSNR : ',num2str(psnr(uint8(handles.S),uint8(handles.F)))),strcat('SSIM : ',num2str(ssim(uint8(handles.S),uint8(handles.F))))})
    cd(handles.curr_dir);
else
    axes(handles.axes6);imshow(imread('image\na.png'));
    axes(handles.axes7);imshow(imread('image\na.png'));
    handles.N=handles.N1;
    axes(handles.axes8);imshow(~handles.N);title('Final mask :: NM');
    axes(handles.axes9);imshow(handles.N~=handles.M);title('Deviation :: NM # M');
    cd('all_algo\bdnd');
    handles.F=filter_image(handles.X,handles.N);
    axes(handles.axes19);imshow(handles.F);title({strcat('PSNR : ',num2str(psnr(uint8(handles.S),uint8(handles.F)))),strcat('SSIM : ',num2str(ssim(uint8(handles.S),uint8(handles.F))))})
    cd(handles.curr_dir);
end
cd('noise_model_ground_truth_performance_measure');
[handles.n_ACC,handles.n_DPR,handles.n_FDDR,handles.n_FA,handles.n_MD]=measure_param(handles.M,handles.N,handles.S,handles.X);
set(handles.text_n_fa, 'String',handles.n_FA);
set(handles.text_n_md, 'String',handles.n_MD);
set(handles.text_n_dpr, 'String',handles.n_DPR);
set(handles.text_n_fddr, 'String',handles.n_FDDR);
set(handles.text_n_acc, 'String',handles.n_ACC);
cd(handles.curr_dir);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_NHP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_NHP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function pushbutton_snap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_snap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
