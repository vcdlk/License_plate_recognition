function HanZi=ReadCharacter(zang,chuan,e,gui,hei,jili,ji,tianjin,jin,jing,liao,lu,min,qiong,xia,su,ruan,xiang,yu,yue,yun,zhe)
HanZi(:,:,1)  =imresize(im2bw(zang,graythresh(zang)),[40 20],'bilinear');%�ҵ����ʵ���ֵ��Ȼ����ж�ά��������׼��ͼ��
HanZi(:,:,2)  =imresize(im2bw(chuan,graythresh(chuan)),[40 20],'bilinear');
HanZi(:,:,3)  =imresize(im2bw(e,graythresh( e)),[40 20],'bilinear');
HanZi(:,:,4)  =imresize(im2bw(gui,graythresh( gui)),[40 20],'bilinear');
HanZi(:,:,5)  =imresize(im2bw(hei,graythresh( hei)),[40 20],'bilinear');
HanZi(:,:,6)  =imresize(im2bw(jili,graythresh( jili)),[40 20],'bilinear');
HanZi(:,:,7)  =imresize(im2bw(ji,graythresh( ji)),[40 20],'bilinear');
HanZi(:,:,8)  =imresize(im2bw(tianjin,graythresh( tianjin)),[40 20],'bilinear');
HanZi(:,:,9)  =imresize(im2bw(jing,graythresh( jing)),[40 20],'bilinear');
HanZi(:,:,10)  =imresize(im2bw(jin,graythresh( jin)),[40 20],'bilinear');
HanZi(:,:,11)  =imresize(im2bw(liao,graythresh( liao)),[40 20],'bilinear');
HanZi(:,:,12)  =imresize(im2bw(lu,graythresh( lu)),[40 20],'bilinear');
HanZi(:,:,13)  =imresize(im2bw(min,graythresh( min)),[40 20],'bilinear');
HanZi(:,:,14)  =imresize(im2bw(qiong,graythresh( qiong)),[40 20],'bilinear');
HanZi(:,:,15)  =imresize(im2bw(xia,graythresh( xia)),[40 20],'bilinear');
HanZi(:,:,16)  =imresize(im2bw(su,graythresh( su)),[40 20],'bilinear');
HanZi(:,:,17)  =imresize(im2bw(ruan,graythresh( ruan)),[40 20],'bilinear');
HanZi(:,:,18)  =imresize(im2bw(xiang,graythresh( xiang)),[40 20],'bilinear');
HanZi(:,:,19)  =imresize(im2bw(yu,graythresh( yu)),[40 20],'bilinear');
HanZi(:,:,20)  =imresize(im2bw(yue,graythresh( yue)),[40 20],'bilinear');
HanZi(:,:,21)  =imresize(im2bw(yun,graythresh( yun)),[40 20],'bilinear');
HanZi(:,:,22)  =imresize(im2bw(zhe,graythresh( zhe)),[40 20],'bilinear');