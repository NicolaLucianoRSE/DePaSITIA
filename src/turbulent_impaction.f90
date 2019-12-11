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
! Program unit: turbulent_impaction                               
! Description: assessment of the absolute value of the turbulent impaction 
!              deposition velocity
!-------------------------------------------------------------------------------
subroutine turbulent_impaction(u_star,u_set_absv,u_TI_absv)
!------------------------
! Modules
!------------------------
!------------------------
! Declarations
!------------------------
implicit none
! Friction velocity (at ground level) 
real, intent(in) :: u_star
! Settling velocity (absolute value)
real, intent(in) :: u_set_absv
! Turbulent impaction deposition velocity (absolute value)
real, intent(out) :: u_TI_absv
! Particle relaxation time
double precision :: tau_p
! Turbulent Stokes number 
double precision :: tau_p_plus
! Turbulent impaction deposition efficiency
double precision :: E_TI
double precision :: K_TI_1,K_TI_2
! Absolute value of the gravitational acceleration
double precision :: gravity_acc_absv
! Dynamic viscosity of the transporting fluid (approximation: air at 
! ambient conditions)
double precision :: dynamic_viscosity
! Density of the transporting fluid: air at ambient conditions (approximation)
double precision :: rho_f
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
dynamic_viscosity = 1.81d-5
rho_f = 1.20d0
K_TI_1 = 3.5d-4
K_TI_2 = 0.18d0
E_TI = 0.d0
!------------------------
! Statements
!------------------------
tau_p = u_set_absv / gravity_acc_absv
tau_p_plus = tau_p * (u_star ** 2) * rho_f / dynamic_viscosity
if (tau_p_plus<20.d0) then
   E_TI = K_TI_1 * (tau_p_plus ** 2)
   else
      E_TI = K_TI_2
endif 
u_TI_absv = u_star * E_TI
!------------------------
! Deallocations
!------------------------
return
end subroutine turbulent_impaction
