function [colorImage2] = matching(colorImage)

returnImage = colorImage;

R = colorImage(:,:,1);
G = colorImage(:,:,2);
B = colorImage(:,:,3);

meanR = mean(mean(R));
meanG = mean(mean(G));
meanB = mean(mean(B));

scaleR = meanG/meanR;
scaleB = meanG/meanB;

colorImage2(:,:,1) = returnImage(:,:,1)*scaleR;
colorImage2(:,:,2) = returnImage(:,:,2);
colorImage2(:,:,3) = returnImage(:,:,3)*scaleB;

srgb2lab = makecform('srgb2lab');
lab2srgb = makecform('lab2srgb');


contrast_image = applycform(colorImage2, srgb2lab); % convert to L*a*b*
% the values of luminosity can span a range from 0 to 100; scale them
% to [0 1] range (appropriate for MATLAB(R) intensity images of class double)
% before applying the three contrast enhancement techniques
max_luminosity = 100;
L = contrast_image(:,:,1)/max_luminosity;

% replace the luminosity layer with the processed data and then convert
% the image back to the RGB colorspace

contrast_image(:,:,1) = imadjust(L)*max_luminosity;
colorImage2 = applycform(contrast_image, lab2srgb);

end