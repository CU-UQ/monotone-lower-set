clear all
close all

% Load battery data
load('./battery_data/A_HC.mat', 'A');
load('./battery_data/An.mat','An');
load('./battery_data/Un_sq.mat','Un_sq');
load('./battery_data/RUL.mat', 'RUL');

% Assign matrix structure
N = 4;
D = 7;
J = 3;
no_samp = 172;
y = RUL(:,2);
x = A\y;
err = norm(A*x-y)/norm(y);

% Begin trials
no_trials = 100;
err_unif = zeros(no_trials,1);
err_lev = zeros(no_trials,1);
err_alev = zeros(no_trials,1);
t_unif = zeros(no_trials,1);
t_lev = zeros(no_trials,1);
t_alev = zeros(no_trials,1);

for tr = 1:no_trials
    [x_sol, time] = hyperbolic_cross_sampling(N,D,J,An,Un_sq,no_samp,y,'unif');
    err_unif(tr) = norm(y-A*x_sol)/norm(y);
    t_unif(tr) = time;
    
    [x_sol, time] = hyperbolic_cross_sampling(N,D,J,An,Un_sq,no_samp,y,'lev');
    err_lev(tr) = norm(y-A*x_sol)/norm(y);
    t_lev(tr) = time;
    
    [x_sol, time] = hyperbolic_cross_sampling(N,D,J,An,Un_sq,no_samp,y,'alev');
    err_alev(tr) = norm(y-A*x_sol)/norm(y);
    t_alev(tr) = time;
    
    tr
end

disp("Error with uniform sampling: " + num2str(mean(err_unif)))
disp("Error with lev. scores of A: " + num2str(mean(err_lev)))
disp("Error with approximate lev. scores of A: " + num2str(mean(err_alev)))
disp("Average time of Unif. sampling: " + num2str(mean(t_unif)))
disp("Average time of lev. sampling: " + num2str(mean(t_lev)))
disp("Average time of approx. lev. sampling: " + num2str(mean(t_alev)))
disp(' ')

% Save results for plotting
err_all = [err_unif err_lev err_alev];
sname0 = ['./battery_HC_exact_N=' int2str(N) '.mat'];
sname1 = ['./battery_HC_N=' int2str(N) '.mat'];
save(sname0,'err');
save(sname1,'err_all');