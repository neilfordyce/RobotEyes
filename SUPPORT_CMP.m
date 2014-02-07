function [ ssdnumber ] = SUPPORT_CMP( window_size, imgL,imgR )
%SUPPORT_CMP: Compute the SSD between pixels in a left and right
%stereoscopic image. Inputs include the left and right image along with the
%window size to be examined.

%SSD
%A = imgL(1:window_size,1:window_size);
%B = imgR(1:window_size,1:window_size);
A = imgL;
B = imgR;

avgA = mean2(A);
avgB = mean2(B);

A = double(A);
B = double(B);

C = (A-B).^2;

%C = ((A-avgA)-(B- avgB)).^2 / std(A(:))*std(B(:));

C = sum(C(:));

ssdnumber = C;
end
