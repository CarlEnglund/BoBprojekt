function [croppedImage] = cropping(unCroppedImage)

[height width] = size(unCroppedImage);
width = width/3
edgeG = edge(rgb2gray(unCroppedImage),'canny', 0.01);
ave_x_G = sum(edgeG,1)/height; 

min = find(ave_x_G(1:width/10)>mean(ave_x_G)*1.5, 1, 'last')
max = find(ave_x_G((width*0.8):width)>mean(ave_x_G)*1.5, 1, 'first')
max = max+width*0.8;

croppedImage  = imcrop(unCroppedImage, [min min max-min max-min]);

end