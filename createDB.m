function [px, py,levels, patches] = createDB( pyr )
% CREATEDB Sample 5 ª 5 patches from levels 1,2,3 of the input pyramid.
% N represents the number of patches that are found in the three images.
% Arguments:
% pyr ? 7 ª 1 cell created using createPyramid
%
% Outputs:
% p x ? N ª 1 vector with the x coordinates of the centers of the patches in the DB
% p y ? N ª 1 vector with the y coordinates of the centers of the patches in the DB
% levels ? N ª 1 vector with the pyramid levels where each patch was sampled
% patches? N ª 5 ª 5 the patches
%
[px1, py1, patches1] = samplePatches(pyr{1},2);
[px2, py2, patches2] = samplePatches(pyr{2},2);
[px3, py3, patches3] = samplePatches(pyr{3},2);

px1 = px1(:);
px2 = px2(:);
px3 = px3(:);

px = [px1; px2; px3];
py = [py1(:); py2(:); py3(:)];
levels = [ones(size(px1,1),1); 2*ones(size(px2,1),1); 3*ones(size(px3,1),1)];


patches1 = reshape(patches1, [], 5, 5);
patches2 = reshape(patches2, [], 5, 5);
patches3 = reshape(patches3, [], 5, 5);

patches = cat(1,patches1, patches2, patches3);