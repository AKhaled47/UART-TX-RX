# UART-TX-RX
We formed firstly the Baud Generator as A counter that produces 'Tick' pulse when it reaches the number of counts defined by input
It can be seen as 'Clock Divisor' where it is divided by ('dvsr'+1) where the output is connected to both TX and RX
Next we made the RX and TX with FSM defining states that according to each one the TX OR RX will behave differently and they are: IDLE,START,DATA,STOP 
Final Module is 'UART_top' is made by combining the TX and RX and the 'Testbench' tests if the RX and TX can act correctly
A png image is attached for 'UART_top_tb' compliling.
