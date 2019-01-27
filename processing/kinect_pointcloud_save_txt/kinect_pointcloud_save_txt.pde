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
float    minDepth = 500;           // in millimeters (50cm)
float    maxDepth = 1500;          // in millimters (1,5m)

String[] stringArray = new String[307200];

void setup() {
  size(1024,768,P3D);
  
  peasy = new PeasyCam(this, 1000);

  kinect = new SimpleOpenNI(this);
  if(kinect.isInit() == false) {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;  
  }
  
  //dataList = new StringList();
  stringArray[0] = "x y z";
  
  // disable mirror
  kinect.setMirror(true);

  // enable depthMap generation 
  kinect.enableDepth();
  perspective(radians(45), float(width)/float(height), 10, 150000);
}

void draw() {
  kinect.update();
  background(0,0,0);

  //translate(width/2, height/2, 0);
  rotateX(rotX);
  rotateY(rotY);
  scale(zoomF);

  int[]   depthMap = kinect.depthMap();
  int     steps   = 2;  // to speed up the drawing, draw every third point
  int     index;
  PVector realWorldPoint;
  
  pushMatrix();
  translate(0, 0, -1000);  // set the rotation center of the scene 1000 infront of the camera

  stroke(255);
  strokeWeight(2);

  PVector[] realWorldMap = kinect.depthMapRealWorld();
  
  for(int y=0;y < kinect.depthHeight();y+=steps) {
    for(int x=0;x < kinect.depthWidth();x+=steps) {
      index = x + y * kinect.depthWidth();
      if(depthMap[index] > 0) { 
        
        // lookup the current (index) point in the realWorldMap
        realWorldPoint = realWorldMap[index];
        
        // if that point is between these thresholds then draw a point and place in stringArray for saving data
        if(realWorldPoint.z >= minDepth && realWorldPoint.z <= maxDepth) {
          
          point(realWorldPoint.x,realWorldPoint.y,realWorldPoint.z);  // make realworld z negative, in the 3d drawing coordsystem +z points in the direction of the eye
          stringArray[index] = (realWorldPoint.x * -1) + " " + (realWorldPoint.y * -1) + " " + (realWorldPoint.z * -1);
          
        }
      }
    }
  } 
  popMatrix();
}


void keyPressed() {
  switch(key) {
  case 's':
    // Writes the strings to a file, each on a separate line
    saveStrings(frameCount+".txt", stringArray);
  }
}
