addpath('../experiments')
addpath('../functions')

exps = {CRT_TMR_HEK293_1(); CNX_EOS_HEK293_1()};

for i=1:length(exps)
    exp = exps{i};
    ana = load(sprintf('../data/%s.mat', exp.exp_name));

    grid = gen_grid(ana.tab_reg, exp.r);

    dens = compute_density_map(ana.tab_reg, grid, grid);

    de = log(dens);
    de(de < 0) = 0;

    figure
    show_map(de, grid + exp.r/2, grid + exp.r/2)
    daspect([1,1,1])
    colorbar
    title(sprintf('%s - DENSITY (log(points / mu m^2))', exp.exp_name), 'Interpreter', 'None')

    diff = compute_diffusion_map(ana.tab_reg, grid, grid);
    di = diff .* (dens .* exp.r^2 > exp.diff_pts_th);

    figure
    show_map(di, grid + exp.r/2, grid + exp.r/2)
    caxis(exp.diff_map_color)
    daspect([1,1,1])
    colorbar
    title(sprintf('%s - DIFFUSION (mu m^2/s)', exp.exp_name), 'Interpreter', 'None')

    [o, b] = hist(di(di > 0), exp.app_diff_bin);

    figure
    bar(b, o / sum(o), 'hist')
    xlabel('Diffusion Coefficient (mu m^2/s)')
    ylabel('Frequency')
    axis square
    title(sprintf('%s', exp.exp_name), 'Interpreter', 'None')
    display(sprintf('AVG: %.2f; SD: %.2f; n=%d', mean(di(di > 0)), ...
        std(di(di > 0)), length(di(di > 0))));
end