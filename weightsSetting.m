function [weights] = weightsSetting( imPatches, Dists, pyr ,dbPatchesStd )
% WEIGHTSSETTING Given 3 nearest neighbors for each patch of the input image
% Find a threshold (maximum distance) for each input patch.
% Next, give a weight for each candidate based on its distance from the input patch.
% denote m,n such that [m,n]=size(pyr{4})
% Arguments:
% imPatches ? (m ? 4) ª (n ? 4) ª 5 ª 5 matrix with the patches that were sampled from the 
% input image (pyr{4})
% Dists ? (m ? 4) ª (n ? 4) ª 3 matrix with the distances returned from findNearestNeighbors.
% pyr ? 7 ª 1 cell created using createPyramid
% dbPatchesStd ? (m ? 4) ª (n ? 4) ª 3 matrix with the STDs of the neighbors patches returned
%from findNearestNeighbors.
%
% Outputs:
% weights ? (m ? 4) ª (n ? 4) ª 3 matrix with the weights for each DB candidates
%
%calculating threshold - 
[transX, transY] = translateImageHalfPixel(pyr{4});
[~,~, sampleX] = samplePatches(transX, 0);
[~, ~, sampleY] = samplePatches(transY, 0);
%calculating norm
sampleX = reshape(sampleX, [], 25);
sampleY = reshape(sampleY, [], 25);
imPatchesReshaped = reshape(imPatches, [], 25);
sampleX = imPatchesReshaped- sampleX;
sampleY = imPatchesReshaped - sampleY;
% sampleX = sampleX.^2;
% sampleY = sampleY.^2;
sampleX = sqrt(sum(sampleX.^2,2));
sampleY = sqrt(sum(sampleY.^2,2));
%calculating threshold
thresh = (sampleX+sampleY)/2;
thresh = reshape(thresh, size(imPatches,1), size(imPatches,2));
% thresh = reshape(thresh, size(

weights = zeros(size(Dists));
chezkot = Dists(:,:,1:2).^2;
weights(:,:,1:2) = exp(-chezkot./dbPatchesStd(:,:,1:2));
%weights(:,:,3) = exp(-(weights.^2)./dbPatchesStd(:,:,3));
% weights(passedThresh, 3) = myExp(passedThresh,3).^(-weights(passedThresh,3)/dbPatchesStd);
weights(:,:,3) = exp(-(weights(:,:,3).^2)./dbPatchesStd(:,:,3));
weights(Dists(:,:,3) > thresh) = 0;