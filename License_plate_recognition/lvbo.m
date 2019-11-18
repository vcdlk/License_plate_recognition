function CuDingWeiErZhi = lvbo(Image);  
[y,x]=size(Image);%size函数将数组的行数返回到第一个输出变量，将数组的列数返回到第二个输出变量
Image=double(Image);
%%%%%%%%%确定行的起始位置和终止位置%%%%%%%%%%%
Y1=zeros(y,1);%产生y行1列全零数组
for i=1:y
    for j=1:x
        if(Image(i,j)==1)
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
IY=Image(PY1:PY2,:,:);
%%%%%%%%%%车牌粗定位之二确定列的起始位置和终止位置%%%%%%%%%%%
%%%%%%%%%%和列分割不同这个是从两边向中间找%%%%%%%%%%%%%%
X1=zeros(1,x);%产生1行x列全零数组
for j=1:x
    for i=PY1:PY2
        if(Image(i,j)==1)
                X1(1,j)= X1(1,j)+1;               
         end  
    end       
end

PX1=1;
while ((X1(1,PX1)<10)&&(PX1<x))
       PX1=PX1+1;
end    
PX3=x;
while ((X1(1,PX3)<10)&&(PX3>PX1))
        PX3=PX3-1;
end
CuDingWeiErZhi=Image(PY1:PY2,PX1:PX3);

