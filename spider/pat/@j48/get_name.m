function s=get_name(a)
if(~isempty(a.tree))
 s=char(a.tree.toString);
else
    s=get_name(a.algorithm);
end
 eval_name                   %% print values of hyperparameters
