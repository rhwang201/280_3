k = 25;
patch_size = 5;

[train_hists, textons, file_list] = compute_textons(k);

fig = figure;
title(sprintf('Visualization of %d Textons', k));

for i = 1:k
    t_vect = textons(i, :)';
    texton = vec2mat(t_vect, patch_size)';

    subplot(5,5,i);
    imagesc(texton);
    colormap(jet);
    axis off;

end

saveas(fig, 'textons.jpg');
