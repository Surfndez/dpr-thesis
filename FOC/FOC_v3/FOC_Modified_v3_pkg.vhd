-- -------------------------------------------------------------
-- 
-- File Name: foc_hdl_prj_v3\hdlsrc\FOC_Modified_v3\FOC_Modified_v3_pkg.vhd
-- Created: 2017-11-28 19:11:02
-- 
-- Generated by MATLAB 9.1 and HDL Coder 3.9
-- 
-- -------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

PACKAGE FOC_Modified_v3_pkg IS
  TYPE vector_of_signed16 IS ARRAY (NATURAL RANGE <>) OF signed(15 DOWNTO 0);
  TYPE vector_of_signed32 IS ARRAY (NATURAL RANGE <>) OF signed(31 DOWNTO 0);
  TYPE vector_of_signed18 IS ARRAY (NATURAL RANGE <>) OF signed(17 DOWNTO 0);
  TYPE vector_of_signed17 IS ARRAY (NATURAL RANGE <>) OF signed(16 DOWNTO 0);
  TYPE vector_of_signed33 IS ARRAY (NATURAL RANGE <>) OF signed(32 DOWNTO 0);
END FOC_Modified_v3_pkg;

