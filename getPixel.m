function [pixel] = getPixel(p, M, N, dist, patch, pk1, pk2, pk3, Idx)

        p = p-1;
        i = floor(p/M)+2 ;
        j = mod(p,N)+2;

        sumdis=0;
        pixel=0;
        cpatch=patch(254*(i-2)+j-1,1:9);

        a=Idx(254*(i-2)+j-1);
        I=find(Idx==a);
        for k=1:length(I)
            dist(k)=discal(cpatch,patch(I(k),1:9));
            sumdis=sumdis+dist(k);
        end
        for k=1:length(I)        
            pixel=pixel+dist(k)/sumdis*patch(I(k),5);
        end
%            pixel=C(a,5);
%         cpatch(5)=[];
        meanv   =mean(cpatch);
        medianv =median(cpatch);
        pixel = uint8(pk1*meanv+pk2*medianv+pk3*pixel);
        
return