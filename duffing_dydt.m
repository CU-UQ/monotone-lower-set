function dydt = duffing_dydt(t, y, w)
%duffing_dydt Derivative of Duffing oscillator

dydt = [y(2); -2*w(1)*w(2)*y(2) - w(1)^2*(y(1) + w(3)*y(1)^3)];

end

