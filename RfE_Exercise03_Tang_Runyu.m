cd 'D:\Runyu\RfE\TCGA-G3-AAV6\20060302\4-Body_5.0_CE';
img(:,:) = dicomread('000030.dcm');
figure(1)
imshow(img,[]); % original image in greyscale
colorbar
title('Original Image')

H = fft2(img); % Fourier transform of original image

%%%%%%%%% Filter design %%%%%%%%%%
% in Matlab, the center of the fft is shifted to four coners, a filter should be designed inversely
%%%%%%%%%% Filter 1: Ramp %%%%%%%%%%
F1 = zeros(length(img)/2,length(img)/2); % right lower submatrix of the filter
x = [1,length(img)/2]; 
y = [1,sqrt(2)/2]; % when fy=0, the amplitude along fx starts with 0 and ends with sqrt(2)/2
F1(:,1) = interp1(x,y,1:length(img)/2); % linearly increase both along fx and fy
F1(1,:) = F1(:,1); % symmetric matrix
y = [sqrt(2)/2,0]; % when fx and fy reach max, the nomalized amplitude is 1
F1(length(img)/2,:) = interp1(x,y,1:length(img)/2); % when fx reach max, the amplitude along fy linearly increases

for i = 2:length(img)/2
    x = [1,length(img)/2]; 
    y = [F1(1,i),F1(length(img)/2,i)]; % for each fy, the starting and ending values of amplitude were calculated previously
    F1(2:length(img)/2,i) = interp1(x,y,2:length(img)/2); % for each fy, the amplitude linearly increases along fx
end

F2 = fliplr(F1); % left lower submatrix
F3 = flipud(F1); % right upper submatrix
F4 = flipud(F2); % left upper submatrix
Filter = [F4,F3;F2,F1]; % 2D filter is a symmetric matrix
figure(2)
imshow(fftshift(Filter))
title('Ramp Filter')
colorbar

%%%%%%%%%% Filter 2: Sharpening low pass %%%%%%%%%%
F12 = zeros(length(img)/2,length(img)/2)
F12(220:256,220:256) = 1; % in Matlab, the center of the fft is shifted to four coners, a low-pass filter should be designed inversely
% when fx and fy both below 250, the amplitude equals 1

F22 = fliplr(F12);
F32 = flipud(F12);
F42 = flipud(F22);
Filter2 = [F42,F32;F22,F12];
figure(3)
imshow(fftshift(Filter2))
title('Low Pass Filter')
colorbar
%%%%%%%%%%%%%%%%%%%%%%%%%%%

F = H.*Filter; % multiplication of image and filter in Fourier domain
filtered_img = ifft2(F); % inverse Fourier transform of filtered image 
figure(4)
imshow(filtered_img,[]); % filtered image in greyscale
colorbar
title('Ramp Filtered Image')

F2 = H.*Filter2; 
filtered_img2 = ifft2(F2); 
figure(5)
imshow(filtered_img2,[]);
colorbar
title('Low Pass Filtered Image')