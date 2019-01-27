// Code by Max Rheiner
// Updated and reworked by Martijn de Heer on January 2019

import SimpleOpenNI.*;
import peasy.*;

PeasyCam peasy;
SimpleOpenNI kinect;

float        zoomF =0.3f;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
                                   // the data from openni comes upside down
float        rotY = radians(0);

// Create a threshold between which you want the tracking to start
float maxThreshold = 600;

// Create a record to keep track of the closest point
float record = 4500;
float rx, ry;

void setup() {
  size(640, 520, P3D);
  peasy = new PeasyCam(this, 1000);

  kinect = new SimpleOpenNI(this);
  if(kinect.isInit() == false) {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;  
  }
  
  // disable mirror
  kinect.setMirror(false);

  // enable depthMap generation 
  kinect.enableDepth();

  perspective(radians(45), float(width)/float(height), 10,150000);
  loc = new PVector(0, 0);
  lerpedLoc = new PVector(0, 0);
}

void draw() {
  record = 4500;
  kinect.update();
  background(0);

  rotateX(rotX);
  rotateY(rotY);
  scale(zoomF);
  

  int[]   depthMap = kinect.depthMap();
  int     steps   = 2;  // to speed up the drawing, draw every third point
  int     index;
  PVector realWorldPoint;
 
  translate(0, 0, -1000);  // set the rotation center of the scene 1000 infront of the camera

  stroke(255);
  strokeWeight(2);

  PVector[] realWorldMap = kinect.depthMapRealWorld();
  
  float sumX = 0;
  float sumY = 0;
  float count = 0;
  
  // draw pointcloud
  for(int y=0;y < kinect.depthHeight();y+=steps) {
    for(int x=0;x < kinect.depthWidth();x+=steps) {
      index = x + y * kinect.depthWidth();
      if(depthMap[index] > 0) { 
        realWorldPoint = realWorldMap[index];
        
          // For every point that is smaller than the record is closer, so that is the new record
          // Also don't forget to log that x and y coordinate for later use
          if(realWorldMap[index].z < record) {
            record = realWorldMap[index].z;
            rx = x;
            ry = y;
          }
      }
    }
  }
  
  // Only draw an ellipse if the closest point is within the threshold
  if(record < maxThreshold) {
    pushMatrix();
    fill(255, 0, 0);
    translate(0, 0, record);
    ellipse(rx, ry, 50, 50);
    popMatrix();
  }
}
