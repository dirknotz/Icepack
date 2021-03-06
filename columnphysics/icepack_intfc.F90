!=========================================================================
!
! flags and interface routines for the column package
!
! authors: Elizabeth C. Hunke, LANL

      module icepack_intfc

      use icepack_kinds, only: icepack_char_len  => char_len
      use icepack_kinds, only: icepack_char_len_long  => char_len_long
      use icepack_kinds, only: icepack_log_kind  => log_kind
      use icepack_kinds, only: icepack_int_kind  => int_kind
      use icepack_kinds, only: icepack_int8_kind => int8_kind
      use icepack_kinds, only: icepack_real_kind => real_kind
      use icepack_kinds, only: icepack_dbl_kind  => dbl_kind
      use icepack_kinds, only: icepack_r16_kind  => r16_kind

      use icepack_tracers,   only: icepack_max_nbtrcr => max_nbtrcr
      use icepack_tracers,   only: icepack_max_algae  => max_algae
      use icepack_tracers,   only: icepack_max_dic    => max_dic
      use icepack_tracers,   only: icepack_max_doc    => max_doc
      use icepack_tracers,   only: icepack_max_don    => max_don
      use icepack_tracers,   only: icepack_max_fe     => max_fe
      use icepack_tracers,   only: icepack_max_aero   => max_aero
      use icepack_tracers,   only: icepack_nmodal1    => nmodal1
      use icepack_tracers,   only: icepack_nmodal2    => nmodal2
      use icepack_parameters, only: icepack_nspint    => nspint

      use icepack_parameters, only: icepack_init_parameters
      use icepack_parameters, only: icepack_query_parameters
      use icepack_parameters, only: icepack_write_parameters
      use icepack_parameters, only: icepack_recompute_constants
      use icepack_parameters, only: nspint, secday, spval_const
      use icepack_parameters, only: c0, c1, c1p5, c2, c3, c4, c5, c6, c8
      use icepack_parameters, only: c10, c15, c16, c20, c25, c100, c1000
      use icepack_parameters, only: p001, p01, p1, p2, p4, p5, p6, p05
      use icepack_parameters, only: p15, p25, p75, p333, p666

      use icepack_tracers, only: icepack_compute_tracers
      use icepack_tracers, only: icepack_query_tracer_sizes
      use icepack_tracers, only: icepack_write_tracer_sizes
      use icepack_tracers, only: icepack_init_tracer_flags
      use icepack_tracers, only: icepack_query_tracer_flags
      use icepack_tracers, only: icepack_write_tracer_flags
      use icepack_tracers, only: icepack_init_tracer_indices
      use icepack_tracers, only: icepack_query_tracer_indices
      use icepack_tracers, only: icepack_write_tracer_indices
      use icepack_tracers, only: icepack_init_tracer_numbers
      use icepack_tracers, only: icepack_query_tracer_numbers
      use icepack_tracers, only: icepack_write_tracer_numbers

      use icepack_itd, only: icepack_init_itd
      use icepack_itd, only: icepack_init_itd_hist
      use icepack_itd, only: icepack_aggregate

      use icepack_mechred, only: icepack_step_ridge
      use icepack_mechred, only: icepack_ice_strength

      use icepack_shortwave, only: icepack_prep_radiation
      use icepack_shortwave, only: icepack_step_radiation

      use icepack_brine, only: icepack_init_hbrine
      use icepack_brine, only: icepack_init_zsalinity

      use icepack_zbgc , only: icepack_init_bgc
      use icepack_zbgc , only: icepack_init_zbgc
      use icepack_zbgc , only: icepack_biogeochemistry
      use icepack_zbgc , only: icepack_init_OceanConcArray
      use icepack_zbgc , only: icepack_init_ocean_conc

      use icepack_atmo , only: icepack_atm_boundary
      use icepack_ocean, only: icepack_ocn_mixed_layer

      use icepack_orbital       , only: icepack_init_orbit
      use icepack_orbital       , only: icepack_query_orbit

      use icepack_therm_vertical, only: icepack_step_therm1
      use icepack_therm_itd     , only: icepack_step_therm2
      use icepack_therm_shared  , only: icepack_ice_temperature
      use icepack_therm_shared  , only: icepack_snow_temperature
      use icepack_therm_shared  , only: icepack_liquidus_temperature
      use icepack_therm_shared  , only: icepack_sea_freezing_temperature
      use icepack_therm_shared  , only: icepack_enthalpy_snow
      use icepack_therm_shared  , only: icepack_init_thermo
      use icepack_therm_shared  , only: icepack_init_trcr

      use icepack_warnings, only: icepack_warnings_clear
      use icepack_warnings, only: icepack_warnings_print
      use icepack_warnings, only: icepack_warnings_flush
      use icepack_warnings, only: icepack_warnings_aborted

      implicit none

      public 

      public :: icepack_configure

!=======================================================================
      contains
!=======================================================================

      ! This subroutine should be called before any part of columnphysics
      ! is used.

      subroutine icepack_configure()

      use icepack_warnings, only: warnstr, icepack_warnings_add
      use icepack_warnings, only: icepack_warnings_setabort, icepack_warnings_aborted

      character(len=*),parameter :: subname='(icepack_configure)'

        call icepack_warnings_setabort(.false.,__FILE__,__LINE__)
        call icepack_recompute_constants()
        if (icepack_warnings_aborted(subname)) return

      end subroutine icepack_configure

!=======================================================================

      end module icepack_intfc

!=======================================================================
