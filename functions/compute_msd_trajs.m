function [all_SDs, all_ts, all_fits, all_gofs] = compute_msd_trajs(trajs, Nrep, Nsamps, t_max)    
    all_SDs = cell(Nrep, 1);
    all_ts = cell(Nrep, 1);
    all_fits = cell(Nrep, 1);
    all_gofs = cell(Nrep, 1);

    ts = [0; trajs{1}(2:end,2) - trajs{1}(1,2)];
    for i=1:Nrep
        samp = randi([1 length(trajs)], 1, Nsamps);
        
        MSD = zeros(t_max, 1);
        for k=samp
            MSD = MSD + sum((trajs{k}(1:t_max,3:4) - repmat(trajs{k}(1, 3:4), t_max, 1)).^2, 2);
        end
        MSD = MSD / Nsamps;

        [f, gof] = fit(ts(2:t_max), MSD(2:end), 'power1', 'Lower', [0 0]);
        all_fits{i} = f;
        all_gofs{i} = gof;
    end
end