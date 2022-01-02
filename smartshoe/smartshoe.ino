#include "Arduino_LSM9DS1.h"
#include <Wire.h>

LSM9DS1Class IMU1(Wire);

void setup() {
  Serial.begin(115200);
  while (!Serial);
  Serial.println("Started");
  if (!IMU.begin(0)) {
    Serial.println("Failed to initialize int IMU!");
    while (1);
  }
  if (!IMU1.begin(1)) {
    Serial.println("Failed to initialize ext IMU!");
    while (1);
  }

//  IMU1.setContinuousMode();
//  IMU1.setSampleRate119Hz();
//  IMU.setContinuousMode();
//  IMU.setSampleRate119Hz();
}

void loop() {
  float ax, ay, az, gx, gy, gz, v;

  if (IMU1.accelerationAvailable() && IMU1.gyroscopeAvailable()) {

    IMU1.readAcceleration(ax, ay, az);
    IMU1.readGyroscope(gx, gy, gz);

    Serial.print(ax);
    Serial.print('\t');
    Serial.print(ay);
    Serial.print('\t');
    Serial.print(az);
    Serial.print('\t');
    Serial.print(gx);
    Serial.print('\t');
    Serial.print(gy);
    Serial.print('\t');
    Serial.print(gz);
    Serial.print('\t');
    delay(1);
  }
  if (IMU.accelerationAvailable() && IMU.gyroscopeAvailable()) {

    IMU.readAcceleration(ax, ay, az);
    IMU.readGyroscope(gx, gy, gz);

    Serial.print(ax);
    Serial.print('\t');
    Serial.print(ay);
    Serial.print('\t');
    Serial.println(az);
    Serial.print('\t');
    Serial.print(gx);
    Serial.print('\t');
    Serial.print(gy);
    Serial.print('\t');
    Serial.print(gz);
    Serial.print('\t');
    delay(1);
  }
  v = analogRead(A0) / 1.024 * 3.3;
  Serial.print(v);
  Serial.print('\t');
  v = analogRead(A1) / 1.024 * 3.3;
  Serial.print(v);
  Serial.print('\t');
  v = analogRead(A2) / 1.024 * 3.3;
  Serial.print(v);
  Serial.print('\t');
  v = analogRead(A3) / 1.024 * 3.3;
  Serial.print(v);
  Serial.print('\t');
  v = analogRead(A6) / 1.024 * 3.3;
  Serial.println(v);
  delay(8);
}
