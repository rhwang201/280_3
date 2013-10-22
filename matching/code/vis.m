function vis(I, d, bf)
% function vis(I, d, bf)
% Function to visualize the textured map disparity map. I is the image and
% d is the disparity image, bf is the baseline into the focal length, put
% in some reasonable value.

    if(~exist('bf', 'var'))
        bf = 10000;
    end
    d = double(d);
    z = bf./d; z(isinf(z)) = max(z(~isinf(z)));
    figure(1); surfl(z); shading interp; axis vis3d; colormap gray; axis xy; axis equal; camup([0 -1 0]); campos([size(d,1)/2-1000 -size(d,1)/2+1000 -bf/2]); axis off; rotate3d on;
    figure(2); warp(z,I); shading interp; axis vis3d; axis xy; axis equal; camup([0 -1 0]); campos([size(d,1)/2-1000 -size(d,1)/2+1000 -bf/2]); axis off; rotate3d on;
end
