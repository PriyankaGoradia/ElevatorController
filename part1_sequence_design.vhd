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

ENTITY sequence_detector IS
    PORT (
        clock           : IN STD_LOGIC;
        reset           : IN STD_LOGIC;
        data_in         : IN STD_LOGIC;
        clk_btn         : IN STD_LOGIC;
        sequence_detect : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        led             : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
    );
END sequence_detector;


-- ----------------- MEALY 

ARCHITECTURE Mealy OF sequence_detector IS

    CONSTANT ticks : INTEGER := 6250000; -- for implementation
    --   CONSTANT ticks : INTEGER   := 2; -- for simulation
    SIGNAL clk_div : STD_LOGIC := '0';
    SIGNAL flag    : STD_LOGIC := '0';
    SIGNAL divider : INTEGER   := 0;
    TYPE states IS (A, B, C, D, E, F, G, H, I); -- state declared as a new type
    SIGNAL state      : states := A;
    SIGNAL next_state : states := B;

BEGIN

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
            state <= A;
        END IF;
    END PROCESS;

    PROCESS (state, data_in)IS
    BEGIN
        CASE state IS
            WHEN A =>
                led <= "0000";
                sequence_detect <= "100";
                IF data_in = '0' THEN
                    next_state <= B;
                ELSE
                    next_state <= A;
                END IF;

            WHEN B =>
                led <= "0001";
                sequence_detect <= "100";
                IF data_in = '0' THEN
                    next_state <= C;
                ELSE
                    next_state <= B;
                END IF;

            WHEN C =>
                led <= "0010";
                IF data_in = '0' THEN
                    next_state <= D;
                ELSE
                    next_state <= E;
                END IF;

            WHEN D =>
                led <= "0011";
                IF data_in = '0' THEN
                    next_state <= F;
                ELSE
                    next_state <= G;
                END IF;

            WHEN E =>
                led <= "0100";
                IF data_in = '0' THEN
                    next_state <= H;
                ELSE
                    next_state <= I;
                END IF;

            WHEN F =>
                led <= "0101";
                IF data_in = '0' THEN
                    next_state <= F;
                    sequence_detect <= "100";
                ELSE
                    next_state <= E;
                    sequence_detect <= "010";
                END IF;

            WHEN G =>
                led <= "0110";
                IF data_in = '0' THEN
                    next_state <= I;
                    sequence_detect <= "100";
                ELSE
                    next_state <= A;
                    sequence_detect <= "010";
                END IF;

            WHEN H =>
                led <= "0111";
                IF data_in = '0' THEN
                    next_state <= C;
                    sequence_detect <= "100";
                ELSE
                    next_state <= A;
                    sequence_detect <= "010";
                END IF;

            WHEN I =>
                led <= "1000";
                IF data_in = '0' THEN
                    next_state <= B;
                    sequence_detect <= "100";
                ELSE
                    next_state <= A;
                    sequence_detect <= "010";
                END IF;
        END CASE;
    END PROCESS;
END Mealy;


  