function varargout = DOFS(varargin)
% DOFS MATLAB code for DOFS.fig
%      DOFS, by itself, creates a new DOFS or raises the existing
%      singleton*.
%
%      H = DOFS returns the handle to a new DOFS or the handle to
%      the existing singleton*.
%
%      DOFS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DOFS.M with the given input arguments.
%
%      DOFS('Property','Value',...) creates a new DOFS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DOFS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DOFS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DOFS

% Last Modified by GUIDE v2.5 03-Mar-2017 21:12:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @DOFS_OpeningFcn, ...
    'gui_OutputFcn',  @DOFS_OutputFcn, ...
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


% --- Executes just before DOFS is made visible.
function DOFS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DOFS (see VARARGIN)

% Choose default command line output for DOFS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DOFS wait for user response (see UIRESUME)
% uiwait(handles.figure1);
restoredefaultpath;
rehash toolboxcache;
use_LOFS;
% if(length(strfind(javaclasspath,'weka'))<=0)
%  eval('use_spider');
% else
%    disp('WEKA support is already enabled!');
%    disp(' ');
% end
eval('use_spider');
global OFS_nf DO1_nf DO2_nf choice1 choice2 choice3 testdata traindata datatype threshold alpha thetest irrelevantF redundantF kfold_CV funchoix theallDATA nbrKNN classfierchoix
OFS_nf=[];
DO1_nf=[];
DO2_nf=[];
choice1=1;
choice2=1;
funchoix=1;
choice3=1;
irrelevantF=[];
redundantF=[];
theallDATA=[];
traindata.X=[];
traindata.Y=[];
testdata.X=[];
testdata.Y=[];
set(handles.checkbox1,'value',0);
set(handles.checkbox2,'value',0);
set(handles.checkbox4,'value',0);
set(handles.radiobutton1,'value',0);
set(handles.radiobutton2,'value',1);
set(handles.radiobutton3,'value',1);
set(handles.radiobutton4,'value',0);
set(handles.radiobutton6,'value',1);
set(handles.radiobutton5,'value',0);
nbrKNN=3;
classfierchoix=2;
datatype=2;
alpha=str2double(get(handles.edit1,'String'));

if(get(handles.popupmenu8,'Value')==1)
    thetest='z';
elseif(get(handles.popupmenu8,'Value')==2)
    thetest='g2';
elseif(get(handles.popupmenu8,'Value')==3)
    thetest='chi2';
end
threshold=str2double(get(handles.edit4,'String'));
kfold_CV=0;

% --- Outputs from this function are returned to the command line.
function varargout = DOFS_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
global choice1;
contents = cellstr(get(hObject,'String'));
choice1=get(hObject,'Value');

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3
global choice2;
contents = cellstr(get(hObject,'String'));
choice2=get(hObject,'Value');

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7
global choice3;
contents = cellstr(get(hObject,'String'));
choice3=get(hObject,'Value');

% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global traindata
[filename1, pathname] = uigetfile( ...
    {'*.mat','MAT (*.mat)'},'ouvrir');

if(filename1~=0) %pour traiter le cas d'appayer sur annule
    fName = fullfile(pathname,filename1);
    fff=load(fName);
    d=fieldnames(fff);
    s=size(fff.(d{1}),2);
    traindata.X=fff.(d{1})(:,1:s-1);
    traindata.Y=fff.(d{1})(:,s);
    clear fff d s;
    set(handles.checkbox1,'value',1);
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global testdata
[filename2, pathname] = uigetfile( ...
    {'*.mat','MAT (*.mat)'},'ouvrir');

if(filename2~=0) %pour traiter le cas d'appayer sur annule
    fName = fullfile(pathname,filename2);
    fff=load(fName);
    d=fieldnames(fff);
    s=size(fff.(d{1}),2);
    testdata.X=fff.(d{1})(:,1:s-1);
    testdata.Y=fff.(d{1})(:,s);
    clear fff d s;
    set(handles.checkbox2,'value',1);
end

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global choice1 choice2 choice3 testdata traindata datatype threshold alpha thetest kfold_CV  nbrKNN classfierchoix

selected_features=[];
if( choice1~=1 && ~isempty(traindata))
    set(handles.edit14,'string','Running...');
    set(handles.edit14,'BackgroundColor','red');
    pause(0.01)
    switch choice1
        case 2  % Alpha_Investing
            if(choice2==2 && choice3==1)
                Initialization1;
                [selected_features, time]=Alpha_Investing('PSO')
            elseif(choice2==3 && choice3==1)
                WD2O2Initialization1;
                [selected_features, time]=Alpha_Investing('WD2O')
                
            else
                [selected_features, time]=Alpha_Investing('')
            end
        case 3  % osfs_d
            if( choice2==2 && choice3==2)
                Initialization1;
                Initialization2;
                [selected_features, time]=osfs_d('PSO','PSO')
            elseif(choice2==2 && choice3==1)
                Initialization1;
                [selected_features, time]=osfs_d('PSO','')
            elseif(choice3==2 && choice2==1)
                Initialization2;
                [selected_features, time]=osfs_d('','PSO')
            elseif(choice3==3 && choice2==1)
                WD2O2Initialization2;
                [selected_features, time]=osfs_d('','WD2O')
            elseif(choice2==3 && choice3==1)
                WD2O2Initialization1;
                [selected_features, time]=osfs_d('WD2O','')
            elseif(choice2==3 && choice3==3)
                WD2O2Initialization1;
                WD2O2Initialization2;
                [selected_features, time]=osfs_d('WD2O','WD2O')
            else
                [selected_features, time]=osfs_d('','')
            end
        case 4  % osfs_z
            if( choice2==2 && choice3==2)
                Initialization1;
                Initialization2;
                [selected_features, time]=osfs_z('PSO','PSO')
            elseif(choice2==2 && choice3==1)
                Initialization1;
                [selected_features, time]=osfs_z('PSO','')
            elseif(choice3==2 && choice2==1)
                Initialization2;
                [selected_features, time]=osfs_z('','PSO')
            elseif(choice3==3 && choice2==1)
                WD2O2Initialization2;
                [selected_features, time]=osfs_z('','WD2O')
            elseif(choice2==3 && choice3==1)
                WD2O2Initialization1;
                [selected_features, time]=osfs_z('WD2O','')
            elseif(choice2==3 && choice3==3)
                WD2O2Initialization1;
                WD2O2Initialization2;
                [selected_features, time]=osfs_z('WD2O','WD2O')
            else
                [selected_features, time]=osfs_z('','')
            end
        case 5  % fast-osfs_d
            if( choice2==2 && choice3==2)
                Initialization1;
                Initialization2;
                [selected_features, time]=fast_osfs_d('PSO','PSO')
            elseif(choice2==2 && choice3==1)
                Initialization1;
                [selected_features, time]=fast_osfs_d('PSO','')
            elseif(choice3==2 && choice2==1)
                Initialization2;
                [selected_features, time]=fast_osfs_d('','PSO')
            elseif(choice3==3 && choice2==1)
                WD2O2Initialization2;
                [selected_features, time]=fast_osfs_d('','WD2O')
            elseif(choice2==3 && choice3==1)
                WD2O2Initialization1;
                [selected_features, time]=fast_osfs_d('WD2O','')
            elseif(choice2==3 && choice3==3)
                WD2O2Initialization1;
                WD2O2Initialization2;
                [selected_features, time]=fast_osfs_d('WD2O','WD2O')
            else
                [selected_features, time]=fast_osfs_d('','')
            end
        case 6  % fast-osfs_z
            if( choice2==2 && choice3==2)
                Initialization1;
                Initialization2;
                [selected_features, time]=fast_osfs_z('PSO','PSO')
            elseif(choice2==2 && choice3==1)
                Initialization1;
                [selected_features, time]=fast_osfs_z('PSO','')
            elseif(choice3==2 && choice2==1)
                Initialization2;
                [selected_features, time]=fast_osfs_z('','PSO')
            elseif(choice3==3 && choice2==1)
                WD2O2Initialization2;
                [selected_features, time]=fast_osfs_z('','WD2O')
            elseif(choice2==3 && choice3==1)
                WD2O2Initialization1;
                [selected_features, time]=fast_osfs_z('WD2O','')
            elseif(choice2==3 && choice3==3)
                WD2O2Initialization1;
                WD2O2Initialization2;
                [selected_features, time]=fast_osfs_z('WD2O','WD2O')
            else
                [selected_features, time]=fast_osfs_z('','')
            end
        case 7  % saola_mi
            if( choice2==2 && choice3==2)
                Initialization1;
                Initialization2;
                [selected_features, time]=saola_mi('PSO','PSO')
            elseif(choice2==2 && choice3==1)
                Initialization1;
                [selected_features, time]=saola_mi('PSO','')
            elseif(choice3==2 && choice2==1)
                Initialization2;
                [selected_features, time]=saola_mi('','PSO')
            elseif(choice3==3 && choice2==1)
                WD2O2Initialization2;
                [selected_features, time]=saola_mi('','WD2O')
            elseif(choice2==3 && choice3==1)
                WD2O2Initialization1;
                [selected_features, time]=saola_mi('WD2O','')
            elseif(choice2==3 && choice3==3)
                WD2O2Initialization1;
                WD2O2Initialization2;
                [selected_features, time]=saola_mi('WD2O','WD2O')
            else
                [selected_features, time]=saola_mi('','')
            end
        case 8  % saola_z_test
            if( choice2==2 && choice3==2)
                Initialization1;
                Initialization2;
                [selected_features, time]=saola_z_test('PSO','PSO')
            elseif(choice2==2 && choice3==1)
                Initialization1;
                [selected_features, time]=saola_z_test('PSO','')
            elseif(choice3==2 && choice2==1)
                Initialization2;
                [selected_features, time]=saola_z_test('','PSO')
            elseif(choice3==3 && choice2==1)
                WD2O2Initialization2;
                [selected_features, time]=saola_z_test('','WD2O')
            elseif(choice2==3 && choice3==1)
                WD2O2Initialization1;
                [selected_features, time]=saola_z_test('WD2O','')
            elseif(choice2==3 && choice3==3)
                WD2O2Initialization1;
                WD2O2Initialization2;
                [selected_features, time]=saola_z_test('WD2O','WD2O')
            else
                [selected_features, time]=saola_z_test('','')
            end
            
    end
    set(handles.edit14,'string','Done');
    set(handles.edit14,'BackgroundColor','green');
end
if(~isempty(selected_features))
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%SPIDER TOOLBOX%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('hello')
    global dtst
    selected_features
    if(kfold_CV~=0)
        alldata=[];
        alldata=[[traindata.X traindata.Y];[testdata.X testdata.Y]];
        class_index=size(alldata,2)
        label=alldata(:,class_index);
        indices = crossvalind('Kfold',label,kfold_CV); % donne des indices aléatoires selon NC
        tot(1:kfold_CV)=0;
        tot1(1:kfold_CV)=0;
        tot2(1:kfold_CV)=0;
        for i = 1:kfold_CV
            testv = (indices == i);
            trainv = ~testv;
            %training dataset
            trainSet = alldata(trainv,:);
            %testing dataset
            testSet = alldata(testv,:);
            group1 = label(trainv);
            group2 = label(testv);
            
            % class = svm_classify(trainSet, group, testSet);
            
            
            d1=data(trainSet(:,selected_features),group1);
            d2=data(testSet(:,selected_features),group2);
            if(classfierchoix==1)
                [r,a]=train(svm,d1);
            elseif(classfierchoix==2)
                [r,a]=train(knn({['k=' num2str(nbrKNN)]}),d1);
            end
            
            tst=test(a,d2);
            dtst=tst;
            accuracy1=loss(tst);
            sensitivity=loss(tst,'sensitivity');
            specificity=loss(tst,'specificity');
            
            tot(i)=1-accuracy1.Y;
            tot1(i)=sensitivity.Y;
            tot2(i)=specificity.Y;
        end
        accuracynono=mean(tot)
        sensitivity=mean(tot1);
        specificity=mean(tot2);
        set(handles.edit6,'string',num2str(accuracynono));
        set(handles.edit11,'string',num2str(sensitivity));
        set(handles.edit13,'string',num2str(specificity));
        set(handles.edit8,'string',num2str(length(selected_features)));
        set(handles.edit7,'string',num2str(time));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    else% kfold_CV==0
        d1=data(traindata.X(:,selected_features),traindata.Y);
        d2=data(testdata.X(:,selected_features),testdata.Y);
        if(classfierchoix==1)
            [r,a]=train(svm,d1);
        elseif(classfierchoix==2)
            [r,a]=train(knn({['k=' num2str(nbrKNN)]}),d1);
        end
        
        tst=test(a,d2);
        dtst=tst;
        accuracy1=loss(tst);
        
        accuracynono=1-accuracy1.Y;
        sensitivity=loss(tst,'sensitivity');
        specificity=loss(tst,'specificity');
        set(handles.edit6,'string',num2str(accuracynono));
        set(handles.edit11,'string',num2str(sensitivity.Y));
        set(handles.edit13,'string',num2str(specificity.Y));
        set(handles.edit8,'string',num2str(length(selected_features)));
        set(handles.edit7,'string',num2str(time));
        
    end
    
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global OFS_nf DO1_nf DO2_nf choice1 choice2 choice3 testdata traindata datatype irrelevantF redundantF kfold_CV alpha threshold funchoix theallDATA nbrKNN classfierchoix
clc
OFS_nf=[];
DO1_nf=[];
DO2_nf=[];
choice1=1;
funchoix=1;
choice2=1;
choice3=1;
irrelevantF=[];
redundantF=[];
theallDATA=[];
traindata.X=[];
traindata.Y=[];
testdata.X=[];
testdata.Y=[];
set(handles.checkbox1,'value',0);
set(handles.checkbox2,'value',0);
set(handles.checkbox4,'value',0);
set(handles.radiobutton3,'value',1);
set(handles.radiobutton4,'value',0);
set(handles.radiobutton1,'value',0);
set(handles.radiobutton2,'value',1);
set(handles.radiobutton6,'value',1);
set(handles.radiobutton5,'value',0);
nbrKNN=3;
classfierchoix=2;
datatype=2;
kfold_CV=0;
set(handles.edit5,'string',num2str(10));
set(handles.edit6,'string',num2str(0));
set(handles.edit8,'string',num2str(0));
set(handles.edit7,'string',num2str(0));
set(handles.edit1,'string',num2str(0.01));
set(handles.edit4,'string',num2str(0.01));
set(handles.edit9,'string',num2str(0));
set(handles.edit5,'string',num2str(0));
set(handles.edit11,'string',num2str(0));
set(handles.edit13,'string',num2str(0));
set(handles.edit17,'string',num2str(3));
set(handles.text26,'string','');
set(handles.edit14,'string','');
set(handles.edit14,'BackgroundColor','white');
alpha=0.01;
threshold=0.01;
set(handles.popupmenu8,'Value',1);
if(get(handles.popupmenu8,'Value')==1)
    thetest='z';
elseif(get(handles.popupmenu8,'Value')==2)
    thetest='g2';
elseif(get(handles.popupmenu8,'Value')==3)
    thetest='chi2';
end
set(handles.popupmenu2,'Value',1);
set(handles.popupmenu3,'Value',1);
set(handles.popupmenu7,'Value',1);



% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
global datatype thetest
datatype=1;
set(handles.radiobutton1,'value',1);
set(handles.radiobutton2,'value',0);
set(handles.popupmenu8,'Value',2);

if(get(handles.popupmenu8,'Value')==1)
    thetest='z';
elseif(get(handles.popupmenu8,'Value')==2)
    thetest='g2';
elseif(get(handles.popupmenu8,'Value')==3)
    thetest='chi2';
end


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
global datatype thetest
datatype=2;
set(handles.radiobutton2,'value',1);
set(handles.radiobutton1,'value',0);
set(handles.popupmenu8,'Value',1);

if(get(handles.popupmenu8,'Value')==1)
    thetest='z';
elseif(get(handles.popupmenu8,'Value')==2)
    thetest='g2';
elseif(get(handles.popupmenu8,'Value')==3)
    thetest='chi2';
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
global alpha
alpha=str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8
global thetest
contents = cellstr(get(hObject,'String'));
if(get(hObject,'Value')==1)
    thetest='z';
elseif(get(hObject,'Value')==2)
    thetest='g2';
elseif(get(hObject,'Value')==3)
    thetest='chi2';
end

% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
global threshold
threshold=str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function text14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
global kfold_CV
kfold_CV=str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
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



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double
global prc1

prc1=str2double(get(hObject,'String'));



% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double



% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global traindata testdata
[filename1, pathname] = uigetfile( ...
    {'*.mat','MAT (*.mat)'},'ouvrir');

% if(filename1~=0) %pour traiter le cas d'appayer sur annule
% fName = fullfile(pathname,filename1);
% fff=load(fName);
% d=fieldnames(fff);
% s=size(fff.(d{1}),2);
% traindata.X=fff.(d{1})(:,1:s-1);
% traindata.Y=fff.(d{1})(:,s);
% clear fff d s;
% set(handles.checkbox1,'value',1);
% end

% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global traindata testdata  prc1  theallDATA

if(~isempty(theallDATA))
    traindata.X=[];
    traindata.Y=[];
    testdata.X=[];
    testdata.Y=[];
    if(prc1~=0)
        
        [N,L]=size(theallDATA);
        
        nbrtrn=floor((prc1*N)/100);
        nbrtst=N-nbrtrn;
        traindata.X=[];
        traindata.Y=[];
        testdata.X=[];
        testdata.Y=[];
        %%%%%%%%%%%%%%%%%%%%%%%
        traindata.X=theallDATA(1:nbrtrn,1:L-1);
        traindata.Y=theallDATA(1:nbrtrn,L);
        testdata.X=theallDATA(nbrtrn+1:N,1:L-1);
        testdata.Y=theallDATA(nbrtrn+1:N,L);
        strinvl=['(' num2str(nbrtrn) ',' num2str(nbrtst) ')'];
        set(handles.text26,'string',strinvl);
    end
elseif(~isempty(traindata) && ~isempty(testdata))
    if(prc1==0)
        theallDATA=[];
    elseif(prc1~=0)
        theallDATA=[[traindata.X traindata.Y];[testdata.X testdata.Y]];
        [N,L]=size(theallDATA);
        
        nbrtrn=floor((prc1*N)/100);
        nbrtst=N-nbrtrn;
        traindata.X=[];
        traindata.Y=[];
        testdata.X=[];
        testdata.Y=[];
        %%%%%%%%%%%%%%%%%%%%%%%
        traindata.X=theallDATA(1:nbrtrn,1:L-1);
        traindata.Y=theallDATA(1:nbrtrn,L);
        testdata.X=theallDATA(nbrtrn+1:N,1:L-1);
        testdata.Y=theallDATA(nbrtrn+1:N,L);
        strinvl=['(' num2str(nbrtrn) ',' num2str(nbrtst) ')'];
        set(handles.text26,'string',strinvl);
    end
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global theallDATA traindata testdata
theallDATA=[];

[filename1, pathname] = uigetfile( ...
    {'*.mat','MAT (*.mat)'},'ouvrir');

if(filename1~=0) %pour traiter le cas d'appayer sur annule
    fName = fullfile(pathname,filename1);
    fff=load(fName);
    d=fieldnames(fff);
    s=size(fff.(d{1}),2);
    theallDATA=fff.(d{1})(:,1:s);
    
    clear fff d s;
    set(handles.checkbox4,'value',1);
end

% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
global funchoix
funchoix=1;
set(handles.radiobutton3,'value',1);
set(handles.radiobutton4,'value',0);

% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
global funchoix
funchoix=2;
set(handles.radiobutton4,'value',1);
set(handles.radiobutton3,'value',0);


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5
global classfierchoix
classfierchoix=1;
set(handles.radiobutton5,'value',1);
set(handles.radiobutton6,'value',0);

% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6
global classfierchoix
classfierchoix=2;
set(handles.radiobutton6,'value',1);
set(handles.radiobutton5,'value',0);


function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double
global nbrKNN

nbrKNN=str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NFS;
