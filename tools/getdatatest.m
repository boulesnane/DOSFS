function [Xtrain,Xtest]=getdatatest(inputfile,start1,end1,start2,end2,train,test)
% create by Noro
Xtrain=[];
Xtest=[];
fid = fopen(inputfile);
tline = fgets(fid);
j=1;

while ischar(tline)
j
   % C = strsplit(tline,',');
   %tline = strrep(tline, ' ', ',');
  if( start1<=j && end1>=j && train==true)
tline
str2num(tline)
     Xtrain((size(Xtrain,1)+1),:)=str2num(tline); 
     
  elseif( start2<=j && end2>=j  && test==true)
    
       Xtest((size(Xtest,1)+1),:)=str2num(tline); 
       
  end
    

    tline = fgets(fid);
        j=j+1;
end

fclose(fid);



end