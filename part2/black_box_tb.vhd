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

ENTITY sequence_detector_tb IS
END sequence_detector_tb;

ARCHITECTURE behavior OF sequence_detector_tb IS

    SIGNAL clock           : STD_LOGIC := '0';
    SIGNAL reset           : STD_LOGIC := '0';
    SIGNAL data_in         : STD_LOGIC := '0';
    SIGNAL clk_btn         : STD_LOGIC := '0';
    SIGNAL sequence_detect_mealy:  STD_LOGIC := '0';
    SIGNAL led_mealy             : STD_LOGIC_VECTOR (2 DOWNTO 0) := (OTHERS => '0');
    SIGNAL data: STD_LOGIC := '0';
    
BEGIN
    
    uut_Mealy: entity work.black_box(Mealy) PORT MAP (
        clock           => clock,
        reset           => reset,
        data_in         => data_in,
        clk_btn         => clk_btn,
        seq_detected => sequence_detect_mealy,
        led             => led_mealy,
        data            =>data 
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
        WAIT FOR 50 ns;
        reset <= '0';
        led_mealy <= "000";
        WAIT FOR 50 ns;
    
        -- Input sequence
        while reset = '0'
        loop
            case led_mealy is
                when "000" => 
                    -- state = S0 ; input = 1
                    data_in <= '1';
                    WAIT FOR 50 ns;
                    assert(sequence_detect_mealy = '0')
                    report "Error"
                    severity ERROR;
                    -- next clock cycle, check state = S0
                    clk_btn <= '1';
                    WAIT FOR 50 ns;
                    clk_btn <= '0';
                    WAIT FOR 50 ns;
                    assert(led_mealy = "000") -- S0
                    report "Error"
                    severity ERROR;
                    led_mealy <= "000"; -- back to CURRENT state = S0
                    WAIT FOR 50 ns;
                    -- state = S0 ; input = 0
                    data_in <= '0';
                    WAIT FOR 50 ns;
                    assert(sequence_detect_mealy = '0')
                    report "Error"
                    severity ERROR;
                    -- next clock cycle, check state = S1
                    clk_btn <= '1';
                    WAIT FOR 50 ns;
                    clk_btn <= '0';
                    WAIT FOR 50 ns;
                    assert(led_mealy = "001") -- S1
                    report "Error"
                    severity ERROR;
                    led_mealy <= "001"; -- NEXT state = S1
                    WAIT FOR 50 ns;
                when "001" => 
                    -- state = S1 ; input = 1
                    data_in <= '1';
                    WAIT FOR 50 ns;
                    assert(sequence_detect_mealy = '0')
                    report "Error"
                    severity ERROR;
                    -- next clock cycle, check state = S3
                    clk_btn <= '1';
                    WAIT FOR 50 ns;
                    clk_btn <= '0';
                    WAIT FOR 50 ns;
                    assert(led_mealy = "011")
                    report "Error"
                    severity ERROR;
                    led_mealy <= "001"; -- back to CURRENT state
                    WAIT FOR 50 ns;
                    -- state = S1 ; input = 0
                    data_in <= '0';
                    WAIT FOR 50 ns;
                    assert(sequence_detect_mealy = '0')
                    report "Error"
                    severity ERROR;
                    -- next clock cycle, check state = S2
                    clk_btn <= '1';
                    WAIT FOR 50 ns;
                    clk_btn <= '0';
                    WAIT FOR 50 ns;
                    assert(led_mealy = "010")
                    report "Error"
                    severity ERROR;
                    led_mealy <= "010";
                    WAIT FOR 50 ns;
                when "010" => 
                    -- state = S2 ; input = 1
                    data_in <= '1';
                    WAIT FOR 50 ns;
                    assert(sequence_detect_mealy = '0')
                    report "Error"
                    severity ERROR;
                    -- next clock cycle, check state = S3
                    clk_btn <= '1';
                    WAIT FOR 50 ns;
                    clk_btn <= '0';
                    WAIT FOR 50 ns;
                    assert(led_mealy = "011")
                    report "Error"
                    severity ERROR;
                    led_mealy <= "010"; -- back to CURRENT state
                    WAIT FOR 50 ns;
                    -- state = S2 ; input = 0
                    data_in <= '0';
                    WAIT FOR 50 ns;
                    assert(sequence_detect_mealy = '0')
                    report "Error"
                    severity ERROR;
                    -- next clock cycle, check state = S4
                    clk_btn <= '1';
                    WAIT FOR 50 ns;
                    clk_btn <= '0';
                    WAIT FOR 50 ns;
                    assert(led_mealy = "100")
                    report "Error"
                    severity ERROR;
                    led_mealy <= "011";
                    WAIT FOR 50 ns;
                when "011" => 
                    -- state = S3 ; input = 1
                    data_in <= '1';
                    WAIT FOR 50 ns;
                    assert(sequence_detect_mealy = '0')
                    report "Error"
                    severity ERROR;
                    -- next clock cycle, check state = S0
                    clk_btn <= '1';
                    WAIT FOR 50 ns;
                    clk_btn <= '0';
                    WAIT FOR 50 ns;
                    assert(led_mealy = "000")
                    report "Error"
                    severity ERROR;
                    led_mealy <= "011"; -- back to CURRENT state
                    WAIT FOR 50 ns;
                    -- state = S3 ; input = 0
                    data_in <= '0';
                    WAIT FOR 50 ns;
                    assert(sequence_detect_mealy = '0')
                    report "Error"
                    severity ERROR;
                    -- next clock cycle, check state = S5
                    clk_btn <= '1';
                    WAIT FOR 50 ns;
                    clk_btn <= '0';
                    WAIT FOR 50 ns;
                    assert(led_mealy = "101")
                    report "Error"
                    severity ERROR;
                    led_mealy <= "100";
                    WAIT FOR 50 ns;
                when "100" => 
                    -- state = S4 ; input = 1
                    data_in <= '1';
                    WAIT FOR 50 ns;
                    assert(sequence_detect_mealy = '0')
                    report "Error"
                    severity ERROR;
                    -- next clock cycle, check state = S3
                    clk_btn <= '1';
                    WAIT FOR 50 ns;
                    clk_btn <= '0';
                    WAIT FOR 50 ns;
                    assert(led_mealy = "011")
                    report "Error"
                    severity ERROR;
                    led_mealy <= "100"; -- back to CURRENT state
                    WAIT FOR 50 ns;
                    -- state = S4 ; input = 0
                    data_in <= '0';
                    WAIT FOR 50 ns;
                    assert(sequence_detect_mealy = '0')
                    report "Error"
                    severity ERROR;
                    -- next clock cycle, check state = S6
                    clk_btn <= '1';
                    WAIT FOR 50 ns;
                    clk_btn <= '0';
                    WAIT FOR 50 ns;
                    assert(led_mealy = "110")
                    report "Error"
                    severity ERROR;
                    led_mealy <= "101";
                    WAIT FOR 50 ns;
                when "101" => 
                    -- state = S5 ; input = 1
                    data_in <= '1';
                    WAIT FOR 50 ns;
                    assert(sequence_detect_mealy = '0')
                    report "Error"
                    severity ERROR;
                    -- next clock cycle, check state = S3
                    clk_btn <= '1';
                    WAIT FOR 50 ns;
                    clk_btn <= '0';
                    WAIT FOR 50 ns;
                    assert(led_mealy = "011")
                    report "Error"
                    severity ERROR;
                    led_mealy <= "101"; -- back to CURRENT state
                    WAIT FOR 50 ns;
                    -- state = S5 ; input = 0
                    data_in <= '0';
                    WAIT FOR 50 ns;
                    assert(sequence_detect_mealy = '0')
                    report "Error"
                    severity ERROR;
                    -- next clock cycle, check state = S7
                    clk_btn <= '1';
                    WAIT FOR 50 ns;
                    clk_btn <= '0';
                    WAIT FOR 50 ns;
                    assert(led_mealy = "111")
                    report "Error"
                    severity ERROR;
                    led_mealy <= "110";
                    WAIT FOR 50 ns;
                when "110" => 
                    -- state = S6 ; input = 1
                    data_in <= '1';
                    WAIT FOR 50 ns;
                    assert(sequence_detect_mealy = '1')
                    report "Error"
                    severity ERROR;
                    -- next clock cycle, check state = S0
                    clk_btn <= '1';
                    WAIT FOR 50 ns;
                    clk_btn <= '0';
                    WAIT FOR 50 ns;
                    assert(led_mealy = "000")
                    report "Error"
                    severity ERROR;
                    led_mealy <= "110"; -- back to CURRENT state
                    WAIT FOR 50 ns;
                    -- state = S6 ; input = 0
                    data_in <= '0';
                    WAIT FOR 50 ns;
                    assert(sequence_detect_mealy = '0')
                    report "Error"
                    severity ERROR;
                    -- next clock cycle, check state = S6
                    clk_btn <= '1';
                    WAIT FOR 50 ns;
                    clk_btn <= '0';
                    WAIT FOR 50 ns;
                    assert(led_mealy = "110")
                    report "Error"
                    severity ERROR;
                    led_mealy <= "111";
                    WAIT FOR 50 ns;
                when "111" => 
                    -- state = S7 ; input = 1
                    data_in <= '1';
                    WAIT FOR 50 ns;
                    assert(sequence_detect_mealy = '1')
                    report "Error"
                    severity ERROR;
                    -- next clock cycle, check state = S0
                    clk_btn <= '1';
                    WAIT FOR 50 ns;
                    clk_btn <= '0';
                    WAIT FOR 50 ns;
                    assert(led_mealy = "000")
                    report "Error"
                    severity ERROR;
                    led_mealy <= "111"; -- back to CURRENT state
                    WAIT FOR 50 ns;
                    -- state = S7 ; input = 0
                    data_in <= '0';
                    WAIT FOR 50 ns;
                    assert(sequence_detect_mealy = '0')
                    report "Error"
                    severity ERROR;
                    -- next clock cycle, check state = S4
                    clk_btn <= '1';
                    WAIT FOR 50 ns;
                    clk_btn <= '0';
                    WAIT FOR 50 ns;
                    assert(led_mealy = "100")
                    report "Error"
                    severity ERROR;
                    reset <= '1';
                    WAIT FOR 50 ns;
                when others =>
                    reset <='1';               
            end case;
        end loop;
        
    END PROCESS;

END behavior;
