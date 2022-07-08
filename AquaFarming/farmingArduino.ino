#include <SoftwareSerial.h>

//code for ph value
#define SensorPin 1          //pH meter Analog output to Arduino Analog Input 0
unsigned long int avgValue;  //Store the average value of the sensor feedback
float b;
int buf[10],temp;
 
//// for float value to string converstion
int f;
float val; // also works with double. 
char buff2[10];
//
////Code for oneWire tempereature sensor
// 
#include <OneWire.h>
#include <DallasTemperature.h>
#define ONE_WIRE_BUS 5
OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);
 float Celcius=0;

void setup() {
  Serial.begin(9600);
  sensors.begin();
  delay(4000); //Delay to let system boot
}
void loop() {

//code for turbidity
//  float turb = analogRead(A0);
//  float vol = turb * (5.0 / 1024.0);

 // sent sensors data to serial (sent sensors data to ESP8266)
//  Serial.println (turb);
//  Serial.println(vol);
//  delay(200);



////Code for oneWire Temperature sensor
 sensors.requestTemperatures(); 
  Celcius=sensors.getTempCByIndex(0);  
Serial.print("Celcius");
Serial.println(Celcius);

  
//code for ph value
 for(int i=0;i<10;i++)       //Get 10 sample value from the sensor for smooth the value
  { 
    buf[i]=analogRead(SensorPin);
//    delay(10);
  }
  for(int i=0;i<9;i++)        //sort the analog from small to large
  {
    for(int j=i+1;j<10;j++)
    {
      if(buf[i]>buf[j])
      {
        temp=buf[i];
        buf[i]=buf[j];
        buf[j]=temp;
      }
    }
  }
  avgValue=0;
  for(int i=2;i<8;i++)                      //take the average value of 6 center sample
    avgValue+=buf[i];
  float phValue=(float)avgValue*5.0/1024/6; //convert the analog into millivolt
  phValue=3.5*phValue;                      //convert the millivolt into pH value
  
//    Value =  dtostrf(phValue, 4, 2, buff2);  //4 is mininum width, 6 is precision
//   valueString = valueString + Value +","; 
   
 // sent sensors data to serial (sent sensors data to ESP8266)
Serial.print("phValue");
  Serial.println(phValue);
  delay(1000);

}
