-- -------------------------------------------------------------
-- 
-- File Name: foc_hdl_prj_v3\hdlsrc\FOC_Modified_v3\Sine_Cosine.vhd
-- Created: 2017-11-28 19:11:02
-- 
-- Generated by MATLAB 9.1 and HDL Coder 3.9
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Sine_Cosine
-- Source Path: FOC_Modified_v3/Sine_Cosine
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Sine_Cosine IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        P                                 :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
        Sin                               :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        Cos                               :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
        );
END Sine_Cosine;


ARCHITECTURE rtl OF Sine_Cosine IS

  -- Component Declarations
  COMPONENT Sine_Cosine_LUT
    PORT( u                               :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En30
          sin_2_pi_u                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          cos_2_pi_u                      :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Sine_Cosine_LUT
    USE ENTITY work.Sine_Cosine_LUT(rtl);

  -- Signals
  SIGNAL P_signed                         : signed(15 DOWNTO 0);  -- sfix16_En12
  SIGNAL P_1                              : signed(15 DOWNTO 0);  -- sfix16_En12
  SIGNAL Normalize_Position_mul_temp      : signed(31 DOWNTO 0);  -- sfix32_En29
  SIGNAL Normalize_Position_out1          : signed(31 DOWNTO 0);  -- sfix32_En30
  SIGNAL Normalize_Position_out1_1        : signed(31 DOWNTO 0);  -- sfix32_En30
  SIGNAL Sine_Cosine_LUT_out1             : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Sine_Cosine_LUT_out2             : std_logic_vector(15 DOWNTO 0);  -- ufix16

BEGIN
  -- Sine Cosine Fixed Point LUT

  -- <S6>/Sine_Cosine_LUT
  u_Sine_Cosine_LUT : Sine_Cosine_LUT
    PORT MAP( u => std_logic_vector(Normalize_Position_out1_1),  -- sfix32_En30
              sin_2_pi_u => Sine_Cosine_LUT_out1,  -- sfix16_En14
              cos_2_pi_u => Sine_Cosine_LUT_out2  -- sfix16_En14
              );

  P_signed <= signed(P);

  HwModeRegister_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '0' THEN
        P_1 <= to_signed(16#0000#, 16);
      ELSIF enb = '1' THEN
        P_1 <= P_signed;
      END IF;
    END IF;
  END PROCESS HwModeRegister_process;


  -- <S6>/Normalize_Position
  Normalize_Position_mul_temp <= to_signed(16#517D#, 16) * P_1;
  Normalize_Position_out1 <= Normalize_Position_mul_temp(30 DOWNTO 0) & '0';

  PipelineRegister_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '0' THEN
        Normalize_Position_out1_1 <= to_signed(0, 32);
      ELSIF enb = '1' THEN
        Normalize_Position_out1_1 <= Normalize_Position_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  Sin <= Sine_Cosine_LUT_out1;

  Cos <= Sine_Cosine_LUT_out2;

END rtl;

