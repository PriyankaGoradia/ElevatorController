----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.11.2023 00:38:08
-- Design Name: 
-- Module Name: elevator_controller_tb - Behavioral
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

entity elevator_controller_tb is
--  Port ( );
end elevator_controller_tb;

architecture Behavioral of elevator_controller_tb is
  
    signal clock        :  STD_LOGIC:='0';
    signal cabin_btn    :  STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";  -- Floor selection buttons (they are the same inside and outside)
    signal floor_sensor :  STD_LOGIC_VECTOR (3 DOWNTO 0):="0000";
    signal motor        : STD_LOGIC_VECTOR(1 DOWNTO 0):="00";
    
begin

utt_cabin_controller: entity work.full_elevator(Structural)  
                        port map (
                                    clock => clock,
                                    cabin_btn => cabin_btn,
                                    floor_sensor => floor_sensor,
                                    motor => motor
                                  );
                                  
clock_process : PROCESS
    BEGIN
        clock <= '0';
        WAIT FOR 5 ns;
        clock <= '1';
        WAIT FOR 5 ns;
    END PROCESS;
    
stimulus_process: PROCESS
begin
    
    WAIT FOR 100 ns;
    cabin_btn <= "0000";
    WAIT FOR 100 ns;
    floor_sensor <= "0000";
    WAIT FOR 100 ns;
    cabin_btn <= "0001";
    WAIT FOR 100 ns;
    floor_sensor <= "0001";
    WAIT FOR 100 ns;
    cabin_btn <= "0010";
    WAIT FOR 100 ns;
    floor_sensor <= "0010";
    WAIT FOR 100 ns; 
    cabin_btn <= "0011";
    WAIT FOR 100 ns;
    floor_sensor <= "0011";
    WAIT FOR 100 ns; 
    
    cabin_btn <= "0010";
    WAIT FOR 100 ns;
    floor_sensor <= "0010";
    WAIT FOR 100 ns; 
    cabin_btn <= "0010";
    WAIT FOR 100 ns;
    floor_sensor <= "0010";
    WAIT FOR 100 ns;
    cabin_btn <= "0001";
    WAIT FOR 100 ns;
    floor_sensor <= "0001";
    WAIT FOR 100 ns;
    cabin_btn <= "0000";
    WAIT FOR 100 ns;
    floor_sensor <= "0000";
    WAIT FOR 100 ns;
     
    
    wait;
end process;

end Behavioral;
