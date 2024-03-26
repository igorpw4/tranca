library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;
use IEEE.std_logic_textio.all; -- require for writing/reading std_logic etc.


entity test is
end test;

architecture a1 of test is
    signal clk, reset, configurado , valido: std_logic; --input
    signal entrada: std_logic_vector(3 downto 0); --input
    signal alarme, configurado, tranca : std_logic; --output

   
    file input_buf : text;  -- text is keyword
    file output_buf : text;  -- text is keyword


    

begin

    DUT: entity work.fsm1
		port map(clk => clk, reset => reset, configurar => configurar, valido => valido, entrada => entrada, alarme => alarme, configurado => configurado, tranca => tranca);
    process

        variable read_col_from_input_buf : line; -- read lines one by one from input_buf
        variable write_col_to_output_buf : line; -- write lines one by one to output_buf


        variable buf_data_from_file : line;  -- buffer for storind the data from input read-file
        variable tentativas , senha1 ,senha2 , senha3 , teste1, teste2, teste3 : std_logic_vector(3 downto 0);
        variable val_comma : character;  -- for commas between data in file
        
        variable good_num : boolean;

        clk <= not clk after 2.5 ns;--perguntar?????????????????

        reset <= '1', '0' after 3 ns;

        
     -- Reading and Writing data

        file_open(input_buf0, "trancaConfig.csv", read_mode);  -- open file in read mode
        file_open(input_buf1, "trancaTeste.csv", read_mode);  -- open file in read mode

        file_open(output_buf, "trancaOutput", write_mode);  -- open file in write mode

      
        write(write_col_to_output_buf, string'("senha1, senha2, senha3, teste1, teste2, teste3, tranca, alarme, configurado"));
        writeline(output_buf, write_col_to_output_buf);

        while not endfile(input_buf0) loop
           
           --lendo arquivo de configuração e mandando as entradas
            readline(input_buf0, read_col_from_input_buf);
            read(read_col_from_input_buf,tentativas, good_num);  -- ler o tentativas se for um 4 bits good_num = true, else good_num = false
            next when not good_num;
            valido<= '1','0' after 2 ns;--perguntar?????????????????
            tentativas <= entrada;
           

            read(read_col_from_input_buf, val_comma);

            read(read_col_from_input_buf, senha1, good_num);  -- ler o senha1 se for um 4 bits good_num = true, else good_num = false
            next when not good_num;
            valido<= '1','0' after 2 ns;
            senha1 <= entrada;
           

            read(read_col_from_input_buf, val_comma);

            read(read_col_from_input_buf, senha2, good_num);  -- ler o senha2 se for um 4 bits good_num = true, else good_num = false
            next when not good_num;
            valido<= '1','0' after 2 ns;
            senha2 <= entrada;

            read(read_col_from_input_buf, val_comma);

            read(read_col_from_input_buf, senha3, good_num);  -- ler o senha3 se for um 4 bits good_num = true, else good_num = false
            next when not good_num;
            valido<= '1','0' after 2 ns;
            senha3 <= entrada;

            
            

            --lendo arquivo de teste
            while not endfile(input_buf1) loop
                readline(input_buf1, read_col_from_input_buf);
                read(read_col_from_input_buf, teste1, good_num);  -- ler o teste1 se for um 4 bits good_num = true, else good_num = false
                next when not good_num;
                valido<= '1','0' after 2 ns;
                teste1 <= entrada;

                read(read_col_from_input_buf, val_comma);

                read(read_col_from_input_buf, teste2, good_num);  -- ler o teste2 se for um 4 bits good_num = true, else good_num = false
                next when not good_num;
                valido<= '1','0' after 2 ns;
                teste2 <= entrada;

                read(read_col_from_input_buf, val_comma);

                read(read_col_from_input_buf, teste3, good_num);  -- ler o teste3 se for um 4 bits good_num = true, else good_num = false
                next when not good_num;
                valido<= '1','0' after 2 ns;
                teste3 <= entrada;
                
                --escrevendo no arquivo de saida
                write(write_col_to_output_buf, tentativas);
                write(write_col_to_output_buf, string'(";"));
                write(write_col_to_output_buf, senha1);
                write(write_col_to_output_buf, string'(";"));
                write(write_col_to_output_buf, senha2);
                write(write_col_to_output_buf, string'(";"));
                write(write_col_to_output_buf, senha3);
                write(write_col_to_output_buf, string'(";"));
                write(write_col_to_output_buf, teste1);
                write(write_col_to_output_buf, string'(";"));
                write(write_col_to_output_buf, teste2);
                write(write_col_to_output_buf, string'(";"));
                write(write_col_to_output_buf, teste3);
                write(write_col_to_output_buf, string'(";"));
                write(write_col_to_output_buf, tranca);
                write(write_col_to_output_buf, string'(";"));
                write(write_col_to_output_buf, alarme);
                write(write_col_to_output_buf, string'(";"));
                write(write_col_to_output_buf, configurado);
                writeline(output_buf, write_col_to_output_buf);
            
            end loop;
        end loop;

        file_close(input_buf0);  -- close the file
        file_close(input_buf1);  -- close the file
        file_close(output_buf);  -- close the file
        wait;
    end process;
end architecture;

    






