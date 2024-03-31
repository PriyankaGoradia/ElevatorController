----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2023 16:09:46
-- Design Name: 
-- Module Name: alarm_fsm - Behavioral
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

entity alarm_fsm is
  Port ( clock: IN STD_LOGIC;
         alarm: IN STD_LOGIC; -- alarm=1 or 0 depending on the state of elevator
         row: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
         rst: OUT STD_LOGIC;
         column: BUFFER STD_LOGIC_VECTOR (3 DOWNTO 0):="0000";
         alarm_timer: BUFFER STD_LOGIC; -- to tell if alarm timer went off
         alarm_led: BUFFER STD_LOGIC_VECTOR (2 DOWNTO 0):="000" -- for the emergency rgb led
  );
end alarm_fsm;

architecture Behavioral of alarm_fsm is
    TYPE alarm_state_type IS (LED_ON, LED_OFF, IDLE);
    signal current_state, next_state: alarm_state_type := IDLE;
    signal clock_signal, clock_signal_1hz, alarm_signal, reset: STD_LOGIC := '0';
    signal timer: INTEGER :=0;
begin
    rst <= reset;
    alarm_timer <= alarm_signal;
    clock_div: ENTITY work.clock_divider(Behavioral)
                            GENERIC MAP(freq_out => 4
                                        )
                            PORT MAP( clock => clock,
                                      clock_div => clock_signal
                                    );
    clock_div_1hz: ENTITY work.clock_divider(Behavioral)
                            GENERIC MAP(freq_out => 1
                                        )
                            PORT MAP( clock => clock,
                                      clock_div => clock_signal_1hz
                                    );
                                    
    keypad_reset: ENTITY work.keypad_press(Behavioral)
                            PORT MAP( data_out => reset,
                                      clock => clock,
                                      row => row,
                                      column => column
                                    );   
                                    
    -- LED reset and rising edge update
    state_update: process(clock_signal, reset)
    begin
        if reset='1' then
            current_state <= IDLE;
        elsif rising_edge(clock_signal) then
            current_state <= next_state;
        end if;
    end process;
    
    alarm_process: process(clock_signal_1hz, reset, timer, alarm)
    begin
        if rising_edge(clock_signal_1hz) and alarm='1' then
            timer <= timer + 1;
        end if;
        if timer>=20 then
            alarm_signal <='1';
        end if;
        if alarm='0' or reset='1' then
            timer <= 0;
            alarm_signal <= '0';
        end if;
    end process;
    
    process(current_state, alarm_signal, reset)
    begin
        case current_state is
            when IDLE => 
                if reset='0' and alarm_signal='1' then
                    next_state <= LED_ON;
                else
                    next_state <= IDLE;
                end if;
            when LED_ON =>
                if reset='1' and alarm_signal='0' then
                    next_state <= IDLE;
                else
                    next_state <= LED_OFF;
                end if;
            when LED_OFF =>
                if reset='1' and alarm_signal='0' then
                    next_state <= IDLE;
                else
                    next_state <= LED_ON;
                end if;
        end case;
    end process;
    
    process(current_state)
    begin
        case current_state is
            when LED_ON => 
                alarm_led <= "100";
            when LED_OFF => 
                alarm_led <= "000";
            when others =>
                alarm_led <= "000";
        end case;
    end process;

end Behavioral;
