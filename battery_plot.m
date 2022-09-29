clear all
close all

err_TD_1 = load('battery_TD_N=4_t=0.mat','err_all').err_all;
err_TD_2 = load('battery_TD_N=5_t=0.mat','err_all').err_all;
err_TD_exact_1 = load('battery_TD_exact_N=4_t=0.mat','err').err;
err_TD_exact_2 = load('battery_TD_exact_N=5_t=0.mat','err').err;
err_HC_1 = load('battery_HC_N=4_t=0.mat','err_all').err_all;
err_HC_2 = load('battery_HC_N=5_t=0.mat','err_all').err_all;
err_HC_exact_1 = load('battery_HC_exact_N=4_t=0.mat','err').err;
err_HC_exact_2 = load('battery_HC_exact_N=5_t=0.mat','err').err;

tiledlayout(2,2,'Padding', 'none', 'TileSpacing','Compact');
font_size = 14;

nexttile
err_unif = err_TD_1(:,1);
err_lev = err_TD_1(:,2);
err_alev = err_TD_1(:,3);
[f1,x1] = ecdf(err_unif);
[f2,x2] = ecdf(err_lev);
[f3,x3] = ecdf(err_alev);
colors = get(gca,'colororder');
hold on
plot(x1,f1, 'linewidth', 2, 'color', colors(2,:));
plot(x2,f2, 'linewidth', 2, 'color', colors(3,:));
plot(x3,f3, 'linewidth', 2, 'color', colors(4,:));
set(gca,'FontSize',10);
xlabel('Relative Error')
ylabel('CDF')
title('M_d=4; Total Degree', 'fontsize', font_size)
grid on


nexttile
err_unif = err_TD_2(:,1);
err_lev = err_TD_2(:,2);
err_alev = err_TD_2(:,3);
[f1,x1] = ecdf(err_unif);
[f2,x2] = ecdf(err_lev);
[f3,x3] = ecdf(err_alev);
legend_cell = {...
    'Uniform Sampling', ...
    'TP Sampling', ...
    'Leverage Sampling'
    };
colors = get(gca,'colororder');
hold on
plot(x1,f1, 'linewidth', 2, 'color', colors(2,:));
plot(x2,f2, 'linewidth', 2, 'color', colors(3,:));
plot(x3,f3, 'linewidth', 2, 'color', colors(4,:));
%legend(legend_cell(:), 'location', 'best');
set(gca,'FontSize',10);
set(gcf,'Position',[100 100 1400 500])
xlabel('Relative Error')
ylabel('CDF')
title('M_d=5; Total Degree', 'fontsize', font_size)
grid on

nexttile
err_unif = err_HC_1(:,1);
err_lev = err_HC_1(:,2);
err_alev = err_HC_1(:,3);
[f1,x1] = ecdf(err_unif);
[f2,x2] = ecdf(err_lev);
[f3,x3] = ecdf(err_alev);
colors = get(gca,'colororder');
hold on
plot(x1,f1, 'linewidth', 2, 'color', colors(2,:));
plot(x2,f2, 'linewidth', 2, 'color', colors(3,:));
plot(x3,f3, 'linewidth', 2, 'color', colors(4,:));
set(gca,'FontSize',10);
xlabel('Relative Error')
ylabel('CDF')
title('M_d=4; Hyperbolic Cross', 'fontsize', font_size)
grid on

nexttile
err_unif = err_HC_2(:,1);
err_lev = err_HC_2(:,2);
err_alev = err_HC_2(:,3);
[f1,x1] = ecdf(err_unif);
[f2,x2] = ecdf(err_lev);
[f3,x3] = ecdf(err_alev);
legend_cell = {...
    'Uniform Sampling', ...
    'TP Sampling', ...
    'Leverage Sampling'
    };
colors = get(gca,'colororder');
hold on
plot(x1,f1, 'linewidth', 2, 'color', colors(2,:));
plot(x2,f2, 'linewidth', 2, 'color', colors(3,:));
plot(x3,f3, 'linewidth', 2, 'color', colors(4,:));
legend(legend_cell(:), 'location', 'best');
set(gca,'FontSize',10);
set(gcf,'Position',[100 100 1400 500])
xlabel('Relative Error')
ylabel('CDF')
title('M_d=5; Hyperbolic Cross', 'fontsize', font_size)
grid on