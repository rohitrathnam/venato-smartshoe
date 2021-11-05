#include <ArduinoBLE.h>
#include <Arduino_LSM9DS1.h>

float x, y, z;
double accelX=0;
double accelY=1;
double accelZ=0;

float gx, gy, gz;


float mag;
float netmag;
float avgmag = 0;
int i = 1;


BLEService IMUService("7DE3F257-A014-42D8-8B8D-E4A75DB3B930");
BLEDoubleCharacteristic AccXChar("2101", BLERead| BLENotify);
BLEDoubleCharacteristic AccYChar("2102",  BLERead | BLENotify);
BLEDoubleCharacteristic AccZChar("2103",  BLERead | BLENotify);
BLEDoubleCharacteristic NetAccel("2104", BLERead | BLENotify);




void setup() {
IMU.begin();
Serial.begin(9600); 

pinMode(LED_BUILTIN, OUTPUT); // initialize the built-in LED pin to indicate when a central is connected

if (!BLE.begin()) {
Serial.println("BLE failed to Initiate");
delay(500);
while (1);
}


  /* Set a local name for the BLE device
     This name will appear in advertising packets
     and can be used by remote devices to identify this BLE device
     The name can be changed but maybe be truncated based on space left in advertisement packet
  */
  
BLE.setLocalName("Arduino IMU");
BLE.setAdvertisedService(IMUService);
IMUService.addCharacteristic(AccXChar);
IMUService.addCharacteristic(AccYChar);
IMUService.addCharacteristic(AccZChar);
IMUService.addCharacteristic(NetAccel);



BLE.addService(IMUService);



AccXChar.writeValue(accelX);
AccYChar.writeValue(accelY);
AccZChar.writeValue(accelZ);
NetAccel.writeValue(netmag);




  /* Start advertising BLE.  It will start continuously transmitting BLE
     advertising packets and will be visible to remote BLE central devices
     until it receives a new connection */

BLE.advertise();

Serial.println("Bluetooth device is now active, waiting for connections...");
}


void loop() {

BLEDevice central = BLE.central();
if (central) {
Serial.print("Connected to central: ");
Serial.println(central.address());
digitalWrite(LED_BUILTIN, HIGH);
while (central.connected()) {


read_Accel(); //runs the read_Accel function defined below


AccXChar.writeValue(accelX);
AccYChar.writeValue(accelY);
AccZChar.writeValue(accelZ);



mag = (sqrt( accelX * accelX + accelY * accelY + accelZ * accelZ )) - 1.03;
netmag = mag - avgmag;

NetAccel.writeValue(netmag);

Serial.print(netmag);
Serial.print("\t");



                
avgmag = (avgmag + mag) / i;
i++;



}
}
digitalWrite(LED_BUILTIN, LOW);
Serial.print("Disconnected from central: ");
Serial.println(central.address());
}

void read_Accel() {

if (IMU.accelerationAvailable()) {
IMU.readAcceleration(x, y, z);

accelX = x;
accelY = y;
accelZ = z;
}
}
