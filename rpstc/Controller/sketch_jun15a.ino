//Author: Naman Gupta, Kedar Joshi
//Date: 03-02-2017

// Library for variable control
#include <VarSpeedServo.h>

// Servo object to control servo 
VarSpeedServo servo1;  
VarSpeedServo servo2;

// Assigning ports for Servo Signals
const int servoPin1 = 9;               // the digital pin used for the first servo
const int servoPin2 = 10;              // the digital pin used for the second servo

float alpha,beta,gamma;                // Control Variables

// Control Angles for servo and Correction values for servo
int mean_angle1, mean_angle2;
int corr_1,corr_2;
const int unit_angle = 5;              // Define value of a unit angle change
const int unit_speed = 5;
const int t = 1;                       // Time (basically: sqrt(sqrt(time/n));
const int n = 10;                      // n value

int led = 13;                          // LED blink for cycle monitoring

void setup() {
	Serial.begin(115200);                // Begin Serial Communication
  
	pinMode(led, OUTPUT);                // LED set to High
	digitalWrite(led, HIGH);
  
	servo1.attach(servoPin1);            // Attaches the servo on pin 9 to the servo object
	servo2.attach(servoPin2);            // Attaches the servo on pin 10 to the servo object
  
	alpha = Serial.read();
	delay(1000);
  
	beta = Serial.read();
	delay(1000);
  
	gamma = Serial.read();
	delay(1000);
  
	corr_1 = Serial.read();
	delay(1000);
  
	corr_2 = Serial.read();
	delay(1000);
  
	Serial.print("Done Reading");
  
	mean_angle1 = 90+corr_1;              // Defining mean angles
	mean_angle2 = 90+corr_2;
  
	servo1.write(mean_angle1,80,true);    // Set the intial position of the servo
	servo2.write(mean_angle2,80,true);
  
	delay(10000);                         // Wait for settling the bot after resetting the positions
}

void loop() {
  
	// Loop start for Alpha
  	servo1.write(mean_angle1+alpha*t,alpha,true);
  	servo2.write(mean_angle2+unit_angle,unit_speed,true);
  	servo1.write(mean_angle1,alpha,true);
  	servo2.write(mean_angle2,unit_speed,true);
  	digitalWrite(13, !digitalRead(13));  // Toggle LED 13 after this to identify end of loop
  
  	// Loop start for Gamma
  	for(int i=0;i<n;i++){
    	servo2.write(mean_angle2+gamma*t,gamma,true);
    	for(int i=0;i<n;i++){
      		servo1.write(mean_angle1+unit_angle,unit_speed,true);
      		servo2.write(mean_angle2+unit_angle,unit_speed,true);
      		servo1.write(mean_angle1,unit_speed,true);
      		servo2.write(mean_angle2,unit_speed,true);
    	}
    	servo2.write(mean_angle2,gamma,true);
    	for(int i=0;i<n;i++){
      		servo1.write(mean_angle1-unit_angle,unit_speed,true);
      		servo2.write(mean_angle2-unit_angle,unit_speed,true);
      		servo1.write(mean_angle1,unit_speed,true);
      		servo2.write(mean_angle2,unit_speed,true);  
    	}    
  	}
    digitalWrite(13, !digitalRead(13));  // Toggle LED 13 after this to identify end of loop
    
    // Loop start for Beta
  	for(int i=0;i<n;i++){
    	servo1.write(mean_angle1+beta*t,beta,true);
    	for(int i=0;i<n;i++){
      		servo1.write(mean_angle1+unit_angle,unit_speed,true);
      		servo2.write(mean_angle2+unit_angle,unit_speed,true);
      		servo1.write(mean_angle1,unit_speed,true);
      		servo2.write(mean_angle2,unit_speed,true);
    	}
    	servo1.write(mean_angle1,beta,true);
    	for(int i=0;i<n;i++){
     		servo1.write(mean_angle1-unit_angle,unit_speed,true);
      		servo2.write(mean_angle2-unit_angle,unit_speed,true);
      		servo1.write(mean_angle1,unit_speed,true);
     		servo2.write(mean_angle2,unit_speed,true);  
    	}  
  	}
 	digitalWrite(13, !digitalRead(13)); // Toggle LED 13 after this to identify end of loop
} 
