#include <Wire.h>
#include "Arduino_LSM9DS1.h"
#include <ArduinoBLE.h>

#define PACKET_SIZE 504
// max limit is 505 for some reason

LSM9DS1Class IMU1(Wire);

BLEService smartshoe("7DE3F257-A014-42D8-8B8D-E4A75DB3B930");
BLECharacteristic dataCharacteristic("1101", BLERead | BLENotify, 252);

unsigned char buff[PACKET_SIZE] = {0};

float raw_data_imu0[60];
float raw_data_imu1[60];

int16_t sensor_data[126];

uint16_t packet_id = 0;

void setup() {
  Serial.begin(115200);
  while (!Serial)
    ;
  Serial.println("Started");

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
  // Setup IMU
  IMU.setContinuousMode();
  IMU.setSampleRate119Hz();
  IMU1.setContinuousMode();
  IMU1.setSampleRate119Hz();
}

void loop() {
  BLEDevice central = BLE.central();
  if (central.connected())
  {
    int num_samples = IMU1.accelerationAvailable();

    if (num_samples > 9)
    {
      for (int i = 0; i < 10; i++)
      {
        IMU1.readAcceleration(raw_data_imu1[i * 6 + 0], raw_data_imu1[i * 6 + 1], raw_data_imu1[i * 6 + 2]);
        IMU1.readGyroscope(raw_data_imu1[i * 6 + 3], raw_data_imu1[i * 6 + 4], raw_data_imu1[i * 6 + 5]);
        IMU.readAcceleration(raw_data_imu0[i * 6 + 0], raw_data_imu0[i * 6 + 1], raw_data_imu0[i * 6 + 2]);
        IMU.readGyroscope(raw_data_imu0[i * 6 + 3], raw_data_imu0[i * 6 + 4], raw_data_imu0[i * 6 + 5]);
        //        Serial.print(millis());
        //        Serial.print('\t');
      }
      sensor_data[120] = (int16_t)(analogRead(A0) / 1.024 * 3.3);
      sensor_data[121] = (int16_t)(analogRead(A1) / 1.024 * 3.3);
      sensor_data[122] = (int16_t)(analogRead(A2) / 1.024 * 3.3);
      sensor_data[123] = (int16_t)(analogRead(A3) / 1.024 * 3.3);
      sensor_data[124] = (int16_t)(analogRead(A6) / 1.024 * 3.3);
      sensor_data[125] = packet_id;

      for (int i = 0; i < 60; i++)
      {
        sensor_data[i] = (int16_t) (raw_data_imu0[i] * 100.0);
        sensor_data[i + 60] = (int16_t) (raw_data_imu1[i] * 100.0);
      }

      memcpy(&buff[0], &sensor_data[0], 252);
      dataCharacteristic.writeValue(&buff, 252);

      packet_id++;
    }
  }
}
