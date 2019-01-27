//main code from SIMPLEOPENNI library examples

//imported libraries
import java.util.Map;
import java.util.Iterator;

import SimpleOpenNI.*;
import java.util.ArrayDeque;
import java.util.Queue;

//initizalizing data - global
static final int INTERVAL = 2 * 15000; 
static final int HUE = 1<<10, FPS = 200, TOLERANCE = 40, ALIASING = 2;
static final int DIM = 100, MAX = 03000, DETAIL = 1000, DEPTH = 2000;
final Queue<PVector> points = new ArrayDeque(MAX);
int resetAt;

SimpleOpenNI context;
float handVecListSize = 20;
Map<Integer, ArrayList<PVector>>  handPathList = new HashMap<Integer, ArrayList<PVector>>();





void setup() {
  thread("timedShots");

  //regular setup
  smooth(8);
  frameRate(300);
  size(640, 480);
  background(0);





  //controls color of lines
  colorMode(HSB, HUE, 1, 1);
  smooth(ALIASING);
  noFill();
  // println("x: " + x);

  //if the camera isn't connected
  context = new SimpleOpenNI(this);
  if (context.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected?"); 
    exit();
    return;
  }   

  // enable depthMap generation 
  context.enableDepth();

  // disable mirror
  context.setMirror(true);

  // enable hands + gesture generation
  //context.enableGesture();
  context.enableHand();
  context.startGesture(SimpleOpenNI.GESTURE_WAVE);
}
void reset() {
  resetAt= millis() + 30000;
}
void draw() {
  // update the cam
  context.update();

  fill(0);
  textSize(12);
  int timeLeft = resetAt - millis();
  text(timeLeft, 20, 20);



  if (timeLeft<3000) {
    fill(0);
    noStroke();
    rectMode(CENTER);
    rect(width/8, height/8, 40, 40);
    textSize(30);
    fill(255);
    textAlign(CENTER, CENTER);
    int countDown = 1 + (timeLeft / 1000);
    text( countDown, width/8, height/8);
  }
  if (millis () >= resetAt) {
    reset();
    background(0);
  }







  // image(context.depthImage(),0,0);

  // draw the tracked hands
  if (handPathList.size() > 0)  
  {    
    Iterator itr = handPathList.entrySet().iterator();     
    while (itr.hasNext())
    {
      Map.Entry mapEntry = (Map.Entry)itr.next(); 
      int handId =  (Integer)mapEntry.getKey();
      ArrayList<PVector> vecList = (ArrayList<PVector>)mapEntry.getValue();
      //PVector p;
      PVector p2;
      PVector p2d = new PVector();
      PVector p2d2 = new PVector();
      lines(vecList, p2d, 0, 2); //makes the three lines
      lines(vecList, p2d, 5, 2);
      lines(vecList, p2d, 10, 2);
    }
  }
}

// Adding multiple lines
void lines(ArrayList<PVector> vl, PVector p2d, int distance, int thickness) {
  int fc = frameCount;

  //makes stroke change color
  stroke (fc++ & HUE-1, 1, 10);
  noFill(); 
  strokeWeight(thickness);        
  Iterator itrVec = vl.iterator(); 
  beginShape();
  while ( itrVec.hasNext() ) 
  { 
    PVector p = (PVector) itrVec.next(); 

    context.convertRealWorldToProjective(p, p2d);
    vertex(p2d.x-distance, p2d.y-distance);
  }
  endShape();
}



// -----------------------------------------------------------------
// hand events
//if a hand starts moving
void onNewHand(SimpleOpenNI curContext, int handId, PVector pos) {
  //let us know hand is found
  println("onNewHand - handId: " + handId + ", pos: " + pos);

  //startscreen goes away when new hand is sensed
  /*if (f_startscreen) {
   f_startscreen = false;
   background(0) ;
   */

  ArrayList<PVector> vecList = new ArrayList<PVector>();
  vecList.add(pos);

  handPathList.put(handId, vecList);
}
//}

//if the hand is tracked
void onTrackedHand(SimpleOpenNI curContext, int handId, PVector pos)
{
  //println("onTrackedHand - handId: " + handId + ", pos: " + pos );

  ArrayList<PVector> vecList = handPathList.get(handId);
  if (vecList != null)
  {
    vecList.add(0, pos);
    if (vecList.size() >= handVecListSize)
      // remove the last point 
      vecList.remove(vecList.size()-1);
  }
}
//if the hand is lost
void onLostHand(SimpleOpenNI curContext, int handId)
{
  //let us know the hand is lost
  println("onLostHand - handId: " + handId);
  handPathList.remove(handId);

  //startscreen comes back if no hand
  //f_startscreen = true;
}

// -----------------------------------------------------------------
// gesture events

void onCompletedGesture(SimpleOpenNI curContext, int gestureType, PVector pos)
{
  println("onCompletedGesture - gestureType: " + gestureType + ", pos: " + pos);

  int handId = context.startTrackingHand(pos);
  println("hand stracked: " + handId);
}

// -----------------------------------------------------------------

//timer
void timedShots() {
  for (;; delay(INTERVAL))  saveFrame(dataPath("####.jpg"));
}
