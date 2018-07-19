function [mu, A, D] = estimate_parameters_chen(traj)
    part1 = [0 0];
    part2 = [0 0];
    part3 = [0 0];
    part4 = [0 0];

    n = size(traj, 1);
    
    for i=2:size(traj, 1)
        part1 = part1 + traj(i,3:4) .* traj(i-1,3:4);
        part2 = part2 + traj(i,3:4);
        part3 = part3 + traj(i-1,3:4);
        part4 = part4 + traj(i-1,3:4).^2;
    end
    beta1 = (1/n * part1 - 1/n^2 * part2 .* part3) ./ (1/n * part4 - 1/n^2 * part3.^2) + 4 / size(traj, 1);
    
    part1 = [0 0];
    for i=2:size(traj, 1)
        part1 = part1 + traj(i,3:4) - beta1 .* traj(i-1,3:4);
    end
    beta2 = 1/n * part1 ./ (1 - beta1);
    
    part1 = [0 0];
    for i=2:size(traj, 1)
        part1 = part1 + (traj(i,3:4) - beta1 .* traj(i-1,3:4) - beta2 .* (1 - beta1)).^2;
    end
    beta3 = 1/n * part1;
    
    mu = beta2;
    A = - 1 / mean(traj(2:end,2) - traj(1:(end-1), 2)) .* log(beta1);
    D = (A .* beta3) ./ (1 - beta1.^2);
    A = (A(1) + A(2))/2;
    D = (D(1) + D(2))/2;
end