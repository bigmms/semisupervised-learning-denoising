function I_rold=ROLD(I,win)    

% compute the ROLD values for an image I
% input:
% I --- the image, the gray value region is [0,1]
% win --- the window size
% output:
% I_rold --- the ROLD matrix of the image

warning off

Imgsize=size(I);
k=(win-1)/2;
temp1=padarray(I,[k k]);  % pad I with zero
temp2=im2col(temp1,[win win],'sliding');

[m,n]=size(temp2);
med=(m+1)/2;
x=temp2(med,:);
d=zeros(m-1,n);
for i=1:1:med-1
    d(i,:)=1+max(log2(abs(temp2(i,:)-x)),-5)/5;
end
for i=med+1:1:m
    d(i-1,:)=1+max(log2(abs(temp2(i,:)-x)),-5)/5;
end
d=sort(d,1);   % sort the difference values in each window
y=sum(d(1:med-1,:),1);    %add the smallest (med-1) difference values as ROLD value

I_rold=reshape(y,Imgsize(1),Imgsize(2));

warning on