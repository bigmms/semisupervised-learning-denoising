function [ dist ] = discal( patch,patch1 )

dist=0;
dist=0;
 for i=1:9
     dist=dist+(patch(i)-patch1(i))^2;
 end
    dist=dist^(1/9);
end

