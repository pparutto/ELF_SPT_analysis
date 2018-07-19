classdef CRT_TMR_HEK293_1 < SPT_params
    properties
        exp_name = 'CRT_TMR_HEK293_1';

        reg_poly = [2.73 28.6;
                    0    23.79;
                    0    20.61;
                    4.82 22.53;
                    6.21 24.03;
                    12.02 19.1;
                    12.23 16.42;
                    17.3    14.5;
                    20.72 17.11;
                    22.53 21.5;
                    24.51 28;
                    24.01 30.71;
                    22.11 32.4;
                    18.82 34.02;
                    10.23 33.71;
                    8.12  33.09;
                    2.73  28.6];

        vel_class = [0 2.5 10 13.5 19 24.5 50];
        vel_plot_order = 'bwd';

        inst_vel_bin = 0.25:0.5:40;
        app_diff_bin = 0.075:0.15:4;
        
        diff_map_color = 'auto';
        
        r = 0.2;
    end
end