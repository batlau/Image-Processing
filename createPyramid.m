function pyr = createPyramid( im )
% CREATEPYRAMID Create a pyramid from the input image, where pyr{1} is the smallest level,
% pyr{4} is the input image, and pyr{5},pyr{6},pyr{7} are zeros.
% The ratio between two adjacent levels in the pyramid is 2(1/3)
% Arguments:
% im ? a grayscale image
%
% outputs:
% pyr ? A 7 ª 1 cell of matrices.
pyr = cell(7,1);
pyr{5} = imresize(zeros(size(im)), round(size(im)*2.^(1/3)), 'cubic');
pyr{6} = imresize(pyr{5}, round(size(pyr{5})*2.^(1/3)),'cubic');
pyr{7} = imresize(pyr{6}, round(size(im)*2),'cubic');
pyr{4} = im;
pyr{3} = imresize(im, round(size(im)/(2^(1/3))),'cubic');
pyr{2} = imresize(pyr{3}, round(size(pyr{3})/2^(1/3)),'cubic');
pyr{1} = imresize(pyr{2}, round(size(pyr{2})/2^(1/3)),'cubic');