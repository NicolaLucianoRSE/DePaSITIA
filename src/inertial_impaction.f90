!-------------------------------------------------------------------------------
! "DePaSITIA v.1.0" (RSE SpA) is a Fortran library, which represents a 
! Deposition scheme for Particulate matter with Sedimentation, Inertial 
! impaction, Turbulent impaction, Interception and Adhesion/bouncing 
! (pollutant dispersion).
! DePaSITIA v.1.0 Copyright 2019 (RSE SpA)
! The authors and email contact of DePaSITIA v.1.0 are provided on the 
! documentation file.
!-------------------------------------------------------------------------------
! This file is part of DePaSITIA v.1.0.
! DePaSITIA v.1.0 is free software: you can redistribute it and/or 
! modify it under the terms of the GNU Lesser General Public License as 
! published by the Free Software Foundation, either version 3 of the 
! License, or (at your option) any later version.
! This library is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
! GNU Lesser General Public License for more details.
! You should have received a copy of the GNU Lesser General Public 
! License along with this library. If not, see 
! <http://www.gnu.org/licenses/>.
!-------------------------------------------------------------------------------
!-------------------------------------------------------------------------------
! Program unit: inertial_impaction                                
! Description: assessment of the absolute value of the inertial impaction 
!              deposition velocity
!-------------------------------------------------------------------------------
subroutine inertial_impaction(St_Stokes_number,mean_velocity_absv,             &
                              leaf_ratio_k_x,u_Ii_absv)
!------------------------
! Modules
!------------------------
!------------------------
! Declarations
!------------------------
implicit none
real, intent(in) :: St_Stokes_number
! Absolute value of the mean velocity
real, intent(in) :: mean_velocity_absv
! Ratio between the projection of the leaf surface on the plane normal to the 
! mean flow direction and the leaf surface
real, intent(in) :: leaf_ratio_k_x
! Inertial impaction deposition velocity (absolute value)
real, intent(out) :: u_Ii_absv
! inertial impaction efficiency
double precision :: E_Ii
double precision :: beta
!------------------------
! Explicit interfaces
!------------------------
!------------------------
! Allocations
!------------------------
!------------------------
! Initializations
!------------------------
beta = 0.7d0
E_Ii = 0.d0
!------------------------
! Statements
!------------------------
E_Ii = (St_Stokes_number / (St_Stokes_number + beta) ) ** 2
u_Ii_absv = mean_velocity_absv * leaf_ratio_k_x * E_Ii
!------------------------
! Deallocations
!------------------------
return
end subroutine inertial_impaction
