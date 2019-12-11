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
! Program unit: Stokes_number                                 
! Description: assessment of Stokes number
!-------------------------------------------------------------------------------
subroutine Stokes_number(d_v_leaf_diameter,mean_velocity_absv,u_set_absv,      &
                         St_Stokes_number)
!------------------------
! Modules
!------------------------
!------------------------
! Declarations
!------------------------
implicit none
! Roughness width of the deposition interface
real, intent(in) :: d_v_leaf_diameter
! Absolute value of the mean velocity
real, intent(in) :: mean_velocity_absv
! Absolute value of the settling velocity
real, intent(in) :: u_set_absv
real, intent(out) :: St_Stokes_number
! Absolute value of the gravitational acceleration
double precision :: gravity_acc_absv
! Relaxation time of a particle in a fluid flow
double precision :: tau_p
! Time scale of a fluid flow over an obstacle
double precision :: tau_0
!------------------------
! Explicit interfaces
!------------------------
!------------------------
! Allocations
!------------------------
!------------------------
! Initializations
!------------------------
gravity_acc_absv = 9.806d0
tau_p = 0.d0
tau_0 = 0.d0
!------------------------
! Statements
!------------------------
tau_p = u_set_absv / gravity_acc_absv
if (mean_velocity_absv>1.d-6) then
   tau_0 = d_v_leaf_diameter / mean_velocity_absv
   if (tau_0>1.d-16) then
      St_Stokes_number = tau_p / tau_0
      else
         St_Stokes_number = 1.d9
   endif
   else
      St_Stokes_number = 0.d0      
endif
!------------------------
! Deallocations
!------------------------
return
end subroutine Stokes_number
