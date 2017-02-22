clear all;
close all;

threshold = 0.5;
I = imread('formas.png');
%diffIntensities = zeros([size(I),4]);

% for x= 2:size(I,1)-1
%     for y = 2:size(I,2)-1
%         diffIntensities(x,y,1) = conv

h = conv2([1 0 -1],I);
v = conv2([1 0 -1]',I);
d1 = conv2([0 0 -1;0 0 0;1 0 0],I);
d2 = conv2([1 0 0;0 0 0;0 0 -1],I);

kernel = [1 1 1; 1 0 1;1 1 1];

hh = conv2(kernel,h);
vv = conv2(kernel,v);
dd1 = conv2(kernel,d1);
dd2 = conv2(kernel,d2);

sizes = [size(hh);size(vv);size(dd1);size(dd2)];
maxY = min(sizes(:,2)');
maxX = min(sizes(:,1)');

hh = hh(1:maxX,1:maxY);
vv = vv(1:maxX,1:maxY);
dd1 = dd1(1:maxX,1:maxY);
dd2 = dd2(1:maxX,1:maxY);

diffImages = cat(3,hh,vv,dd1,dd2);
corners = abs(min(diffImages,[],3)); 

figure,imshow(cornerns),title('Min');

cmax = corners/max(max(corners));
figure,imshow(cmax),title('Normalizado');

[indi,indj] = ind2sub(size(cmax),find(cmax > threshold));
figure, imshow(I),hold on, plot(indi,indj,'r*');

