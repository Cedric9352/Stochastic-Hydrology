function [SAR_seq,SAR_std] = SARW_Hseq(p,X,year,omega)
%% SAR skewness distribution sequence simulation via W-H
    % input:
    %   p is the order of SAR model
    %   X is the original independent skewness distribution sequence
    %   omega is the total season count
    %   year is the required sequence length
    % output:
    %   SAR_seq is the simulated sequence
    %   SAR_std is the standardized sequenc
    %---------------------------------
    % author: Yujia Cheng @ Ocean University of China, Master of OE
    % complete: May 18th, 2016  

%% assumed initial value
t = 1;
tau = p;
Y = zeros(size(X));
Z = zeros(size(X));
x = zeros(year,omega);
y = zeros(year,omega);
z = zeros(year,omega);
Csx = zeros(1,omega);
z = z(:);

%% standardized original sequence
meanX = mean(X);
varX = var(X);
for i = 1:omega
    Y(:,i) = (X(:,i)-meanX(i))/sqrt(varX(i));
end

%% calculation of skewness factor
for i = 1:size(X,2)
    sum = 0;
    for j = 1:size(X,1)
        sum = sum + (X(j,i)-mean(x(:,i))^3);
    end
    Csx(i) = (1/(size(X,1)-3))*sum/var(X(:,i))^3;
end

%% W-H reverse transformation
for i = 1:size(Y,2)
    Z(:,i) = (6/Csx(i))*((Csx(i)*Y(:,i)/2+1).^(1/3)-1)+Csx(i)/6;
end
rho = paraEst(Z);

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
        z((t-1)*omega+tau) = z_new;
        tau = tau + 1;
    end
    tau = 1;
    t = t + 1;
end
std_z = zeros(year,omega);
for i = 1:year
    std_z(i,:) = z((i-1)*omega+1:i*omega);
end

%% W-H and re-standardized transformation
for i = 1:size(std_z,2)
    y(:,i) = (((std_z(:,i)-Csx(i))*Csx(i)+1).^3-1)/(Csx(i)/2);
end
for i = 1:size(y,2)
    x(:,i) = y(:,i)*sqrt(varX(i))+meanX(i);
end

%% return sequence
SAR_seq = x;
SAR_std = y;
