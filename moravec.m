clear all;
close all;

threshold = 0.5;
I = imread('formas.png');

h = conv2([1 -1],I);
v = conv2([1 -1]',I);
d1 = conv2([0 0 -1;0 0 0;1 0 0],I);
d2 = conv2([1 0 0;0 0 0;0 0 -1],I);

for i=2:size(h,1)-1
    for j=2:size(h,2)-1
        hh(i,j) =sum(sum(abs(h(i-1:i+1,j-1:j+1))));
    end
end


for i=2:size(v,1)-1
    for j=2:size(v,2)-1
        vv(i,j) =sum(sum(abs(v(i-1:i+1,j-1:j+1))));
    end
end


for i=2:size(d1,1)-1
    for j=2:size(d1,2)-1
        dd1(i,j) =sum(sum(abs(d1(i-1:i+1,j-1:j+1))));
    end
end


for i=2:size(d2,1)-1
    for j=2:size(d2,2)-1
        dd2(i,j) =sum(sum(abs(d2(i-1:i+1,j-1:j+1))));
    end
end

sizes = [size(hh);size(vv);size(dd1);size(dd2)];
maxY = min(sizes(:,2)');
maxX = min(sizes(:,1)');

hh = hh(1:maxX,1:maxY);
vv = vv(1:maxX,1:maxY);
dd1 = dd1(1:maxX,1:maxY);
dd2 = dd2(1:maxX,1:maxY);

diffImages = cat(3,hh,vv,dd1,dd2);
corners = min(diffImages,[],3); 

figure,imshow(corners),title('Min');

cmax = corners/max(corners(:));
figure,imshow(cmax),title('Normalizado');

ct = cmax;

for i = 1:size(ct,1)*size(ct,2)
    if(ct(i) < threshold)
        ct(i) = 0;
    end
end
figure,imshow(ct),title('Threshold');

cn = ct;

for i = 2:size(cn,1)-1
    for j = 2:size(cn,2)-1
        if(cn(i,j) == max(reshape(cn(i-1:i+1,j-1:j+1),1,[])))
            cn(i) = 1;
        else
            cn(i) = 0;
        end
    end
end
figure,imshow(cn),title('Final Corners');

% [indi,indj] = ind2sub(size(cn),find(cn > 0));
% indi = indi+1;
% indj = indj+1;
% figure,imshow(I),hold on,plot(indi,indj,'r*');
