classdef SPT_params
    properties
        %timestep
        dt = 0.018;

        %Keep only trajectories with > 1 pts and < 500 pts
        traj_size_th = [1 500];
       
        %Min number of points to compute diffusion in cell
        diff_pts_th = 20;

        w_duration = 36;
        w_overlap = 0;

        trajid_pos = 1;
        t_pos = 7;
        x_pos = 5;
        y_pos = 6;
        delim = '\t';
    end
end