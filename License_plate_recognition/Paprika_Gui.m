function varargout = Paprika_Gui(varargin)
% PAPRIKA_GUI MATLAB code for Paprika_Gui.fig
%      PAPRIKA_GUI, by itself, creates a new PAPRIKA_GUI or raises the existing
%      singleton*.
%
%      H = PAPRIKA_GUI returns the handle to a new PAPRIKA_GUI or the handle to
%      the existing singleton*.
%
%      PAPRIKA_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PAPRIKA_GUI.M with the given input arguments.
%
%      PAPRIKA_GUI('Property','Value',...) creates a new PAPRIKA_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Paprika_Gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Paprika_Gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Paprika_Gui

% Last Modified by GUIDE v2.5 05-Jul-2018 22:31:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Paprika_Gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Paprika_Gui_OutputFcn, ...
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


% --- Executes just before Paprika_Gui is made visible.
function Paprika_Gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Paprika_Gui (see VARARGIN)

% Choose default command line output for Paprika_Gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Paprika_Gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Paprika_Gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname]=uigetfile('Originalpicture\*.jpg', 'File Selector');
I=imread([pathname '\' filename]);%括号括起来就是把这个看成一个路径
handles.I=I;
guidata(hObject, handles);%%传递自己的变量
axes(handles.axes1);
imshow(I);title('原图');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
YuanShi=handles.I;
YuanShiHuiDu=rgb2gray(YuanShi);%转化为灰度图像
BianYuan=edge(YuanShiHuiDu,'canny',0.2);%Canny算子边缘检测
%BianYuan=edge(YuanShiHuiDu,'roberts',0.2,'both');
axes(handles.axes2);
imshow(BianYuan);
se1=[1;1;1]; %线型结构元素 
FuShi=imerode(BianYuan,se1);    %腐蚀图像
axes(handles.axes3);
imshow(FuShi);
se2=strel('rectangle',[25,25]); %矩形结构元素
TianChong=imclose(FuShi,se2);%图像聚类、填充图像
YuanShiLvBo=bwareaopen(TianChong,2000);%从对象中移除面积小于2000的小对象
axes(handles.axes4);
imshow(YuanShiLvBo);
%subplot(2,2,2),plot(0:y-1,Y1),title('原图行方向像素点值累计和'),xlabel('行值'),ylabel('像素'); 
%%%%%%%%%%车牌定位%%%%%%%%%%%
[y,x]=size(YuanShiLvBo);%size函数将数组的行数返回到第一个输出变量，将数组的列数返回到第二个输出变量
YuCuDingWei=double(YuanShiLvBo);
%%%%%%%%%2.确定行的起始位置和终止位置%%%%%%%%%%%
Y1=zeros(y,1);%产生y行1列全零数组
for i=1:y
    for j=1:x
        if(YuCuDingWei(i,j)==1)
            Y1(i,1)= Y1(i,1)+1;%白色像素点统计
        end
    end
end
[temp,MaxY]=max(Y1);%Y方向车牌区域确定。返回行向量temp和MaxY，temp向量记录Y1的每列的最大值，MaxY向量记录Y1每列最大值的行号

PY1=MaxY;
while ((Y1(PY1,1)>=50)&&(PY1>1))%从最高点开始向两侧找边界
        PY1=PY1-1;
end
PY2=MaxY;
while ((Y1(PY2,1)>=50)&&(PY2<y))
        PY2=PY2+1;
end
IY=YuanShi(PY1:PY2,:,:);
%%%%%%%%%%车牌粗定位之二确定列的起始位置和终止位置%%%%%%%%%%%
%%%%%%%%%%和列分割不同这个是从两边向中间找%%%%%%%%%%%%%%
X1=zeros(1,x);%产生1行x列全零数组
for j=1:x
    for i=PY1:PY2
        if(YuCuDingWei(i,j,1)==1)
                X1(1,j)= X1(1,j)+1;               
         end  
    end       
end

PX1=1;
while ((X1(1,PX1)<3)&&(PX1<x))
       PX1=PX1+1;
end    
PX3=x;
while ((X1(1,PX3)<3)&&(PX3>PX1))
        PX3=PX3-1;
end
CuDingWei=YuanShi(PY1:PY2,PX1+10:PX3-10,:);%待定
axes(handles.axes5);
imshow(CuDingWei);
%%%%%%%%%%2.3、车牌精定位之一预处理%%%%%%%%%%%
CuDingWeiHuiDu=rgb2gray(CuDingWei); %将RGB图像转化为灰度图像
axes(handles.axes6);
imshow(CuDingWeiHuiDu);
c_max=double(max(max(CuDingWeiHuiDu)));
c_min=double(min(min(CuDingWeiHuiDu)));
T=round(c_max-(c_max-c_min)/3); %T为二值化的阈值
CuDingWeiErZhi=im2bw(CuDingWeiHuiDu,T/256);
CuDingWeiErZhi=bwareaopen(CuDingWeiErZhi,20);
CuDingWeiErZhi(: ,PX3-4)=0;
CuDingWeiErZhi=bwareaopen(CuDingWeiErZhi,100);

CuDingWeiErZhi=lvbo(CuDingWeiErZhi);

axes(handles.axes7);
imshow(CuDingWeiErZhi);
%subplot(2,2,2),imshow(CuDingWeiErZhi),title('粗定位的二值车牌图像')%DingWei
%figure(3);
%%%%%%%%%%%%精确分割%%%%%%%%%%%%%
ChePaiLvBo=CuDingWeiErZhi;%logical()
FuShi=imerode(BianYuan,se1);    %腐蚀图像
ChePaiYuFenGe=double(ChePaiLvBo);
[p,q]=size(ChePaiYuFenGe);
X3=zeros(1,q);%产生1行q列全零数组
for j=1:q
    for i=1:p
       if(ChePaiYuFenGe(i,j)==1) 
           X3(1,j)=X3(1,j)+1;
       end
    end
end
%%%%%%%%%%3.2、字符分割%%%%%%%%%%%p高q宽，倒序分割
Px0=q;%字符右侧限
Px1=q;%字符左侧限
for i=1:6
    while((X3(1,Px0)<3)&&(Px0>0))
       Px0=Px0-1;
    end
    Px1=Px0;
    while(  (   (X3(1,Px1) >=3)  )  &&  (Px1>0)  || ((Px0-Px1)<25)  )%要求一个字符大于15个像素
        Px1=Px1-1;
    end
    ChePaiFenGe=ChePaiLvBo(:,Px1:Px0,:);%得到一个第一个字符（右侧）
    ii=int2str(8-i);%命名
    imwrite(ChePaiFenGe,strcat(ii,'.jpg'));%strcat连接字符串。保存字符图像。
    Px0=Px1;
end
PX3=Px1;%字符1右侧限
while((X3(1,PX3)<3)&&(PX3>0))
       PX3=PX3-1;
end
ZiFu1DingWei=ChePaiYuFenGe(:,1:PX3,:);
%subplot(1,7,1);imshow(ZiFu1DingWei);
imwrite(ZiFu1DingWei,'1.jpg');

%%%%%%%%%%%%%%读取分割完成的字符%%%%%%%%%%%%%%%%%%%%%%%%
ZiFu1=imresize(im2bw(imread('1.jpg'),graythresh(imread('1.jpg'))), [40 20],'bilinear');
ZiFu2=imresize(im2bw(imread('2.jpg'),graythresh(imread('2.jpg'))), [40 20],'bilinear');
ZiFu3=imresize(im2bw(imread('3.jpg'),graythresh(imread('3.jpg'))), [40 20],'bilinear');
ZiFu4=imresize(im2bw(imread('4.jpg'),graythresh(imread('4.jpg'))), [40 20],'bilinear');
ZiFu5=imresize(im2bw(imread('5.jpg'),graythresh(imread('5.jpg'))), [40 20],'bilinear');
ZiFu6=imresize(im2bw(imread('6.jpg'),graythresh(imread('6.jpg'))), [40 20],'bilinear');
ZiFu7=imresize(im2bw(imread('7.jpg'),graythresh(imread('7.jpg'))), [40 20],'bilinear');
axes(handles.axes8);
imshow(ZiFu1);
axes(handles.axes9);
imshow(ZiFu2);
axes(handles.axes10);
imshow(ZiFu3);
axes(handles.axes11);
imshow(ZiFu4);
axes(handles.axes12);
imshow(ZiFu5);
axes(handles.axes13);
imshow(ZiFu6);
axes(handles.axes14);
imshow(ZiFu7);

%%%%%%%%%%%把0-9,A-Z以及省份简称的数据存储方便访问%%%%%%%%%%%

HanZi=ReadCharacter(imread('Chinesecharacter\藏.jpg'),imread('Chinesecharacter\川.jpg'),imread('Chinesecharacter\鄂.jpg'),...
                    imread('Chinesecharacter\贵.jpg'),imread('Chinesecharacter\黑.jpg'), imread('Chinesecharacter\吉.jpg'),...
                    imread('Chinesecharacter\冀.jpg'),imread('Chinesecharacter\津.jpg'),imread('Chinesecharacter\晋.jpg'),...
                    imread('Chinesecharacter\京.jpg'),imread('Chinesecharacter\辽.jpg'),imread('Chinesecharacter\鲁.jpg'),...
                    imread('Chinesecharacter\闽.jpg'),imread('Chinesecharacter\琼.jpg'),imread('Chinesecharacter\陕.jpg'),...
                    imread('Chinesecharacter\苏.jpg'),imread('Chinesecharacter\皖.jpg'),imread('Chinesecharacter\湘.jpg'),...
                    imread('Chinesecharacter\豫.jpg'),imread('Chinesecharacter\粤.jpg'),imread('Chinesecharacter\云.jpg'),...
                    imread('Chinesecharacter\浙.jpg'));
ShuZiZiMu=ReadStringNumber(imread('E and N character\0.jpg'),imread('E and N character\1.jpg'),imread('E and N character\2.jpg'),...
                    imread('E and N character\3.jpg'),imread('E and N character\4.jpg'),imread('E and N character\5.jpg'),...
                    imread('E and N character\6.jpg'),imread('E and N character\7.jpg'),imread('E and N character\8.jpg'),...
                    imread('E and N character\9.jpg'),imread('E and N character\A.jpg'),imread('E and N character\B.jpg'),...
                    imread('E and N character\C.jpg'),imread('E and N character\D.jpg'),imread('E and N character\E.jpg'),...
                    imread('E and N character\F.jpg'),imread('E and N character\G.jpg'),imread('E and N character\H.jpg'),...
                    imread('E and N character\J.jpg'),imread('E and N character\K.jpg'),imread('E and N character\L.jpg'),...
                    imread('E and N character\M.jpg'),imread('E and N character\N.jpg'),imread('E and N character\P.jpg'),...
                    imread('E and N character\Q.jpg'),imread('E and N character\R.jpg'),imread('E and N character\S.jpg'),...
                    imread('E and N character\T.jpg'),imread('E and N character\U.jpg'),imread('E and N character\V.jpg'),...
                    imread('E and N character\W.jpg'),imread('E and N character\X.jpg'),imread('E and N character\Y.jpg'),...
                    imread('E and N character\Z.jpg'));

%%%%%%%%%%%4.3、车牌字符识别%%%%%%%%%%%
%%%%%%%%%%%第一位一定为汉字，两个矩阵相减%%%%%%%%%%%
store1=strcat('藏','川','鄂','贵','黑','吉','冀','津','京','晋','辽','鲁','闽','琼','陕','苏','皖','湘','豫','粤','云','浙');  %创建汉字识别模板库
ShiBieJieGuo=[];
for j=1:22
    Im=ZiFu1;
    Template= HanZi(:,:,j);
    Differ=Im-Template;
    Compare(j)=sum(sum(abs(Differ)));
end
index=find(Compare==(min(Compare)));
index;
ShiBieJieGuo=[ShiBieJieGuo store1(index)];

store2=strcat('0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z'); %创建字母与数字识别模板库
for j=1:34
        Im=ZiFu2;
        Template=ShuZiZiMu(:,:,j);
        Differ=Im-Template;
        Compare(j)=sum(sum(abs(Differ)));
end
index=find(Compare==(min(Compare)));
ShiBieJieGuo=[ShiBieJieGuo store2(index)];

for j=1:34
        Im=ZiFu3;
        Template=ShuZiZiMu(:,:,j);
        Differ=Im-Template;
        Compare(j)=sum(sum(abs(Differ)));
end
index=find(Compare==(min(Compare)));
ShiBieJieGuo=[ShiBieJieGuo store2(index)];

for j=1:34
        Im=ZiFu4;
        Template=ShuZiZiMu(:,:,j);
        Differ=Im-Template;
        Compare(j)=sum(sum(abs(Differ)));
end
index=find(Compare==(min(Compare)));
ShiBieJieGuo=[ShiBieJieGuo store2(index)];

for j=1:34
        Im=ZiFu5;
        Template=ShuZiZiMu(:,:,j);
        Differ=Im-Template;
        Compare(j)=sum(sum(abs(Differ)));
end
index=find(Compare==(min(Compare)));
ShiBieJieGuo=[ShiBieJieGuo store2(index)];;

for j=1:34
        Im=ZiFu6;
        Template=ShuZiZiMu(:,:,j);
        Differ=Im-Template;
        Compare(j)=sum(sum(abs(Differ)));
end
index=find(Compare==(min(Compare)));
ShiBieJieGuo=[ShiBieJieGuo store2(index)];

for j=1:34
        Im=ZiFu7;
        Template=ShuZiZiMu(:,:,j);
        Differ=Im-Template;
        Compare(j)=sum(sum(abs(Differ)));
end
index=find(Compare==(min(Compare)));
ShiBieJieGuo=[ShiBieJieGuo store2(index)];



set(handles.edit1,'String',ShiBieJieGuo);














% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


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
