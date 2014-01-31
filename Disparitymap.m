L = imread('testL.jpg');
R = imread('testR.jpg');

L = rgb2gray(L);
R = rgb2gray(R);

L = L(1:100,1:100);
R = R(1:100,1:100);

figure;
imshow(L);
figure;
imshow(R);
DISP_MAP(L,R);