/*
  Arduino LSM9DS1 - Simple Accelerometer

  this code generates Acceleration signal without having a low pass filter.
*/

#include <Arduino_LSM9DS1.h>

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("Started");

  if (!IMU.begin()) {
    Serial.println("Failed to initialize IMU!");
    while (1);
  }

  Serial.print("Accelerometer sample rate = ");
  Serial.print(IMU.accelerationSampleRate());
  Serial.println(" Hz");
  Serial.println();
  Serial.println("Acceleration in m/s2");
  Serial.println('\t');
}

void loop() {
  float x, y, z;
  float mag;
  float netmag;
  float avgmag = 0;
  int i = 1;
  

  if (IMU.accelerationAvailable()) {
    IMU.readAcceleration(x, y, z);
    mag = ((sqrt( x*x + y*y + z*z ))* 9.8) - 9.8;
    
    netmag = mag - avgmag;

    Serial.print(netmag);
    Serial.println('\t');

    avgmag = (avgmag + mag)/ i;
    i++;
    
    
  }

  
  

  

  

  
   

   

  
}
