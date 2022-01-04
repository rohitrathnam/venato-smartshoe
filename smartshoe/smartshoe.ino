#include "Arduino_LSM9DS1.h"
#include <Wire.h>
#include <ArduinoBLE.h>

LSM9DS1Class IMU1(Wire);

BLEService smartshoe("7DE3F257-A014-42D8-8B8D-E4A75DB3B930");
BLECharacteristic dataCharacteristic("1101", BLERead | BLENotify, 68);

union
{
  float f;
  unsigned char b[4];
} data[17];

unsigned char buff[476]={0};
unsigned int buff_idx = 0;

unsigned int max_count = 0;

void setup()
{
  Serial.begin(115200);
  while (!Serial)
    ;
  Serial.println("Started");
  if (!IMU.begin(0))
  {
    Serial.println("Failed to initialize int IMU!");
    while (1)
      ;
  }
  if (!IMU1.begin(1))
  {
    Serial.println("Failed to initialize ext IMU!");
    while (1)
      ;
  }
  if (!BLE.begin())
  {
    Serial.println("starting BLE failed!");

    while (1)
      ;
  }

  BLE.setLocalName("Arduino");
  BLE.setAdvertisedService(smartshoe);
  smartshoe.addCharacteristic(dataCharacteristic);
  BLE.addService(smartshoe);

  BLE.advertise();

  //  IMU1.setContinuousMode();
  //  IMU1.setSampleRate119Hz();
  //  IMU.setContinuousMode();
  //  IMU.setSampleRate119Hz();
}

void loop()
{
  BLEDevice central = BLE.central();
  if (central)
  {
    Serial.print("Connected to central: ");
    Serial.println(central.address());
    while (central.connected() && max_count < 690)
    {
//      max_count++;
      if (IMU1.accelerationAvailable() && IMU1.gyroscopeAvailable())
      {

        IMU1.readAcceleration(data[0].f, data[1].f, data[2].f);
        IMU1.readGyroscope(data[3].f, data[4].f, data[5].f);

        // Serial.print(ax0);
        // Serial.print('\t');
        // Serial.print(ay0);
        // Serial.print('\t');
        // Serial.print(az0);
        // Serial.print('\t');
        // Serial.print(gx0);
        // Serial.print('\t');
        // Serial.print(gy0);
        // Serial.print('\t');
        // Serial.print(gz0);
        // Serial.print('\t');
      }
      if (IMU.accelerationAvailable() && IMU.gyroscopeAvailable())
      {

        IMU.readAcceleration(data[6].f, data[7].f, data[8].f);
        IMU.readGyroscope(data[9].f, data[10].f, data[11].f);

        // Serial.print(ax1);
        // Serial.print('\t');
        // Serial.print(ay1);
        // Serial.print('\t');
        // Serial.print(az1);
        // Serial.print('\t');
        // Serial.print(gx1);
        // Serial.print('\t');
        // Serial.print(gy1);
        // Serial.print('\t');
        // Serial.print(gz1);
        // Serial.print('\t');
      }
      data[12].f = analogRead(A0) / 1.024 * 3.3;
      data[13].f = analogRead(A1) / 1.024 * 3.3;
      data[14].f = analogRead(A2) / 1.024 * 3.3;
      data[15].f = analogRead(A3) / 1.024 * 3.3;
      data[16].f = analogRead(A6) / 1.024 * 3.3;

      // Serial.print(v0);
      // Serial.print('\t');
      // Serial.print(v1);
      // Serial.print('\t');
      // Serial.print(v2);
      // Serial.print('\t');
      // Serial.print(v3);
      // Serial.print('\t');
      // Serial.println(v4);

      for (int i=0; i<17; i++) 
      {
        memcpy(&buff[i*4 + buff_idx], &data[i].b, 4);
      }
      if (buff_idx < 408) buff_idx += 68;
      else {
        buff_idx = 0;
        Serial.println("Sent data");
        dataCharacteristic.writeValue(&buff, 476);
      }
    }
  }
  else buff_idx=0;
}
