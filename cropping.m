function [croppedImage] = cropping(unCroppedImage)

[height width d] = size(unCroppedImage);

edgeG = edge(rgb2gray(unCroppedImage),'canny', 0.01);

ave_x_G = sum(edgeG,1)/height; 
minX = round(find(ave_x_G(1:end*0.1)>mean(ave_x_G), 1, 'last'));
maxX = round(find(ave_x_G(0.9*end:end)>mean(ave_x_G), 1, 'first')+0.9*width);


ave_x_R = sum(edgeG,2)/width; 
minY = round(find(ave_x_R(1:end*0.1)>mean(ave_x_R)*1.5, 1, 'last'));
maxY = round(find(ave_x_R(0.9*end:end)>mean(ave_x_R), 1, 'first')+0.9*width);


croppedImage = imcrop(unCroppedImage, [minX minY maxX-minX maxY-minY]);

end