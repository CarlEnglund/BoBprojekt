function [displacement] = shifting(imageToBeMapped, mappingImage, threshold)
    SSDtracker = inf;

    for i = -threshold : threshold
        for j = -threshold : threshold
            shiftedImage = circshift(imageToBeMapped, [i j]);
            SSD = sum((mappingImage(:) - shiftedImage(:)).^2);
            if SSD < SSDtracker
                SSDtracker = SSD;
                displacement = [i j];
            end
        end
    end
end