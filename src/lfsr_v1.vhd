----------------------------------------------------------------------------------
-- Company:  fpga'er
-- Engineer: Claudio Avi Chami - FPGA'er Website
--           http://fpgaer.tech
-- Create Date: 03.06.2022 11:01:05
-- Module Name: lfsr_v1.vhd
-- Description: First part of LFSR tutorial
-- 
-- Dependencies: None
-- 
-- Revision: 1
-- Revision  1 - File Created
-- 
----------------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity lfsr_v1 is
  port (
    rstn   : in  std_logic;
    clk    : in  std_logic; 
    rand   : out std_logic    -- lfsr output
  );
end entity;

architecture rtl of lfsr_v1 is
  signal lfsr 	    : std_logic_vector (3 downto 0); -- for lfsr register
  signal feedback 	: std_logic;                     -- lfsr feedback

begin
  feedback <= not(lfsr(3) xor lfsr(2));		-- LFSR size 4

  -- lfsr generate
  lfsr_pr : process (clk) 
  begin
    if (rising_edge(clk)) then
      if (rstn = '0') then
        lfsr <= (others=>'0');
      else
        lfsr <= lfsr(2 downto 0) & feedback;
      end if;
    end if;
  end process lfsr_pr;
  rand <= lfsr(3);

end architecture;
