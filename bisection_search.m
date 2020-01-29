function mid = bisection_search(fun, Consts, val, SearchRange, epsilon, NegSlope, PosConstraint)
%BISECTION Summary of this function goes here
%   Detailed explanation goes here
    low = SearchRange(1);
    high = SearchRange(2);
    mid = (low + high)/2.0;
    while abs(fun(mid, Consts) - val) > epsilon
%         [[low mid high], [fun(low, Consts) fun(mid, Consts) fun(high, Consts) val]]
        if fun(mid, Consts) > val
            if NegSlope
                low = mid;
            else
                high = mid;
            end
        else
            if NegSlope
                high = mid;
            else
                low = mid;
            end
        end
        mid = (low + high)/2.0;
    end
    if PosConstraint
        if (fun(mid, Consts) - val) < 0
            if NegSlope
                alpha = 0.99;
                while fun(low + alpha*(mid - low), Consts) - val < 0
                    alpha = alpha^2;
                end
                mid = low + alpha*(mid - low);
            else
                alpha = 0.99;
                while fun(high - alpha*(high - mid), Consts) - val < 0
                    alpha = alpha^2;
                end
                mid = high - alpha*(high - mid);
            end
        end
    end
end

