function f = evaluate_objective(x,problem)

% Function to evaluate the objective functions for the given input vector
% x. x has the decision variables



switch problem
    case 1
        f = [];
        
%% Constraints function
q=10000; %  Exterior Penalty Function Method에서 rp값을 나타냄
 
 g(1) = 164.99750 - 43.208366*x(1) - 53.682525*x(2) - 5.4786443*x(3) + 12.379835*x(4) - 5.6292047*x(1)*x(1) + 5.8720012*x(1)*x(2) + 1.9715081*x(2)*x(2) - 3.2981268*x(1)*x(3) + 10.285299*x(2)*x(3) + 0.25793014*x(3)*x(3) + 2.434375*x(1)*x(4) - 1.3189468*x(2)*x(4) + 1.0883086*x(3)*x(4) - 0.25905977*x(4)*x(4);
 g(2) = 1.5289110 - 0.10289975*x(1) - 0.4018969*x(2) - 0.15677687*x(3) - 0.23388023*x(4) + 0.033338762*x(1)*x(1) + 0.069962972*x(1)*x(2) + 0.032714309*x(2)*x(2) + 0.031405766*x(1)*x(3) + 0.0014542695*x(2)*x(3) - 0.0008088836*x(3)*x(3) + 0.00100625*x(1)*x(4) + 0.0016797117*x(2)*x(4) + 0.0048710606*x(3)*x(4)  - 0.0018933414*x(4)*x(4);
 if g(1) > 60
     g1 = g(1);
 else
     g1 = 0;
 end
 
 if g(2) > 0.5
     g2 = g(2);
 else
     g2 = 0;
 end
%% Objective function one
formular1 = 0.73039037 + 0.257138*x(1) + 0.258275085*x(2) + 0.45739771*x(3) + 0.078496963*x(4) - 0.013423763*x(1)*x(1) - 0.02947004*x(1)*x(2) - 0.080407611*x(2)*x(2) - 0.0061030324*x(1)*x(3) - 0.000125*x(1)*x(4) + 0.001850496*x(2)*x(4); 

f(1) = formular1+q*(g1^2+g2^2);

%% Objective function two

f(2) = 0;
        
    case 2
        f = [];
        %% Intermediate function
        g_x = 0;
        for m = 3 : 12
            g_x = g_x + (x(m) - 0.5)^2;
        end
        %% Objective function one
        f(1) = (1 + g_x)*cos(0.5*pi*x(1))*cos(0.5*pi*x(2));
        %% Objective function two
        f(2) = (1 + g_x)*cos(0.5*pi*x(1))*sin(0.5*pi*x(2));
        %% Objective function three
        f(3) = (1 + g_x)*sin(0.5*pi*x(1));
end
