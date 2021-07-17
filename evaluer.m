function [FitVal] = evaluer(pop,features)
global funchoix

switch funchoix
    
    case 1
        FitVal = FitFunc(pop,features);
    case 2
        FitVal = FitFunc2(pop,features);
end


end