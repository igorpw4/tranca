library ieee;
use ieee.std_logic_1164.all;


entity tranca is
    port(
        clk, reset , configurar, valido: in std_logic;
        entrada: in std_logic_vector(3 downto 0);--entrada de 4 bits
        tranca, configurado, alarme: out std_logic;
    );
end tranca;

architecture a1 of tranca is
    type estado is (desconfigurado, numT, senha1, senha2, senha3,num1 ,num2, num3,validando,destrancado);
    signal estado_atual, prox_estado: estado;
    signal tentativas: std_logic_vector(3 downto 0);
    signal auxTentativa : std_logic_vector(3 downto 0);
    signal senha1, senha2, senha3, teste1, teste2 , teste3: std_logic_vector(3 downto 0); 

    begin
        sequencial: process(clk, reset)
        begin
            if reset = '1' then
                estado_atual <= desconfigurado;
            elsif rising_edge(clock)
                estado_atual <= prox_estado;
            end if;
        end process sequencial;
        
        combinacional: process(estado_atual, entrada, configurar, valido)
                case estado_atual is

                    when desconfigurado => 
                        tranca <= '0';
                        configurado <= '0';
                        alarme <= '0';
                        if configurar = '1' then
                            prox_estado <= numT;
                        end if;
            
                    when numT =>
                        if valido = '1' then
                            tentativas <= entrada;
                            auxTentativa <= '0';
                            prox_estado <= senha1;
                        else
                            prox_estado <= numT;
                        end if;
                            --se não for valido volta para o estado desconfigurado?????
                    when senha1 =>
                            if valido = '1' then
                                senha1 <= entrada;
                                prox_estado <= senha2;
                            else
                                prox_estado <= senha1;
                            end if;
                    when senha2 =>
                            if valido = '1' then
                                senha2 <= entrada;
                                prox_estado <= senha3;
                            else
                                prox_estado <= senha2;
                            end if;

                    when senha3 =>
                            if valido = '1' then
                                senha3 <= entrada;
                                tranca <= '1';
                                prox_estado <= esperando;
                            else
                                prox_estado <= senha3;
                            end if;

                    when num1 =>
                        if valido = '1' then
                            teste1 <= entrada;
                            prox_estado <= num2;
                        else
                            prox_estado <= num1;
                        end if;
                                 
                    when num2 =>
                         if valido = '1' then
                            teste2 <= entrada;
                            prox_estado <= num3;
                            else
                             prox_estado <= num2;
                            end if;

                    when num3 =>
                         if valido = '1' then
                            teste3 <= entrada;
                            prox_estado <= validando;
                        else
                            prox_estado <= num3;
                        end if;
                    
                    when validando =>
                        if teste1 = senha1 and teste2 = senha2 and teste3 = senha3 then
                            prox_estado <= destrancado;
                            alarme <= '0';
                        else
                            if tentativas = '0' and auxTentativa = '0'
                                prox_estado <= num1;
                            elsif tentativas = auxTentativa then
                                alarme <= '1';
                                prox_estado <= num1;
                                    
                            else
                                auxTentativa <= auxTentativa + 1;
                                prox_estado <= num1;
                            end if;
                                    
                        end if;
                    when destrancado =>
                            
                        tranca <= '0' after 375 ms then '1';
                        proximo_estado <= teste1;
                end case;
    end process combinacional;
end a1;

                            
                                
                        
                                


    
