function [imagn1] = multi_idwfiltering_3item(img,noise_type,pk1,pk2,pk3 )

img=double(img);
[m,n]=size(img);

imagn1=zeros(m,n);

if (noise_type == 0)
    idx = find(img == 255);
    img(idx) = 0;
    imagn1 = img;
end

if (noise_type == 1)
    binmatrix=ROLD(img,5);
    for i=1:m
     for j=1:n
         if(binmatrix(i,j)<19.5&&binmatrix(i,j)>13.5)
             imagn1(i,j)=img(i,j);
         end
             
     end
     end
end

imagn1=double(imagn1);
 
[A,B,V]=find(imagn1);
C=[A,B];
[A1,B1,V1]=find(imagn1==0);
C1=[A1,B1];

y=idw_mm(C,V,C1,4);

for i=1:length(y)
    imagn1(C1(i,1),C1(i,2))=uint8(y(i));
end


patch=zeros((m-2)*(n-2),9);
for i=2:m-1
    for j=2:n-1
    cpatch=double(imagn1(i-1:i+1,j-1:j+1));
    cpatch=cpatch(:);
    patch(254*(i-2)+j-1,1:9)=cpatch;
    end
end
[Idx, ~]=kmeans(patch,200);
dist=zeros(1000000,1);

M = m-2;
N = n-2;
img = zeros(M*N, 1); 

parfor p = 1:M*N
    img(p+1) = getPixel(p, M, N, dist, patch, pk1, pk2, pk3, Idx);
end

for p = 1:M*N
    i = floor(p/M)+2 ;
    j = mod(p,N)+2;
    imagn1(i,j) = img(p);
end

end

