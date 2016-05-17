function [phi,sigma_eps] = autoCorrFun(p,tau,rho,omega)
%% Seasonal autoregressive model parameter estimation
    % input:
    %	p is the order of SAR model
    %	rho is the autocorrelation coefficient matrix
    %	tau is the id of seasons
    %   omega is the total season count
    % output:
    %   phi is the autoregressive coeffieient matrix
    %   sigma_eps is the variance of stochastics
    %---------------------------------
    % author: Yujia Cheng @ Ocean University of China, Master of OE
    % complete: May 10th, 2016
 
%% calculation of autoregressive coefficient
B = rho(1:p,tau);
A = zeros(p,p);
for i = 1:p
    for j = 1:p
        if abs(i-j) ~= 0
            if tau <= min([i,j])
                A(i,j) = rho(abs(i-j),tau-min([i,j])+omega);
            else
                A(i,j) = rho(abs(i-j),tau-min([i,j]));
            end
        else
            A(i,j) = 1;
        end
    end
end
phi = A\B;

%% variance of stochastics
sigma_eps = 1;
for i = 1:p
    sigma_eps = sigma_eps - rho(i,tau)*phi(i);
end
