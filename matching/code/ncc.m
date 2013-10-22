function [cost] = ncc(x,y)

cost = -x.y / (norm(x) * norm(y));
