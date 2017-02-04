//Author: Naman Gupta
//Date: 14-06-2016

#include <VarSpeedServo.h> // Library for variable control
 
VarSpeedServo servo1;  // Servo object to control servo 
VarSpeedServo servo2;

const int servoPin1 = 9;  // the digital pin used for the first servo
const int servoPin2 = 10; // the digital pin used for the second servo
const int alpha = 0;
const float beta = 3;  //10
const float gamma = 9; //30
int corr_1 = 45;
int corr_2 = 45;
int curr_angle_1 = 90;
int curr_angle_2 = 90;
int led = 13;

void setup() { 
  Serial.print("Done");
  pinMode(led, OUTPUT);
  digitalWrite(led, HIGH);
  servo1.attach(servoPin1);  // attaches the servo on pin 9 to the servo object
  servo1.write(180,50,true); // set the intial position of the servo, as fast as possible, run in background
  servo2.attach(servoPin2);  // attaches the servo on pin 10 to the servo object
  servo2.write(180,50,true);  // set the intial position of the servo, as fast as possible, wait until done
  Serial.print("Done");
}

void loop(){
}

