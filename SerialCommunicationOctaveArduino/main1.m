% Serial port communication: Tiva C Series LaunchPad

% Demonstrate connection to the LounchPad trough the serial port
% communication. 
% LaunchPad sends three variablas of type: float, double and char,
% with innitial value [0 0 0]. serial_read1 function reads them.
% Then we increase values (optional)
% and write it back, using the function serial_write.
% LaunchPad again increases values (+1). To demonstrate propper communicaion,
% we again read modified values. (Should be [2 2 2] after first run).

% In order to use the following file, the instrument-control package must be instaled.
% The package can be found on http://octave.sourceforge.net/instrument-control/.

% Load the instrument-control package, and check if serial communication is supported.
pkg load instrument-control
 
if (exist("serial") == 3)
    disp("Serial: Supported")
else
    disp("Serial: Unsupported")
endif


% Add try/catch if there is an error in serial port communication. Close
% the port in the case of the error.
try

% Create serial port object and connection settings  
s = serial_setup('COM3');

# Flush input and output buffers
srl_flush(s);


% Read data array
A = serial_read1(s);

% Display
fprintf('First read: %f, %f, %f\n', A(1), A(2), A(3));

% Modify data i.e. add 1 to all entries
A = A+1;
pause(1);

% Write back
serial_write1(s, A);
srl_flush(s);
pause(1);

% Read again and display
A = serial_read1(s);
fprintf('Second read: %f, %f, %f', A(1), A(2), A(3));


% Close the serial port communication
fclose(s);

clear s;

catch
% If there is an error close the serial port communication
display('Error');
fclose(s);
clear s;
end;