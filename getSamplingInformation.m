
function [assignmentPositionsX,assignmentPositionsY,samplingPositionsX,samplingPositionsY] = ...
    getSamplingInformation(sampleCentersX,sampleCentersY,pyr,inputPatchesCentersX,inputPatchesCentersY,levelsUp)
% GETSAMPLINGINFORMATION
% Get the information for sampling a high resolution image. Pairs of: assignment positions in the high resolution image,
% and sampling positions from the rendered pyramid image
% Arguments:
% sampleCentersX ? (m ? 4) ª (n ? 4) ª 3 matrix with the x coordinates of the center of the high resolution patches in
% the rendered image. This variable should be returned from getSamplingCenters function. (green x locations)
% sampleCentersY ? (m ? 4) ª (n ? 4) ª 3 matrix with the y coordinates of the center of the high resolution patches in
% the rendered image. This variable should be returned from getSamplingCenters function. (green y locations).
% pyr ? 7 ª 1 cell created using createPyramid
% inputPatchesCentersX ? (m ? 4) ª (n ? 4) input patches center x coordinates
% inputPatchesCentersY ? (m ? 4) ª (n ? 4) input patches center y coordinates
% levelsUp ? integer which tells how much levels up we need to sample the window, from the found patch. In the figure
% the case is levelsUp=1
%
% Outputs:
% assignmentPositionsX ? (m ? 4) ª (n ? 4) ª 3 ª 5 ª 5 x assignment coordinates in the high resolution image (see figure)
% assignmentPositionsY ? (m ? 4) ª (n ? 4) ª 3 ª 5 ª 5 y assignment coordinates in the high resolution image (see figure)
% samplingPositionsX ? (m ? 4) ª (n ? 4) ª 3 ª 5 ª 5 x sampling coordinates in the rendered pyramid image (see figure)
% samplingPositionsY ? (m ? 4) ª (n ? 4) ª 3 ª 5 ª 5 y sampling coordinates in the rendered pyramid image (see figure)
%
[upPixelX,upPixelY,~] = transformPointsLevelsUp ...
    (inputPatchesCentersX,inputPatchesCentersY,ones(size(inputPatchesCentersX)),pyr,levelsUp);
roundedX = upPixelX;
roundedY = upPixelY;
assignmentPositionsX = repmat(roundedX, [1,1,5,5]);
assignmentPositionsY = repmat(roundedY, [1,1,5,5]);
[meshMatX,meshMatY] = meshgrid(-2:2);
meshMatX = permute(meshMatX, [3,4,1,2]);
meshMatX = repmat(meshMatX, size(inputPatchesCentersX));
meshMatY = permute(meshMatY, [3,4,1,2]);
meshMatY = repmat(meshMatY, size(inputPatchesCentersX));
assignmentPositionsX = round(assignmentPositionsX + meshMatX);
assignmentPositionsX = repmat(assignmentPositionsX, [1,1,1,1,3]);
assignmentPositionsX = permute(assignmentPositionsX,  [1,2,5,3,4]);
assignmentPositionsY = round(assignmentPositionsY + meshMatY);
assignmentPositionsY = repmat(assignmentPositionsY, [1,1,1,1,3]);
assignmentPositionsY = permute(assignmentPositionsY, [1,2,5,3,4]);
tempX = assignmentPositionsX - repmat(upPixelX, [1,1,3,5,5]);
tempY = assignmentPositionsY - repmat(upPixelY, [1,1,3,5,5]);
samplingPositionsX = repmat(sampleCentersX, [1,1,1,5,5]) + tempX;
samplingPositionsY = repmat(sampleCentersY, [1,1,1,5,5]) + tempY;
