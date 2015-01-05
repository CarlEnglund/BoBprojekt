function [colorImage2] = matching(colorImage)

imshow(colorImage);
[posX posY] = ginput(1);
posX = round(posX);
posY = round(posY);
R_intensity = colorImage(posX,posY,1);
G_intensity = colorImage(posX,posY,2);
B_intensity = colorImage(posX,posY,3);

minVal = R_intensity;

if G_intensity < minVal
    minVal = G_intensity;
end

if B_intensity < minVal
    minVal = B_intensity;
end

R_intensity = R_intensity / minVal;
G_intensity = G_intensity / minVal;
B_intensity = B_intensity / minVal;

colorImage2(:,:,1) = colorImage(:,:,1)*R_intensity;
colorImage2(:,:,2) = colorImage(:,:,2)*G_intensity;
colorImage2(:,:,3) = colorImage(:,:,3)*B_intensity;

end