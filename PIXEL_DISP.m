function [ minimumvalue,disparity_vector,mag,f_max ] = PIXEL_DISP(x, y, imgL,imgR, subwindowsize, searcharea, x_searcharea )
%PIXEL_DISP Summary of this function goes here
x_searcharea = floor(x_searcharea / 2);
searcharea = floor(searcharea / 2);
subwindowsize = floor(subwindowsize / 2);

%Get first pixel on left window
A_SUBWINDOW = imgL(x-subwindowsize:x+subwindowsize, y-subwindowsize:y+subwindowsize);
fft = gradient(double(A_SUBWINDOW));
f_max = max(abs(fft(:)));
%Search window has half the sub window size add to each edge
B_SEARCHWINDOW = imgR(x-x_searcharea-subwindowsize:x+x_searcharea+subwindowsize, y-searcharea-subwindowsize:y+searcharea+subwindowsize);

DISP = ones(x_searcharea*2, searcharea+1) * inf;  %All disparities inf to begin with
min_disp = -inf;
for x2 = 1:x_searcharea*2
    for y2 = 1:searcharea+1  %Need +1 to look at the same windows in L and R: i.e. no disparity
        B_SUBWINDOW = B_SEARCHWINDOW(x2:x2+subwindowsize*2, y2:y2+subwindowsize*2);
        DISP(x2,y2) = SUPPORT_CMP(A_SUBWINDOW, B_SUBWINDOW);
        
        if DISP(x2,y2) < min_disp && x > 50 && y > 60 && subwindowsize > 4
            min_disp = DISP(x2,y2);
            subplot(2,2,2);
            imshow(B_SUBWINDOW);
            subplot(2,2,1);
            imshow(A_SUBWINDOW);
            subplot(2,2,3);
            imshow(B_SEARCHWINDOW);
            pause(0.5)
        end
    end
end

%location
[minimumvalue,ind] = min(DISP(:));
[m,n] = ind2sub(size(DISP),ind);
%n and m are rows and columns so switch for xy coords
disparity_vector = [n, m];

%mag = abs(n+offset);
mag = norm(disparity_vector);
mag = size(DISP, 2) - n;
%mag=minimumvalue;
end
