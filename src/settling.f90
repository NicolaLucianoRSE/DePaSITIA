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
! Program unit: settling                                
! Description: assessment of the absolute value of the settling velocity
!-------------------------------------------------------------------------------
subroutine settling(rho_PM,d_50,u_set_absv)
!------------------------
! Modules
!------------------------
!------------------------
! Declarations
!------------------------
implicit none
! 50-th percentile of the Particulate Matter granulometric curve
real, intent(in) :: d_50
! Density of the Particulate Matter
real, intent(in) :: rho_PM
! Settling velocity
real, intent(out) :: u_set_absv
! Molecular mass of the transporting fluid (approximation: dry air)
double precision :: molecular_mass_f
! Cunningham's correction factor
double precision :: C_C
double precision :: PI_GRECO
! Mean free path of the transporting fluid particles
double precision :: lambda_f
! Boltzmann's constant
double precision :: k_Boltzmann
! Absolute value of the gravitational acceleration
double precision :: gravity_acc_absv
! Dynamic viscosity of the transporting fluid (approximation: air at 
! ambient conditions)
double precision :: dynamic_viscosity
! Density of the transporting fluid: air at ambient conditions (approximation)
double precision :: rho_f
! Temperature (K) (approximation: ambient conditions)
double precision :: T_amb
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
k_Boltzmann = 1.380649d-23
PI_GRECO = 3.1415926d0
dynamic_viscosity = 1.81d-5
molecular_mass_f = 4.82d-26
rho_f = 1.20d0
T_amb = 293.d0
!------------------------
! Statements
!------------------------
lambda_f = dynamic_viscosity / rho_f * sqrt((PI_GRECO * molecular_mass_f) /    &
         (2.d0 * k_Boltzmann * T_amb))
if (lambda_f<1.d-15) then
   write(0,*) 'Program unit "settling.f90": the mean free path of the ',       &
              'particles of the transporting fluid is too small: "lambda_f"=', &
              d_50,"m. The simulation stops here. "
   stop
endif
if (d_50<1.e-12) then
   write(0,*) 'Program unit "settling.f90": the 50th percentile of the ',      &
              'granulometric curve of the Particulate Matter is too small: ',  &
              '"d_50"=',d_50,'m. The simulation stops here. '
   stop
endif
C_C = 1.d0 + 2.d0 * lambda_f / d_50 * (1.257d0 + 0.4d0 * exp(-1.1d0 * d_50 /   &
      (2.d0 * lambda_f)))
u_set_absv = gravity_acc_absv * rho_PM * C_C * (d_50 ** 2) / (18.d0 *          &
             dynamic_viscosity)
!------------------------
! Deallocations
!------------------------
return
end subroutine settling
