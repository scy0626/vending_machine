library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_vendingmachine_tb is
end test_vendingmachine_tb;

architecture Behavioral of test_vendingmachine_tb is
	component test_vendingmachine_mod
		port(--in
		     clk,reset,refund: in std_logic;
			  in_500won, in_100won, in_50won : in std_logic;
			  in_coffee : in std_logic;
			  --out			  
			  out_500won, out_100won, out_50won : out std_logic_vector(2 downto 0);
			  out_coffee, out_error : out std_logic);
		end component;
	signal clk, reset,refund, in_500won, in_100won, in_50won, in_coffee : std_logic :='0';
	signal out_500won, out_100won, out_50won: std_logic_vector(2 downto 0) :="000";
	signal out_coffee, out_error: std_logic :='0';
begin
	
	main1 : test_vendingmachine_mod port map(clk, reset,refund, in_500won, in_100won, in_50won, in_coffee, out_500won, out_100won, out_50won, out_coffee, out_error);
	
	pro1 : process
				begin
					clk<= '0'; wait for 10ns;
					clk<= '1'; wait for 10ns;
			 end process;
	pro2 : process
				begin
					in_500won<= '0'; wait for 20ns;
					in_500won<= '1'; wait for 20ns;
					in_500won<= '0'; wait for 50ns;
					in_500won<= '1'; wait for 20ns;
					in_500won<= '0'; wait for 50ns;
					in_500won<= '1'; wait for 20ns;
					in_500won<= '0'; wait;
				end process;
--	pro3 : process
--				begin
--					in_coffee<= '0'; wait for 400ns;
--					in_coffee<= '1'; wait for 20ns;
--					in_coffee<= '0'; wait for 400ns;
--					in_coffee<= '1'; wait for 20ns;
--					in_coffee<= '0'; wait for 50ns;
--					in_coffee<= '1'; wait for 20ns;
--					in_coffee<= '0'; wait;
--				end process;
end Behavioral;

