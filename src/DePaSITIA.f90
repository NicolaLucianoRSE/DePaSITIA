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
! Program unit: DePaSITIA
! Description: Deposition scheme for Particulate matter with Sedimentation, 
!              Inertial impaction, Turbulent impaction, Interception and 
!              Adhesion/bouncing
!-------------------------------------------------------------------------------
subroutine DePaSITIA(mean_velocity_absv,u_star,d_50,rho_PM,leaf_ratio_k_z,     &
                     leaf_ratio_k_x,d_v_leaf_diameter,DePaSITIA_vel)
!------------------------
! Modules
!------------------------
!------------------------
! Declarations
!------------------------
implicit none
! Absolute value of the mean velocity
real, intent(in) :: mean_velocity_absv
! Friction velocity (at ground level)
real, intent(in) :: u_star
! 50-th percentile of the Particulate Matter granulometric curve
real, intent(in) :: d_50
! Density of the Particulate Matter
real, intent(in) :: rho_PM
! Ratio between the projection of the leaf area on the horizontal and the 
! total leaf area
real, intent(in) :: leaf_ratio_k_z
! Ratio between the projection of the leaf area on the plane normal to the 
! mean flow direction and the total leaf area
real, intent(in) :: leaf_ratio_k_x
! Roughness width of the deposition interface
real, intent(in) :: d_v_leaf_diameter
! Deposition velocity (absolute value) estimated by DePaSITIA
real, intent(out) :: DePaSITIA_vel
! Settling velocity
real :: u_set_absv
real :: St_Stokes_number
! Sedimentation deposition velocity (absolute value)
real :: u_Sed_absv
! Inertial impaction deposition velocity (absolute value)
real :: u_Ii_absv
! Turbulent impaction deposition velocity (absolute value)
real :: u_Ti_absv
! Interception deposition velocity (absolute value)
real :: u_Int_absv
real :: Adhesion_coefficient
!------------------------
! Explicit interfaces
!------------------------
!------------------------
! Allocations
!------------------------
!------------------------
! Initializations
!------------------------
u_set_absv = 0.
St_Stokes_number = 0.
u_Sed_absv = 0.
u_Ii_absv = 0.
u_Ti_absv = 0.
u_Int_absv = 0.
Adhesion_coefficient = 0.
!------------------------
! Statements
!------------------------
! Settling (included the particle relaxation time) is introduced for 
! sedimentation and turbulent impaction (boundary terms), but not for the 
! settling inner term in the pollutant mass balance equations
call settling(rho_PM,d_50,u_set_absv)
call sedimentation(u_set_absv,leaf_ratio_k_z,u_Sed_absv)
! Stokes number influences both inertial impaction and adhesion
call Stokes_number(d_v_leaf_diameter,mean_velocity_absv,u_set_absv,            &
                   St_Stokes_number)
call inertial_impaction(St_Stokes_number,mean_velocity_absv,leaf_ratio_k_x,    &
                        u_Ii_absv)
call turbulent_impaction(u_star,u_set_absv,u_TI_absv)
call interception(d_50,d_v_leaf_diameter,mean_velocity_absv,leaf_ratio_k_x,    &
                  u_Int_absv)
call adhesion(St_Stokes_number,Adhesion_coefficient)
DePaSITIA_vel = (u_Sed_absv + u_Ii_absv + u_Ti_absv + u_Int_absv) *            &
                Adhesion_coefficient
!------------------------
! Deallocations
!------------------------
return
end subroutine DePaSITIA
