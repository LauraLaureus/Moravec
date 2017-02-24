%% ejercicio 1

I1 = imread('disney_r1.png');
I2 = imread('disney_r2.png');
I3 = imread('disney_r3.png');
I4 = imread('disney_r4.png');
I5 = imread('disney_r5.png');

gs = fspecial('gaussian'); %tamaño predefinido kernel de 3x3 y std 0.5

figure
subplot(1,3,1), imshow(I1), subplot(1,3,2), imshow(imfilter(I1,gs)), subplot(1,3,3), imshow(medfilt2(I1));

figure
subplot(1,3,1), imshow(I2), subplot(1,3,2), imshow(imfilter(I2,gs)), subplot(1,3,3), imshow(medfilt2(I2));

figure
subplot(1,3,1), imshow(I3), subplot(1,3,2), imshow(imfilter(I3,gs)), subplot(1,3,3), imshow(medfilt2(I3));

figure
subplot(1,3,1), imshow(I4), subplot(1,3,2), imshow(imfilter(I4,gs)), subplot(1,3,3), imshow(medfilt2(I4));

figure
subplot(1,3,1), imshow(I5), subplot(1,3,2), imshow(imfilter(I5,gs)), subplot(1,3,3), imshow(medfilt2(I5));

%Para imágenes con ruido el filtro de la mediana consigue recuperar más
%información que el filtro de la gausiana. Si la cantidad de ruido es
%pequeña, como es el caso de la imagen I1, se puede decir que se puede
%recuperar toda la imagen, pero para altas cantidades de ruido como la
%imagen I5, se obtiene una imagen con menor ruido. 

%% ejercicio 2

clear all;
close all;

Id = imread('distorsion2.jpg');
Ir1 = imread('rostro1.png');
Ir2 = imread('rostro2.png');

figure, subplot(1,3,1),imshow(Id),subplot(1,3,2),imshow(Ir1),subplot(1,3,3),imshow(Ir2);
%imagen 1: el primer plano no tiene bordes definidos. -> detección de bordes
%imagen 2: tiene un suavizado que no le define los bordes. -> perfilado
%imagen 3: se le ha añadido ruido.  -> filtro mediana.

Id2 = rgb2gray(Id)+ uint8(edge(rgb2gray(Id),'canny')); % suma los contornos a la imagen. 

us = fspecial('unsharp');
Ir11 = imfilter(Ir1,us); % realiza un perfilado de la imagen.

Ir22 = medfilt2(Ir2,[5 5]); %aplica el filtro mediana
figure, subplot(1,3,1),imshow(Id2),subplot(1,3,2),imshow(Ir11),subplot(1,3,3),imshow(Ir22);

%% ejercicio 3
clear all;
close all;

%creación de los dos filtros especificados. 
gs = fspecial('gaussian');
mt = fspecial('motion');

I = imread('distorsion1.jpg'),
figure,imshow(I);

Ig = imfilter(I,gs);
Im = imfilter(I,mt);

%mi propuesta de solución es aplicar un filtro media en cada capa de la
%imagen convertida en el espacio de color HSV. 
hsvI = rgb2hsv(I);
Imd = hsv2rgb(cat(3,medfilt2(hsvI(:,:,1),[7 7]),medfilt2(hsvI(:,:,2),[7 7]),medfilt2(hsvI(:,:,3),[7 7])));

figure, imshow(Ig),title('Filtro gaussiano'),
figure, imshow(Im),title('Filtro movimiento'),
figure, imshow(Imd),title('Filtro mediana'),

%% ejercicio 4
clear all;
close all;


I = imread('formas.png');
%creación de los elementos estructurales
e = strel(imread('estrella.png'));
o = strel(imread('ovalo.png'));
c = strel(imread('cuadrado.png'));
c2 = strel(imread('cuadrado2.png'));
c3 = strel(imread('cuadrado3.png'));

imshow(imopen(I,e)); %solo se detecta una estrella por su tamaño, hay que reducir su dimensión. 
close all;
%creación de los elementos estructurales con una nueva dimensión
e = strel('arbitrary',im2bw(imresize(imread('estrella.png'),0.9)));
o = strel('arbitrary',im2bw(imresize(imread('ovalo.png'),0.9)));
c = strel('arbitrary',im2bw(imresize(imread('cuadrado.png'),0.9)));
c2 = strel('arbitrary',im2bw(imresize(imread('cuadrado2.png'),0.9)));
c3 = strel('arbitrary',im2bw(imresize(imread('cuadrado3.png'),0.9)));

%visualización
imshow(imopen(I,e));
figure,imshow(imopen(I,o));
figure,imshow(imopen(I,e));
figure,imshow(imopen(I,c));
figure,imshow(imopen(I,c2));
figure,imshow(imopen(I,c3));

%subconjunto de imágenes de texto
clear all;
close all;

%obtención de la imagen inversa de la leída para mejorar la detección
I = ~im2bw(imread('texto.png'));
imshow(I);
%creación de los elementos estructurales a partir de la imagen inversa de
%la leída. 
i = strel('arbitrary',~im2bw(imread('letra_i.png')));
k = strel('arbitrary',~im2bw(imread('letra_k.png')));
m = strel('arbitrary',~im2bw(imread('letra_m.png')));
o = strel('arbitrary',~im2bw(imread('letra_o.png')));
p = strel('arbitrary',~im2bw(imread('letra_p.png')));

figure,imshow(imopen(I,i));
figure,imshow(imopen(I,k));
figure,imshow(imopen(I,m));
figure,imshow(imopen(I,o));
figure,imshow(imopen(I,p));

%% ejercicio 5 - Moravec
clear all;
close all;

threshold = 0.5;
I = imread('formas.png');

%calculo de las distancias.
h = conv2([1 -1],I);
v = conv2([1 -1]',I);
d1 = conv2([0 0 -1;0 0 0;1 0 0],I);
d2 = conv2([1 0 0;0 0 0;0 0 -1],I);

%calculo de las distancias vecinales.
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

% [indi,indj] = ind2sub(size(cn),find(cn > 0)); No se visualiza bien. 
% indi = indi+1;
% indj = indj+1;
% figure,imshow(I),hold on,plot(indi,indj,'r*');
