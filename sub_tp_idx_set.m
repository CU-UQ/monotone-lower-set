function [idx_sub, idx_lin] = sub_tp_idx_set(no_dim, bound, type)
%sub_tp_idx_set Compute sub indices for various polynomial spaces
%
%idx_sub = sub_tp_idx_set(no_dim, bound, type) returns a matrix idx_sub
%with no_dim rows, with each column representing a set of indices for each
%dimension which satisfies the constrain for the polynomial space specified
%in the variable type with an upper bound given in the variable bound. See
%Eq (2.2)-(2.4) in Zhou, Narayan & Xiu, J. Comput. Phys. 298, 2015] for a
%definition of the different polynomial spaces.
%
%Example: Consider a 3-dimensional problem. The function call
%
%>> idx_sub = sub_tp_idx_set(3,5,"total degree") 
%
%will return a 3 by 53 matrix. Each column idx_sub(:,n) contains a valid
%selection of polynomial orders that satisfy the constraint that the total
%degree is less than or equal to 5, i.e., sum(idx_sub(:,n))<=5 for each n.
%Moreover, idx_sub contain all such 3-tuples of orders.
%
%The choice type = "tensor product" just returns the tensor product of
%indices, i.e., all indices satisfying max(idx_sub(:,n))<=bound. 
%
%The choice type = "hyperbolic cross" returns indices satisfying 
%prod(idx_sub(:,n)+1)<=bound+1.

idx_1d = 0:bound;
idx = nan(no_dim, (bound+1)^no_dim);
for d = 1:no_dim
    idx(d,:) = repmat(repelem(idx_1d, 1, (bound+1)^(d-1)), 1, (bound+1)^(no_dim-d));
end

switch type
    case "tensor product"
        idx_sub = idx;
        
    case "total degree"
        s = sum(idx, 1);
        idx_sub = idx(:, s <= bound);
        
    case "hyperbolic cross"
        s = prod(idx+1, 1);     
        idx_sub = idx(:, s <= bound+1);
        
    otherwise
        error('Invalid type.')
end

idx_lin = (bound+1).^(no_dim-1:-1:0)*idx_sub + 1;

[idx_lin, srt_idx] = sort(idx_lin);
idx_sub = idx_sub(:, srt_idx);

end
