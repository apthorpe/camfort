subroutine bar(X)
    integer :: x
    integer :: i
    integer :: j
    real A(0:x), B(0:x), c

    common i, j

    c = 0.1

    do i = 0, x
       A(i) = i
    end do

    do i = 0, x
       A(i) = i
       A(i-1) = i
    end do

    if (i .EQ. 0) then
      i = 0
    else
      i = 1
    end if

    do i = 1, x
       print '(i8, A, f0.7)', i, " ", A(i)
    enddo

    do i = 1, x
      c = c + 0.1
      j = j + 1
      A(i) = j
      B(i) = A(i+1)
      print '(f0.7)', A(i+2)

    end do

    j = j + 1
    print '(f0.7)', c

end subroutine
