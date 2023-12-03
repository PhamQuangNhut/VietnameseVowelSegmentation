function [startStable,endStable] = findStableRegion(startFrame,endFrame)
startStable = floor(startFrame + (endFrame - startFrame)/3);
endStable = floor(startFrame + 2*(endFrame - startFrame)/3);
end