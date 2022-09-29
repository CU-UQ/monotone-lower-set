clear all
close all

err_TD_7 = load('ishigami_TD_J=7.mat','err_all').err_all;
err_TD_9 = load('ishigami_TD_J=9.mat','err_all').err_all;
err_TD_exact_7 = load('ishigami_TD_exact_J=7.mat','err').err;
err_TD_exact_9 = load('ishigami_TD_exact_J=9.mat','err').err;
err_HC_15 = load('ishigami_HC_J=15.mat','err_all').err_all;
err_HC_18 = load('ishigami_HC_J=18.mat','err_all').err_all;
err_HC_exact_15 = load('ishigami_HC_exact_J=15.mat','err').err;
err_HC_exact_18 = load('ishigami_HC_exact_J=18.mat','err').err;

figure('Position', [1, 1, 800, 400]);
tiledlayout(2,2,'Padding', 'none', 'TileSpacing','Compact');
font_size = 14;

nexttile
err_unif = err_TD_7(:,1);
err_lev = err_TD_7(:,2);
err_alev = err_TD_7(:,3);
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
title('K=7; Total Degree', 'fontsize', font_size);
grid on

nexttile
err_unif = err_TD_9(:,1);
err_lev = err_TD_9(:,2);
err_alev = err_TD_9(:,3);
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
set(gca,'FontSize',10);
grid on
set(gcf,'Position',[100 100 1400 500])
xlabel('Relative Error')
ylabel('CDF')
title('K=9; Total Degree', 'fontsize', font_size);
grid on

nexttile
err_unif = err_HC_15(:,1);
err_lev = err_HC_15(:,2);
err_alev = err_HC_15(:,3);
[f1,x1] = ecdf(err_unif);
[f2,x2] = ecdf(err_lev);
[f3,x3] = ecdf(err_alev);
colors = get(gca,'colororder');
hold on
plot(x1,f1, 'linewidth', 2, 'color', colors(2,:));
plot(x2,f2, 'linewidth', 2, 'color', colors(3,:));
plot(x3,f3, 'linewidth', 2, 'color', colors(4,:));
set(gca,'FontSize',10);
xlabel('Relative Error');
ylabel('CDF');
title('K=15; Hyperbolic Cross', 'fontsize', font_size);
grid on

nexttile
err_unif = err_HC_18(:,1);
err_lev = err_HC_18(:,2);
err_alev = err_HC_18(:,3);
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
title('K=18; Hyperbolic Cross', 'fontsize', font_size)
grid on