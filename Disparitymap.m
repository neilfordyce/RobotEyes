%L = imread('testL.jpg');
%R = imread('testR.jpg');
L = imread('stereoPairs/pentagon_left.bmp');
R = imread('stereoPairs/pentagon_right.bmp');
%L = imread('stereoPairs/scene_l.bmp');
%R = imread('stereoPairs/scene_r.bmp');

%L = rgb2gray(L);
%R = rgb2gray(R);

%L = L(1:100,1:100);
%R = R(1:100,1:100);

DISP_MAP(L,R);