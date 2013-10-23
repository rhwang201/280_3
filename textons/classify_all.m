[train_hists, textons, train_file_list] = compute_textons(25);

train_dir = 'texture_train';
test_dir = 'texture_test';

imgs = dir(sprintf('%s/*.tiff', test_dir));
test_file_list = {imgs.name};
[~, n_files] = size(test_file_list);

f = figure;
for test_f_i = 1:n_files
    im_name = test_file_list{test_f_i};
    test_im_name = sprintf('%s/%s', test_dir, im_name);

    pred = classify(test_im_name, train_hists, textons, train_file_list);

    pred_im_name = sprintf('%s/%s', train_dir, pred);

    subplot(n_files, 1, test_f_i);
    imshow(imread(test_im_name));
    subplot(n_files, 2, test_f_i);
    imshow(imread(pred_im_name)))
end

saveas(f, 'texture_predictions');
