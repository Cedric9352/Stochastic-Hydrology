function rho = paraEst(X)
%% SAR parameter estimation
    % input:
    %	X is the original sequence matrix
    % output:
    %   rho is the autocorrelation coefficient matrix 
    %---------------------------------
    % author: Yujia Cheng @ Ocean University of China, Master of OE
    % complete: May 9th, 2016

%% calculation of autocorrelation coefficient
[row_X,col_X] = size(X);
rho = zeros(col_X,col_X);
for i = 1:col_X
    for j = 1:col_X
        if i < j
            x_r = mean(X(:,j));
            x_rk = mean(X(:,j-i));
            s_r = sqrt(var(X(:,j)));
            s_rk = sqrt(var(X(:,j-i)));
            sum = 0;
            for k = 1:row_X
                sum = sum + (X(k,j)-x_r)*(X(k,j-i)-x_rk);
            end
            rho(i,j) = sum/((row_X-1)*s_r*s_rk);
        else
            x_r = mean(X(:,j));
            x_rk = mean(X(:,j-i+col_X));
            s_r = sqrt(var(X(:,j)));
            s_rk = sqrt(var(X(:,j-i+col_X)));
            sum = 0;
            for k = 2:row_X
                sum = sum + (X(k,j)-x_r)*(X(k-1,j-i+col_X)-x_rk);
            end
            rho(i,j) = sum/((row_X-2)*s_r*s_rk);
        end
    end
end
