function [ PSNR ] = psnr(img, image )

[h w]=size(img);
img=double(img);
image=double(image);

B=8;                
MAX=2^B-1;          
MES=sum(sum((img-image).^2))/(h*w);  
PSNR=20*log10(MAX/sqrt(MES)); 


end

