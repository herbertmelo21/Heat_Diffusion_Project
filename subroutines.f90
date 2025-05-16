module Diffusion
    
    contains
    
    
    subroutine Input_plate(grid_size, n_time, special_constant)
        implicit none
        integer(4) :: grid_size, n_time
        real(8) :: special_constant
        read(100,*)!----------------
        read(100,*)!*******INPUT*******
        read(100,*)!----------------
        read(100,*)!grid_size (N):
        read(100,*)!----------------
        read(100,*)grid_size
        read(100,*)!----------------
        read(100,*)!n_time (number of time steps):
        read(100,*)!----------------
        read(100,*)n_time
        read(100,*)!----------------
        read(100,*)!special_constant alpha*Deltat / Deltax^2 = 0.2
        read(100,*)!----------------
        read(100,*)special_constant    
    end subroutine
    
    
    
    
end module 