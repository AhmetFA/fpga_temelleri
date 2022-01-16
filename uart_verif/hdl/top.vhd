library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity top is
  Port ( 
  clock             : in  std_logic;
  reset	     		: in  std_logic;
  sw				: in  std_logic_vector(2 downto 0);
  rx_din			: in  std_logic;
  tx_dout			: out std_logic;
  tx_active			: out std_logic;
  rx_active			: out std_logic
  );
end top;

architecture Behavioral of top is

signal    sw1				: std_logic_vector(2 downto 0);
signal    sw2				: std_logic_vector(2 downto 0);
signal    rx_din1 	        : std_logic;
signal    rx_din2 	        : std_logic;
signal    tx_data	 	    : std_logic_vector(7 downto 0);		
signal    tx_send 	        : std_logic;	
signal    rx_data_ready 	: std_logic;
signal    rx_data 	        : std_logic_vector(7 downto 0);
signal    fifo_empty        : std_logic;
signal    fifo_full         : std_logic;
signal    tx_start          : std_logic;
signal    tx_active1		: std_logic;
signal fifo_data_count : STD_LOGIC_VECTOR(7 DOWNTO 0);

type   fifo_states is (load , unload);
signal fifo_state : fifo_states;

constant osc_freq      : integer := 100_000_000; 
constant Data_width 	: integer := 8;
constant no_of_sample  : integer := 16;

component uart_top is
  generic(
  osc_freq      : integer := 100_000_000; 
  Data_width 	: integer := 8;
  no_of_sample  : integer := 16
  );
  Port ( 
  clock             : in  Std_logic;
  reset	     		: in  Std_logic;
  sw				: in  Std_logic_vector(2 downto 0); 
  rx_din			: in  std_logic;
  tx_data			: in  std_logic_vector(Data_width - 1 downto 0);
  tx_send			: in  std_logic;
  tx_dout			: out std_logic;
  tx_active			: out std_logic;
  rx_active			: out std_logic;
  rx_data_ready		: out std_logic;
  rx_data			: out std_logic_vector(Data_width - 1 downto 0)
  );
end component;

component fifo_generator_0 IS
  PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    data_count : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END component;

begin
tx_active <= tx_active1;
------------------------------------------------------------------
Uart_0 : uart_top
  generic map(
  osc_freq      =>  osc_freq,
  Data_width 	=>  Data_width,
  no_of_sample  =>  no_of_sample
  )
  Port Map( 
  clock             =>clock,
  reset	  			=>reset,   		
  sw				=>sw2,			 
  rx_din			=>rx_din2,			
  tx_data			=>tx_data,			
  tx_send			=>tx_send,
  tx_dout			=>tx_dout,			
  tx_active			=>tx_active1,
  rx_active			=>rx_active,		
  rx_data_ready		=>rx_data_ready,
  rx_data			=>rx_data		
  );
------------------------------------------------------------------
fifo_0 : fifo_generator_0
  port map(
    clk   => clock,
    srst  => reset,
    din   => rx_data,
    wr_en => rx_data_ready,
    rd_en => tx_start,
    dout  => tx_data,
    full  => fifo_full,
    empty => fifo_empty,
    data_count => fifo_data_count
  );
------------------------------------------------------------------

process(clock)
begin
if rising_edge(clock) then
    --flip flops for asyncronous inputs
    sw1     <= sw ;
    sw2     <= sw1;
    rx_din1 <= rx_din;
    rx_din2 <= rx_din1;
    --delay for memory read
    tx_send <= tx_start;

	if reset = '1' then
	   fifo_state <= load;
	else
		case fifo_state is 
		when load			 =>
		    tx_start <= '0';
		    if (fifo_full = '1') then
		         fifo_state <= unload;
		    end if;
		when unload          =>
            if (tx_active1 = '0') and (tx_start = '0') and (tx_send = '0')  then
                tx_start <= '1';
            else
                tx_start <= '0';
            end if;
            
            if (fifo_empty = '1') then
		         fifo_state <= load;
		    end if;
        when others =>
            fifo_state <= load;
        end case;
    end if;
    
end if;
end process;

end Behavioral;
