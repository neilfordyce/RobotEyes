function [ minimumvalue, location, DISP] = PIXEL_DISP(x, y, imgL,imgR, subwindowsize, searcharea )
%PIXEL_DISP Summary of this function goes here
%Get first pixel on left window
A_SUBWINDOW = imgL(x:subwindowsize+x, y:subwindowsize+y);
%B_SEARCHWINDOW = imgR(x:searcharea+x, y:searcharea+y);

offset = -searcharea/2;
DISP = ones(searcharea, searcharea);
for x2 = 1:searcharea
    for y2 = 1:searcharea
        B_SUBWINDOW = imgR(x2+x+offset:subwindowsize+x2+x+offset, y2+y+offset:subwindowsize+y2+y+offset);
        DISP(x2,y2) = SUPPORT_CMP(subwindowsize + 1, A_SUBWINDOW, B_SUBWINDOW);
    end
end

%location
[minimumvalue,ind] = min(DISP(:));
[m,n] = ind2sub(size(DISP),ind);
location = -[m+offset,n+offset];

end

