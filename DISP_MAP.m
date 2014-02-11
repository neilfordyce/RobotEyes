function [ DISP_MAG ] = DISP_MAP( imgL,imgR)

PAD = 40;

imgL = padarray(imgL, [PAD PAD], 0, 'both');
imgR = padarray(imgR, [PAD PAD], 0, 'both');

numRows = size(imgL,1);
numCols = size(imgL,2);

DISP_MAG = zeros(size(imgL));

for R = PAD:numRows-PAD 
    for C = PAD:numCols-PAD 
        [~,~,mag] = PIXEL_DISP(R,C,imgL,imgR, 5, 21, 5);
        DISP_MAG(R,C) = mag;
    end
end
    figure;
    imshow(DISP_MAG(PAD:end-PAD, PAD:end-PAD), []);
end

