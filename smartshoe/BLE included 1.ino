#include <ArduinoBLE.h>
#include <Arduino_LSM9DS1.h>
#include "Arduino_LSM9DS1.h"
#include <Wire.h>

LSM9DS1Class IMU1(Wire);

BLEService IMUService1("7DE3F257-A014-42D8-8B8D-E4A75DB3B930");
BLEDoubleCharacteristic AccXChar1("1101", BLERead| BLENotify);
BLEDoubleCharacteristic AccYChar1("1102",  BLERead | BLENotify);
BLEDoubleCharacteristic AccZChar1("1103",  BLERead | BLENotify);
BLEDoubleCharacteristic GyroXChar1("1104", BLERead| BLENotify);
BLEDoubleCharacteristic GyroYChar1("1105",  BLERead | BLENotify);
BLEDoubleCharacteristic GyroZChar1("1106",  BLERead | BLENotify);

BLEService IMUService2("6E7306BD-4D4B-47A2-A4A7-E5B9F0976C76");
BLEDoubleCharacteristic AccXChar2("2101", BLERead| BLENotify);
BLEDoubleCharacteristic AccYChar2("2102",  BLERead | BLENotify);
BLEDoubleCharacteristic AccZChar2("2103",  BLERead | BLENotify);
BLEDoubleCharacteristic GyroXChar2("2104", BLERead| BLENotify);
BLEDoubleCharacteristic GyroYChar2("2105",  BLERead | BLENotify);
BLEDoubleCharacteristic GyroZChar2("2106",  BLERead | BLENotify);

BLEService PressureService("FD534505-F6B8-489A-8B89-A28862F4F950");
BLEDoubleCharacteristic Pressure0("3101", BLERead| BLENotify);
BLEDoubleCharacteristic Pressure1("3102",  BLERead | BLENotify);
BLEDoubleCharacteristic Pressure2("3103",  BLERead | BLENotify);
BLEDoubleCharacteristic Pressure3("3104", BLERead| BLENotify);
BLEDoubleCharacteristic Pressure6("3105",  BLERead | BLENotify);





void setup() {
  Serial.begin(115200);
  while (!Serial);
  Serial.println("Started");
  if (!IMU.begin()) {
    Serial.println("Failed to initialize int IMU!");
    while (1);
  }
  if (!IMU1.begin()) {
    Serial.println("Failed to initialize ext IMU!");
    while (1);
  }

BLE.setLocalName("Arduino");
BLE.setAdvertisedService(IMUService1);
IMUService1.addCharacteristic(AccXChar1);
IMUService1.addCharacteristic(AccYChar1);
IMUService1.addCharacteristic(AccZChar1);
IMUService1.addCharacteristic(GyroXChar1);
IMUService1.addCharacteristic(GyroYChar1);
IMUService1.addCharacteristic(GyroZChar1);

BLE.setAdvertisedService(IMUService2);
IMUService2.addCharacteristic(AccXChar2);
IMUService2.addCharacteristic(AccYChar2);
IMUService2.addCharacteristic(AccZChar2);
IMUService2.addCharacteristic(GyroXChar2);
IMUService2.addCharacteristic(GyroYChar2);
IMUService2.addCharacteristic(GyroZChar2);

BLE.setAdvertisedService(PressureService);
PressureService.addCharacteristic(Pressure0);
PressureService.addCharacteristic(Pressure1);
PressureService.addCharacteristic(Pressure2);
PressureService.addCharacteristic(Pressure3);
PressureService.addCharacteristic(Pressure6);

BLE.addService(IMUService1);
BLE.addService(IMUService2);
BLE.addService(PressureService);

BLE.advertise();

//  IMU1.setContinuousMode();
//  IMU1.setSampleRate119Hz();
//  IMU.setContinuousMode();
//  IMU.setSampleRate119Hz();
}

void loop() {
  BLEDevice central = BLE.central();
  if (central) {
  Serial.print("Connected to central: ");
  Serial.println(central.address());
  digitalWrite(LED_BUILTIN, HIGH);
  while (central.connected()) {

      float ax, ay, az, gx, gy, gz, ax2, ay2, az2, gx2, gy2, gz2;
      float v0, v1, v2, v3, v6;
    
      if (IMU1.accelerationAvailable() && IMU1.gyroscopeAvailable()) {
    
        IMU1.readAcceleration(ax, ay, az);
        IMU1.readGyroscope(gx, gy, gz);

        AccXChar1.writeValue(ax);
        AccYChar1.writeValue(ay);
        AccZChar1.writeValue(az);
        GyroXChar1.writeValue(gx);
        GyroYChar1.writeValue(gy);
        GyroZChar1.writeValue(gz);
    
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
    
        IMU.readAcceleration(ax2, ay2, az2);
        IMU.readGyroscope(gx2, gy2, gz2);

        
        AccXChar2.writeValue(ax2);
        AccYChar2.writeValue(ay2);
        AccZChar2.writeValue(az2);
        GyroXChar2.writeValue(gx2);
        GyroYChar2.writeValue(gy2);
        GyroZChar2.writeValue(gz2);
    
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
      
      v0 = analogRead(A0) / 1.024 * 3.3;
      Serial.print(v0);
      Serial.print('\t');
      v1 = analogRead(A1) / 1.024 * 3.3;
      Serial.print(v1);
      Serial.print('\t');
      v2 = analogRead(A2) / 1.024 * 3.3;
      Serial.print(v2);
      Serial.print('\t');
      v3 = analogRead(A3) / 1.024 * 3.3;
      Serial.print(v3);
      Serial.print('\t');
      v6 = analogRead(A6) / 1.024 * 3.3;
      Serial.println(v6);

      Pressure0.writeValue(v0);
      Pressure1.writeValue(v1);
      Pressure2.writeValue(v2);
      Pressure3.writeValue(v3);
      Pressure6.writeValue(v6);
            
      delay(8);

      
  }
 digitalWrite(LED_BUILTIN, LOW);
 Serial.print("Disconnected from central: ");
 Serial.println(central.address());
}
}
