images = {'butterfly.png', 'audi.jpg', 'cemetary.jpg'};
for i = 1:size(images,2)
    yiqIm = im2double(imread(images{1,i}));
    figure('name', 'original image'), imshow(yiqIm);
    resized = imresize(yiqIm, 2);
    [m,n,~] = size(yiqIm);
    yiqIm = rgb2ntsc(yiqIm);
    y = superResolution(yiqIm(:,:,1));
    res = zeros(m*2,n*2,3);
    res(:,:,1) = y;
    res(:,:,2) = imresize(yiqIm(:,:,2), 2,'cubic');
    res(:,:,3) = imresize(yiqIm(:,:,3), 2,'cubic');
    figure('name', 'super resolution'), imshow(ntsc2rgb(res));
    figure('name', 'resized by matlab'),imshow(resized);
end