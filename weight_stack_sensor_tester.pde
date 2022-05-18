import processing.serial.*;

Serial sensorPort;
boolean sensorWaiting = false;
int sensorWaitingTime = 0;

int sensorValue = 0;

void setup() {
  size(800, 600);
  
  sensorPort = new Serial(this, "/dev/cu.usbmodem111301", 115200);
}

void serialEvent(Serial s) {
  if(s != sensorPort) {
    print("Error");
    return;
  }
  
  if(!sensorWaiting) {
    return;
  }
  
  String inputString = s.readStringUntil('\n');
  if(inputString != null) {
    sensorValue = Integer.parseInt(inputString.trim());
    sensorWaiting = false;
    sensorWaitingTime = millis();
  }
}

void draw() {
  background(0, 0, 0);
  
  textSize(12);
  fill(255, 255, 255);
  text(Integer.toString(sensorValue), 10, 10);
  
  if(sensorWaiting) {
    if(millis() - sensorWaitingTime >= 500) {
      sensorWaiting = false;
      sensorWaitingTime = millis();
    }
  }
  else {
    if(millis() - sensorWaitingTime >= 50) {
      sensorPort.write("AD");
      sensorWaiting = true;
      sensorWaitingTime = millis();
    }
  }
}
