function [disparity] = match(im_name, window, cost)

half = (window - 1) / 2;

left = rgb2gray(im2double(imread(sprintf('../data/%s/left.png', im_name))));
right = rgb2gray(im2double(imread(sprintf('../data/%s/right.png', im_name))));

% Original dimensions
[m,n] = size(left);

left = padarray(left, [half, half]);
right = padarray(right, [half, half]);

disparity = zeros(m,n);

for i = half+1:half+m
    for j_l = half+1:half+n
        min_cost = inf;
        min_j_r = -1;

        x = left(i-half:i+half, j_l-half:j_l+half);
        x = x(:);

        for j_r = half+1:half+n
            y = right(i-half:i+half, j_r-half:j_r+half);
            y = y(:);

            if cost == 'ssd'
                cost = ssd(x,y);
            elseif cost == 'ncc'
                cost = ncc(x,y);
            end

            if cost < min_cost
                min_cost = cost;
                min_j_r = j_r;
            end
        end

        disparity(i,j_l) = j_l - min_j_r;
    end
end
