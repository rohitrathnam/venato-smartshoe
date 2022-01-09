#include "mbed.h"

mbed::Ticker pulsegen;
bool state = LOW;

void flip() {
  state = !state;
  digitalWrite(10, state);
}

void setup()
{
  Serial.begin(9600);
  Serial.println("Stepper test!");
  pinMode(10, OUTPUT);
  pulsegen.attach_us(&flip, 625);
//  pulsegen.attach_us(&flip, 1000);
}

void loop()
{
//  digitalWrite(10, HIGH);
////  delay(500);
//  delayMicroseconds(620);
//  digitalWrite(10, LOW);
////  delay(500);
//  delayMicroseconds(620);
////  Serial.println("1");
}
