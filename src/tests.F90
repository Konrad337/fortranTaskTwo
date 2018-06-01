module gauss_test
    use gauss
    use fruit

    implicit none
    !private
    integer(kind=4)            :: size = 3, i
    real(kind=8), dimension(9) :: test_array_1 = (/ 1.0, 0.0, 0.0, 3.0, 10.0, 5.0, 0.0, 0.0, 10.0 /)
    real(kind=8), dimension(3) :: correct_output = (/ 7.0, -3.6, 7.0/)
    real(kind=8), dimension(3) :: output_test_array


contains
    subroutine gauss_elimination_test
        call gauss_elimination(test_array_1, output_test_array, 3)
        do i = 1,size
            call assert_equals(output_test_array(i), correct_output(i))
        end do
    end subroutine

end module gauss_test


module matrice_ops_test
    use matrice_ops
    use fruit

    implicit none
    integer(kind=4)                                          :: size = 10
    real(kind=8)                                             :: P1 = 1.3, P2 = 1.0, P3 = 0.7
    real(kind=8), dimension(10,10)                           :: matrice
    integer(kind=4)                                          :: i, j

contains
    subroutine fill_matrice_test
        call fill_matrice(P1, P2, P3, size, matrice)
        do i = 2,size
            call assert_equals(P1, matrice(i-1,i))
            call assert_equals(P2, matrice(i,i))
            call assert_equals(P3, matrice(i,i-1))
        end do
        call assert_equals(P2, matrice(1,1))
    end subroutine


end module matrice_ops_test


PROGRAM tests
    use fruit
    use gauss_test
    use matrice_ops_test
    call init_fruit
    call gauss_elimination_test
    call fill_matrice_test
    call fruit_summary

END PROGRAM tests
