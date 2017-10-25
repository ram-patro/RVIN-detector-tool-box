function [N2,N,nh,nhd,b1,b2]=noise_hist_process(X,N)
X_pixel_intensity=X(find(N==1));
nh=imhist(X_pixel_intensity);
nhd=[0 nh(3:end)'-nh(1:end-2)'];
[~,low]=min(nhd(1:127));
[~,high]=max(nhd(end:-1:128));
b1=max([low(1) high(1)]);
b2=255-b1;
N1=N;
N=zeros(size(X));
N(union(find((X<=b1)),find((X>=b2))))=1;
N2=N;
N=zeros(size(X));
N_loc=intersect((find(N1==1)),(find(N2==1)));
N(N_loc)=1;
end