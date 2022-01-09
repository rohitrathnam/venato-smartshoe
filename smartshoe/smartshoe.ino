#include <MadgwickAHRS.h>
#include "Arduino_LSM9DS1.h"
#include <Wire.h>

LSM9DS1Class IMU1(Wire);

Madgwick filter0;
Madgwick filter1;

float raw_data_imu0[60];
float raw_data_imu1[60];
float raw_data_fsr[5];

void setup()
{
  Serial.begin(115200);
  while (!Serial)
    ;

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
  IMU1.setContinuousMode();
  IMU1.setSampleRate119Hz();
  IMU.setContinuousMode();
  IMU.setSampleRate119Hz();

//  Serial.println("ax0 \t ay0 \t az0 \t gx0 \t gy0 \t gz0 \t ax1 \t ay1 \t az1 \t gx1 \t gy1 \t gz1 \t f1 \t f2 \t f3 \t f4 \t f5 \t r0 \t p0 \t y0 \t r1 \t p1 \t y1");
//  Serial.println("f1 \t f2 \t f3 \t f4 \t f5 \t r0 \t p0 \t y0 \t r1 \t p1 \t y1");
//  Serial.println("f_in \t toe \t h_in \t h_out \t f_out");
Serial.println("ax0 \t ay0 \t az0 \t ax1 \t ay1 \t az1");

}

void loop()
{
  int num_samples = IMU.accelerationAvailable();
  if (num_samples > 4)
  {
    raw_data_fsr[0] = analogRead(A0) / 1.024 * 3.3;
    raw_data_fsr[1] = analogRead(A1) / 1.024 * 3.3;
    raw_data_fsr[2] = analogRead(A2) / 1.024 * 3.3;
    raw_data_fsr[3] = analogRead(A3) / 1.024 * 3.3;
    raw_data_fsr[4] = analogRead(A6) / 1.024 * 3.3;
    
    for (int i = 0; i < 5; i++)
    {
      IMU1.readAcceleration(raw_data_imu1[i * 6 + 0], raw_data_imu1[i * 6 + 1], raw_data_imu1[i * 6 + 2]);
      IMU1.readGyroscope(raw_data_imu1[i * 6 + 3], raw_data_imu1[i * 6 + 4], raw_data_imu1[i * 6 + 5]);
      IMU.readAcceleration(raw_data_imu0[i * 6 + 0], raw_data_imu0[i * 6 + 1], raw_data_imu0[i * 6 + 2]);
      IMU.readGyroscope(raw_data_imu0[i * 6 + 3], raw_data_imu0[i * 6 + 4], raw_data_imu0[i * 6 + 5]);
    }

    for (int i = 0; i < 5; i++)
    {
      filter0.updateIMU(raw_data_imu0[i * 6 + 3], raw_data_imu0[i * 6 + 4], raw_data_imu0[i * 6 + 5], raw_data_imu0[i * 6 + 0], raw_data_imu0[i * 6 + 1], raw_data_imu0[i * 6 + 2]);
      filter1.updateIMU(raw_data_imu1[i * 6 + 3], raw_data_imu1[i * 6 + 4], raw_data_imu1[i * 6 + 5], raw_data_imu1[i * 6 + 0], raw_data_imu1[i * 6 + 1], raw_data_imu1[i * 6 + 2]);
      Serial.print(raw_data_imu0[i * 6 + 0]);
      Serial.print("\t");
      Serial.print(raw_data_imu0[i * 6 + 1]);
      Serial.print("\t");
      Serial.print(raw_data_imu0[i * 6 + 2]);
      Serial.print("\t");
//      Serial.print(raw_data_imu0[i * 6 + 3]);
//      Serial.print("\t");
//      Serial.print(raw_data_imu0[i * 6 + 4]);
//      Serial.print("\t");
//      Serial.print(raw_data_imu0[i * 6 + 5]);
//      Serial.print("\t");
      Serial.print(raw_data_imu1[i * 6 + 0]);
      Serial.print("\t");
      Serial.print(raw_data_imu1[i * 6 + 1]);
      Serial.print("\t");
      Serial.println(raw_data_imu1[i * 6 + 2]);
//      Serial.print("\t");
//      Serial.print(raw_data_imu1[i * 6 + 3]);
//      Serial.print("\t");
//      Serial.print(raw_data_imu1[i * 6 + 4]);
//      Serial.print("\t");
//      if (i == 9) {
//        Serial.print(raw_data_imu1[i * 6 + 5]);
//        Serial.print("\t");
//      }
//      else
//        Serial.println(raw_data_imu1[i * 6 + 5]);
    }

//    Serial.print(raw_data_fsr[0]);
//    Serial.print('\t');
//    Serial.print(raw_data_fsr[1]);
//    Serial.print('\t');
//    Serial.print(raw_data_fsr[2]);
//    Serial.print('\t');
//    Serial.print(raw_data_fsr[3]);
//    Serial.print('\t');
//    Serial.println(raw_data_fsr[4]);
//    Serial.print('\t');
//
//    Serial.print(filter0.getRoll());
//    Serial.print('\t');
//    Serial.print(filter0.getPitch());
//    Serial.print('\t');
//    Serial.print(filter0.getYaw());
//    Serial.print('\t');
//
//    Serial.print(filter1.getRoll());
//    Serial.print('\t');
//    Serial.print(filter1.getPitch());
//    Serial.print('\t');
//    Serial.println(filter1.getYaw());
  }
}
