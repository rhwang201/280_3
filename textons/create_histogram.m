function [histogram] = create_histogram(im, textons)

[k, d] = size(textons);

% Extract patches, center, normalize
patch_size = 5;
num_patches = 10;
texture_size = 50;
patch_jump = texture_size / num_patches;

patches = zeros(num_patches*num_patches, patch_size*patch_size);

for i = 1:num_patches
    for j = 1:num_patches
        patch = im(patch_jump*(i-1)+1:patch_jump*(i-1)+5, patch_jump*(j-1)+1:patch_jump*(j-1)+5);
        patch = (patch - mean2(patch)) / norm(patch, 1);

        patches(num_patches*(i-1)+j, :) = patch(:);
    end
end

% Find which cluster (texton) each patch corresponds to, and bin
closest_textons = dsearchn(textons, patches);
histogram = histc(closest_textons, 1:k);

% Normalize histogram
histogram = histogram / norm(histogram);
