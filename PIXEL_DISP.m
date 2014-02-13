function [ minimumvalue,disparity_vector,mag ] = PIXEL_DISP(x, y, imgL,imgR, subwindowsize, searcharea, x_searcharea )
%PIXEL_DISP Summary of this function goes here

%Get first pixel on left window
A_SUBWINDOW = SUB_WINDOW(imgL, x, y, subwindowsize, subwindowsize);
%Search window has half the sub window size add to each edge
B_SEARCHWINDOW = SUB_WINDOW(imgR, x, y, x_searcharea+subwindowsize, searcharea+subwindowsize);

DISP = ones(x_searcharea, round(searcharea/2)) * inf;  %All disparities inf to begin with
min_disp = -inf;
for x2 = 1:x_searcharea
    for y2 = 1:round(searcharea/2)  %Need 1/2 the window only, the other half is in the wrong direction
        B_SUBWINDOW = B_SEARCHWINDOW(x2:x2+floor(subwindowsize)-1, y2:y2+floor(subwindowsize)-1);
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
