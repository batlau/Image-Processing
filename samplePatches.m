function [px, py, patches] = samplePatches( im , border )
% SAMPLEPATCHES Sample 5 ª 5 patches from the input image. You are allowed to use 2D loops here.
% Arguments:
% im ? a grayscale image of size m ª n
% border ? An integer that determines how much border we want to leave in the image. For example: if border=0 the
%center of the first patch will be at (3,3), and the last one will be at (end?2,end?2), so the number of patches in this
%case is (m ? 4) ª (n ? 4). But if border=1 the center of the first patch will be at (4,4) and the last one will be at (
%end?3,end?3). So in general, the number of patches is (m ? 2 · (2 + border)) ª (n ? 2 · (2 + border)).
%
% outputs:
% p x ? (m ? 2 · (2 + border)) ª (n ? 2 · (2 + border)) matrix with the x indices of the centers of the patches
% p y ? (m ? 2 · (2 + border)) ª (n ? 2 · (2 + border)) matrix with the y indices of the centers of the patches
% patches? (m ? 2 · (2 + border)) ª (n ? 2 · (2 + border)) ª 5 ª 5 the patches
[m,n] = size(im);
px = zeros((m-2*(2+border)), (n-2*(2+border)));
py = zeros((m-2*(2+border)), (n-2*(2+border)));
patches = zeros((m-2*(2+border)), (n-2*(2+border)), 5, 5);
for i = (3+border):(m-2-border)
    for j = (3+border):(n-2-border)
        px(i-2,j-2) = j;
        py(i-2,j-2) = i;      
        patches(i-2,j-2,:,:) = im((i-2):(i+2),(j-2):(j+2));
    end
end
