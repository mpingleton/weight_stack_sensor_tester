
Controller controller;

void setup() {
  size(800, 600);
  
  controller = new Controller();
  controller.connect(this, "/dev/cu.usbmodem111301");
}

void serialEvent(Serial s) {
  controller.event(s);
}

void draw() {
  background(0, 0, 0);
  
  textSize(12);
  fill(255, 255, 255);
  text(Integer.toString(controller.sensorValue), 10, 10);
  
  controller.check();
}
