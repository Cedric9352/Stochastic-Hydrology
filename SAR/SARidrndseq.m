function [SAR_seq,ogaSAR] = SARidrndseq(p,X,year,omega)
%% SAR normal distribution sequence simulation
    % input:
    %   p is the order of SAR model
    %   X is the original independent skewness distribution sequence
    %   omega is the total season count
    %   year is the required sequence length
    % output:
    %   SAR_seq is the simulated sequence
    %---------------------------------
    % author: Yujia Cheng @ Ocean University of China, Master of OE
    % complete: May 17th, 2016  

%% assumed initial value
t = 1;
tau = p;
x = zeros(year,omega);
z = zeros(year,omega);
Csx = zeros(1,omega);
z = z(:);
rho = paraEst(X);

%% calculation of skewness factor
for i = 1:size(X,2)
    sum = 0;
    for j = 1:size(X,1)
        sum = sum + (X(j,i)-mean(x(:,i))^3);
    end
    Csx(i) = (1/(size(X,1)-3))*sum/var(X(:,i))^3;
end

%% iterative generation of sequence
while t <= year
    while tau <= omega
        xi = normalDSS();
        [phi,sigma_eps] = autoCorrFun(p,tau,rho,omega);
        Cs_phi_tau = calCs(p,tau,omega,rho,phi,Csx);
        PHI = (2/Cs_phi_tau)*(1+(Cs_phi_tau*xi/6)-(Cs_phi_tau^2/36))^3-...
            2/Cs_phi_tau;
        epsilon = sqrt(sigma_eps) * PHI;
        if t == 1 && tau == p
            z_zero = [0,z(1:p-1)'];
            z_new = z_zero * flipud(phi) + epsilon;
        else
            z_nonzero = z((t-1)*omega+tau-p+1:(t-1)*omega+tau);
            z_new = z_nonzero' * flipud(phi) + epsilon;
        end
        x_new = mean(X(:,tau)) + sqrt(var(X(:,tau)))*z_new;
        z((t-1)*omega+tau) = z_new;
        x(t,tau) = x_new;
        tau = tau + 1;
    end
    tau = 1;
    t = t + 1;
end
        
%% return sequence
SAR_seq = x;
ogaSAR = zeros(year,omega);
for i = 1:year
    ogaSAR(i,:) = z((i-1)*omega+1:i*omega);
end