%Carl Englund
%caren083 MT3A
%caren083@student.liu.se

function [colorImage2] = matching(colorImage, contrast)

returnImage = colorImage;

%Weight color channels with theory from https://courses.cs.washington.edu/courses/cse467/08au/labs/l5/whiteBalance.pdf
%Gray World Assumption
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

%Improve contrast, method from http://se.mathworks.com/help/images/examples/contrast-enhancement-techniques.html
srgb2lab = makecform('srgb2lab');
lab2srgb = makecform('lab2srgb');

if nargin > 1
    disp('lol');
    contrast_image = applycform(colorImage2, srgb2lab); 
    max_luminosity = 100;
    L = contrast_image(:,:,1)/max_luminosity;

    contrast_image(:,:,1) = imadjust(L)*max_luminosity;
    colorImage2 = applycform(contrast_image, lab2srgb);
end

end