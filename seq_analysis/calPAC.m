function r = calPAC(x,k)
%% calculation of PAC
    % input:
    %   x is the original sequency
    % output:
    %   r is the autocorrelation coefficient matrix
    %   graph of autocorrelation coefficient in k orders
    %---------------------------------
    % author: Yujia Cheng @ Ocean University of China, Master of OE
    % complete: March 25th, 2016

%% arguments check
if(nargin == 1)
    k = size(x,2)-10;
elseif(nargin > 2)
    error('wrong arguments!');
end

%% calculation   
n = size(x,2);
if(k >= n)
    error('out of index!');
end
cov = zeros(1,k+1);
sig_t2 = zeros(1,k+1);
sig_tk2 = zeros(1,k+1);
r = zeros(1,k+1);
up = zeros(1,k+1);
down = zeros(1,k+1);
for i = 1:k+1
    ave_xt = mean(x(1:n-i+1));
    ave_xtk = mean(x(1+i-1:n));
    for j = 1:n-i+1
        cov(i) = cov(i) + (x(j+i-1)-ave_xtk).*(x(j)-ave_xt)/(n-i+1);
        sig_t2(i) = sig_t2(i) + (x(j) - ave_xt).^2/(n-i+1);
        sig_tk2(i) = sig_tk2(i) + (x(j+i-1) - ave_xtk).^2/(n-i+1);
    end
    r(i) = cov(i)./sqrt(sig_t2(i).*sig_tk2(i));
    up(i) = (-1 + 1.96*sqrt(n-i))/(n-i+1);
    down(i) = (-1 - 1.96*sqrt(n-i))/(n-i+1);
end

%% plot
X = linspace(0,k,k+1);
xlabel('rk');
ylabel('k');
plot(X,r,'-bs');hold on
plot(X,up,'-rs');hold on
plot(X,down,'-ks');
legend('autocorrelation coefficient','ceil','floor');
axis([0 20 -1.1 1.1]);
