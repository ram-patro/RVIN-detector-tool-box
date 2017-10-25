function [accuracy,DPR,FDDR,FA,MD]=measure_param(M1,M2,S,X)
M_1=M1(:);%vectorising the noise mask 'M1'
M_2=M2(:);%vectorising the noise mask 'M2'
TP=0;FN=0;FP=0;TN=0;Dn=[];%initialization
%finding confusion matrix [TP Tn FP FN] Table(1) 
for i=1:numel(M_1)
    if(M_1(i)==1 && M_2(i)==1)
        TP=TP+1;
    elseif (M_1(i)==1 && M_2(i)==0)%'M3' eq(17)
        FN=FN+1;
        Dn=[Dn (abs(S(i)-X(i)))];%eq(21)
    elseif (M_1(i)==0 && M_2(i)==1)
        FP=FP+1;
    else
        TN=TN+1;
    end
end
FA=FP;%False alarm is False positive
MD=FN;%Miss detection is False negative
N=(TP+TN+FP+FN);
accuracy=(TP+TN)/N;%
Fr=(1-(FN/N));
Mid=mean(Dn);%
Fmidr=(1-(Mid/255));%
if (numel(Dn)==0)
    FDDR=Fr;
else
    FDDR=Fmidr*Fr;%
end
DPR=1-(FP/N);%
