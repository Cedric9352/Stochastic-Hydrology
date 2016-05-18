function [SAR_seq,SAR_norm] = SARnormseq(p,X,year,omega)
%% SAR normal distribution sequence simulation
    % input:
    %   p is the order of SAR model
    %   X is the original normal distribution sequence
    %   omega is the total season count
    %   year is the required sequence length
    % output:
    %   SAR_seq is the simulated sequence
    %   SAR_norm is the normal sequence
    %---------------------------------
    % author: Yujia Cheng @ Ocean University of China, Master of OE
    % complete: May 13th, 2016  

%% assumed initial value
t = 1;
tau = p;
x = zeros(year,omega);
z = zeros(year,omega);
z = z(:);
rho = paraEst(X);

%% iterative generation of sequence
while t <= year
    while tau <= omega
        xi = normalDSS();
        [phi,sigma_eps] = autoCorrFun(p,tau,rho,omega);
        epsilon = sqrt(sigma_eps) * xi;
        if t == 1 && tau == p
            z_zero = [0,z(1:p-1)'];
            z_new = z_zero * flipud(phi) + epsilon;
        else
            z_nonzero = z((t-1)*omega+tau-p:(t-1)*omega+tau-1);
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
SAR_norm = zeros(year,omega);
for i = 1:year
    SAR_norm(i,:) = z((i-1)*omega+1:i*omega);
end