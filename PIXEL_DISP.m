function [ minimumvalue,disparity_vector,mag ] = PIXEL_DISP(x, y, imgL,imgR, subwindowsize, searcharea, x_searcharea )
%PIXEL_DISP Summary of this function goes here
%Get first pixel on left window
A_SUBWINDOW = imgL(x:subwindowsize+x, y:subwindowsize+y);
%B_SEARCHWINDOW = imgR(x:searcharea+x, y:searcharea+y);

offset = -searcharea/2;
x_offset = -x_searcharea/2;
DISP = ones(x_searcharea, searcharea);
min_disp = inf;
for x2 = 1:x_searcharea
    for y2 = 1:searcharea
        B_SUBWINDOW = imgR(x2+x+x_offset:subwindowsize+x2+x+x_offset, y2+y+offset:subwindowsize+y2+y+offset);
        DISP(x2,y2) = SUPPORT_CMP(subwindowsize + 1, A_SUBWINDOW, B_SUBWINDOW);
        
        %{
        if DISP(x2,y2) < min_disp
            min_disp = DISP(x2,y2)
            subplot(2,1,2);
            imshow(B_SUBWINDOW);
            subplot(2,1,1);
            imshow(A_SUBWINDOW);
            pause(0.5)
        end
        %}
    end
end

%location
[minimumvalue,ind] = min(DISP(:));
[m,n] = ind2sub(size(DISP),ind);
%n and m are rows and columns so switch for xy coords
disparity_vector = -[n+offset, m+offset];

mag = norm(disparity_vector);

end

