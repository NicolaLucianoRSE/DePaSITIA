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
! Program unit: interception                                 
! Description: assessment of the absolute value of the interception deposition 
!              velocity
!-------------------------------------------------------------------------------
subroutine interception(d_50,d_v_leaf_diameter,mean_velocity_absv,             &
                        leaf_ratio_k_x,u_Int_absv)
!------------------------
! Modules
!------------------------
!------------------------
! Declarations
!------------------------
implicit none
! 50-th percentile of the Particulate Matter granulometric curve
real, intent(in) :: d_50
! Roughness width of the deposition interface
real, intent(in) :: d_v_leaf_diameter
! Absolute value of the mean velocity
real, intent(in) :: mean_velocity_absv
! Ratio between the projection of the leaf surface on the plane normal to the 
! mean flow direction and the leaf surface
real, intent(in) :: leaf_ratio_k_x
! Interception deposition velocity (absolute value)
real, intent(out) :: u_Int_absv
! Interception efficiency
double precision :: E_Int
!------------------------
! Explicit interfaces
!------------------------
!------------------------
! Allocations
!------------------------
!------------------------
! Initializations
!------------------------
E_Int = 0.d0
!------------------------
! Statements
!------------------------
if (d_v_leaf_diameter>1.e-10) then
   E_Int = 2.d0 * d_50 / d_v_leaf_diameter
   u_Int_absv = mean_velocity_absv * leaf_ratio_k_x * E_Int
   else
      u_Int_absv = 1000.
endif
!------------------------
! Deallocations
!------------------------
return
end subroutine interception
