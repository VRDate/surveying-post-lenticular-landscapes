class videoObject {
  PApplet app;
  Movie videoSource;

  float sizeW, sizeH, minThreshold, maxThreshold;
  int newFrame = 0;
  int totalFrames;

  videoObject(PApplet papp, float minProximity, float maxProximity) {
    app = papp;
    minThreshold = minProximity;
    maxThreshold = maxProximity;
  }

  void setMovie(String videoSourceSource) {
    // Load and set the videoSource to play. Setting the videoSource 
    // in play mode is needed so at least one frame is read
    // and we can get duration, size and other information from
    // the videoSource stream. 
    videoSource = new Movie(app, videoSourceSource);
    // Pausing the videoSource at the first frame. 
    videoSource.play();
    videoSource.jump(0);
    videoSource.pause();
    totalFrames = getLength();
  }

  void update(PVector zDepth) {
    if (zDepth.z > minThreshold && zDepth.z < maxThreshold) {
      newFrame = floor(map(zDepth.z, 0, totalFrames, maxThreshold, minThreshold));
      setFrame(newFrame);      
    }
  }

  void display(float tempSizeW, float tempSizeH) {
    sizeW = tempSizeW;
    sizeH = tempSizeH;
    translate(centerVideo(tempSizeW, tempSizeH).x, centerVideo(tempSizeW, tempSizeH).y);
    image(videoSource, 0, 0, sizeW, sizeH);
  }

  int getFrame() {    
    return ceil(videoSource.time() * 30) - 1;
  }

  void setFrame(int n) {
    videoSource.play();

    // The duration of a single frame:
    float frameDuration = 1.0 / videoSource.frameRate;

    // We move to the middle of the frame by adding 0.5:
    float where = (n + 0.5) * frameDuration; 

    // Taking into account border effects:
    float diff = videoSource.duration() - where;
    if (diff < 0) {
      where += diff - 0.25 * frameDuration;
    }

    videoSource.jump(where);
    videoSource.pause();
  }  

  int getLength() {
    return int(videoSource.duration() * videoSource.frameRate);
  }
  
  PVector centerVideo(float tempX, float tempY) {
    float marginX = (width - tempX)/2;
    float marginY = (height - tempY)/2;
    return new PVector(marginX, marginY, 0);
  }
}
