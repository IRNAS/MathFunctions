function [] = serial_write1(s, A)

  % Convert data stored in array A to uint8 array
  a=[]; % prepare array
  
  % convert float
  a1 = typecast(single(A(1)), 'uint8');
  a=[a a1];

  % Convert double
  a1 = typecast(uint32(A(2)), 'uint8');
  a=[a a1];
 
  % Convert char (no need for typecast
  a1 = A(3);
  a=[a a1];
  
  
  % Send request to write on the serial port
  srl_write(s, '#STARTAAAA'); %send packet start
  
  % Write data
  srl_write(s, a);

end