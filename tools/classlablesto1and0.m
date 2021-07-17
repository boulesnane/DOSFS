for i=1:size(leukemia_std,1)
if(leukemia_std(i,size(leukemia_std,2))==1)
leukemia_std(i,size(leukemia_std,2))=1;
elseif(leukemia_std(i,size(leukemia_std,2))==-1)
leukemia_std(i,size(leukemia_std,2))=0;
end
end