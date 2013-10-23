function [train_hists, textons, file_list] = compute_textons(k)

patch_size = 5;
num_patches = 30;
texture_size = 300;
patch_jump = texture_size / num_patches;

patterns = dir('texture_train/*.tiff');
file_list = {patterns.name};
[~, n_files] = size(file_list);

patches = zeros(n_files*num_patches*num_patches, patch_size*patch_size);
for f_i = 1:n_files
    im = im2double(imread(sprintf('texture_train/%s', file_list{f_i})));

    for i = 1:num_patches
        for j = 1:num_patches
            patch = im(patch_jump*(i-1)+1:patch_jump*(i-1)+5, patch_jump*(j-1)+1:patch_jump*(j-1)+5);
            patch = (patch - mean2(patch)) / norm(patch, 1);

            patches(num_patches*num_patches*(f_i-1)+num_patches*(i-1)+j, :) = patch(:)';
        end
    end
end

% Cluster
[idx, textons] = kmeans(patches, k);

% Compute histograms for each training texture.
train_hists = zeros(n_files,k);
for f_i = 1:n_files
    cur_patches = patches(num_patches*num_patches*(f_i-1)+1:num_patches*num_patches*f_i, :);

    closest_textons = dsearchn(textons, cur_patches);
    histogram = histc(closest_textons, 1:k);
    histogram = histogram / norm(histogram);

    train_hists(f_i, :) = histogram';
end
