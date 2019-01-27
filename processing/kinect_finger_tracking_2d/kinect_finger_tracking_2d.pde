import fingertracker.*;
import SimpleOpenNI.*;

FingerTracker fingers;
SimpleOpenNI kinect;
int threshold = 625;

void setup() {
  size(640, 480);


  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.setMirror(true);

  fingers = new FingerTracker(this, 640, 480);
  fingers.setMeltFactor(100);
}

void draw() {

  kinect.update();
  PImage depthImage = kinect.depthImage();
  image(depthImage, 0, 0);


  fingers.setThreshold(threshold);


  int[] depthMap = kinect.depthMap();
  fingers.update(depthMap);


  stroke(0, 255, 0);
  for (int k = 0; k < fingers.getNumContours(); k++) {
    fingers.drawContour(k);
  }

  // iterate over all the fingers found
  // and draw them as a red circle
  noStroke();
  fill(255, 0, 0);
  for (int i = 0; i < fingers.getNumFingers(); i++) {
    PVector position = fingers.getFinger(i);
    ellipse(position.x - 5, position.y -5, 10, 10);
  }


  fill(255, 0, 0);
  text(threshold, 10, 20);
}


void keyPressed() {
  if (key == '-') {
    threshold -= 10;
  }

  if (key == '=') {
    threshold += 10;
  }
}
