function D = compute_diffusion_map(tab, gx, gy)
    r = gx(2) - gx(1);

    sigmaxx= zeros(length(gx), length(gy));
    sigmayy= zeros(length(gx), length(gy));
    cpt = zeros(length(gx), length(gy));

    for i=1:length(tab)-1
        line = tab(i,:);
        line2 = tab(i+1,:);

        if line(1)==line2(1)
            if ~isnan(line(3) + line2(3))
                x = floor(single((line(3)-gx(1)) / r)) + 1;
                y = floor(single((line(4)-gy(1)) / r)) + 1;

                dx = (line2(3) - line(3))^2;
                dy = (line2(4) - line(4))^2;
                dt = line2(2) - line(2);

                if x > 0 && y > 0
                    sigmaxx(x,y) = sigmaxx(x,y) + dx / dt;
                    sigmayy(x,y) = sigmayy(x,y) + dy / dt;
                    cpt(x,y) = cpt(x,y) + 1;  
                end
            end
        end
    end

    sigmaxx = sigmaxx ./ cpt;
    sigmayy = sigmayy ./ cpt;
    D = (sigmaxx + sigmayy)/4;
end