clear
picture = im2double(imread('00106v.jpg'));

[height width] = size(picture);

height = round(height/3);

B = picture((height*0)+1:height, :);
G = picture(height*1:(height*2), :);
R = picture(height*2:(height*3), :);

BW = corner(B, 'Harris', 4);
GW = corner(G, 'Harris', 4);
RW = corner(R, 'Harris', 4);

GX = [BW(1,1), BW(2,1), BW(3,1), BW(4,1)];
GY = [BW(1,2), BW(2,2), BW(3,2), BW(4,2)];

HX = [GW(1,1), GW(2,1), GW(3,1), GW(4,1)];
HY = [GW(1,2), GW(2,2), GW(3,2), GW(4,2)];

GC = [GX; GY; 1 1 1 1;]';
HC = [HX; HY; 1 1 1 1;]';

Transform = mldivide(HC, C);
Transform(1,3) = 0;
Transform(2,3) = 0;
Transform(3,3) = 1;
C = affine2d(Transform);
Rcb = imref2d(size(G))

transFormedImage = imwarp(G, C, 'OutputView', Rcb);

imshowpair(G, transFormedImage);

