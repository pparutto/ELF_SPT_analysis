addpath('../experiments')
addpath('../functions')

exp = junction_1();

ana = load(sprintf('../data/%s.mat', exp.exp_name));

ana.tab_reg(:, 3:4) = ana.tab_reg(:, 3:4) * exp.dx;
ana.tab_reg(:, 2) = ana.tab_reg(:, 2) * exp.dt;

[trajs, tab] = filter_tab_size(ana.tab_reg, exp.minNpts);

figure
hold on
for i=1:length(trajs)
    plot(trajs{i}(:, 3), trajs{i}(:, 4), 'Color', rand(3,1))
end
hold off

%The following MSD results may vary slightly due to sampling
[all_SDs, all_ts, all_fits, all_gofs] = compute_msd_trajs(trajs, 100, 20, 20);
alphas = cellfun(@(x) x.b, all_fits);

figure
[o,b] = hist(alphas, 0.06:0.12:2);
bar(b,o / sum(o),'hist')
axis square
xlabel('Anomalous exponent alpha')
ylabel('Frequency')

figure
boxplot(alphas)
ylabel('Anomalous exponent alpha')
display(sprintf('alphas: AVG=%.1f; SD=%.2f, n=%d', ...
        mean(alphas), std(alphas), length(alphas)))

vels = [];
for i=1:length(trajs)
    for j=2:size(trajs{i}, 1)
        vels = [vels; sqrt(sum((trajs{i}(j,3:4) - trajs{i}(j-1,3:4)).^2)) / (trajs{i}(j,2) - trajs{i}(j-1,2))];
    end
end

[o,b] = hist(vels, 0.05:0.1:3);
figure
bar(b, o / sum(o), 'hist')
xlabel('Instantaneous velocity (mu m/s)')
ylabel('Frequency')
display(sprintf('Inst. vel.: AVG=%.2f; SD=%.2f; n=%d', ...
        mean(vels), std(vels), length(vels)))

wells = zeros(length(trajs), 4) * nan;
for i=1:length(trajs)
    wells(i, 1:2) = mean(trajs{i}(:, 3:4));
    tmp_traj = trajs{i};
    tmp_traj(:, 3:4) = tmp_traj(:, 3:4) - repmat(wells(i, 1:2), size(tmp_traj, 1), 1);
    [no, A, D] = estimate_parameters_chen(tmp_traj);
    wells(i, 3:4) = [A D];
    clear tmp_traj
end

wells(imag(wells(:,3)) ~= 0, :) = [];

[o,b] = hist(wells(:,3), 0.5:1:30);
figure
bar(b, o / sum(o), 'hist')
axis square
xlabel('kappa (1/s)')
ylabel('Frequency')
xlim([0 30])
display(sprintf('κ: AVG=%.2f; SD=%.2f; n=%d', ...
        mean(wells(:,3)), std(wells(:,3)), size(wells, 1)))

[o,b] = hist(wells(:,4), 0.001:0.002:0.04);
figure
bar(b, o / sum(o), 'hist')
axis square
xlabel('Diffusion coefficient (mu m^2/s)')
ylabel('Frequency')
xlim([0 0.04])
display(sprintf('D: AVG=%.3f; SD=%.3f; n=%d', ...
        mean(wells(:,4)), std(wells(:,4)), size(wells, 1)))
