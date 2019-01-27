class depthTracker {
  PVector avrgClosestPoint, lerpedLoc;
  int steps;

  // Create a record to keep track of the closest point
  float record;

  depthTracker(int details) {
    avrgClosestPoint = new PVector(0, 0, 0);
    lerpedLoc = new PVector(0, 0, 0);
    steps = details;
  }

  void update() {
    int[] depthMap = kinect.depthMap();
    PVector[] realWorldMap = kinect.depthMapRealWorld();
    int index;
    
    // set all the average values to 0 at the beginning of every frame
    float sumZ = 0;
    float sumX = 0;
    float sumY = 0;
    float count = 0;

    record = 4500;

    // loop through all the pixels the kinect sees to find the closest set of points
    for (int y = 0; y < kinect.depthHeight(); y += steps) {
      for (int x = 0; x < kinect.depthWidth(); x += steps) {
        index = x + y * kinect.depthWidth();
        if (depthMap[index] > 0) {
          // For every point that is smaller than the record is closer, so that is the new record
          // Also don't forget to log that x and y coordinate for later use
          if (depthMap[index] < record) {
            record = depthMap[index];
            sumZ += record;
            //sumX += x;
            //sumY += y;
            count++;
          }
        }
      }
    }

    if (count != 0) {
      avrgClosestPoint = new PVector(0, 0, sumZ/count);
    }
    
    // create a smoother transition between positions so that it's less stuttering
    // it would work even better if you would have a threshold or larger area to walk before having the video jump to the next frame to make it smoother
    //lerpedLoc.x = PApplet.lerp(lerpedLoc.x, avrgClosestPoint.x, 0.3f);
    //lerpedLoc.y = PApplet.lerp(lerpedLoc.y, avrgClosestPoint.y, 0.3f);
    lerpedLoc.z = PApplet.lerp(lerpedLoc.z, avrgClosestPoint.z, 0.3f);
  }
  
  void debug() {
    //debug = 
    image(kinect.depthImage(), 0, 0);
    fill(255, 0, 0);
    ellipse(lerpedLoc.x, lerpedLoc.y, 20, 20);
  }

  PVector getDepthTracker() {
    return avrgClosestPoint;
  }
  
  PVector getDepthTrackerLerped() {
    return lerpedLoc;
  }
}
