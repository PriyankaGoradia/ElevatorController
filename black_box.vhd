----------------------------------------------------------------------------------
-- Filename : example.vhdl
-- Author : Antonio Alejandro Andara Lara and Priyanka Goradia
-- Date : 06-Oct-2023
-- Design Name: example sequence detector
-- Module Name: VHDL_essentials
-- Project Name: VHDL_essentials
-- Description : In this file we implement a simple sequence detector in both
-- Mealy and Moore styles
-- Additional Comments:
-- Copyright : University of Alberta, 2023
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY black_box IS
    PORT (
        clock           : IN STD_LOGIC;
        reset           : IN STD_LOGIC;
        data_in         : IN STD_LOGIC;
        clk_btn         : IN STD_LOGIC;
        data            : OUT STD_LOGIC;
        led             : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        seq_detected    : OUT STD_LOGIC
        );
        
END black_box;

architecture Mealy OF black_box is

--    CONSTANT ticks : INTEGER := 6250000; -- for implementation
    CONSTANT ticks : INTEGER   := 2; -- for simulation
    SIGNAL clk_div : STD_LOGIC := '0';
    SIGNAL flag    : STD_LOGIC := '0';
    SIGNAL divider : INTEGER   := 0;
    TYPE states IS (S0, S1, S2, S3, S4, S5, S6, S7); -- state declared as a new type
    SIGNAL state : states := S0;
    SIGNAL next_state : states := S1; 

begin

    clock_divider : PROCESS (clock) IS
    BEGIN
        IF rising_edge(clock) THEN

            IF divider < ticks THEN
                divider <= divider + 1;
            ELSE
                divider <= 0;
                clk_div <= NOT clk_div;
            END IF;
        END IF;
    END PROCESS;

    manual_clock : PROCESS (clk_div, reset) IS
    BEGIN
        IF rising_edge(clk_div) THEN
            IF clk_btn = '1' AND flag = '0' THEN
                state <= next_state;
                flag  <= '1';
            END IF;
            IF clk_btn = '0' AND flag = '1' THEN
                flag <= '0';
            END IF;
        END IF;

        IF reset = '1' THEN
            state <= S0;
        END IF;
    END PROCESS;

    PROCESS(state, data_in)IS
    begin
        CASE state IS
            WHEN S0 =>
                led <= "000";
                seq_detected <= '0';
                data <= data_in;
                IF data_in = '0' THEN
                    next_state <= S1;
                    seq_detected <= '0';
                ELSE
                    next_state <= S0;
                    seq_detected <= '0';
                END IF;

            WHEN S1 =>
                led <= "001";
                data <= data_in;
                IF data_in = '0' THEN
                    next_state <= S2;
                    seq_detected <= '0';
                ELSE
                    next_state <= S3;
                    seq_detected <= '0';
                END IF;

            WHEN S2 =>
                led <= "010";
                data <= data_in;
                IF data_in = '0' THEN
                    next_state <= S4;
                    seq_detected <= '0';
                ELSE
                    next_state <= S3;
                    seq_detected <= '0';
                END IF;

            WHEN S3 =>
                led <= "011";
                data <= data_in;
                IF data_in = '0' THEN
                    next_state <= S5;
                    seq_detected <= '0';
                ELSE
                    next_state <= S0;
                    seq_detected <= '0';
                END IF;

            WHEN S4 =>
                led <= "100";
                data <= data_in;
                IF data_in = '0' THEN
                    next_state <= S6;
                    seq_detected <= '0';
                ELSE
                    next_state <= S3;
                    seq_detected <= '0';
                END IF;

            WHEN S5 =>
                led <= "101";
                data <= data_in;
                IF data_in = '0' THEN
                    next_state <= S7;
                    seq_detected <= '0';
                ELSE
                    next_state <= S3;
                    seq_detected <= '0';
                END IF;

            WHEN S6 =>
                led <= "110";
                data <= data_in;
                IF data_in = '0' THEN
                    next_state <= S6;
                    seq_detected <= '0';
                ELSE
                    next_state <= S0;
                    seq_detected <= '1';
                END IF;

            WHEN S7 =>
                led <= "111";
                data <= data_in;
                IF data_in = '0' THEN
                    next_state <= S4;
                    seq_detected <= '0';
                ELSE
                    next_state <= S0;
                    seq_detected <= '1';
                END IF;
        end case;
    end process;

end Mealy;
