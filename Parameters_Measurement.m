function varargout = Parameters_Measurement(varargin)
% PARAMETERS_MEASUREMENT MATLAB code for Parameters_Measurement.fig
%      PARAMETERS_MEASUREMENT, by itself, creates a new PARAMETERS_MEASUREMENT or raises the existing
%      singleton*.
%
%      H = PARAMETERS_MEASUREMENT returns the handle to a new PARAMETERS_MEASUREMENT or the handle to
%      the existing singleton*.
%
%      PARAMETERS_MEASUREMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARAMETERS_MEASUREMENT.M with the given input arguments.
%
%      PARAMETERS_MEASUREMENT('Property','Value',...) creates a new PARAMETERS_MEASUREMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Parameters_Measurement_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Parameters_Measurement_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Parameters_Measurement

% Last Modified by GUIDE v2.5 06-Feb-2020 15:41:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Parameters_Measurement_OpeningFcn, ...
                   'gui_OutputFcn',  @Parameters_Measurement_OutputFcn, ...
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


% --- Executes just before Parameters_Measurement is made visible.
function Parameters_Measurement_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Parameters_Measurement (see VARARGIN)

currentFolder = pwd;
addpath([currentFolder '/bfmatlab'])
addpath([currentFolder '/export_fig-master'])
addpath([currentFolder '/newid'])

handles.data = [];
handles.indx = [];
handles.file = [];
handles.res = [];
handles.undo = [];

% Choose default command line output for Parameters_Measurement
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Parameters_Measurement wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%%positions
set(handles.file_list,'Units', 'normalized');
set(handles.file_list,'Position', [0.01 0.548 0.26 0.45]);
set(handles.file_popUp,'Units', 'normalized');
set(handles.file_popUp,'Position', [0.01 0.532 0.26 0.01]);
set(handles.button_measurements,'Units', 'normalized');
set(handles.button_measurements,'Position', [0.01 0.43 0.08 0.05]);
set(handles.save_excel,'Units', 'normalized');
set(handles.save_excel,'Position', [0.19 0.43 0.08 0.05]);
set(handles.contrast_panel,'Units', 'normalized');
set(handles.contrast_panel,'Position', [0.01 0.468 0.13 0.05]);
set(handles.Contrast,'Units', 'normalized');
set(handles.Contrast,'Position', [0.02 0.1 0.96 0.8]);
set(handles.brightness_panel,'Units', 'normalized');
set(handles.brightness_panel,'Position', [0.14 0.468 0.13 0.05]);
set(handles.Brightness,'Units', 'normalized');
set(handles.Brightness,'Position', [0.02 0.1 0.96 0.8]);

set(handles.button_measurements,'Units', 'normalized');
set(handles.button_measurements,'Position', [0.01 0.423 0.08 0.04]);
set(handles.auto_checkbox,'Units', 'normalized');
set(handles.auto_checkbox,'Position', [0.12 0.423 0.05 0.04]);
set(handles.save_excel,'Units', 'normalized');
set(handles.save_excel,'Position', [0.19 0.423 0.08 0.04]);

set(handles.table_info,'Units', 'normalized');
set(handles.table_info,'Position', [0.01 0.02 0.26 0.4],'ColumnWidth',{112 112 112});
set(handles.figure,'Units', 'normalized');
set(handles.figure,'Position', [0.27 0.1 0.7 0.85]);
set(handles.save_image,'Units', 'normalized');
set(handles.save_image,'Position', [0.93 0.02 0.05 0.05]);
set(handles.grid,'Units', 'normalized');
set(handles.grid,'Position', [0.87 0.02 0.05 0.05]);

%measurements
set(handles.InnDiameter, 'Position', [0.3 0.02 0.05 0.05])
set(handles.OutDiameter, 'Position', [0.36 0.02 0.05 0.05])
set(handles.window_sz,'Units', 'normalized');
set(handles.window_sz,'Position', [0.42 0.02 0.05 0.05]);
set(handles.window,'Units', 'normalized');
set(handles.window,'Position', [0.1 0.1 0.8 0.8]);
set(handles.Next, 'Position', [0.48 0.02 0.05 0.05])


% --- Outputs from this function are returned to the command line.
function varargout = Parameters_Measurement_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function menu_Callback(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function open_Callback(hObject, eventdata, handles)
% [filename, pathname] = uigetfile('*.czi*');
[Files, pathname]=uigetfile('*.*', 'Select files to load:','MultiSelect','on');

if size(Files,2) == 1
    return
end

if iscell(Files)
    L = size(Files,2);
    f = waitbar(1/L,'Loading files');
else
    L = 1;
    filename = Files;
end

for i = 1:L
    if iscell(Files)
        filename = Files{1,i};
    end
    data = bfopen([pathname filename]);
    s1 = data{1,1}{1,1};
    %save to the memory
    handles.data = [handles.data;{s1}];
    %handles.res = [handles.res; res];

    %pop up
    txt = get(handles.file_popUp,'String');
    txt = [txt; {filename}];
    set(handles.file_popUp,'String',txt);


    % Adding file to file list
    txt = get(handles.file_list,'String');
    txt = [txt; {filename}];
    set(handles.file_list,'String',txt);

    files = get(handles.file_list,'String');
    handles.file = files(2:end,1);
    
    if iscell(Files)
        waitbar(i/L,f)
    end
    
end

if iscell(Files)
    close(f)
end


guidata(hObject, handles);



% --- Executes on selection change in file_list.
function file_list_Callback(hObject, eventdata, handles)
% hObject    handle to file_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns file_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from file_list


% --- Executes during object creation, after setting all properties.
function file_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in file_popUp.
function file_popUp_Callback(hObject, eventdata, handles)
% hObject    handle to file_popUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns file_popUp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from file_popUp
contents = cellstr(get(hObject,'String'));
display_choice = contents(get(hObject, 'Value'));
handles.dispChoice = display_choice;
handles.Npoints = 0;
handles.points = [];
handles.Diameters = {};
handles.DiamPos = {};
table = zeros(1,3);
set(handles.table_info, 'data', table);
handles.tableidx = 0;

set(handles.InnDiameter, 'Visible', 'Off')
set(handles.OutDiameter, 'Visible', 'Off')
set(handles.Next, 'Visible', 'Off')
set(handles.window_sz, 'Visible', 'Off');

set(handles.contrast_panel,'Visible', 'on');
set(handles.brightness_panel,'Visible', 'on');

if strcmp(handles.dispChoice, 'Select file...')
    set(get(gca,'children'),'Visible','off')
    handles.dispChoice = [];
elseif isempty(handles.dispChoice)
    return
else
    indx = strcmp(handles.file_list.String, handles.dispChoice);
    indx = indx(2:end);
    handles.indx = indx;
    data = handles.data{indx};
    
    con = get(handles.Contrast,'Value');
    low_in = mean(mean(im2double(data)))-(con/2+0.0001);
    low_in(low_in < 0) = 0;
    high_in = mean(mean(im2double(data)))+(con/2+0.0001);
    high_in(high_in > 1) = 1;
    handles.contrast.low = low_in;
    handles.contrast.high = high_in;
    
    data = imadjust(data,[low_in high_in],[]);
    
    bright = get(handles.Brightness,'Value');
    data = imadjust(data,[],[],0.5+bright);
    
    imshow(data(round(size(data,1)/5)*4:end,1:round(size(data,2)/1.8)),[])
end

roi = drawline('InteractionsAllowed','none','Deletable' ,true);
scale = pdist(roi.Position);

prompt = {'What is the scale distance? Example 10 \mum'};
dlgtitle = 'Scale distance';
dims = [1 50];
definput = {'10'};
opts.Interpreter = 'tex';
x = newid(prompt,dlgtitle,dims,definput,opts);

handles.res = str2double(x{1,1})/scale;

delete(roi)
imshow(data,[])
if get(handles.grid,'Value')
    Grid_pic(hObject, eventdata, handles)
end
table = zeros(1,3);
set(handles.table_info, 'data', table);

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function file_popUp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file_popUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in button_measurements.
function button_measurements_Callback(hObject, eventdata, handles)
% hObject    handle to button_measurements (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.dispChoice)
    warndlg('File is not selected.','Warning');
    return
end

data = handles.data{handles.indx};
low_in = handles.contrast.low;
high_in = handles.contrast.high;

data = imadjust(data,[low_in high_in],[]);

bright = get(handles.Brightness,'Value');
data = imadjust(data,[],[],0.5+bright);

[x,y] = getpts;
x = round(x);
y = round(y);

pts = [x,y];
handles.points = [handles.points;pts];
handles.Npoints = handles.Npoints+1;
guidata(hObject, handles);

if get(handles.auto_checkbox,'Value')
    
    for i = 1:size(pts,1)
        Disp_window(hObject, eventdata, handles)
        handles = guidata(hObject);
        
        %Inner Diameter
        roi = drawline('InteractionsAllowed','none','Deletable' ,true);
        InD = pdist(roi.Position);
        table = get(handles.table_info, 'data');
        resolution = handles.res;
        table(handles.Npoints,1) = InD*resolution;
        set(handles.table_info, 'data', table);
        handles.Diameters{handles.Npoints,1} = handles.DiamPos{handles.Npoints,1}+roi.Position;
        
        %Outer Diameter
        roi = drawline('InteractionsAllowed','none','Deletable' ,true);
        OutD = pdist(roi.Position);
        table = get(handles.table_info, 'data');
        table(handles.Npoints,2) = OutD*resolution;
        handles.Diameters{handles.Npoints,2} = handles.DiamPos{handles.Npoints,2}+roi.Position;
        
        %G-ratio
        table(handles.Npoints,3) = table(handles.Npoints,1)/table(handles.Npoints,2);
        set(handles.table_info, 'data', table);
        
        %new iteration
        handles.Npoints = handles.Npoints+1;
        guidata(hObject, handles);
    end
    if size(handles.points,1)<handles.Npoints
        handles.Npoints = handles.Npoints-1;
        guidata(hObject, handles);
        imshow(data,[])
        for i = 1:size(handles.points,1)
            drawline('Position',handles.Diameters{i,1},'InteractionsAllowed','none');
            drawline('Position',handles.Diameters{i,2},'InteractionsAllowed','none');
        end
        set(handles.contrast_panel,'Visible', 'on');
        set(handles.brightness_panel,'Visible', 'on');
        if get(handles.grid,'Value')
            Grid_pic(hObject, eventdata, handles)
        end
        
        
        table = get(handles.table_info, 'data');
        zer = table>0;
        idx_zer = sum(zer');
        for i = 1:length(idx_zer)
            if idx_zer(i)<3
                row = i;
                table(row,:)=[];
                set(handles.table_info, 'data', table);

                handles.points(row,:)=[];
                handles.Diameters{row,1}=[];
                handles.Diameters{row,2}=[];
                Rnew = handles.Diameters(~cellfun(@isempty, handles.Diameters));
                if sum(sum(handles.points))>0
                    handles.Diameters = reshape(Rnew,size(Rnew,1)/2,2);
                else
                    handles.Diameters = {};
                end
                handles.Npoints = handles.Npoints-1;
                imshow(data,[])
                for i = 1:size(handles.points,1)
                    drawline('Position',handles.Diameters{i,1},'InteractionsAllowed','none');
                    drawline('Position',handles.Diameters{i,2},'InteractionsAllowed','none');
                end
                if get(handles.grid,'Value')
                    Grid_pic(hObject, eventdata, handles)
                end
                guidata(hObject, handles);
            end
        end
    end
else
set(handles.InnDiameter, 'Visible', 'On')
set(handles.OutDiameter, 'Visible', 'On')
set(handles.Next, 'Visible', 'On')
set(handles.window_sz, 'Visible', 'On');
Disp_window(hObject, eventdata, handles)
end

function Disp_window(hObject, eventdata, handles)

w = round(str2double(get(handles.window,'String'))/handles.res);

data = handles.data{handles.indx};
low_in = handles.contrast.low;
high_in = handles.contrast.high;

data = imadjust(data,[low_in high_in],[]);

bright = get(handles.Brightness,'Value');
data = imadjust(data,[],[],0.5+bright);

[r,c] = size(data);

x = handles.points(handles.Npoints,1);
y = handles.points(handles.Npoints,2);

if x>0 && y>0 && x<c && y<r 
        x1=x-w;
        x2=x+w;
        y1=y-w;
        y2=y+w;
        if x1<0
            x1=1;
        end
        
        if y1<0
            y1=1;
        end
        
        if x2>c
            x2=c;
        end
        
        if y2>r
            y2=r;
        end
end

handles.DiamPos{handles.Npoints,1} = [x1,y1;x1,y1];
handles.DiamPos{handles.Npoints,2} = [x1,y1;x1,y1];
guidata(hObject, handles);

set(handles.contrast_panel,'Visible', 'off');
set(handles.brightness_panel,'Visible', 'off');

imshow(data(y1:y2,x1:x2));



% --- Executes on button press in InnDiameter.
function InnDiameter_Callback(hObject, eventdata, handles)
% hObject    handle to InnDiameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
roi = drawline('InteractionsAllowed','none','Deletable' ,true);
InD = pdist(roi.Position);
table = get(handles.table_info, 'data');

resolution = handles.res;

table(handles.Npoints,1) = InD*resolution;

if any(table(handles.Npoints,2))
    table(handles.Npoints,3) = table(handles.Npoints,1)/table(handles.Npoints,2);
end

set(handles.table_info, 'data', table);

handles.Diameters{handles.Npoints,1} = handles.DiamPos{handles.Npoints,1}+roi.Position;
guidata(hObject, handles);


% --- Executes on button press in OutDiameter.
function OutDiameter_Callback(hObject, eventdata, handles)
% hObject    handle to OutDiameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
roi = drawline('InteractionsAllowed','none','Deletable' ,true);
OutD = pdist(roi.Position);
table = get(handles.table_info, 'data');

resolution = handles.res;
table(handles.Npoints,2) = OutD*resolution;


if any(table(handles.Npoints,1))
    table(handles.Npoints,3) = table(handles.Npoints,1)/table(handles.Npoints,2);
end

set(handles.table_info, 'data', table);

handles.Diameters{handles.Npoints,2} = handles.DiamPos{handles.Npoints,2}+roi.Position;
guidata(hObject, handles);

% --- Executes on button press in Next.
function Next_Callback(hObject, eventdata, handles)
% hObject    handle to Next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data = handles.data{handles.indx};
low_in = handles.contrast.low;
high_in = handles.contrast.high;

data = imadjust(data,[low_in high_in],[]);

bright = get(handles.Brightness,'Value');
data = imadjust(data,[],[],0.5+bright);

if size(handles.points,1)>handles.Npoints
    handles.Npoints = handles.Npoints+1;
    guidata(hObject, handles);
    Disp_window(hObject, eventdata, handles)
else
    imshow(data,[])
    for i = 1:size(handles.points,1)
        drawline('Position',handles.Diameters{i,1},'InteractionsAllowed','none');
        drawline('Position',handles.Diameters{i,2},'InteractionsAllowed','none');
    end
    set(handles.InnDiameter, 'Visible', 'Off')
    set(handles.OutDiameter, 'Visible', 'Off')
    set(handles.Next, 'Visible', 'Off')
    set(handles.window_sz, 'Visible', 'Off');
    set(handles.contrast_panel,'Visible', 'on');
    set(handles.brightness_panel,'Visible', 'on');
    
    if get(handles.grid,'Value')
        Grid_pic(hObject, eventdata, handles)
    end
    
    table = get(handles.table_info, 'data');
    zer = table>0;
    idx_zer = sum(zer');
    for i = 1:length(idx_zer)
        if idx_zer(i)<3
            row = i;
            table(row,:)=[];
            set(handles.table_info, 'data', table);

            handles.points(row,:)=[];
            handles.Diameters{row,1}=[];
            handles.Diameters{row,2}=[];
            Rnew = handles.Diameters(~cellfun(@isempty, handles.Diameters));
            if sum(sum(handles.points))>0
                handles.Diameters = reshape(Rnew,size(Rnew,1)/2,2);
            else
                handles.Diameters = {};
            end
            handles.Npoints = handles.Npoints-1;
            imshow(data,[])
            for i = 1:size(handles.points,1)
                drawline('Position',handles.Diameters{i,1},'InteractionsAllowed','none');
                drawline('Position',handles.Diameters{i,2},'InteractionsAllowed','none');
            end
            if get(handles.grid,'Value')
                Grid_pic(hObject, eventdata, handles)
            end
            guidata(hObject, handles);
        end
    end
end



%Disp(hObject, eventdata, handles)





% --- Executes on button press in save_excel.
function save_excel_Callback(hObject, eventdata, handles)
% hObject    handle to save_excel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.dispChoice)
    return
end

File = array2table(get(handles.table_info, 'data'));

File.Properties.VariableNames = {'Inner_Diameter' 'Outer_Diameter' 'G_ratio'};

name = [handles.dispChoice{1,1} '_results'];
        
[filename, filepath] = uiputfile('*.xlsx', 'Save the project file:',name);
FileName = fullfile(filepath, filename);
writetable(File,FileName);
tablee = get(handles.table_info, 'data');
diameters = handles.Diameters;
Npoints = handles.Npoints;
points = handles.points;
DiamPos = handles.DiamPos;
save([name, '.mat'],'diameters','tablee','Npoints','points','DiamPos','-v7.3')



% --- Executes on button press in save_image.
function save_image_Callback(hObject, eventdata, handles)
% hObject    handle to save_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.dispChoice)
    return
end

set(handles.grid, 'Value', 0)
data = handles.data{handles.indx};

low_in = handles.contrast.low;
high_in =handles.contrast.high;

data = imadjust(data,[low_in high_in],[]);

bright = get(handles.Brightness,'Value');
data2 = imadjust(data,[],[],0.5+bright);

imshow(data2,[])

for i = 1:size(handles.points,1)
    drawline('Position',handles.Diameters{i,1},'InteractionsAllowed','none');
    drawline('Position',handles.Diameters{i,2},'InteractionsAllowed','none');
end




filename =  handles.dispChoice{1,1};
filename = [filename(1:end-4) '_measurements'];
export_fig(handles.figure, filename);



function window_Callback(hObject, eventdata, handles)
% hObject    handle to window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of window as text
%        str2double(get(hObject,'String')) returns contents of window as a double
Disp_window(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function window_CreateFcn(hObject, eventdata, handles)
% hObject    handle to window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected cell(s) is changed in table_info.
function table_info_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to table_info (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

if sum(sum(eventdata.Indices))>0
    data = handles.data{handles.indx};
    low_in = handles.contrast.low;
    high_in = handles.contrast.high;

    data = imadjust(data,[low_in high_in],[]);

    bright = get(handles.Brightness,'Value');
    data = imadjust(data,[],[],0.5+bright);
    imshow(data,[])
    for i = 1:size(handles.points,1)
        drawline('Position',handles.Diameters{i,1},'InteractionsAllowed','none');
        drawline('Position',handles.Diameters{i,2},'InteractionsAllowed','none');
    end
    if get(handles.grid,'Value')
        Grid_pic(hObject, eventdata, handles)
    end
    row_s = eventdata.Indices(1,1);
    [I,O]=handles.Diameters{row_s,:};
    drawline('Position',I,'InteractionsAllowed','none','Color','r');
    drawline('Position',O,'InteractionsAllowed','none','Color','r');

    handles.tableidx = row_s;
    guidata(hObject, handles);
end



% --- Executes on key press with focus on table_info and none of its controls.
function table_info_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to table_info (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
keyPressed = eventdata.Key;
if strcmpi(keyPressed,'backspace')
    row = handles.tableidx; 
    answer = questdlg(['Do you want to delete ', num2str(row), '. row?'] ,'Delete','Yes', 'No','Yes');
    % Handle response
    switch answer
        case 'No'
            return
        case 'Yes'
            table = get(handles.table_info, 'data');
            table(row,:)=[];
            set(handles.table_info, 'data', table);
            
            handles.points(row,:)=[];
            handles.Diameters{row,1}=[];
            handles.Diameters{row,2}=[];
            Rnew = handles.Diameters(~cellfun(@isempty, handles.Diameters));
            if sum(sum(handles.points))>0
                handles.Diameters = reshape(Rnew,size(Rnew,1)/2,2);
            else
                handles.Diameters = {};
            end
            handles.Npoints = handles.Npoints-1;
            
            data = handles.data{handles.indx};
            low_in = handles.contrast.low;
            high_in = handles.contrast.high;

            data = imadjust(data,[low_in high_in],[]);

            bright = get(handles.Brightness,'Value');
            data = imadjust(data,[],[],0.5+bright);
            imshow(data,[])
            for i = 1:size(handles.points,1)
                drawline('Position',handles.Diameters{i,1},'InteractionsAllowed','none');
                drawline('Position',handles.Diameters{i,2},'InteractionsAllowed','none');
            end
            if get(handles.grid,'Value')
                Grid_pic(hObject, eventdata, handles)
            end
            guidata(hObject, handles);
    end
  
end


% --- Executes on button press in auto_checkbox.
function auto_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to auto_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of auto_checkbox


function load_measurement_Callback(hObject, eventdata, handles)
% [filename, pathname] = uigetfile('*.czi*');
[File, pathname]=uigetfile('*.mat', 'Select existing measurement to load:');
handles = guidata(hObject);

load([pathname, File])
handles.Diameters = diameters;
T = tablee;
set(handles.table_info, 'data', T);
handles.Npoints = Npoints;
handles.points = points;
handles.DiamPos = DiamPos;

for i = 1:size(handles.Diameters,1)
    drawline('Position',handles.Diameters{i,1},'InteractionsAllowed','none');
    drawline('Position',handles.Diameters{i,2},'InteractionsAllowed','none');
end
if get(handles.grid,'Value')
    Grid_pic(hObject, eventdata, handles)
end
guidata(hObject, handles);

% --- Executes on slider movement.
function Contrast_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
data = handles.data{handles.indx};

con = get(handles.Contrast,'Value');
low_in = mean2(im2double(data))-(con/2+0.0001);
low_in(low_in < 0) = 0;
high_in = mean2(im2double(data))+(con/2+0.0001);
high_in(high_in > 1) = 1;
handles.contrast.low = low_in;
handles.contrast.high = high_in;

data = imadjust(data,[low_in high_in],[]);

bright = get(handles.Brightness,'Value');
data2 = imadjust(data,[],[],0.5+bright);

imshow(data2,[])

for i = 1:size(handles.points,1)
    drawline('Position',handles.Diameters{i,1},'InteractionsAllowed','none');
    drawline('Position',handles.Diameters{i,2},'InteractionsAllowed','none');
end
if get(handles.grid,'Value')
    Grid_pic(hObject, eventdata, handles)
end

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Contrast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function Brightness_Callback(hObject, eventdata, handles)
% hObject    handle to Brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
data = handles.data{handles.indx};

low_in = handles.contrast.low;
high_in =handles.contrast.high;

data = imadjust(data,[low_in high_in],[]);

bright = get(handles.Brightness,'Value');
data2 = imadjust(data,[],[],0.5+bright);

imshow(data2,[])

for i = 1:size(handles.points,1)
    drawline('Position',handles.Diameters{i,1},'InteractionsAllowed','none');
    drawline('Position',handles.Diameters{i,2},'InteractionsAllowed','none');
end
if get(handles.grid,'Value')
    Grid_pic(hObject, eventdata, handles)
end


% --- Executes during object creation, after setting all properties.
function Brightness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in grid.
function grid_Callback(hObject, eventdata, handles)
% hObject    handle to grid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of grid
if isempty(handles.dispChoice)
    return
end

data = handles.data{handles.indx};

low_in = handles.contrast.low;
high_in =handles.contrast.high;

data = imadjust(data,[low_in high_in],[]);

bright = get(handles.Brightness,'Value');
data2 = imadjust(data,[],[],0.5+bright);

imshow(data2,[])

for i = 1:size(handles.points,1)
    drawline('Position',handles.Diameters{i,1},'InteractionsAllowed','none');
    drawline('Position',handles.Diameters{i,2},'InteractionsAllowed','none');
end

if get(handles.grid,'Value')
    Grid_pic(hObject, eventdata, handles)
end



function Grid_pic(hObject, eventdata, handles)
data = handles.data{handles.indx};
[r,c] = size(data);
stepR = r/4;
stepC = c/4;
drawline('Position',[1,stepR;c,stepR],'InteractionsAllowed','none','Color','w','LineWidth',1);
drawline('Position',[1,stepR*2;c,stepR*2],'InteractionsAllowed','none','Color','w','LineWidth',1);
drawline('Position',[1,stepR*3;c,stepR*3],'InteractionsAllowed','none','Color','w','LineWidth',1);
drawline('Position',[stepC,1;stepC,r],'InteractionsAllowed','none','Color','w','LineWidth',1);
drawline('Position',[stepC*2,1;stepC*2,r],'InteractionsAllowed','none','Color','w','LineWidth',1);
drawline('Position',[stepC*3,1;stepC*3,r],'InteractionsAllowed','none','Color','w','LineWidth',1);
    
