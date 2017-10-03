function [image] = getImage(assignmentPositionsX,assignmentPositionsY,samplingPositionsX, ...
    samplingPositionsY,weights,emptyHighResImage,renderedPyramid)
% GETIMAGE given an image of the rendered pyrmamid, sampling indices from the rendered pyrmamid, and
% assignment indices in the highres image return a high resolution image
% Arguments:
% assignmentPositionsX ? (m ? 4) ª (n ? 4) ª 3 ª 5 ª 5 x assignment coordinates in the high resolution image (
% getSamplingInformation output)
% assignmentPositionsY ? (m ? 4) ª (n ? 4) ª 3 ª 5 ª 5 y assignment coordinates in the high resolution image (
% getSamplingInformation output)
% samplingPositionsX ? (m ? 4) ª (n ? 4) ª 3 ª 5 ª 5 x sampling coordinates in the rendered pyramid image (
% getSamplingInformation output)
% samplingPositionsY ? (m ? 4) ª (n ? 4) ª 3 ª 5 ª 5 y sampling coordinates in the rendered pyramid image (
% getSamplingInformation output)
% weights ? (m ? 4) ª (n ? 4) ª 3 matrix with the weights for each DB candidate
% emptyHighResImage ? M ª N zeros image, where M and N are the dimensions of a level in the pyramid that should
% be reconstructed in this function
% renderedPyramid ? a single image containing all levels of the pyramid
%
% Outputs:
% image ? M ª N high resolution image
num = zeros(size(emptyHighResImage));
den = zeros(size(emptyHighResImage));
im = zeros(size(emptyHighResImage));
repWeights = repmat(weights,[1,1,1,5,5]);
%[n,m] = size(assignmentPositionsX);
for i = 1:3
    for j = 1:5
        for k = 1:5
            %sampling positions
            curSamplePosX = arrangeData(samplingPositionsX, j, k, i);
            curSamplePosY = arrangeData(samplingPositionsY, j, k, i);
            %assignment positions
            curAssignmentPosX = arrangeData(assignmentPositionsX,j,k,i);
            curAssignmentPosY = arrangeData(assignmentPositionsY,j,k,i);   
            curWeights = arrangeData(repWeights,j,k,i);
            %interpolating
            interpData = interp2(renderedPyramid, curSamplePosX, curSamplePosY,'cubic');
            im(sub2ind(size(im),curAssignmentPosY(:), curAssignmentPosX(:))) = interpData;
            myWeights = zeros(size(im));
            myWeights(sub2ind(size(myWeights),curAssignmentPosY(:), curAssignmentPosX(:))) = curWeights;
            num(isnan(num)) = 0;
            den(isnan(den)) = 0;
            myWeights(isnan(myWeights)) = 0;
            num = num + (im.*myWeights);
            den = den + myWeights;
        end
    end    
end
num(isnan(num)) = 0;
%den(isnan(den)) = 0.000001;
image = num./den;
image(isnan(image)) = 0;
end

function samples = arrangeData(mat, j, k, i)
    samples = mat(j:5:end,k:5:end,i,:,:);
    samples = reshape(samples, [size(samples,1), size(samples,2), 5,5]);
    samples = permute(samples, [3,1,4,2]);
    samples = reshape(samples, size(samples,2)*5,[]);
end

