! Numerical solution of the 2D heat diffusion equation
! over time
! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
! Author: Herbert Melo
program Heat_Diffusion_OMP
    use Diffusion
    use omp_lib
    implicit none

    integer(4) :: grid_size, n_time, center_point
    integer(4) :: i, j, istep
    real(8)    :: special_constant
    real(8), allocatable :: temperature(:,:,:)

    open(unit=100, file='./input/input.txt', form='formatted')
    open(unit=200, file='./output/output.csv', form='formatted')
    call Input_plate(grid_size, n_time, special_constant)
    allocate(temperature(grid_size, grid_size, n_time+1))

    ! Initial condition
    temperature = 0.d0
    center_point = grid_size/2 + 1
    do i = 1, 3
        do j = 1, 3
            temperature(center_point+i-2, center_point+j-2, 1) = 100.d0
        end do
    end do

    ! Optionally set threads at runtime
    call omp_set_num_threads(8)

    do istep = 1, n_time
        !— Boundary (parallel) —!
        !$omp parallel do default(shared) private(i)
        do i = 1, grid_size
            temperature(1,        i, istep) = 30.d0
            temperature(grid_size, i, istep) = 30.d0
            temperature(i,        1, istep) = 30.d0
            temperature(i,        grid_size, istep) = 30.d0
        end do
        !$omp end parallel do

        !— Interior update (parallel, collapse two loops) —!
        !$omp parallel do collapse(2) default(shared) private(i,j)
        do i = 2, grid_size-1
            do j = 2, grid_size-1
                temperature(i,j,istep+1) = temperature(i,j,istep) + &
                     special_constant * ( &
                        temperature(i+1,j,istep) + temperature(i-1,j,istep) + &
                        temperature(i,j+1,istep) + temperature(i,j-1,istep) - &
                        4.d0 * temperature(i,j,istep) )
            end do
        end do
        !$omp end parallel do

        !— Output (serial) —!
        do i = 1, grid_size
            do j = 1, grid_size
                write(200,'(I0,",",I0,",",F12.6,",",I0)') i, j, &
                    temperature(i,j,istep), istep
            end do
        end do
    end do

    close(100)
    close(200)
end program Heat_Diffusion_OMP

    
