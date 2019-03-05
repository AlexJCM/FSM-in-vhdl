
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Test_MaquinaExpendedora IS
END Test_MaquinaExpendedora;
 
ARCHITECTURE behavior OF Test_MaquinaExpendedora IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MaquinaExpendedora
    PORT(
         C_Detect : IN  std_logic;
         D_Button : IN  std_logic;
         C_Weight : IN  std_logic;
         C_r_Button : IN  std_logic;
         clk : IN  std_logic;
         rst : IN  std_logic;
         CR_OUT : OUT  std_logic;
         DD_OUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal C_Detect : std_logic := '0';
   signal D_Button : std_logic := '0';
   signal C_Weight : std_logic := '0';
   signal C_r_Button : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal CR_OUT : std_logic;
   signal DD_OUT : std_logic;

   -- clk period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MaquinaExpendedora PORT MAP (
          C_Detect => C_Detect,
          D_Button => D_Button,
          C_Weight => C_Weight,
          C_r_Button => C_r_Button,
          clk => clk,
          rst => rst,
          CR_OUT => CR_OUT,
          DD_OUT => DD_OUT
        );

   -- clk process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
		
      --Probamos los 5 estados
		
      C_r_Button <='1';
		D_Button <='0';
		C_Detect <='0';
		C_Weight <='0';
		rst <='1';
		-- hold rst state for 100 ns.
      wait for 100 ns;
		
		C_r_Button <='0';
		D_Button <='1';
		C_Detect <='0';
		C_Weight <='0';		
		rst <='1';			
		wait for 100 ns;
		
		C_r_Button <='0';
		D_Button <='1';
		C_Detect <='0';
		C_Weight <='1';
		rst <='1';		
		wait for 100 ns;
		
		C_r_Button <='0';
		D_Button <='0';
		C_Detect <='1';
		C_Weight <='0';
		rst <='1';		
		wait for 100 ns;
		
		C_r_Button <='0';
		D_Button <='0';
		C_Detect <='1';
		C_Weight <='1';	
		rst <='1';		
		wait for 100 ns;

      --wait;
   end process;

END;

