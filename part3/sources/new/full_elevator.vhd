----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Priyanka Goradia
-- 
-- Create Date: 09.11.2023 15:39:29
-- Design Name: 
-- Module Name: full_elevator - Structural
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity full_elevator is
PORT (
        clock        : IN STD_LOGIC;
        cabin_btn    : IN STD_LOGIC_VECTOR(3 DOWNTO 0);  -- Floor selection buttons (they are the same inside and outside)
        floor_sensor : IN STD_LOGIC_VECTOR (3 DOWNTO 0); -- Elevator floor position sensor
        motor        : BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0); -- Elevator motor (01 moving down, 10 moving up, 00 idle)
        floor        : BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0);  -- Binary value of floor
        row: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        column: BUFFER STD_LOGIC_VECTOR (3 DOWNTO 0):="0000";
        alarm_led: BUFFER STD_LOGIC_VECTOR (2 DOWNTO 0):="000";
        segments : BUFFER STD_LOGIC_VECTOR (6 DOWNTO 0);
        cc       : BUFFER STD_LOGIC := '0'
    );
end full_elevator;

architecture Structural of full_elevator is

signal alarm: STD_LOGIC:='0';
signal alarm_timer: STD_LOGIC:='0';

component cabin_controller_0   
        port (
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
end component;
              
component display_controller
        PORT (
        clock    : IN STD_LOGIC;
        motor    : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        floor    : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        cc       : BUFFER STD_LOGIC := '0';             -- Controls active display
        segments : BUFFER STD_LOGIC_VECTOR (6 DOWNTO 0); --controls active segments
        alarm: IN STD_LOGIC;
        alarm_timer: IN STD_LOGIC
        );
end component;

begin

    cabin_controller_1: cabin_controller_0 
                        port map (
                                    clock => clock,
                                    cabin_btn => cabin_btn,
                                    floor_sensor => floor_sensor,
                                    row => row,
                                    motor => motor,
                                    floor => floor,
                                    alarm_led => alarm_led,
                                    alarm => alarm,
                                    alarm_timer => alarm_timer
                                  );
                  
    display_driver_1: display_controller 
                        port map (
                                    clock => clock,
                                    motor => motor,
                                    floor => floor,
                                    segments => segments,
                                    alarm => alarm,
                                    cc => cc,
                                    alarm_timer => alarm_timer
                                  );
                                                                      
end architecture Structural;
