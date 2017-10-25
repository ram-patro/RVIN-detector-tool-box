function out=filter_image(noised,noise)
noise_density=(numel(find(noise==1))/numel(noise));
out=noised;
win=1;
new_noise=noise;
[row,col]=size(noised);
count=Inf;
if(noise_density<=0.2)
    w_max=3;
elseif(noise_density<=0.4 && noise_density>0.2)
    w_max=5;
else
    w_max=7;
end
while(count~=0)
    win=win+2;
    xtend_noised=wextend('2D','sym',noised,ceil(win/2)-1);
    xtend_noise=wextend('2D','sym',new_noise,ceil(win/2)-1);
    count=0;
    for i=1:row
        for j=1:col
            if(noise(i,j)==1)
                wk=zeros(win);
                bk=zeros(win);
                for x=1:win
                    for y=1:win
                        wk(x,y)=xtend_noised(i+x-ceil(win/2)+ceil(win/2)-1,j+y-ceil(win/2)+ceil(win/2)-1);
                        bk(x,y)=xtend_noise(i+x-ceil(win/2)+ceil(win/2)-1,j+y-ceil(win/2)+ceil(win/2)-1);
                    end
                end          
                vec=find(bk~=1);
                if((length(vec)>=0.5*win*win)|| (win>w_max && numel(vec)~=0))    
                    out(i,j)=median(wk(vec));
                    noise(i,j)=0;
                else
                    count=count+1;
                end
            end
        end
        h=waitbar(i/row);
    end
    close(h);
   % [count win]
end
out=uint8(out);