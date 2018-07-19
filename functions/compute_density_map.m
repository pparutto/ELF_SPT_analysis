function dens = compute_density_map(tab, gx, gy)
    r = gx(2) - gx(1);
    dens = zeros(length(gx), length(gy));
    
    for k = 1:size(tab, 1)
        cx = floor(single((tab(k,3) - gx(1)) / r)) + 1;
        cy = floor(single((tab(k,4) - gy(1)) / r)) + 1;
        
        if cx > 0 && cy > 0
            dens(cx, cy) = dens(cx, cy) + 1;
        end
    end

    dens = dens / r^2;
end