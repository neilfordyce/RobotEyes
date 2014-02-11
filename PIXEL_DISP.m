function [ minimumvalue,disparity_vector,mag ] = PIXEL_DISP(x, y, imgL,imgR, subwindowsize, searcharea, x_searcharea )
%PIXEL_DISP Summary of this function goes here
x_searcharea = round(x_searcharea / 2);
searcharea = round(searcharea / 2);
subwindowsize = round(subwindowsize / 2);

%Get first pixel on left window
A_SUBWINDOW = imgL(x-subwindowsize:x+subwindowsize, y-subwindowsize:y+subwindowsize);
%Search window has half the sub window size add to each edge
B_SEARCHWINDOW = imgR(x-x_searcharea-subwindowsize:x+x_searcharea+subwindowsize, y-searcharea-subwindowsize:y+searcharea+subwindowsize);

DISP = zeros(x_searcharea, searcharea);
min_disp = 0;
for x2 = 1:x_searcharea
    for y2 = 1:searcharea
        B_SUBWINDOW = B_SEARCHWINDOW(x2+1:x2+subwindowsize*2+1, y2:y2+subwindowsize*2);
        DISP(x2,y2) = SUPPORT_CMP(subwindowsize + 1, A_SUBWINDOW, B_SUBWINDOW);
        
        if DISP(x2,y2) < min_disp && x > 50 && y > 50
            min_disp = DISP(x2,y2);
            subplot(2,1,2);
            imshow(B_SUBWINDOW);
            subplot(2,1,1);
            imshow(A_SUBWINDOW);
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
