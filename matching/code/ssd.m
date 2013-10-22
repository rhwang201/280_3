function [cost] = ssd(x,y)

cost = norm(x - y)^2;
