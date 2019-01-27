// Code by Max Rheiner
// Modified by David Sanz Kirbis 
// Updated and reworked by Martijn de Heer on January 2019

import SimpleOpenNI.*;
SimpleOpenNI kinect;
import peasy.*;
PeasyCam peasy;

float        zoomF = 10;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
float        rotY = radians(0);    // the data from openni comes upside down

float    minDepth = 0;             // in millimeters (0cm)
float    maxDepth = 900;           // in millimters (90cm)

int         steps = 2;             // to speed up the drawing, draw every third point
PVector   s_rwp = new PVector();   // standarized realWorldPoint;
int       kdh;
int       kdw;
int       max_edge_len = 50;
int       i00, i01, i10, i11; // indices
PVector   p00, p10, p01, p11, pNormal1, pNormal2; // points
PVector   k_rwp; // kinect realWorldPoint;

void setup() {
  size(1024, 768, P3D);
  peasy = new PeasyCam(this, 0);
  
  //kinect = new SimpleOpenNI(this,SimpleOpenNI.RUN_MODE_SINGLE_THREADED);
  kinect = new SimpleOpenNI(this);
  kinect.setMirror(false);
  
  // enable depthMap generation 
  if (kinect.enableDepth() == false) {
    println("Can't open the depthMap, maybe the camera is not connected!"); 
    exit();     
    return;
  }
  if (kinect.enableRGB() == false) {
    println("Can't open the rgbMap, maybe the camera is not connected or there is no rgbSensor!"); 
    exit();     
    return;
  }
  
  // align depth data to image data
  kinect.alternativeViewPointDepthToImage();

  kdh = kinect.depthHeight();
  kdw = kinect.depthWidth();

  colorMode(HSB);
  perspective(radians(45), 
    float(width)/float(height), 
    10, 150000);
}

void draw() {
  kinect.update();
  PImage    rgbImage = kinect.rgbImage();
  PVector[] realWorldMap = kinect.depthMapRealWorld();

  // set the scene pos
  rotateX(rotX);
  rotateY(rotY);

  for (int y=0; y < kdh-steps; y+=steps) {
    int y_steps_kdw = (y+steps)*kdw;
    int y_kdw = y * kdw;
    
    for (int x=0; x < kdw-steps; x+=steps) {
      i00 = x + y_kdw;
      i01 = x + y_steps_kdw;
      i10 = (x + steps) + y_kdw;
      i11 = (x + steps) + y_steps_kdw;

      p00 = realWorldMap[i00];
      p01 = realWorldMap[i01];
      p10 = realWorldMap[i10];
      p11 = realWorldMap[i11];

      beginShape(TRIANGLES);
      texture(rgbImage); // fill the triangle with the rgb texture
      if ((p00.z >= minDepth) && (p00.z <= maxDepth) &&                              // only catch points within the threshold
          (p01.z >= minDepth) && (p01.z <= maxDepth) &&                              // only catch points within the threshold
          (p10.z >= minDepth) && (p10.z <= maxDepth) &&                              // only catch points within the threshold
          (p00.z > 0) && (p01.z > 0) && (p10.z > 0)  &&                              // check for non valid values
          (abs(p00.z-p01.z) < max_edge_len) && (abs(p10.z-p01.z) < max_edge_len))    // only catch points that are within the max_edge_len
      {
        pNormal1 = PVector.cross(PVector.sub(p01, p00, null), PVector.sub(p10, p00, null), null);
        pNormal1.normalize();
        PVector centroid1 = new PVector( (p00.x+p01.x+p10.x)/3, (p00.y+p01.y+p10.y)/3, (p00.z+p01.z+p10.z)/3 );
        //line(centroid1.x, centroid1.y, centroid1.z, centroid1.x + 20 * pNormal1.x, centroid1.y + 20 * pNormal1.y, centroid1.z + 20 * pNormal1.z);
        
        normal(pNormal1.x, pNormal1.y, pNormal1.z);
        vertex(p00.x, p00.y, p00.z, x, y); // x,y,x,u,v   position + texture reference
        vertex(p01.x, p01.y, p01.z, x, y+steps);
        vertex(p10.x, p10.y, p10.z, x+steps, y);

      }
      
      if ((p11.z >= minDepth) && (p11.z <= maxDepth) &&                              // only catch points within the threshold
          (p01.z >= minDepth) && (p01.z <= maxDepth) &&                              // only catch points within the threshold
          (p10.z >= minDepth) && (p10.z <= maxDepth) &&                              // only catch points within the threshold
          (p11.z > 0) && (p01.z > 0) && (p10.z > 0)  &&                              // check for non valid values
          (abs(p11.z-p01.z) < max_edge_len) && (abs(p10.z-p01.z) < max_edge_len))    // only catch points that are within the max_edge_len
      {
        pNormal2 = PVector.cross(PVector.sub(p11, p01, null), PVector.sub(p10, p01, null), null);
        pNormal2.normalize();
        PVector centroid2 = new PVector( (p01.x+p11.x+p10.x)/3, (p01.y+p11.y+p10.y)/3, (p01.z+p11.z+p10.z)/3 );
        //line(centroid2.x, centroid2.y, centroid2.z, centroid2.x + 20 * pNormal2.x, centroid2.y + 20 * pNormal2.y, centroid2.z + 20 * pNormal2.z);
        
        vertex(p01.x, p01.y, p01.z, x, y+steps);
        vertex(p11.x, p11.y, p11.z, x+steps, y+steps);
        vertex(p10.x, p10.y, p10.z, x+steps, y);
      }
      endShape();
    }
  }
}

void keyPressed() {
  switch(key) {
  case '+': 
    if (steps < 9) steps++; 
    break;
  case '-': 
    if (steps > 1) steps--; 
    break;
  }
  switch(keyCode) {
  case LEFT:
    rotY += 0.1f;
    break;
  case RIGHT:
    // zoom out
    rotY -= 0.1f;
    break;
  case UP:
    if (keyEvent.isShiftDown())
      zoomF += 0.01f;
    else
      rotX += 0.1f;
    break;
  case DOWN:
    if (keyEvent.isShiftDown()) {
      zoomF -= 0.01f;
      if (zoomF < 0.01)
        zoomF = 0.01;
    } else
      rotX -= 0.1f;
    break;
  }
}
