function show_map(m, gx, gy)    
    r = gx(2) - gx(1);

    m = m(floor(single((gx-gx(1))/ r)) + 1, floor(single((gy-gy(1)) / r)) + 1);
    
    cm = jet;
    cm(1,:) = [1, 1, 1];
    colormap(cm);

    imagesc(m', 'XData', [gx(1), gx(end)], 'YData', [gy(1), gy(end)]);
    set(gca,'YDir','normal')
end