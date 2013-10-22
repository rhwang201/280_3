[train_hists, textons, train_file_list] = compute_textons(25);

test_dir = 'texture_test';

imgs = dir(sprintf('%s/*.tiff', test_dir));
test_file_list = {imgs.name};
[~, n_files] = size(test_file_list);

for test_f_i = 1:n_files
    im_name = test_file_list{test_f_i};
    test_im_name = sprintf('%s/%s', test_dir, im_name);

    fig = classify(test_im_name, train_hists, textons, train_file_list);

    result_name = sprintf('classify_results/%s.jpg', im_name);
    saveas(fig, result_name);
end
