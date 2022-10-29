#include <WiFi.h>
#include <DHT.h>
#include <Wire.h>
#include <PubSubClient.h>

// Koneksi MQTT
const char* ssid = "Yayat";
const char* password = "ratnasusanti";
const char* mqtt_server = "192.168.100.129";
WiFiClient espClient;
PubSubClient client(espClient);

//DC Motor Slider
int IN1 = 27;
int IN2 = 26;
int ENA = 14;

int IN3 = 4;
int IN4 = 25;
int ENB = 15;

const int frequency = 30000;
const int resolution = 8;                                                                                                                        
const int channel1 = 0;
const int channel2 = 0;


// Water Flow Sensor
const int Water = 4; 
float calibrationFactor = 4.5; 
volatile byte pulseCount;
byte pulse1Sec = 0;
float flowRate; 
unsigned int flowMilliLitres ;
unsigned long totalMilliLitres ;

// Temperature dan Humidity Sensor
DHT dht(13, DHT11);

// Millis
long lastMsg = 0;
char msg[50];
int value = 0;


// Pulsa Counter
void IRAM_ATTR pulseCounter() 
{
  pulseCount++;
}

void setup() 
{
  Serial.begin(115200); // Baudrate serial

  // DC Motor 
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(ENA, OUTPUT);
  pinMode(IN3, OUTPUT);
  pinMode(IN4, OUTPUT);
  pinMode(ENB, OUTPUT);
  
  // PWM Setup
  ledcSetup(channel1, frequency, resolution);
  ledcSetup(channel2, frequency, resolution);
  
  ledcAttachPin(ENA, channel1);
  ledcAttachPin(ENB, channel2);

  //Setup WIFI
  setup_wifi();
  client.setServer(mqtt_server, 1883);
  client.setCallback(callback);
  delay(200);

  // Water Sensor
  pinMode(Water, INPUT_PULLUP);
  pulseCount = 0;
  flowRate = 0.0;
  flowMilliLitres = 0;
  totalMilliLitres = 0;
  attachInterrupt(digitalPinToInterrupt(Water), pulseCounter, FALLING);

  //Temperature
  dht.begin();
}

void setup_wifi() 
{
  delay(10);
  // Menyambungkan ke WIFI
  Serial.println();
  Serial.print("Menyambungkan ke  ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) 
  {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

void callback(char* topic, byte* message, unsigned int length)
{
  Serial.print("Message arrived on topic: ");
  Serial.print(topic);
  Serial.print(" || Message: ");
  String messageTemp;
  
  for (int i = 0; i < length; i++) {
    Serial.print((char)message[i]);
     messageTemp+= (char)message[i];
  }
  Serial.println();
  
  // SLIDER TOPIC
  if (String(topic) == "DC Motor Slider CW1") 
  {
    ledcWrite(channel1,messageTemp.toInt());
    digitalWrite(IN1, HIGH);
    digitalWrite(IN2, LOW);
  }

  else if (String(topic) == "DC Motor Slider CCW1") 
  {
    ledcWrite(channel1,messageTemp.toInt());
    digitalWrite(IN1, LOW);
    digitalWrite(IN2, HIGH);
  }

  else if (String(topic) == "DC Motor Slider CW2") 
  {
    ledcWrite(channel2,messageTemp.toInt());
    digitalWrite(IN3, HIGH);
    digitalWrite(IN4, LOW);
  }

  else if (String(topic) == "DC Motor Slider CCW2") 
  {
    ledcWrite(channel2,messageTemp.toInt());
    digitalWrite(IN3, LOW);
    digitalWrite(IN4, HIGH);
  }
  
}

void reconnect() 
{
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    if (client.connect("ESP8266Client")) {
      Serial.println("connected");
      // Subscribe
      client.subscribe("DC Motor Slider CW1");
      client.subscribe("DC Motor Slider CCW1");
      client.subscribe("DC Motor Slider CW2");
      client.subscribe("DC Motor Slider CCW2");
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}

void loop() {
  if (!client.connected()) {
    reconnect();
  }
  client.loop();

  long now = millis();
  if (now - lastMsg > 1000) 
  {
    // WATER FLOW SENSOR
    pulse1Sec = pulseCount;
    pulseCount = 0;
    flowRate = ((1000.0/(millis()-lastMsg))*pulse1Sec)/calibrationFactor;
    lastMsg = millis();
    flowMilliLitres = (flowRate/60)*1000;
    totalMilliLitres += flowMilliLitres;

    //Laju Aliran 1 detik dalam 1 menit
    Serial.print("Flow rate: ");
    Serial.print(float(flowRate));
    char flowRate_String[8];
    dtostrf(flowRate, 4, 2, flowRate_String);
    Serial.print(" L/min");
    client.publish("FlowRate",flowRate_String);

    // Total Kumulatif Liter yang mengalir sejak awal
    Serial.print(" ||| Output Liquid Quantitty: ");
    Serial.print(totalMilliLitres);
    Serial.print("mL");
   // Serial.print(totalMilliLitres/1000);
    char total_String[8];
    dtostrf(totalMilliLitres, 0, 0, total_String);
    //Serial.println(" L");
    client.publish("TotalLiter",total_String);

    // TEMPERATURE dan HUMIDITY SENSOR
    float suhu = dht.readTemperature();
    float kelembapan = dht.readHumidity();
    Serial.print("Temperature: ");
    Serial.print(suhu);
    char suhu_String[8];
    dtostrf(suhu, 3, 2, suhu_String);
    Serial.print(" °C");
    client.publish("Temp",suhu_String);
   
    Serial.print(" ||| Humidity: ");
    Serial.print(kelembapan);
    char kelembapan_String[8];
    dtostrf(kelembapan, 3, 2, kelembapan_String);
    Serial.println(" RH");
    client.publish("Humidity",kelembapan_String);
    
  }
 
  client.publish("statusesp","on");
}
