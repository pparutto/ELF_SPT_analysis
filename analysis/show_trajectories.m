addpath('../experiments')
addpath('../functions')

cols = [166 206 227
    31  120 180;
    51  160 44;
    230 171 2;
    217 95  2;
    228 26  28;
    0   0   0] ./ 255;

exps = {CRT_TMR_HEK293_1(); CNX_EOS_HEK293_1()};

for i=1:length(exps)
    exp = exps{i};

    ana = load(sprintf('../data/%s.mat', exp.exp_name));

    [v_norms, d_xs, d_ys] = extract_inst_vel(ana.tab_reg, exp.vel_class);

    figure
    hold on
    if strcmp(exp.vel_plot_order, 'bwd')
        for k=length(d_xs):-1:1
            plot(d_xs{k}, d_ys{k}, 'Color', cols(k,:))
        end
    elseif strcmp(exp.vel_plot_order, 'fwd')
        for k=1:length(d_xs)
            plot(d_xs{k}, d_ys{k}, 'Color', cols(k,:))
        end
    else
        display(sprintf('ERROR: invalid argument |%s| for vel_plot_order', exp.vel_plot_order));
    end
    hold off
    daspect([1,1,1])
    title(exp.exp_name, 'Interpreter', 'None')

    [o,b] = hist(v_norms, exp.inst_vel_bin);

    figure
    hold on
    bar(b, o / sum(o), 'hist')
    for k=1:length(exp.vel_class)
        plot([1 1] * exp.vel_class(k), [0 0.08], 'Color', cols(k, :))
    end
    hold off
    xlabel('Instantaneous Velocity (mu m/s)')
    ylabel('Frequency')
    title(exp.exp_name, 'Interpreter', 'None')
    axis square

    figure
    hold on
    plot(b, cumsum(o) / sum(o), 'k')
    for k=1:length(exp.vel_class)
        plot([1 1] * exp.vel_class(k), [0 1], 'Color', cols(k, :))
    end
    hold off
    xlabel('Instantaneous Velocity (mu m/s)')
    ylabel('Cumulative')
    title(exp.exp_name, 'Interpreter', 'None')
    axis square
end