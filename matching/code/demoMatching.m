%% Make sure you are in the matching/code directory
I = imread('../data/teddy/left.png');
dt = load('../data/teddy/gt.mat');
vis(I, dt.gt);