function [res_trajs, res_tab] = filter_tab_size(tab, min_npts)
    res_trajs = {};
    res_tab = [];
    for i=unique(tab(:,1))'
        t = tab(tab(:, 1) == i, :);
        if size(t, 1) >= min_npts
            res_trajs = [res_trajs; t];
            res_tab = [res_tab; t];
        end
    end
end

