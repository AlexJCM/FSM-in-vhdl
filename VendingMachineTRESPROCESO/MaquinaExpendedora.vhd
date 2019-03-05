library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
------------------------------------------------------------------------------------
entity MaquinaExpendedora is
    Port ( C_Detect, D_Button, C_Weight, C_r_Button : in  STD_LOGIC;
           clk, rst : in  STD_LOGIC;
           CR_OUT, DD_OUT : out  STD_LOGIC); --Coin Return Cup, Delivery Door
end MaquinaExpendedora;
------------------------------------------------------------------------------------
architecture Behavioral of MaquinaExpendedora is
	--DECLARACIONES
	--Estamos creando el nuevo tipo states y tendra 5 elementos
	type states is (state0, state1, state2, state3, state4);
	signal currentState, nextState : states; --señales internas definidas como tipo STATES
	
begin
	--El proceso de P1 es activado por el flanco descendente del reloj (es decir, clk’event y clk = '0'),
	--	que realiza las transiciones de estado (línea 7, CS \ = NS). 
	--Proceso modela el registro de estado que define el siguiente estado
	P1: process (clk, rst)
	begin
		if falling_edge(clk) then
			if rst = '0' then
				currentState <= state0;
			else			 
				currentState <=  nextState;
			end if;
		end if;
	end process;
	
	--El proceso P2 es activado por CS y las señales de entrada...
	--De acuerdo con las entradas, P2 define el siguiente estado del FSM, 
	--que P1 asignará a CS en el siguiente flanco descendente del reloj. 	
	--Proceso actualiza el siguiente estado
	P2: process(currentState, C_Detect, D_Button, C_Weight, C_r_Button)
	begin
	 if (currentState = state0) then
			--Espera un evento
								if (C_r_Button = '1') then 
									nextState <= state1;
								elsif (D_Button = '1') then
									nextState <= state2;
								elsif (C_Detect = '1') then 
									nextState <= state3;
								else 
									nextState <= state0;	
								end if;
								
		elsif (currentState = state1) then
			 --Return una moneda de 0.25$
								nextState <= state0;
								
		elsif (currentState = state2) then
			 --Hay pago?
								if (C_Weight = '0') then 
									nextState <= state0;
								else 
									nextState <= state4;
								end if;
								
		elsif (currentState = state3) then
			 --Es una moneda valida
								if (C_Weight = '0') then 
									nextState <= state0;
								else 
									nextState <= state1;
								end if;
								
		elsif (currentState = state4) then
			 --Entrega del producto
								nextState  <= state0;		
								
		end if;		
	end process;
	
	--El proceso P3 se desencadena por el flanco ascendente del reloj (es decir, clk’event y clk = "1"),
	--	y es responsable de proporcionar las salidas del FSM, de acuerdo con (CS)
	--Proceso proporciona la salida del FSM.
	P3: process (clk, rst)
	begin
		if (rising_edge(clk)) then
			if (currentState = state0) then
				CR_OUT <= '0';  
				DD_OUT <= '0'; --Espera un evento								
								
			elsif (currentState = state1) then
				CR_OUT <= '1';  
				DD_OUT <= '0'; --Return una moneda de 0.25$								
								
			elsif (currentState = state2) then
				CR_OUT <= '0';  
				DD_OUT <= '0'; --Hay pago?								
								
			elsif (currentState = state3) then
				CR_OUT <= '0'; 
				DD_OUT <= '0'; --Es una moneda valida								
								
			elsif (currentState = state4) then
				CR_OUT <= '0';  
				DD_OUT <= '1';  --Entrega del producto								
								
			end if;
		end if;
	end process;
	
end Behavioral;
------------------------------------------------------------------------------------
