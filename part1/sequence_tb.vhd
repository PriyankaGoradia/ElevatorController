----------------------------------------------------------------------------------
-- Filename : example_tb.vhdl
-- Author : Antonio Alejandro Andara Lara and Priyanka Goradia
-- Date : 06-Oct-2023
-- Design Name: example sequence detector
-- Module Name: VHDL_essentials
-- Project Name: VHDL_essentials
-- Description : In this file we implement a simple testbench for a
-- sequence detector FSM
-- Additional Comments:
-- Copyright : University of Alberta, 2023
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

ENTITY sequence_detector_tb IS
END sequence_detector_tb;

ARCHITECTURE behavior OF sequence_detector_tb IS

    SIGNAL clock           : STD_LOGIC := '0';
    SIGNAL reset           : STD_LOGIC := '0';
    SIGNAL data_in         : STD_LOGIC := '0';
    SIGNAL clk_btn         : STD_LOGIC := '0';
    SIGNAL sequence_detect_mealy : STD_LOGIC_VECTOR (2 DOWNTO 0) := (OTHERS => '0');
    SIGNAL led_mealy             : STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '0');
    
BEGIN
    
    uut_Mealy: entity work.sequence_detector(Mealy) PORT MAP (
        clock           => clock,
        reset           => reset,
        data_in         => data_in,
        clk_btn         => clk_btn,
        sequence_detect => sequence_detect_mealy,
        led             => led_mealy
    );

    clock_process : PROCESS
    BEGIN
        clock <= '0';
        WAIT FOR 1 ns;
        clock <= '1';
        WAIT FOR 1 ns;
    END PROCESS;
    
    stimulus_process : PROCESS
    BEGIN
        
        -- System reset
        reset <= '1';
        WAIT FOR 10 ns;
        reset <= '0';
        WAIT FOR 10 ns;
        
        
        data_in <= '1'; --A to A 
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns;
   
        data_in <= '0'; -- A to B
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns;
        
        data_in <= '1'; -- B to B
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns;
        
        data_in <= '0'; -- B to C
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns;
        
        data_in <= '0'; -- C to D
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns;

        data_in <= '0'; -- D to F
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns;
        
        data_in <= '0'; -- F to F
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns;  
        
        data_in <= '1'; -- F to E
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns;  
        
        data_in <= '0'; -- E to H
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns;
        
        data_in <= '1'; -- H to C
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns; 
        
        data_in <= '1'; -- C to E
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns;
        
        data_in <= '1'; -- E to I
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns;   
        
        data_in <= '1'; -- I to A
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns; 
        
        data_in <= '0'; -- A to B
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns;  
        
        data_in <= '0'; -- F to E
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns;    
        
        data_in <= '1'; -- F to E
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns; 
        
        data_in <= '0'; -- F to E
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns; 
        
        data_in <= '1'; -- F to E
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns; 
        
        data_in <= '0'; -- F to E
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns;
        
        data_in <= '0'; -- F to E
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns; 
        
        data_in <= '0'; -- F to E
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns; 
        
        data_in <= '1'; -- F to E
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns; 
        
        data_in <= '0'; -- F to E
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns;
        
        data_in <= '0'; -- F to E
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns; 
        
        data_in <= '0'; -- F to E
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns; 
        
        data_in <= '0'; -- F to E
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns; 
        
        data_in <= '1'; -- F to E
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns;
        
        data_in <= '1'; -- F to E
        WAIT FOR 10 ns;
        clk_btn <='1';
        WAIT FOR 10 ns;
        clk_btn <='0';
        WAIT FOR 10 ns;  
        
        WAIT;
        
    END PROCESS;

END behavior;
