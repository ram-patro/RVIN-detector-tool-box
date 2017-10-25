function noise=noise_extract(noised)
win=3;
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
        med=median(w(:));
        mn=mean(w(:));
        if((med-mn/2)<w(ceil(win/2),ceil(win/2)) && w(ceil(win/2),ceil(win/2))<(med+(255-mn)/2))
           o(i,i)=0;
        else
           o(i,j)=1;
        end
    end
    h=waitbar(i/row);
end
close(h);
noise=o;