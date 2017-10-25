function [noise]=noise_extract(noised)
win=21;
b=double(noised);
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
        a=unique(w(:))';
        aa=abs(a(1:end-1)-a(2:end));
        [aaa,loc]=sort(aa);
        for h=1:numel(aa)
            if(aa(h)>1)
                a1=a(h);
                break;
            end
        end
        for h=numel(aa):-1:1
            if(aa(h)>1)
                a2=a(h);
                break;
            end
        end
        if(w(ceil(win/2),ceil(win/2))>=a2 || w(ceil(win/2),ceil(win/2))<=a1)
           o(i,j)=1;
        else
           o(i,j)=0;
        end
    end
    h=waitbar(i/row);
end
close(h);
noise=o;