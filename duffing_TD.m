clear
N = 20; % No. of grid points
D = 3; % No. dimensions
J = 9; % Max polynomial degree: 0, 1, ..., J
left_end_pt = -1;
right_end_pt = 1;
no_samp = 800;

% Compute Gauss-Legendre quadrature points and weights
[xn, wn] = lgwt(N, left_end_pt, right_end_pt);
wn = wn./2;

% Compute matrix A^(n) which is the same for all n
An = zeros(N, J+1);
for i = 1:N
    An(i, :) = my_legendre_1d(J,xn(i))';
end
An = sqrt(wn).*An;

% Note: we don't need to construct A explicitly
% Compute big matrix A for tensor product space

% Compute leverage scores of A
[Un, ~] = qr(An, 0);
Un_sq = Un.^2;

% Compute big matrix A for tensor product space
A_ = An;
Wn = sqrt(wn);
for d = 2:D
    A_ = kron(A_, An);
    Wn = kron(Wn,sqrt(wn));
end

% Truncate A into total degree space
sub = sub_tp_idx_set(D,J,'tensor product');
s = sum(sub,1);
l = 1:(1+J)^D;
ind = l(s <= J);
A = A_(:,ind);

% Compute Duffing data
tspan = [0 4];
y0 = [1; 0];
y = zeros(N^D, 1);
for n1 = 1:N
    for n2 = 1:N
        for n3 = 1:N
            param = zeros(3,1);
            param(1) = 2*pi*(1 + 0.2*xn(n2));
            param(2) = 0.05*(1 + 0.05*xn(n1));
            param(3) = -0.5*(1 + 0.5*xn(n3));
            [t, osc] = ode45(@(t,y) duffing_dydt(t,y,param), tspan, y0);
            y(n3 + (n2-1)*N + (n1-1)*N^2) = osc(end,1);
        end
    end
end
y = Wn.*y;

% Begin trials
no_trials = 100;
err_unif = zeros(no_trials,1);
err_lev = zeros(no_trials,1);
err_alev = zeros(no_trials,1);
t_unif = zeros(no_trials,1);
t_lev = zeros(no_trials,1);
t_alev = zeros(no_trials,1);

%x = A\y;
x = A'*y;
err = norm(A*x-y)/norm(y);

for tr = 1:no_trials
    [x_sol, time] = total_degree_sampling(N,D,J,An,Un_sq,no_samp,y,'unif');
    err_unif(tr) = norm(y-A*x_sol)/norm(y);
    t_unif(tr) = time;
    
    [x_sol, time] = total_degree_sampling(N,D,J,An,Un_sq,no_samp,y,'lev');
    err_lev(tr) = norm(y-A*x_sol)/norm(y);
    t_lev(tr) = time;
    
    [x_sol, time] = total_degree_sampling(N,D,J,An,Un_sq,no_samp,y,'alev');
    err_alev(tr) = norm(y-A*x_sol)/norm(y);
    t_alev(tr) = time;
    
    tr
end

disp("Error with uniform sampling: " + num2str(mean(err_unif)))
disp("Error with lev. scores of A: " + num2str(mean(err_lev)))
disp("Error with approximate lev. scores of A: " + num2str(mean(err_alev)))
disp("Exact error: " + num2str(err));
disp("Average time of Unif. sampling: " + num2str(mean(t_unif)))
disp("Average time of lev. sampling: " + num2str(mean(t_lev)))
disp("Average time of approx. lev. sampling: " + num2str(mean(t_alev)))
disp(' ')

err_all = [err_unif err_lev err_alev];
sname0 = ['duffing_TD_exact_J=' int2str(J) '.mat'];
sname1 = ['duffing_TD_J=' int2str(J) '.mat'];
save(sname0,'err');
save(sname1,'err_all');