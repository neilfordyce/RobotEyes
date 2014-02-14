function [ DISP_MAG ] = DISP_MAP( imgL,imgR)

PAD = 40;

imgL = padarray(imgL, [PAD PAD], 0, 'both');
imgR = padarray(imgR, [PAD PAD], 0, 'both');

numRows = size(imgL,1);
numCols = size(imgL,2);

DISP_MAG = zeros(size(imgL));

grad = gradient(double(imgL));

for R = PAD:numRows-PAD 
    for C = PAD:numCols-PAD 
        max_grad = -inf;
        support_window_size = 9;
        max_window_size = 21;
        search_window_size = 31;        
        
        %Grow the window until there is enough detail in the support window
        while max_grad < 1.3 && support_window_size <= max_window_size 
            subwindow = SUB_WINDOW(grad, R, C, support_window_size, support_window_size);
            max_grad = mean(abs(subwindow(:)));
            support_window_size = support_window_size + 2;
        end
          
        %[~,~,mag] = PIXEL_DISP(R,C,imgL,imgR, support_window_size, 13, 5);
        [~,~,mag] = PIXEL_DISP(R,C,imgL,imgR, support_window_size, search_window_size, 5);
        DISP_MAG(R,C) = mag;
    end
end
    figure;
    imshow(DISP_MAG(PAD:end-PAD, PAD:end-PAD), []);
end

