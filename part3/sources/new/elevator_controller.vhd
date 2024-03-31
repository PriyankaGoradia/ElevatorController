----------------------------------------------------------------------------------
-- Filename : elevator_controller.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 06-Nov-2022
-- Design Name: elevator controller
-- Module Name: VHDL_essentials
-- Project Name: VHDL_essentials
-- Description : In this file we will implement a simple elevator controller
-- that services 2 out 4 possible floors
-- using positive logic
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY cabin_controller_0 IS
    PORT (
        clock        : IN STD_LOGIC;
        cabin_btn    : IN STD_LOGIC_VECTOR(3 DOWNTO 0);  -- Floor selection buttons (they are the same inside and outside)
        floor_sensor : IN STD_LOGIC_VECTOR (3 DOWNTO 0); -- Elevator floor position sensor
        motor        : BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0); -- Elevator motor (01 moving down, 10 moving up, 00 idle)
        floor        : BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0);  -- Binary value of floor
        row: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        column: BUFFER STD_LOGIC_VECTOR (3 DOWNTO 0):="0000";
        alarm_led: BUFFER STD_LOGIC_VECTOR (2 DOWNTO 0):="000";
        alarm: BUFFER STD_LOGIC:='0';
        alarm_timer: BUFFER STD_LOGIC:='0'
    );
END cabin_controller_0;


ARCHITECTURE Mealy OF cabin_controller_0 IS

    TYPE elevator_state_type IS (FLOOR_0, FLOOR_1, FLOOR_2, FLOOR_3, MOVING_DOWN, MOVING_UP);
    SIGNAL state, next_state : elevator_state_type := FLOOR_0;
    SIGNAL floor_signal, request_signal       : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL valid_sensor, valid_btn, clock_div : STD_LOGIC             := '0';
    SIGNAL destination                        : INTEGER RANGE 0 TO 3  := 0;
    SIGNAL location                           : INTEGER RANGE -1 TO 3 := 0;
    SIGNAL ticks                              : INTEGER             := 0;
    --    CONSTANT count           : INTEGER             := 2; -- for simulation
    CONSTANT count : INTEGER := 6250000; -- for implementation
    
--    signal alarm: STD_LOGIC:='0';
    

BEGIN
    floor_encoder     : ENTITY work.priority_encoder(Behavioral)
                            PORT MAP( data_in => floor_sensor
                                    , group_select => valid_sensor
                                    , data_out => floor_signal
                                    );
    cabin_btn_encoder : ENTITY work.priority_encoder(Behavioral)
                            PORT MAP( data_in => cabin_btn
                                    , group_select => valid_btn
                                    , data_out => request_signal
                                    );   
                                    
    alarm_fsm_entity : ENTITY work.alarm_fsm(Behavioral)
                            PORT MAP(  clock => clock
                                       ,alarm_led => alarm_led
                                       ,row => row
                                       ,column => column
                                       ,alarm => alarm
                                       , alarm_timer => alarm_timer  
                                    );

    WITH valid_sensor SELECT -- turn floor signal value into integer
        location <= to_integer(unsigned(floor_signal)) WHEN '1', -- location is deternmined by floor_signal
                    - 1 WHEN OTHERS;
    floor <= floor_signal;

    PROCESS (clock) IS -- Clock divider and state update
    BEGIN
        IF rising_edge(clock) THEN
            ticks <= ticks + 1;
            IF ticks = count THEN
                ticks     <= 0;
                clock_div <= NOT clock_div;
                state     <= next_state;
            END IF;
        END IF;
    END PROCESS;

    -- Register desired destination
    destination_process : PROCESS (clock_div)
    BEGIN
        IF rising_edge(clock_div) AND valid_btn = '1' THEN
            IF state /= MOVING_UP AND state /= MOVING_DOWN THEN
                CASE request_signal IS -- request_signal = data out from the priority encoder (floor selected by the priority encoder)
                    WHEN "00"   => destination <= 0;
                    WHEN "01"   => destination <= 1;
                    WHEN "10"   => destination <= 2;
                    WHEN OTHERS => destination <= 3; -- Default value
                END CASE;
            END IF;
        END IF;
    END PROCESS;
    
--    alarm_buffer <= alarm;

    -- Main FSM process logic
    elevator: PROCESS (state, location, destination, alarm)
    BEGIN
        CASE state IS
        WHEN FLOOR_0 =>
            alarm <= '0';
            IF destination > 0 THEN
                next_state <= MOVING_UP;
                motor      <= "10";
            ELSE
                next_state <= FLOOR_0;
                motor      <= "00";
            END IF;
    
        WHEN FLOOR_1 =>
            alarm <= '0';
            IF destination > 1 THEN
                next_state <= MOVING_UP;
                motor <= "10";
            ELSIF destination < 1 THEN
                next_state <= MOVING_DOWN;
                motor <= "01";
            ELSE
                next_state <= FLOOR_1;
                motor <= "00";
            END IF;
    
        WHEN FLOOR_2 =>
            alarm <= '0';
            IF destination >2 THEN
                next_state <= MOVING_UP;
                motor <= "10";
            ELSIF destination < 2 THEN
                next_state <= MOVING_DOWN;
                motor <= "01";
            ELSE
                next_state <= FLOOR_2;
                motor <= "00";
            END IF;
    
        WHEN FLOOR_3 =>
            alarm <= '0';
            IF destination < 3 THEN
                next_state <= MOVING_DOWN;
                motor      <= "01";
            ELSE
                next_state <= FLOOR_3;
                motor      <= "00";
            END IF;
    
        WHEN MOVING_UP =>
            IF location = destination THEN
                IF location = 3 THEN
                    next_state <= FLOOR_3;
                ELSIF location = 2 THEN
                    next_state <= FLOOR_2;
                ELSIF location = 1 THEN
                    next_state <= FLOOR_1;
                END IF;
                motor <= "00";
            ELSE
                alarm <= '1';
                next_state <= MOVING_UP;
                motor      <= "10";
            END IF;
    
        WHEN MOVING_DOWN =>
            IF location = destination THEN
                IF location = 0 THEN
                    next_state <= FLOOR_0;
                ELSIF location = 2 THEN
                    next_state <= FLOOR_2;
                ELSIF location = 1 THEN
                    next_state <= FLOOR_1;
                END IF;
                motor <= "00";
            ELSE
                alarm <= '1';
                next_state <= MOVING_DOWN;
                motor      <= "01";
            END IF;
        END CASE;    
    END PROCESS;

END Mealy;
