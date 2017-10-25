function noise=noise_extract(noised)
win=5;
b=noised;
[row,col]=size(b);
c11=wextend('2D','sym',b,(win-1)/2);
o=zeros(row,col);
for i=1:row
    for j=1:col
        w=zeros(win);
        for x=1:win
            for y=1:win
                w(x,y)=c11(i+x-1,j+y-1);
            end
        end
       w_3=w(2:4,2:4);
       w_5=w;
       gmax=max(w_3(:));
       gmin=min(w_3(:));
       w_avg=0;
       for d=1:9
           if((w_3(d)/4)==(gmax/4) || (w_3(d)/4)==(gmin/4))
               w_3(d)=0;
           else
               w_avg=w_3(d)+w_avg;
           end
       end
       w_avg=w_avg/(numel(find(w_3~=0)));
       if(numel(find(w_3==0))==9)
            w_avg=0;
            gmax=max(w_5(:));
            gmin=min(w_5(:));
            w_avg=0;
            for d=1:25
                if((w_5(d)/4)==(gmax/4) || (w_5(d)/4)==(gmin/4))
                    w_5(d)=0;
                else
                    w_avg=w_5(d)+w_avg;
                end
            end
            w_avg=w_avg/(numel(find(w_5==0)));
            if(numel(find(w_5==0))==25)
                w_avg=(w(8)+w(12)+w(14)+w(18))/4;
            end
       end
           
       
        if(abs(w_avg-w(13))>30)
           o(i,j)=1;
        else
           o(i,j)=0;
        end
    end
    h=waitbar(i/row);
end
close(h);
noise=o;