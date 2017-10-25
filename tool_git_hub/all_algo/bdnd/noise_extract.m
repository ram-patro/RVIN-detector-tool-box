function noise=noise_extract(noised)
b=double(noised);
[row,col]=size(b);
win=21;
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
        [a,b]=find_ab(w);
        if((a<w(11,11))&&(w(11,11)<b))
            o(i,j)=0;
        else
            w_new=w(10:12,10:12);
            [a1,b1]=find_ab(w_new);
            if((a1<w_new(2,2))&&(w_new(2,2)<b1))
                o(i,j)=0;
            else
                o(i,j)=1;
            end
        end
    end
    h=waitbar(i/row);
end
close(h);
noise=o;

function [a,b]=find_ab(w)
data_vec=w(:)';
v0=sort(data_vec);
med=median(v0);
vd=[abs(v0(2:end)-v0(1:end-1))];
aa=max(vd(find(v0<med)));
if(numel(aa)==0)
    a=v0(1);
    b=v0(end);
else
    a=find(vd==aa);
    a=v0(a(1)+1);
    locs=find(v0>=med);
    bb=max(vd(locs(1:end-1)));
    if(numel(bb)~=0)
        b=find(vd==bb);
        b=v0(b(1));
    end
end
