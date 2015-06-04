function s = serial_setup(port)

  s = serial(port);
  set(s, "baudrate", 115200);
  set(s, "timeout", 100);

  display('Serial port communication established.');

end