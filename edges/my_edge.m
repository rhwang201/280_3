function [] = my_edge(img_name, k_size, mu)

% Use low-pass filter Gaussian to reduce noise
img = imread(img_name);
img_double = im2double(img);
img_gray = rgb2gray(img_double);

H = fspecial('Gaussian', [k_size, k_size], mu);

img = conv2(img_gray, H, 'same');
[m, n] = size(img);

% Intensity Gradient
[g_mag, g_dir] = imgradient(img);

% Non-max Suppression
for i = 2:m-1
    for j = 2:n-2
        mag = g_mag(i,j);
        dir = abs(g_dir(i,j));

        if (dir < 45/2)
            % West/East
            if (mag < g_mag(i,j-1)|| mag < g_mag(i,j+1))
                g_mag(i,j) = 0;
            end
        elseif (dir < (90+45)/2)
            % SouthWest/NorthEast
            if (mag < g_mag(i+1,j-1)|| mag < g_mag(i-1,j+1))
                g_mag(i,j) = 0;
            end
        elseif (dir < (135+90)/2)
            % North/South
            if (mag < g_mag(i-1,j)|| mag < g_mag(i+1,j))
                g_mag(i,j) = 0;
            end
        elseif (dir < (180+135)/2)
            % NorthWest/SouthEast
            if (mag < g_mag(i-1,j-1)|| mag < g_mag(i+1,j+1))
                g_mag(i,j) = 0;
            end
        else
            % West/East
            if (mag < g_mag(i,j-1)|| mag < g_mag(i,j+1))
                g_mag(i,j) = 0;
            end
        end

        %if (mag > 0.01) 
        %    % Find two neighbors using bilinear interpolation
        %    dir = g_dir(i,j);

        %    xq = [i-sind(dir), i+sind(dir)];
        %    yq = [j+cosd(dir), j-cosd(dir)];

        %    mag_interp = interp2(g_mag, xq, yq);

        %    if (mag < mag_interp(1) || mag < mag_interp(2))
        %        g_mag(i,j) = 0;
        %    end
        %else
        %    g_mag(i,j) = 0;
        %end
    end
end
%g_mag(find(g_mag)) = 1;

% Show result.
figure;
imshow(g_mag);
title('My implementation');

figure;
imshow(edge(rgb2gray(im2double(imread(img_name))), 'canny'));
title('MATLAB');
