#if !defined(_KIND)
#define _KIND 8
#endif


module matrice_ops

    implicit none

contains

    subroutine fill_matrice(P1, P2, P3, size, matrice)

        implicit none
        integer(kind=4), intent(IN)                                  :: size
        real(kind=_KIND),    intent(IN)                              :: P1, P2, P3
        real(kind=_KIND),    intent(INOUT)                           :: matrice(size, size)
        integer(kind=4)                                              :: i

        do i=2,size
            matrice(i-1, i) = P1
            matrice(i, i) = P2
            matrice(i, i-1) = P3
        end do
        matrice(1,1) = P2





    end subroutine


end module
