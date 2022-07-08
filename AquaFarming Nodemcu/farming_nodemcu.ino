//FirebaseESP8266.h must be included before ESP8266WiFi.h
#include "FirebaseESP8266.h"    // Install Firebase ESP8266 library
  #include <ESP8266WiFi.h>
  #include <SoftwareSerial.h>
  SoftwareSerial mySerial (2,3);
  #include <NTPClient.h>
#include <WiFiUdp.h>
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org");

//Week Days
String weekDays[7]={"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};

//Month names
String months[12]={"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};


////Code for oneWire tempereature sensor
//#include <OneWire.h>
//#include <DallasTemperature.h>
//#define ONE_WIRE_BUS 5
//OneWire oneWire(ONE_WIRE_BUS);
//DallasTemperature sensors(&oneWire);
//float Celcius=0;



#define FIREBASE_HOST "https://fishfarm-d5334-default-rtdb.firebaseio.com/"                          // the project name address from firebase id
#define FIREBASE_AUTH "iA13sHIzYEf1JfUD59n439oKRLsEmz0TZlYl2EQM"            // the secret key generated from firebase
#define WIFI_SSID "rammobile"
#define WIFI_PASSWORD "ram@1234"

//Define FirebaseESP8266 data object
FirebaseData firebaseData;

FirebaseJson json;
void setup()
{


  
  mySerial.begin(9600);
  Serial.begin(9600);
//  sensors.begin();
 
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);

  // Initialize a NTPClient to get time
  timeClient.begin();
  // Set offset time in seconds to adjust for your timezone, for example:
//   GMT +1 = 3600
  // GMT +8 = 28800
  // GMT -1 = -3600
  // GMT 0 = 0
  timeClient.setTimeOffset(0);
}
void sensorUpdate(){
 
timeClient.update();

  time_t epochTime = timeClient.getEpochTime();
  
  
  String formattedTime = timeClient.getFormattedTime();
    

  int currentHour = timeClient.getHours();
 

  int currentMinute = timeClient.getMinutes();
 
  int currentSecond = timeClient.getSeconds();
   

  String weekDay = weekDays[timeClient.getDay()];
 
  //Get a time structure
  struct tm *ptm = gmtime ((time_t *)&epochTime); 
  int monthDay = ptm->tm_mday;
  int currentMonth = ptm->tm_mon+1;
  String currentMonthName = months[currentMonth-1];
  int currentYear = ptm->tm_year+1900; 
  //Print complete date:
  String currentDate = String(currentYear) + "-" + String(currentMonth) + "-" + String(monthDay)+ "," + int(currentHour)+ "-" + int(currentMinute)+ "-" + int(currentSecond);


    //Code for ph Value
float phValue= mySerial.read();
Serial.println(phValue);

 if (Firebase.setString(firebaseData, "/farmingIOT/PH_Value", 7.5))
  {
    Serial.println("PASSED");
  }
  else
  {
    Serial.println("FAILED");
  }



  //code for turbidity
  float turb = analogRead(A0);
  float vol = turb * (5.0 / 1024.0);

 // sent sensors data to serial (sent sensors data to ESP8266)  
  Serial.println(turb);
  Serial.println(vol);
  
  
  if (Firebase.setFloat(firebaseData, "/farmingIOT/turbidity", turb))
  {
    Serial.println("PASSED");
  }
  else
  {
    Serial.println("FAILED");
  }
  if (Firebase.setFloat(firebaseData, "/farmingIOT/voltage", vol))
  {
    Serial.println("PASSED");
  }
  else
  {
    Serial.println("FAILED");
  }
//delay(200);
//Code for oneWire Temperature sensor
// sensors.requestTemperatures(); 
  float Celcius=mySerial.read();  

Serial.println(Celcius);

 if (Firebase.setString(firebaseData, "/farmingIOT/heat", Celcius))
  {
    Serial.println("PASSED");
  }
  else
  {
    Serial.println("FAILED");
  }

//  delay(200);

  if (Firebase.setString(firebaseData, "/farmingIOT/time",currentDate))
  {
    Serial.println("PASSED");
  }
  else
  {
    Serial.println("FAILED");
  }
}
void loop() {
   

  
  sensorUpdate();
 
  delay(2000);
}
