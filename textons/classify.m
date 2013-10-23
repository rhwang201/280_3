function [pred] = classify(im_name, train_hists, textons, file_list)

im = im2double(imread(im_name));

if nargin < 4
    [train_hists, textons, file_list] = compute_textons(25);
end
[n_textures, k] = size(train_hists);


hist = create_histogram(im, textons);


% Find nearest neighbor, using intersection kernel
min_dist = inf;
min_text_i = -1;

for texture_i = 1:n_textures
    text_hist = train_hists(texture_i, :);
    dist = 0;

    for bin_i = 1:k
        dist = dist + min(hist(bin_i), text_hist(bin_i));
    end

    dist = 1 - dist;

    if dist < min_dist
        min_dist = dist;
        min_text_i = texture_i;
    end
end

f = figure(1);
subplot(1,2,1);
imshow(im);

subplot(1,2,2);
matched = imread(sprintf('texture_train/%s',file_list{min_text_i}));
imshow(matched);

pred = file_list{min_text_i};
disp(sprintf('%s predicted to be %s', im_name, pred));
