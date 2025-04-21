function [ind] = get_index(sample_index_matrix,N)
% The input matrix should be a count by D matrix, each column represents
% index for submatrix
[~,D] = size(sample_index_matrix);
ind = sample_index_matrix(:,end);
for d = 2:D
    ind = ind + (sample_index_matrix(:,end+1-d)-1).*(N^(d-1));
end
end