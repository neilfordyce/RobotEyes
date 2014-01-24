function [ minimumvalue, location ] = PIXEL_DISP(x, y, imgL,imgR, subwindowsize, searcharea )
%PIXEL_DISP Summary of this function goes here
%Get first pixel on left window
A_SUBWINDOW = imgL(x:subwindowsize+x, y:subwindowsize+y, :);
%B = imgR(x:searcharea+x, y:searcharea+y, :);

DISP = ones(searcharea, searcharea);
for x2 = x:searcharea + x
    for y2 = y:searcharea + y
        B_SUBWINDOW = imgR(x2:subwindowsize+x2, y2:subwindowsize+y2, :);
        DISP(x2,y2) = SUPPORT_CMP(subwindowsize + 1, A_SUBWINDOW, B_SUBWINDOW);
    end
end

[minimumvalue,ind] = min(DISP(:));
[m,n] = ind2sub(size(DISP),ind);
location = [m,n];

%DISP = SUPPORT_CMP(searcharea, A, B);


%Compare to each pixel in turn on the right hand window
%while(
    
    
    
%end






end

