function noise=noise_extract(noised,th)
th=1.3;
win=9;
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
        w_h=w(4:6,:);
        w_v=w(:,4:6);
        sd_h=std(w_h(:));
        mn_h=mean(w_h(:));
        sd_v=std(w_v(:));
        mn_v=mean(w_v(:));  
        HD=abs(w(ceil(win/2),ceil(win/2))-mn_h)/(sd_h+1);%horizontal deviation
        VD=abs(w(ceil(win/2),ceil(win/2))-mn_v)/(sd_v+1);%vertical deviation
        ND=min(HD,VD);%normalised deviation
        if(ND>th)
           o(i,j)=1;
        else
           o(i,j)=0;
        end
    end
    h=waitbar(i/row);
end
close(h);
noise=o;