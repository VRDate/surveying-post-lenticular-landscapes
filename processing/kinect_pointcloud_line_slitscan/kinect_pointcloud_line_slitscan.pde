// Code by Max Rheiner
// Updated and reworked by Martijn de Heer on January 2019

import SimpleOpenNI.*;
import peasy.*;

PeasyCam peasy;
SimpleOpenNI kinect;

float        zoomF =0.3f;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
float        rotY = radians(0);

float    minDepth = 0;             // in millimeters (0cm)
float    maxDepth = 900;           // in millimters (90cm)

int drawPositionX;
ArrayList<PVector> frames = new ArrayList<PVector>();

void setup() {
  size(1024, 768, P3D);
  
  peasy = new PeasyCam(this, 0);

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
  drawPositionX = kinect.depthWidth();
}

void draw() {
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
  strokeWeight(3);

  PVector[] realWorldMap = kinect.depthMapRealWorld();
  for(int y = 0; y < kinect.depthHeight(); y += steps) {
    for(int x = 0; x < 20; x += steps) {
      // Use this one for scanning the Kinect area
      //index = drawPositionX + y * kinect.depthWidth();
      
      // Use this one for scanning just 1 line of the Kincet
      index = ((kinect.depthWidth()/2)-x) + y * kinect.depthWidth();
      if(depthMap[index] > 0 && depthMap[index] > minDepth && depthMap[index] < maxDepth) { 
        realWorldPoint = realWorldMap[index];
        point(realWorldPoint.x,realWorldPoint.y,realWorldPoint.z);  // make realworld z negative, in the 3d drawing coordsystem +z points in the direction of the eye
        PVector temp = new PVector(realWorldPoint.x+drawPositionX,realWorldPoint.y,realWorldPoint.z);
        frames.add(temp);
      }
    }
  }

  pushMatrix();
  translate(-drawPositionX, 0, 0);
  for(int i = 0; i < frames.size(); i++) {
    point(frames.get(i).x, frames.get(i).y, frames.get(i).z);
  }
  popMatrix();
  
  drawPositionX-=20;
  //if (drawPositionX < 0) {
  //    drawPositionX = kinect.depthWidth() - 1;
  //}
}


void keyPressed() {
  switch(key) {
  case ' ':
    kinect.setMirror(!kinect.mirror());
    break;
  }
}
