library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity test_vendingmachine_mod is

port(clk,reset,refund: in std_logic;
	  in_500won, in_100won, in_50won : in std_logic;
	  in_coffee : in std_logic;
	  out_500won, out_100won, out_50won : out std_logic_vector(2 downto 0):="000";
	  out_coffee, out_error : out std_logic :='0');
end test_vendingmachine_mod;

architecture Behavioral of test_vendingmachine_mod is
	-- Total 17 state
	type state is (won0, won50, won100, won150, won200, won250, won300, won350, won400, won450, won500, won550, won600, won650, won700, won750, won800);
	signal input_state : state;

begin
	
	process(clk, reset, refund, in_500won, in_100won, in_50won, in_coffee)
	
	-- Idle_couter : if no input until idle_counter_max then return all coins
	variable idle_counter : integer := 0;
	constant idle_counter_max : integer := 30; -- Change this value to increase/decrase duration
	--Total duration : idle_counter_max * clk period
	
	begin
		
		-- Resets all value when 'reset' is 1
		if (reset='1') then
			input_state<= won0;
			out_50won<="000";
			out_100won<="000";
			out_500won<="000";
		
		elsif(clk'event and clk = '1') then -- when clock is rising
			out_coffee<='0';
			out_error<='0';
			
			case input_state is
				
				-- Case won0
				when won0 =>
					-- if refund button pressed or idle_counter_max reached
					if (refund='1' or idle_counter = idle_counter_max) then
							if(idle_counter = idle_counter_max) then idle_counter := 0;
							end if;
						out_500won<="000";
						out_100won<="000";
						out_50won<="000";
						input_state<=won0;
					-- coffed button pressed(not enough money)
					elsif (in_coffee='1') then
						out_error<='1';
						idle_counter := 1 + idle_counter;
						input_state<=won0;
					-- 500won added
					elsif (in_500won='1') then 
						idle_counter := 0;
						input_state<=won500;
					-- 100won added
					elsif (in_100won='1') then 
						idle_counter := 0;
						input_state<=won100;
					-- 50won added
					elsif (in_50won='1') then 
						idle_counter := 0;
						input_state<=won50;
					-- no input
					else  
					idle_counter := 1 + idle_counter;
					input_state<=won0;
					end if;
				
				-- Case won50
				when won50 =>
					-- if refund button pressed or idle_counter_max reached
					if (refund='1' or idle_counter = idle_counter_max) then
							if(idle_counter = idle_counter_max) then idle_counter := 0;
							end if;
						out_500won<="000";
						out_100won<="000";
						out_50won<="001";
						input_state<=won0;
					-- coffed button pressed(not enough money)
					elsif (in_coffee='1') then
						out_error<='1';
						idle_counter := 1 + idle_counter;
						input_state<=won50;
					-- 500won added
					elsif (in_500won='1') then 
						idle_counter := 0;
						input_state<=won550;
					-- 100won added
					elsif (in_100won='1') then 
						idle_counter := 0;
						input_state<=won150;
					-- 50won added
					elsif (in_50won='1') then 
						idle_counter := 0;
						input_state<=won100;
					-- no input
					else  
						idle_counter := 1 + idle_counter;
						input_state<=won50;
					end if;
				
				-- Case won100
				when won100 =>
					-- if refund button pressed or idle_counter_max reached
					if (refund='1' or idle_counter = idle_counter_max) then
							if(idle_counter = idle_counter_max) then idle_counter := 0;
							end if;
						out_500won<="000";
						out_100won<="001";
						out_50won<="000";
						input_state<=won0;
					-- coffed button pressed(not enough money)
					elsif (in_coffee='1') then
						out_error<='1';
						idle_counter := 1 + idle_counter;
						input_state<=won100;
					-- 500won added
					elsif (in_500won='1') then 
						idle_counter := 0;
						input_state<=won600;
					-- 100won added
					elsif (in_100won='1') then 
						idle_counter := 0;
						input_state<=won200;
					-- 50won added
					elsif (in_50won='1') then 
						idle_counter := 0;
						input_state<=won150;
					-- no input
					else  
						idle_counter := 1 + idle_counter;
						input_state<=won100;
					end if;
				
				-- Case won150
				when won150 =>
					-- if refund button pressed or idle_counter_max reached
					if (refund='1' or idle_counter = idle_counter_max) then
							if(idle_counter = idle_counter_max) then idle_counter := 0;
							end if;
						out_500won<="000";
						out_100won<="001";
						out_50won<="001";
						input_state<=won0;
					-- coffed button pressed(not enough money)
					elsif (in_coffee='1') then
						out_error<='1';
						idle_counter := 1 + idle_counter;
						input_state<=won150;
					-- 500won added
					elsif (in_500won='1') then 
						idle_counter := 0;
						input_state<=won650;
					-- 100won added
					elsif (in_100won='1') then 
						idle_counter := 0;
						input_state<=won250;
					-- 50won added
					elsif (in_50won='1') then 
						idle_counter := 0;
						input_state<=won200;
					-- no input
					else  
						idle_counter := 1 + idle_counter;
						input_state<=won150;
					end if;
				
				-- Case won200
				when won200 =>
					-- if refund button pressed or idle_counter_max reached
					if (refund='1' or idle_counter = idle_counter_max) then
							if(idle_counter = idle_counter_max) then idle_counter := 0;
							end if;
						out_500won<="000";
						out_100won<="010";
						out_50won<="000";
						input_state<=won0;
					-- coffed button pressed(not enough money)
					elsif (in_coffee='1') then
						out_error<='1';
						idle_counter := 1 + idle_counter;
						input_state<=won200;
					-- 500won added
					elsif (in_500won='1') then 
						idle_counter := 0;
						input_state<=won700;
					-- 100won added
					elsif (in_100won='1') then 
						idle_counter := 0;
						input_state<=won300;
					-- 50won added
					elsif (in_50won='1') then 
						idle_counter := 0;
						input_state<=won250;
					-- no input
					else  
						idle_counter := 1 + idle_counter;
						input_state<=won200;
					end if;
				
				-- Case won250
				when won250 =>
					-- if refund button pressed or idle_counter_max reached
					if (refund='1' or idle_counter = idle_counter_max) then
							if(idle_counter = idle_counter_max) then idle_counter := 0;
							end if;
						out_500won<="000";
						out_100won<="010";
						out_50won<="001";
						input_state<=won0;
					-- coffed button pressed(not enough money)
					elsif (in_coffee='1') then
						out_error<='1';
						idle_counter := 1 + idle_counter;
						input_state<=won250;
					-- 500won added
					elsif (in_500won='1') then 
						idle_counter := 0;
						input_state<=won750;
					-- 100won added
					elsif (in_100won='1') then 
						idle_counter := 0;
						input_state<=won350;
					-- 50won added
					elsif (in_50won='1') then 
						idle_counter := 0;
						input_state<=won300;
					-- no input
					else  
						idle_counter := 1 + idle_counter;
						input_state<=won250;
					end if;
				
				-- Case won300
				when won300 =>
					-- if refund button pressed or idle_counter_max reached
					if (refund='1' or idle_counter = idle_counter_max) then
							if(idle_counter = idle_counter_max) then idle_counter := 0;
							end if;
						out_500won<="000";
						out_100won<="011";
						out_50won<="000";
						input_state<=won0;
					-- coffed button pressed(not enough money)
					elsif (in_coffee='1') then
						out_error<='1';
						idle_counter := 1 + idle_counter;
						input_state<=won300;
					-- 500won added
					elsif (in_500won='1') then 
						idle_counter := 0;
						input_state<=won800;
					-- 100won added
					elsif (in_100won='1') then 
						idle_counter := 0;
						input_state<=won400;
					-- 50won added
					elsif (in_50won='1') then 
						idle_counter := 0;
						input_state<=won350;
					-- no input
					else  
						idle_counter := 1 + idle_counter;
						input_state<=won300;
					end if;
				
				-- Case won350
				when won350 =>
					-- if refund button pressed or idle_counter_max reached
					if (refund='1' or idle_counter = idle_counter_max) then
							if(idle_counter = idle_counter_max) then idle_counter := 0;
							end if;
						out_500won<="000";
						out_100won<="011";
						out_50won<="001";
						input_state<=won0;
					-- coffed button pressed(enough money)
					elsif (in_coffee='1') then
						idle_counter := 0;
						out_coffee<='1';
						input_state<=won0;
					-- 500won added(total 850won : refund)
					elsif (in_500won='1') then
						idle_counter := 0;
						out_500won<="001";
						out_100won<="011";
						out_50won<="001";
						input_state<=won0;
					-- 100won added
					elsif (in_100won='1') then 
						idle_counter := 0;
						input_state<=won450;
					-- 50won added
					elsif (in_50won='1') then 
						idle_counter := 0;
						input_state<=won400;
					-- no input
					else  
						idle_counter := 1 + idle_counter;
						input_state<=won350;
					end if;
				
				-- Case won400
				when won400 =>
					-- if refund button pressed or idle_counter_max reached
					if (refund='1' or idle_counter = idle_counter_max) then
							if(idle_counter = idle_counter_max) then idle_counter := 0;
							end if;
						out_500won<="000";
						out_100won<="100";
						out_50won<="000";
						input_state<=won0;
					-- coffed button pressed(enough money)
					elsif (in_coffee='1') then
						idle_counter := 0;
						out_coffee<='1';
						input_state<=won50;
					-- 500won added(total 900won : refund)
					elsif (in_500won='1') then
						idle_counter := 0;
						out_500won<="001";
						out_100won<="100";
						out_50won<="000";
						input_state<=won0;
					-- 100won added
					elsif (in_100won='1') then 
						idle_counter := 0;
						input_state<=won500;
					-- 50won added
					elsif (in_50won='1') then 
						idle_counter := 0;
						input_state<=won450;
					-- no input
					else  
						idle_counter := 1 + idle_counter;
						input_state<=won400;
					end if;
				
				-- Case won450
				when won450 =>
					-- if refund button pressed or idle_counter_max reached
					if (refund='1' or idle_counter = idle_counter_max) then
							if(idle_counter = idle_counter_max) then idle_counter := 0;
							end if;
						out_500won<="000";
						out_100won<="100";
						out_50won<="001";
						input_state<=won0;
					-- coffed button pressed(enough money)
					elsif (in_coffee='1') then
						idle_counter := 0;
						out_coffee<='1';
						input_state<=won100;
					-- 500won added(total 950won : refund)
					elsif (in_500won='1') then
						idle_counter := 0;
						out_500won<="001";
						out_100won<="100";
						out_50won<="001";
						input_state<=won0;
					-- 100won added
					elsif (in_100won='1') then 
						idle_counter := 0;
						input_state<=won550;
					-- 50won added
					elsif (in_50won='1') then 
						idle_counter := 0;
						input_state<=won500;
					-- no input
					else  
						idle_counter := 1 + idle_counter;
						input_state<=won450;
					end if;
				
				-- Case won500
				when won500 =>
					-- if refund button pressed or idle_counter_max reached
					if (refund='1' or idle_counter = idle_counter_max) then
							if(idle_counter = idle_counter_max) then idle_counter := 0;
							end if;
						out_500won<="001";
						out_100won<="000";
						out_50won<="000";
						input_state<=won0;
					-- coffed button pressed(enough money)
					elsif (in_coffee='1') then
						idle_counter := 0;
						out_coffee<='1';
						input_state<=won150;
					-- 500won added(total 1000won : refund)
					elsif (in_500won='1') then
						idle_counter := 0;
						out_500won<="010";
						out_100won<="000";
						out_50won<="000";
						input_state<=won0;
					-- 100won added
					elsif (in_100won='1') then 
						idle_counter := 0;
						input_state<=won600;
					-- 50won added
					elsif (in_50won='1') then 
						idle_counter := 0;
						input_state<=won550;
					-- no input
					else  
						idle_counter := 1 + idle_counter;
						input_state<=won500;
					end if;
				
				-- Case won550
				when won550 =>
					-- if refund button pressed or idle_counter_max reached
					if (refund='1' or idle_counter = idle_counter_max) then
							if(idle_counter = idle_counter_max) then idle_counter := 0;
							end if;
						out_500won<="001";
						out_100won<="000";
						out_50won<="001";
						input_state<=won0;
					-- coffed button pressed(enough money)
					elsif (in_coffee='1') then
						idle_counter := 0;
						out_coffee<='1';
						input_state<=won200;
					-- 500won added(total 1050won : refund)
					elsif (in_500won='1') then
						idle_counter := 0;
						out_500won<="010";
						out_100won<="000";
						out_50won<="001";
						input_state<=won0;
					-- 100won added
					elsif (in_100won='1') then 
						idle_counter := 0;
						input_state<=won650;
					-- 50won added
					elsif (in_50won='1') then 
						idle_counter := 0;
						input_state<=won600;
					-- no input
					else  
						idle_counter := 1 + idle_counter;
						input_state<=won550;
					end if;
				
				-- Case won600
				when won600 =>
					-- if refund button pressed or idle_counter_max reached
					if (refund='1' or idle_counter = idle_counter_max) then
							if(idle_counter = idle_counter_max) then idle_counter := 0;
							end if;
						out_500won<="001";
						out_100won<="001";
						out_50won<="000";
						input_state<=won0;
					-- coffed button pressed(enough money)
					elsif (in_coffee='1') then
						idle_counter := 0;
						out_coffee<='1';
						input_state<=won250;
					-- 500won added(total 1100won : refund)
					elsif (in_500won='1') then
						idle_counter := 0;
						out_500won<="010";
						out_100won<="001";
						out_50won<="000";
						input_state<=won0;
					-- 100won added
					elsif (in_100won='1') then 
						idle_counter := 0;
						input_state<=won700;
					-- 50won added
					elsif (in_50won='1') then 
						idle_counter := 0;
						input_state<=won650;
					-- no input
					else  
						idle_counter := 1 + idle_counter;
						input_state<=won600;
					end if;
				
				-- Case won650
				when won650 =>
					-- if refund button pressed or idle_counter_max reached
					if (refund='1' or idle_counter = idle_counter_max) then
							if(idle_counter = idle_counter_max) then idle_counter := 0;
							end if;
						out_500won<="001";
						out_100won<="001";
						out_50won<="001";
						input_state<=won0;
					-- coffed button pressed(enough money)
					elsif (in_coffee='1') then
						idle_counter := 0;
						out_coffee<='1';
						input_state<=won300;
					-- 500won added(total 1150won : refund)
					elsif (in_500won='1') then 
						idle_counter := 0;
						out_500won<="010";
						out_100won<="001";
						out_50won<="001";
						input_state<=won0;
					-- 100won added
					elsif (in_100won='1') then 
						idle_counter := 0;
						input_state<=won750;
					-- 50won added
					elsif (in_50won='1') then 
						idle_counter := 0;
						input_state<=won700;
					-- no input
					else  
						idle_counter := 1 + idle_counter;
						input_state<=won650;
					end if;
				
				-- Case won700
				when won700 =>
					-- if refund button pressed or idle_counter_max reached
					if (refund='1' or idle_counter = idle_counter_max) then
							if(idle_counter = idle_counter_max) then idle_counter := 0;
							end if;
						out_500won<="001";
						out_100won<="010";
						out_50won<="000";
						input_state<=won0;
					-- coffed button pressed(enough money)
					elsif (in_coffee='1') then
						idle_counter := 0;
						out_coffee<='1';
						input_state<=won350;
					-- 500won added(total 1200won : refund)
					elsif (in_500won='1') then
						idle_counter := 0;
						out_500won<="010";
						out_100won<="010";
						out_50won<="000";
						input_state<=won0;
					-- 100won added
					elsif (in_100won='1') then 
						idle_counter := 0;
						input_state<=won800;
					-- 50won added
					elsif (in_50won='1') then 
						idle_counter := 0;
						input_state<=won750;
					-- no input
					else  
						idle_counter := 1 + idle_counter;
						input_state<=won700;
					end if;
				
				-- Case won750
				when won750 =>
					-- if refund button pressed or idle_counter_max reached
					if (refund='1' or idle_counter = idle_counter_max) then
							if(idle_counter = idle_counter_max) then idle_counter := 0;
							end if;
						out_500won<="001";
						out_100won<="010";
						out_50won<="001";
						input_state<=won0;
					-- coffed button pressed(enough money)
					elsif (in_coffee='1') then
						idle_counter := 0;
						out_coffee<='1';
						input_state<=won400;
					-- 500won added(total 1250won : refund)
					elsif (in_500won='1') then
						idle_counter := 0;
						out_500won<="010";
						out_100won<="010";
						out_50won<="001";
						input_state<=won0;
					-- 100won added(total 850won : refund)
					elsif (in_100won='1') then
						idle_counter := 0;
						out_500won<="001";
						out_100won<="011";
						out_50won<="001";
						input_state<=won0;
					-- 50won added
					elsif (in_50won='1') then 
						idle_counter := 0;
						input_state<=won800;
					-- no input
					else  
						idle_counter := 1 + idle_counter;
						input_state<=won750;
					end if;
				
				-- Case won800
				when won800 =>
					-- if refund button pressed or idle_counter_max reached
					if (refund='1' or idle_counter = idle_counter_max) then
							if(idle_counter = idle_counter_max) then idle_counter := 0;
							end if;
						out_500won<="001";
						out_100won<="011";
						out_50won<="000";
						input_state<=won0;
					-- coffed button pressed(enough money)
					elsif (in_coffee='1') then
						idle_counter := 0;
						out_coffee<='1';
						input_state<=won450;
					-- 500won added(total 1300won : refund)
					elsif (in_500won='1') then 
						idle_counter := 0;
						out_500won<="010";
						out_100won<="011";
						out_50won<="000";
						input_state<=won0;
					-- 100won added(total 900won : refund)
					elsif (in_100won='1') then 
						idle_counter := 0;
						out_500won<="001";
						out_100won<="100";
						out_50won<="000";
						input_state<=won0;
					-- 50won added(total 850won : refund)
					elsif (in_50won='1') then 
						idle_counter := 0;
						out_500won<="001";
						out_100won<="011";
						out_50won<="001";
						input_state<=won0;
					-- no input
					else  
						idle_counter := 1 + idle_counter;
						input_state<=won800;
					end if;
				end case;
			end if;
		end process;
				
				

end Behavioral;

