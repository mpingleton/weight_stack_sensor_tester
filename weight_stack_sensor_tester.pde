
Controller controller;

void setup() {
  size(800, 600);
  
  controller = new Controller();
  controller.connect(this, "/dev/cu.usbserial-21140");
}

void serialEvent(Serial s) {
  controller.event(s);
}

void draw() {
  // Clear the background to black.
  background(0, 0, 0);
  
  // Draw the visual indicator.
  fill(255, 255, 255);
  rect(200, (float)controller.sensorValue / 10.f, 400, 25);
  
  // Draw the raw sensor value in text.
  textSize(12);
  fill(255, 255, 255);
  text(Integer.toString(controller.sensorValue), 10, 10);
  
  controller.check();
}
