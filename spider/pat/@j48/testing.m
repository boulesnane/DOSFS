function d =  testing(a,d)
  
 Xt=get_x(d); 

 if isempty(d.Y) 
     d.Y= zeros(get_dim(d),1);
 end
 
 dw = wekaCategoricalData(d);
 tmp = a.tree;
 
 if (a.algorithm.use_signed_output),
     %% if categorical output only
    Yest = zeros(size(Xt,1),1);
    for i=1:size(Xt,1),
        Yest(i) = tmp.classifyInstance(dw.instance(i-1))+1;
    end;
     u = sort(unique(Yest));
     if (length(u)>2),
        Yest2 = -ones(size(Xt,1),length(u));
        for i =1:length(u),
            Yest2(Yest==u(i),i) = 1;
        end
     else
        Yest2 = 2*(Yest-1.5);
     end
     Yest = Yest2;
 else
     %% probabilistic output 
     checkQ = tmp.distributionForInstance(dw.instance(0));
     Q = size(checkQ,1);
     Yest = zeros(size(Xt,1),Q);
     for i=1:size(Xt,1),
        Yest(i,:) = tmp.distributionForInstance(dw.instance(i-1))';
     end
     if (Q==2),
        Yest = Yest(:,2); 
     end
 end
 
 
 d=set_x(d,Yest); 
 d=set_name(d,[get_name(d) ' -> ' get_name(a.algorithm)]); 
 
