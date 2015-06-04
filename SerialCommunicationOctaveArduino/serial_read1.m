function A = serial_read1(s)

  % define reading precission - i.e. we want to read a float, a double and a character. To use a typecast
  % those are represented as single, unit32 and char respecively. 
  % Number of bytes in each type is stored in array l, and it is 4, 4 and 1 byte respectively.
  data = ['single'; 'uint32'; 'char'];
  l = [4 4 1];
  
  % send start and routing header
  srl_write(s, '#STARTABCD');
  
  % read data
  
    a=[];
    a = srl_read(s,9); %read 9 bytes from serial port
    %fprintf('read_in: %f\n', a);
    A =[];
    
    % convert float and double
    for i=1:2
      A(i) = typecast(uint8(a(1:l(i))), data(i,:));
      %fprintf('read: %f\n', A(i));
      a(1:l(i))=[]; %delete converted data from the arry
    
    end;
    
    % read remaining characters (no typecast needed)
    A(3) = a(1);
    %fprintf('read: %f\n', A(3)); 
  
  
  # Flush input and output buffers
  srl_flush(s); 

end
