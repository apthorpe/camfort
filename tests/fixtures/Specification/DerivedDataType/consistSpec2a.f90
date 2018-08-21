program consistSpec2
  integer, parameter :: x = 1
  integer, parameter :: y = 2
  integer, parameter :: z = 3

  != ddt consist2(1=>label1, 2=>label2, 3=>label3) :: d(dim=2)
  real, dimension(3,4) :: d, e
  real :: sum
  integer :: i
  common /consist2/ d
  do i=1,3
     sum = d(i,x) + d(i,y) + d(i,z)
  end do
end program
