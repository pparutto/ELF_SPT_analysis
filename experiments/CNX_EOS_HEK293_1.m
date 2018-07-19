classdef CNX_EOS_HEK293_1 < SPT_params
    properties
        exp_name = 'CNX_EOS_HEK293_1';

        reg_poly = [0 0;
                    50 0;
                    50 50;
                    0 50;
                    0 0];

        vel_class = [0 2.5 10 13.5 19 24.5 50];
        vel_plot_order = 'fwd';

        inst_vel_bin = 0.5:1:40;
        app_diff_bin = 0.025:0.05:1;

        diff_map_color = [0 1];

        r = 0.4;
    end
end