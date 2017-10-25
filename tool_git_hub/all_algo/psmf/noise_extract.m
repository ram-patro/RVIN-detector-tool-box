function z = noise_extract(x)
x = double(x);
WF = 3; ND = 3;T = 40;a = 65;b = -50;
M = medfilt2(x,[3 3]);
N = abs(x - M);
N(N>T)=0;
N = N ~= 0;
N = double(N);
R = sum(N(:))/(size(x,1) * size(x,2));
if R <= 0.25
    WD = 3;
else
    WD = 5;
end
TD = a + (b * R);
z = IMPDET(x,ND,WD,TD);
end

function F1 = IMPDET(x,ND,WD,TD)
X = x;
M = medfilt2(X,[WD WD]);
D = abs(X - M);
F = zeros(size(x));
F(D>=TD)=1;
F1 = F;
X(F1==F)=X(F1==F);
X(F1~=F)=M(F1~=F);
for i = 1:ND-1
    M = medfilt2(X,[WD WD]);
    F1(abs(X - M)<TD)=F(abs(X - M)<TD);
    F1((X - M)>=TD)=1;
    X(F1==F)=X(F1==F);
    X(F1~=F)=M(F1~=F);
    F = F1;
    h=waitbar(i/(ND-1));
end
close(h);
end