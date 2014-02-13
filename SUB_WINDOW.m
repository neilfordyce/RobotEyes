function [ sub_window ] = SUB_WINDOW( img, centre_x, centre_y, size_x, size_y )
%SUB_WINDOW makes a subwindow of img of size size_x/y centred at centre_x/y
%size_x/y should be odd
size_x = floor(size_x / 2);
size_y = floor(size_y / 2);

sub_window = img(centre_x-size_x:centre_x+size_x, centre_y-size_y:centre_y+size_y);
end

