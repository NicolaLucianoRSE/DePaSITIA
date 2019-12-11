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
! Program unit: sedimentation                                
! Description: assessment of the absolute value of the sedimentation deposition 
!              velocity
!-------------------------------------------------------------------------------
subroutine sedimentation(u_set_absv,leaf_ratio_k_z,u_Sed_absv)
!------------------------
! Modules
!------------------------
!------------------------
! Declarations
!------------------------
implicit none
! Settling velocity (absolute value)
real, intent(in) :: u_set_absv
! Ratio between the projection of the leaf surface on the horizontal and the 
! leaf surface
real, intent(in) :: leaf_ratio_k_z
! Sedimentation deposition velocity (absolute value)
real, intent(out) :: u_Sed_absv
!------------------------
! Explicit interfaces
!------------------------
!------------------------
! Allocations
!------------------------
!------------------------
! Initializations
!------------------------
!------------------------
! Statements
!------------------------
u_Sed_absv = u_set_absv * leaf_ratio_k_z
!------------------------
! Deallocations
!------------------------
return
end subroutine sedimentation
