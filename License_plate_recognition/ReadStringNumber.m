function ShuZiZiMu = ReadStringNumber(s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,...
                              s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,...
                              s21,s22,s23,s24,s25,s26,s27,s28,s29,s30,...
                              s31,s32,s33,s34)
%0-9            
%10-14 ABCDE 15-19FGHJK 20-24 LMNPQ 25-29 RSTUV 30-33 WXYZ
ShuZiZiMu(:,:,1)   =imresize(im2bw(s1, graythresh( s1)), [40 20],'bilinear');
ShuZiZiMu(:,:,2)   =imresize(im2bw(s2, graythresh( s2)), [40 20],'bilinear');
ShuZiZiMu(:,:,3)   =imresize(im2bw(s3, graythresh( s3)), [40 20],'bilinear');
ShuZiZiMu(:,:,4)   =imresize(im2bw(s4, graythresh( s4)), [40 20],'bilinear');
ShuZiZiMu(:,:,5)   =imresize(im2bw(s5, graythresh( s5)), [40 20],'bilinear');
ShuZiZiMu(:,:,6)   =imresize(im2bw(s6, graythresh( s6)), [40 20],'bilinear');
ShuZiZiMu(:,:,7)   =imresize(im2bw(s7, graythresh( s7)), [40 20],'bilinear');
ShuZiZiMu(:,:,8)   =imresize(im2bw(s8, graythresh( s8)), [40 20],'bilinear');
ShuZiZiMu(:,:,9)   =imresize(im2bw(s9, graythresh( s9)), [40 20],'bilinear');
ShuZiZiMu(:,:,10)  =imresize(im2bw(s10,graythresh( s10)),[40 20],'bilinear');
ShuZiZiMu(:,:,11)  =imresize(im2bw(s11,graythresh( s11)),[40 20],'bilinear');
ShuZiZiMu(:,:,12)  =imresize(im2bw(s12,graythresh( s12)),[40 20],'bilinear');
ShuZiZiMu(:,:,13)  =imresize(im2bw(s13,graythresh( s13)),[40 20],'bilinear');
ShuZiZiMu(:,:,14)  =imresize(im2bw(s14,graythresh( s14)),[40 20],'bilinear');
ShuZiZiMu(:,:,15)  =imresize(im2bw(s15,graythresh( s15)),[40 20],'bilinear');
ShuZiZiMu(:,:,16)  =imresize(im2bw(s16,graythresh( s16)),[40 20],'bilinear');
ShuZiZiMu(:,:,17)  =imresize(im2bw(s17,graythresh( s17)),[40 20],'bilinear');
ShuZiZiMu(:,:,18)  =imresize(im2bw(s18,graythresh( s18)),[40 20],'bilinear');
ShuZiZiMu(:,:,19)  =imresize(im2bw(s19,graythresh( s19)),[40 20],'bilinear');
ShuZiZiMu(:,:,20)  =imresize(im2bw(s20,graythresh( s20)),[40 20],'bilinear');
ShuZiZiMu(:,:,21)  =imresize(im2bw(s21,graythresh( s21)),[40 20],'bilinear');
ShuZiZiMu(:,:,22)  =imresize(im2bw(s22,graythresh( s22)),[40 20],'bilinear');
ShuZiZiMu(:,:,23)  =imresize(im2bw(s23,graythresh( s23)),[40 20],'bilinear');
ShuZiZiMu(:,:,24)  =imresize(im2bw(s24,graythresh( s24)),[40 20],'bilinear');
ShuZiZiMu(:,:,25)  =imresize(im2bw(s25,graythresh( s25)),[40 20],'bilinear');
ShuZiZiMu(:,:,26)  =imresize(im2bw(s26,graythresh( s26)),[40 20],'bilinear');
ShuZiZiMu(:,:,27)  =imresize(im2bw(s27,graythresh( s27)),[40 20],'bilinear');
ShuZiZiMu(:,:,28)  =imresize(im2bw(s28,graythresh( s28)),[40 20],'bilinear');
ShuZiZiMu(:,:,29)  =imresize(im2bw(s29,graythresh( s29)),[40 20],'bilinear');
ShuZiZiMu(:,:,30)  =imresize(im2bw(s30,graythresh( s30)),[40 20],'bilinear');
ShuZiZiMu(:,:,31)  =imresize(im2bw(s31,graythresh( s31)),[40 20],'bilinear');
ShuZiZiMu(:,:,32)  =imresize(im2bw(s32,graythresh( s32)),[40 20],'bilinear');
ShuZiZiMu(:,:,33)  =imresize(im2bw(s33,graythresh( s33)),[40 20],'bilinear');
ShuZiZiMu(:,:,34)  =imresize(im2bw(s34,graythresh( s34)),[40 20],'bilinear');
