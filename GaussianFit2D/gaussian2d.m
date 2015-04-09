% Function Gaussian-2D approximate 2-d Gaussian to the random number of measurment points (x y z). 
% It returns coefficients for f(x,y) = A*exp(-(x-x_0)/(2*d_x^2) - (y-y_0)/(2*d_y^2)), where we assume
% deviations d_x=d_y.
%
% Output coefficients:
% - a(1): A-magnitude
% - a(2): standard deviation
% - a(3): cetre x-coordinate x_0
% - a(4): cetre y-coordinate x_0
%
% Input argument: data - 3xn matrix with rows: [x-coordinate; y-coordinate; measurements]
 
function [a] = gaussian2d(data)

x = data(1,:); %x-coordinates
y = data(2,:); %y-coordinates
z = data(3,:); %measurements

% Construct matrix A and log of solution vector
A = transpose([x.^2 + y.^2; x; y; ones(1,length(x))]);
b = transpose(log(z));

% Solve linear equations
%c = A\b;
c = linsolve(A,b);

% Invert coefficients
a(2) = -1/(2*c(1));
a(3) = c(2)*a(2);
a(4) = c(3)*a(2);
a(1) = c(4) -c(1)*(a(3)^2 +a(4)^2);
a(1) = exp(a(1));
a(2) = sqrt(a(2));

% OPTIONAL! Set lower bound on the amplitude coefficient
m = max(z);
if a(1) < m
  a(1)=m;
end;



end;