function Cs_phi = calCs(p,tau,omega,rho,phi,Csx)
%% SAR normal distribution sequence simulation
    % input:
    %   p is the order of SAR model
    %   tau is the id of seasons
    %   Csx is the deviation coefficient of sequence
    %   phi is the autoregressive coefficient of sequence
    % output:
    %   Cs_phi is the p-order P-III deviation coefficient
    %---------------------------------
    % author: Yujia Cheng @ Ocean University of China, Master of OE
    % complete: May 17th, 2016  

%% initial value
phi = [1;-phi];
Cs = zeros(1,p+1);
Cs(1) = Csx(tau);
for i = 1:p
    if i < tau
        Cs(i+1) = Csx(tau-i);
    else
        Cs(i+1) = Csx(tau-i+omega);
    end
end

%% calculation
Cs_phi = Cs*(phi.^3)/([1,rho(1:p,tau)']*phi)^(3/2);

