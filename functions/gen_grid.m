function grid = gen_grid(tab, r)
    Xmax=max(tab(:,3));
    Ymax=max(tab(:,4));
    
    Nx=ceil(Xmax/r)+1;
    Ny=ceil(Ymax/r)+1;
    Nx=max(Nx,Ny);
    
    grid = (0:1:Nx) .* r;
end