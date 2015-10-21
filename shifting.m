%Carl Englund
%caren083 MT3A
%caren083@student.liu.se

%Performed the Sum of Squared Differences method on the images. Try to find
%the best fitting shift by doing it several times and comparing the results
%against each other.
function [displacement] = shifting(imageToBeMapped, mappingImage)
    SSDtracker = inf;

    for i = -20 : 20
        for j = -20 : 20
            shiftedImage = circshift(imageToBeMapped, [i j]);
            SSD = sum((mappingImage(:) - shiftedImage(:)).^2);
            if SSD < SSDtracker
                SSDtracker = SSD;
                displacement = [i j];
            end
        end
    end
end