function [vel_norms, disp_xs, disp_ys] = extract_inst_vel(tab, vel_class)
    vel_norms = [];

    disp_xs = cell(length(vel_class)-1, 1);
    disp_ys = cell(length(vel_class)-1, 1);

    for i=2:size(tab,1)
        if tab(i-1,1) == tab(i,1) && all(tab(i-1,3:4) ~= tab(i,3:4))
            d = sqrt(sum((tab(i,3:4) - tab(i-1,3:4)).^2)) / (tab(i,2) - tab(i-1,2));
            vel_norms = [vel_norms; d];

            for kk=2:length(vel_class)
                if d > vel_class(kk-1) && d < vel_class(kk)
                    disp_xs{kk-1} = [disp_xs{kk-1}; tab(i-1,3); tab(i,3); nan];
                    disp_ys{kk-1} = [disp_ys{kk-1}; tab(i-1,4); tab(i,4); nan];
                end
            end
        end
    end
end