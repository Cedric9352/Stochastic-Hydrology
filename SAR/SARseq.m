function SAR_seq = SARseq(p,x,omega,length)
%% Seasonal autoregressive model simulation
    % input:
    %   p is the order of SAR model
    %   x is the original sequence
    %   omega is the total season count
    %   length is the required sequence length
    % output:
    %   SAR_seq is the simulated sequence
    %---------------------------------
    % author: Yujia Cheng @ Ocean University of China, Master of OE
    % complete: May 13th, 2016  

%% assumed initial value
t = 1;
x = [];
tau = p;
z = zeros(1,p);
rho = paraEst(x);

%% 
while 1
    while tau ~= p
        xi = normalDSS();
        [phi, sigma_eps] = autoCorrFun(p,tau,rho);
        epsilon = sqrt(sigma_eps) * xi;
        z_new = z * phi + epsilon;
        x_new = mean(x(:,tau)) + sqrt(var(x(:,tau)))*z_new;
        x = [x,x_new];
        tau = tau + 1;
        length = length - 1;
        

