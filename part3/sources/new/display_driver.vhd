----------------------------------------------------------------------------------
-- Filename : display_driver.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 06-Nov-10-2022
-- Design Name: elevator display driver
-- Module Name: VHDL_essentials
-- Project Name: VHDL_essentials
-- Description : In this file we will implement a design that can read two 4 bit
-- characters from a register and show it on the appropriate seven segments display
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY display_controller IS
    PORT (
        clock    : IN STD_LOGIC;
        motor    : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        floor    : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        cc       : BUFFER STD_LOGIC := '0';             -- Controls active display
        segments : BUFFER STD_LOGIC_VECTOR (6 DOWNTO 0); --controls active segments
        alarm: IN STD_LOGIC;
        alarm_timer: IN STD_LOGIC
    );
END display_controller;

ARCHITECTURE Behavioral OF display_controller IS
    SIGNAL active_display              : STD_LOGIC                     := '0';
    SIGNAL ticks                       : INTEGER                       := 0;
--    CONSTANT count                     : INTEGER                       := 2;
    CONSTANT count                     : INTEGER                       := 1_250_000;
    SIGNAL display_left, display_right : STD_LOGIC_VECTOR (6 DOWNTO 0) := (OTHERS => '0');

BEGIN

    PROCESS (clock) IS -- Clock divider
    BEGIN
        IF rising_edge(clock) THEN
            ticks <= ticks + 1;
            IF ticks = count THEN
                ticks          <= 0;
                active_display <= NOT active_display;
            END IF;
        END IF;
    END PROCESS;

    cc <= active_display;

    WITH active_display SELECT
        segments <= display_right WHEN '1',
        display_left WHEN '0',
        (OTHERS => '0') WHEN OTHERS;
 
    PROCESS(motor, floor, alarm)
        VARIABLE current_floor_display: STD_LOGIC_VECTOR (7 DOWNTO 0);
    BEGIN
        if alarm_timer = '0' then
        
                if motor = "01" then
                    display_left <= "1100111";
                elsif motor = "10" then
                    display_left <= "1110110";
                else
                    display_left <= "0000001";
                end if;
            
                if floor = "00" then
                    display_right <= "1111110";
                elsif floor = "01" then 
                    display_right <= "0000110";
                elsif floor = "10" then 
                    display_right <= "1101101";
                elsif floor = "11" then
                    display_right <= "1001111";
                else 
                    display_right <= "0000000";
                end if;
                
        else
            display_left <= "1111001";
            display_right <= "0100001";
        end if;
    END PROCESS;
    
--    -- update left display using selected signal assignment
--    WITH motor SELECT
--        display_left <= "" WHEN "01",
--                        "" WHEN "10",
--                        "" WHEN OTHERS;

--    -- update right display using conditional signal assignmet
--    display_right <= "" WHEN floor = "00" ELSE
--                     "" WHEN floor = "01" ELSE
--                     "" WHEN floor = "10" ELSE
--                     "" WHEN floor = "11" ELSE
--                     "";

END Behavioral;
