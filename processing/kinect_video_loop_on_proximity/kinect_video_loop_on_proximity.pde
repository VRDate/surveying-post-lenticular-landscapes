// Apt Opt Out : Martijn de Heer
// January 2019

import SimpleOpenNI.*;
import processing.video.*;
SimpleOpenNI kinect;
videoObject video;
depthTracker tracker;

void setup() {
  size(800, 600, P3D);

  // initialize the kinect
  kinect = new SimpleOpenNI(this);

  // if the Kinect isn't connected exit the program
  if (kinect.isInit() == false) {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }

  // disable mirror
  kinect.setMirror(false);

  // enable depthMap generation 
  kinect.enableDepth();
  
  // setting up our video object
  // the 1st number is the closest distance in mm you want people to get, this also means that at this distance your video will be at the last frame
  // the 2nd number is the furthest distance in mm you want people to get, this also means that at this distance your video will be at the first frame
  video = new videoObject(this, 50, 1500);
  
  // load the video you want, type between the quotation marks the filename of your video, don't forget to place the video file in the folder 'data'
  video.setMovie("apollo_11_landing_site_edited.mp4");
  
  // create a tracker object, this will go over every point the Kinect sees and check the depth
  // the number is how detailed you want the kinect to check, my advice is to keep this number bigger than 2 otherwise your program will slowdown
  tracker = new depthTracker(3);
}

// we need to tell the program to start reading the movie to get the pixels
void movieEvent(Movie m) {
  m.read();
}


void draw() {
  // ask every frame the kinect to update its information
  kinect.update();
  
  // draw a black (r,g,b) background to clean the previous frame
  background(0, 0, 0);
  
  // tell the depth tracker
  tracker.update();
  
  // if you want to check what the Kinect actually sees uncomment the next line
  // tracker.debug();
  
  // tell the video to update (or not) according to the whatever the tracker senses
  video.update(tracker.getDepthTrackerLerped());
  
  // draw the video frame on the screen
  // the numbers are the width and height of the video, I wrote it so that it's always centered
  video.display(800, 477);
  
}
