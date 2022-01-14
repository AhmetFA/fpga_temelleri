library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity sync_mul is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           din_a : in STD_LOGIC_VECTOR (15 downto 0);
           din_b : in STD_LOGIC_VECTOR (15 downto 0);
           dout  : out STD_LOGIC_VECTOR (31 downto 0));
end sync_mul;
architecture Behavioral of sync_mul is
begin
process(clk,rst)
begin
    if rising_edge(clk) then
        if rst = '1' then
            dout <= (others => '0');
        else
            dout <= std_logic_vector(unsigned(din_a)*unsigned(din_b));
        end if;
    end if;
end process;
end Behavioral;
