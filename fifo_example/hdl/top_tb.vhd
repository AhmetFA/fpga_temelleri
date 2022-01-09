library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity top_tb is
end top_tb;

architecture Behavioral of top_tb is
  signal  baud_time : time;
  signal  Clock	   :  std_logic;
  signal  reset    :  std_logic:= '1';
  signal  sw	   :  std_logic_vector(2 downto 0):="100";
  
  signal  rx_din		: std_logic;
  signal  tx_dout		: std_logic;
  signal  tx_active		: std_logic;
  signal  rx_active		: std_logic;
  
  signal  data_to_send     : std_logic_vector(7 downto 0);
  signal  data_to_receive  : std_logic_vector(7 downto 0);
  
  component top is
    generic(
    osc_freq      : integer := 100_000_000; 
    Data_width 	  : integer := 8;
    no_of_sample  : integer := 16
    );
    Port ( 
    Clock           : in  std_logic;
    reset	     	: in  std_logic;
    sw				: in  std_logic_vector(2 downto 0);
    rx_din			: in  std_logic;
    tx_dout			: out std_logic;
    tx_active		: out std_logic;
    rx_active		: out std_logic
    );
  end component;

begin

dut: top
     generic map(
     osc_freq     => 100_000_000,
     Data_width   => 8,
     no_of_sample => 16
     )
     port map( 
     Clock       => Clock,
     reset	    => reset,
     sw		    => sw,
     rx_din		=> rx_din,
     tx_dout	    => tx_dout,
     tx_active   => tx_active,
     rx_active   => rx_active
     );
  
baud_sel : process(sw)
            begin
            case sw is 
            when "000"  =>
                baud_time <= 105 us;
            when "001"  =>
                baud_time <= 52.1 us;
            when "010"  =>
                baud_time <= 26.5 us;
            when "011"  =>
                baud_time <= 17.4 us;
            when "100"  =>
                baud_time <= 8.7 us;
            when others =>
                baud_time <= 105 us;
            end case;
end process;
 
clock_proc : process
             begin
             Clock <= '0';
             wait for 5ns;
             Clock <= '1';
             wait for 5ns;
end process;
 
data_test         : process
                    begin
                    rx_din <='1';
                    sw <= "100";
                    reset <= '1'; 
                    wait for 100ns;
                    reset <= '0';
                    wait for 100ns;
                    
                    for j in 0 to 255 loop
                        data_to_send <= std_logic_vector(to_unsigned(j,8));
                        
                        rx_din <= '0';
                        wait for baud_time;
                        for i in 0 to 7 loop
                            rx_din <= data_to_send(i);
                            wait for baud_time;
                        end loop;
                        rx_din <= '1';
                        wait for baud_time;
                    end loop;
                    wait;
end process;

end Behavioral;
