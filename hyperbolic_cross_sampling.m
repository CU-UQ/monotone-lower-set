function [x_sol, time, samp_list, scaling] = hyperbolic_cross_sampling(N,D,J,An,Un_sq,no_samp,y,type)
% total_degree_sampling function evaluate the sampling least square
% problem's error and return time cost with total degree method
% 
% Input: 
% N: number of nodes for quadrature;
% D: dimension of the data;
% J: polynomial degree (total degree: largest polynomial term degree) J<N
% no_samp: number of row samples for the sketched least square problem;
% y: function value for regression;
% type: unif/lev/alev
% Output: 
% x_sol: solution x for the sketched least square problem;
% time: time the algo takes


% Find index of columns for total degree
col_ind = sub_tp_idx_set(D,J,'hyperbolic cross')+1;
row_ind = sub_tp_idx_set(D,N-1,'tensor product')+1;
[~,J_TD] = size(col_ind);

switch type

%% Solve Uniform Sampling
    case "unif"
        my_tic = tic;
        samp_list = zeros(no_samp,D);
        for d = 1:D
            samp = randsample(N, no_samp,true,ones(N,1)/N);
            samp_list(:,d) = samp;
        end
        samp = get_index(samp_list,N);
        [occurs, unq_samp] = groupcounts(samp);
        samp = unq_samp;
        real_no_samp = length(samp);
        samp_row_ind = row_ind(:,samp);

        p_unif = ones(real_no_samp,1)./N^D;
        scaling = sqrt(occurs./(no_samp*p_unif));

        % Generate sampled A and sampled y
        samp_A = ones(real_no_samp,J_TD);
        for i = 1:real_no_samp
            for j = 1:J_TD
                for d = 1:D
                    samp_A(i,j) = samp_A(i,j)*An(samp_row_ind(d,i),col_ind(d,j));
                end
            end
        end
        samp_y = y(samp);
        samp_list = get_index(samp_list,N);

        SA = scaling .* samp_A;
        Sy = scaling .* samp_y;
        x_sol = SA \ Sy;
        time = toc(my_tic);

%% Solve Lev. Sampling
    case 'lev'
        my_tic = tic;
        samp_list = zeros(no_samp,D);
        pn = sum(Un_sq,2);
        for d = 1:D
            samp = randsample(N, no_samp,true,pn);
            samp_list(:,d) = samp;
        end
        samp = get_index(samp_list,N);
        [occurs, unq_samp] = groupcounts(samp);
        samp = unq_samp;
        real_no_samp = length(samp);
        samp_row_ind = row_ind(:,samp);

        p_lev = ones(real_no_samp,1);
        for smp = 1:real_no_samp
            row_list = row_ind(:,samp(smp));
            for d = 1:D
                p_lev(smp) = p_lev(smp) * pn(row_list(d));
            end
        end
        scaling = sqrt(occurs./(no_samp*p_lev));

        % Generate sampled A and sampled y
        samp_A = ones(real_no_samp,J_TD);
        for i = 1:real_no_samp
            for j = 1:J_TD
                for d = 1:D
                    samp_A(i,j) = samp_A(i,j)*An(samp_row_ind(d,i),col_ind(d,j));
                end
            end
        end
        samp_y = y(samp);

        SA = scaling .* samp_A;
        Sy = scaling .* samp_y;
        x_sol = SA \ Sy;
        time = toc(my_tic);

%% Solve Approx Lev. Sampling
    case 'alev'
        my_tic = tic;
        % Generate sample index for no_samp samples wrt. approx lev scores
        count = mnrnd(no_samp,ones(J_TD,1)/J_TD);
        samp_list = zeros(no_samp, 1);
        samp_id = [0 cumsum(count)];
        for col = 1:J_TD
            col_list = col_ind(:,col);
            count_value = count(col);
            samps_list = zeros(count_value,D);
            for d = 1:D
                p = Un_sq(:,col_list(d));
                samp = randsample(N, count_value,true,p);
                samps_list(:,d) = samp;
            end
            samps = get_index(samps_list,N)';
            id1 = samp_id(col)+1;
            id2 = samp_id(col+1);
            samp_list(id1:id2) = samps;
        end

        [occurs, unq_samp] = groupcounts(samp_list);
        real_no_samp = length(unq_samp);

        % Calculate the probability for unq_samp
        unq_p_list = ones(real_no_samp,J_TD);
        for smp = 1:real_no_samp
            row_list = row_ind(:,unq_samp(smp));
            for col = 1:J_TD
                col_list = col_ind(:,col);
                for d = 1:D
                    unq_p_list(smp,col) = unq_p_list(smp,col) * Un_sq(row_list(d),col_list(d));
                end
            end
        end
        uniq_p = unq_p_list*count'./no_samp;

        scaling = sqrt(occurs./(no_samp*uniq_p));
        samp = unq_samp;
        samp_row_ind = row_ind(:,samp);

        % Generate sampled A and sampled y
        samp_A = ones(real_no_samp,J_TD);
        for i = 1:real_no_samp
            for j = 1:J_TD
                for d = 1:D
                    samp_A(i,j) = samp_A(i,j)*An(samp_row_ind(d,i),col_ind(d,j));
                end
            end
        end
        samp_y = y(samp);

        SA = scaling .* samp_A;
        Sy = scaling .* samp_y;
        x_sol = SA \ Sy;
        time = toc(my_tic);
    
    otherwise
        error('Invalid Type.')
end
end