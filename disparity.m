A = imread('testL.jpg');
B = imread('testR.jpg');

%SSD
A = A(1:30,1:30,:);
B = B(1:30,1:30,:);

avgA = mean2(A);
avgB = mean2(B);

A = double(A);
B = double(B);

C = ((A-avgA)-(B- avgB)).^2 / std(A(:))*std(B(:));

C = sum(sum(C(:)))

%SAD

D = abs(((A-avgA)-(B- avgB))) / std(A(:))*std(B(:));

D = sum(sum(D(:)))
