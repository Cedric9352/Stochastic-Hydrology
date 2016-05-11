function [phi,sigma_eps] = autoCorrFun(p,tau,rho)
%% seasonal autoregressive model parameter estimation
    % input:
    %	p is the order of SAR model
    %	rho is the autocorrelation coefficient matrix
    %	tau is the id of seasons
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
            A(i,j) = rho(abs(i-j),tau-min([i,j]));
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
