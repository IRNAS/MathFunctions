/* to be used with http://energia.nu/ or http://arduino.cc/
This firmware communicates a struct of data with Octave or Matlab 

Copyright Institute IRNAS Rače 2015 - info@irnas.eu

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.*/

// defining a struct holding all the variables that should be communicated

typedef struct struct_data_t{
  float var1; //float type variable
  long var2; //long/double variable type
  char var3; //char variable type
};

// making a union so reading as struct or as char array is possible
typedef union data_t{
 struct_data_t data_num;
 char data_char[sizeof(struct_data_t)];
};

//Create data structure isntance
data_t data_var;

char header_arr[]={0x41,0x41,0x41,0x41,0x00};

void setup(){
  Serial.begin(115200);
}

void loop(){
  
  if (Serial.available() > 3) {
    char header_in[]={0x00,0xff,0xff,0xff,0x00}; // buffer for header
    // wait to receive the start condition
    if(!Serial.findUntil("#START", "\n\r")){
      //Serial1.println("Header timeout.");
    }
    Serial.readBytes(header_in, 4); // read the following 4 bytes
 
    // if header is AAAA then get data and run algorithm on it
    if(!strcmp(header_in, "AAAA")){
      Serial.readBytes(data_var.data_char, sizeof(struct_data_t));
      
      // perform an operation on the data
      data_var.data_num.var1++; //incrementing variable
      data_var.data_num.var2++; //incrementing variable
      data_var.data_num.var3++; //incrementing variable
    }
    // if header is ABCD then reply with the data in the struct
    else if(!strcmp(header_in, "ABCD")){
      send_data();
    }
    // or define your custom functions
  }
}

void send_data(){
  char i=0;
  for(i=0;i<sizeof(data_var);i++){
    Serial.write(data_var.data_char[i]);
  }
}

