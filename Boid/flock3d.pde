/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/7054*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
/*Main runner area
* Matt Wetmore
* Changelog
* ---------
* 12/14/09: Started work
* 12/18/09: Reimplemented with BoidList class
* 1/12/09: Added lots of good stuff. user settings, etc
*/

int initBoidNum = 200; //amount of boids to start the program with
BoidList flock1;//,flock2,flock3;
float zoom=800,rX=0,rY=0; //camera variables
boolean smoothEdges = false,avoidWalls = false,lighting = false,movingCamera=false; //some booleans for user settings
int spaceCounter = 0; //counter variables


void setup()
{
  size(600,600,P3D);
  //create and fill the list of boids
  flock1 = new BoidList(initBoidNum,255);
  //flock2 = new BoidList(100,0);
  //flock3 = new BoidList(100,128);
  
  //mousewheel code. Hacky...
  addMouseWheelListener(new java.awt.event.MouseWheelListener() { 
    public void mouseWheelMoved(java.awt.event.MouseWheelEvent evt) { 
      mouseWheel(evt.getWheelRotation());
  }}); 
}

void draw()
{  
  handleCounters(); //for keypresses, etc
  handleCamera(); //all the camera code. 
  background(205); //clear screen
  if(lighting) //if the user wants some lighting...
    directionalLight(255,255,255, 0, 1, -100); //...give him some lighting
  noFill();
  stroke(0);
  drawBounds();
  flock1.run(avoidWalls);
  //flock2.run(avoidWalls);
  //flock3.run(avoidWalls);
  if(smoothEdges) //if the user wants antialiasing...
    smooth(); 
  else
    noSmooth();
  println(frameRate); //print the framerate
}

//--------------------------------
//handle keys
void keyPressed()
{
  switch (keyCode)
  {
    case UP: zoom-=10; break;
    case DOWN: zoom+=10; break;
  }
  switch (key)
  {
    case 's': smoothEdges = !smoothEdges; break;
    case 'a': avoidWalls = !avoidWalls; break;
    case 'd': lighting = !lighting; break;
    case '=': flock1.add(); break;
    case '-': flock1.remove(); break;
  }
}

void keyReleased()
{
  switch(key)
  {
  }
}
//--------------------------------
//handle mouse events
void mousePressed()
{
  switch(mouseButton)
  {
    case RIGHT: if(spaceCounter>0 && !movingCamera){rX=0;rY=0;} if(!movingCamera)spaceCounter = 30; movingCamera = true; break;
  }
}

void mouseReleased()
{
  switch(mouseButton)
  {
    case RIGHT: movingCamera = false; break;
  }
}

void mouseWheel(int delta)
{
  zoom+=delta*100;
}
//--------------------------------

void drawBounds()
{
  stroke(0,255,0);
  line(0,0,300,  0,height,300);
  stroke(0);
  line(0,0,900,  0,height,900);
  stroke(255,0,0);
  line(0,0,300,  width,0,300);
  stroke(0);
  line(0,0,900,  width,0,900);
  
  line(width,0,300,  width,height,300);
  line(width,0,900,  width,height,900);
  line(0,height,300,  width,height,300);
  line(0,height,900,  width,height,900);
  
  stroke(0,0,255);
  line(0,0,300,  0,0,900);
  stroke(0);
  line(0,height,300,  0,height,900);
  line(width,0,300,  width,0,900);
  line(width,height,300,  width,height,900);
}

void handleCounters()
{
  if(spaceCounter>0)
    spaceCounter--;
}

void handleCamera()
{
  //camera controls
  beginCamera();
  camera();
  //translate(b.pos.x+10,b.pos.y,b.pos.z);
  //rotateY(atan2(-b.vel.z,b.vel.x));
  //rotateZ(asin(b.vel.y/b.vel.mag()));
  if(movingCamera)
  {
    rY -= (mouseX-pmouseX)*.01;
    rX += (mouseY-pmouseY)*.01;
    //rX = (map(mouseY,0,height,0,TWO_PI)); //old camera controls
    //rY = (map(mouseX,width,0,0,TWO_PI));  //kept just in case...
  }
  rotateX(rX);
  rotateY(rY);
  translate(0,0,zoom);
  endCamera();
}
