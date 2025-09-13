function avg = AvgF(x,init)
persistent prevAvg k

if(init == 0)
    k = 1;
    prevAvg  = 0;
end

alpha = (k - 1) / k;
avg = alpha*prevAvg + (1- alpha)*x;

prevAvg = avg;
k       = k + 1;
end