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