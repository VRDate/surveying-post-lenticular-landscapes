// import the fingertracker library
// and the SimpleOpenNI library for Kinect access
import fingertracker.*;
import SimpleOpenNI.*;
import java.util.*; 
import peasy.*;

PeasyCam peasy;
SimpleOpenNI kinect;

float        zoomF =0.3f;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
                                   // the data from openni comes upside down
float        rotY = radians(0);

ArrayList<Float> depths = new ArrayList<Float>();
float closestPoint;

// declare FignerTracker and SimpleOpenNI objects
FingerTracker fingers;

// set a default threshold distance:
// 625 corresponds to about 2-3 feet from the Kinect
int threshold = 625;

void setup() {
  size(640, 480);
  
  peasy = new PeasyCam(this, 1000);

  kinect = new SimpleOpenNI(this);
  if(kinect.isInit() == false) {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;  
  }
  
  // disable mirror
  kinect.setMirror(true);

  // enable depthMap generation 
  kinect.enableDepth();

  perspective(radians(45), float(width)/float(height), 10,150000);
  
  // initialize the FingerTracker object
  // with the height and width of the Kinect
  // depth image
  fingers = new FingerTracker(this, 640, 480);
  // the "melt factor" smooths out the contour
  // making the finger tracking more robust
  // especially at short distances
  // farther away you may want a lower number
  fingers.setMeltFactor(100);
}

void draw() {
  // get new depth data from the kinect
  kinect.update();
  // get a depth image and display it
  //PImage depthImage = kinect.depthImage();
  //image(depthImage, 0, 0);

  // update the depth threshold beyond which
  // we'll look for fingers
  fingers.setThreshold(threshold);
  
  // access the "depth map" from the Kinect
  // this is an array of ints with the full-resolution
  // depth data (i.e. 500-2047 instead of 0-255)
  // pass that data to our FingerTracker
  int[] depthMap = kinect.depthMap();
  fingers.update(depthMap);
  int     steps   = 2;  // to speed up the drawing, draw every third point
  int     index;
  PVector realWorldPoint;
  PVector[] realWorldMap = kinect.depthMapRealWorld();
  
  pushMatrix();
  rotateX(rotX);
  rotateY(rotY);
  scale(zoomF);
  
  // draw pointcloud
  for(int y=0;y < kinect.depthHeight();y+=steps) {
    for(int x=0;x < kinect.depthWidth();x+=steps) {
      index = x + y * kinect.depthWidth();
      if(depthMap[index] > 0) { 
        realWorldPoint = realWorldMap[index];
        point(realWorldPoint.x,realWorldPoint.y,realWorldPoint.z);  // make realworld z negative, in the 3d drawing coordsystem +z points in the direction of the eye
        depths.add(realWorldPoint.x);
        closestPoint = Collections.max(depths);
      }
    }
  }
  popMatrix();
  
  translate(0, 0, closestPoint);
  
  // iterate over all the contours found
  // and display each of them with a green line
  stroke(0,255,0);
  for (int k = 0; k < fingers.getNumContours(); k++) {
    fingers.drawContour(k);
  }
  
  // iterate over all the fingers found
  // and draw them as a red circle
  noStroke();
  fill(255,0,0);
  for (int i = 0; i < fingers.getNumFingers(); i++) {
    PVector position = fingers.getFinger(i);
    ellipse(position.x - 5, position.y -5, 10, 10);
  }
}

// keyPressed event:
// pressing the '-' key lowers the threshold by 10
// pressing the '+/=' key increases it by 10 
void keyPressed(){
  if(key == '-'){
    threshold -= 10;
  }
  
  if(key == '='){
    threshold += 10;
  }
}
