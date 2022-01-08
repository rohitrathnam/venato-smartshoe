#include <MadgwickAHRS.h>
#include "Arduino_LSM9DS1.h"
#include <Wire.h>
#include <ArduinoBLE.h>

#define PACKET_SIZE 512

LSM9DS1Class IMU1(Wire);

bool hasConnectedBefore = false;

BLEService smartshoe("7DE3F257-A014-42D8-8B8D-E4A75DB3B930");
BLECharacteristic dataCharacteristic("1101", BLERead | BLENotify, 502);

//Madgwick filter0;
//Madgwick filter1;

union
{
  int16_t i;
  unsigned char b[2];
} sensor_data[125];

float raw_data_imu0[60];
float raw_data_imu1[60];

unsigned char buff[PACKET_SIZE] = {0};
unsigned int buff_idx = 0;
unsigned char buff1[10] = {0};

unsigned int max_count = 0;
double ltime = 0;

union
{
  uint16_t i;
  unsigned char b[2];
} packet_count;

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

  // Setup BLE
  BLE.setLocalName("Arduino");
  //  BLE.setConnectionInterval(0x000A, 0x019);
  BLE.setAdvertisedService(smartshoe);
  smartshoe.addCharacteristic(dataCharacteristic);
  BLE.addService(smartshoe);

  BLE.advertise();

  // Setup IMU
  IMU1.setContinuousMode();
  IMU1.setSampleRate119Hz();
  IMU.setContinuousMode();
  IMU.setSampleRate119Hz();

  packet_count.i = 0;
}

void loop()
{
  BLEDevice central = BLE.central();
  if (central.connected())
  {
    hasConnectedBefore = true;
    //    Serial.print("Connected to central: ");
    //    Serial.println(central.address());
    Serial.println("r0 \t p0 \t y0 \t r1 \t p1 \t y1 \t f1 \t f2 \t f3 \t f4 \t f5");

    //    while (max_count < 100)
    while (1)
    {
      int num_samples = IMU.accelerationAvailable();
      if (num_samples > 9)
      {
        ltime = millis();
        for (int i = 0; i < 10; i++)
        {
          IMU1.readAcceleration(raw_data_imu1[i * 6 + 0], raw_data_imu1[i * 6 + 1], raw_data_imu1[i * 6 + 2]);
          IMU1.readGyroscope(raw_data_imu1[i * 6 + 3], raw_data_imu1[i * 6 + 4], raw_data_imu1[i * 6 + 5]);
          IMU.readAcceleration(raw_data_imu0[i * 6 + 0], raw_data_imu0[i * 6 + 1], raw_data_imu0[i * 6 + 2]);
          IMU.readGyroscope(raw_data_imu0[i * 6 + 3], raw_data_imu0[i * 6 + 4], raw_data_imu0[i * 6 + 5]);
          //        Serial.print(millis());
          //        Serial.print('\t');
        }
//        for (int i = 0; i < 10; i++)
//        {
//          filter0.updateIMU(raw_data_imu0[i * 6 + 3], raw_data_imu0[i * 6 + 4], raw_data_imu0[i * 6 + 5], raw_data_imu0[i * 6 + 0], raw_data_imu0[i * 6 + 1], raw_data_imu0[i * 6 + 2]);
//          filter1.updateIMU(raw_data_imu1[i * 6 + 3], raw_data_imu1[i * 6 + 4], raw_data_imu1[i * 6 + 5], raw_data_imu1[i * 6 + 0], raw_data_imu1[i * 6 + 1], raw_data_imu1[i * 6 + 2]);
//        }


        sensor_data[120].i = (int16_t)(analogRead(A0) / 1.024 * 3.3);
        sensor_data[121].i = (int16_t)(analogRead(A1) / 1.024 * 3.3);
        sensor_data[122].i = (int16_t)(analogRead(A2) / 1.024 * 3.3);
        sensor_data[123].i = (int16_t)(analogRead(A3) / 1.024 * 3.3);
        sensor_data[124].i = (int16_t)(analogRead(A6) / 1.024 * 3.3);

//        Serial.print(filter0.getRoll());
//        Serial.print('\t');
//        Serial.print(filter0.getPitch());
//        Serial.print('\t');
//        Serial.print(filter0.getYaw());
//        Serial.print('\t');
//
//        Serial.print(filter1.getRoll());
//        Serial.print('\t');
//        Serial.print(filter1.getPitch());
//        Serial.print('\t');
//        Serial.print(filter1.getYaw());
//        Serial.print('\t');

        Serial.print(sensor_data[120].i);
        Serial.print('\t');
        Serial.print(sensor_data[121].i);
        Serial.print('\t');
        Serial.print(sensor_data[122].i);
        Serial.print('\t');
        Serial.print(sensor_data[123].i);
        Serial.print('\t');
        Serial.println(sensor_data[124].i);

        for (int i = 0; i < 60; i++)
        {
          sensor_data[i].i = (int16_t) (raw_data_imu0[i] * 100.0);
          sensor_data[i + 60].i = (int16_t) (raw_data_imu1[i] * 100.0);
        }

        memcpy(&buff[buff_idx], &sensor_data[0].b, 250);

        //        Serial.println(millis()-ltime);
        if (buff_idx == 0) buff_idx = 250;
        else {
          buff_idx = 0;
          //          memcpy(&buff[500], &packet_count.b, 2);
          buff[500] = packet_count.b[0];
          buff[501] = packet_count.b[1];
          packet_count.i++;

          //          Serial.println(packet_count.i);
          dataCharacteristic.writeValue(&buff, PACKET_SIZE);
          max_count++;
        }
      }
    }
  }
  //  else {
  //    buff_idx = 0;
  //    Serial.println("Disconnected");
  //    if (hasConnectedBefore) {
  //      while (1);
  //    }
  //  }
}
