
import peasy.*;
PeasyCam cam;

PImage bg;

int initBoidNum = 200; //amount of boids to start the program with
BoidList flock1; //,flock2,flock3;
boolean smoothEdges = false, avoidWalls = false, lighting = true; //some booleans for user settings


void setup() {
  size(600, 600, P3D);

  //create and fill the list of boids
  flock1 = new BoidList(initBoidNum, 255);
  //flock2 = new BoidList(100,0);
  //flock3 = new BoidList(100,128);

  //peasycam
  cam = new PeasyCam(this, 300, 300, 600, 800);
  cam.setMaximumDistance(4000);

  //background image
  bg = loadImage("bg.jpg");
}

void draw() {  
  background(0); //clear screen

  //lighting
  if (lighting) {
    directionalLight(255, 0, 0, 0, 1, -100);
    directionalLight(0, 255, 0, 0, 1, 100);
  }

  noFill();
  stroke(0);
  drawScene();
  flock1.run(avoidWalls);
  //flock2.run(avoidWalls);
  //flock3.run(avoidWalls);

  // antialiasing
  if (smoothEdges) {
    smooth();
  } 
  else {
    noSmooth();
  }

  println(frameRate); //print the framerate
}

//--------------------------------
//handle keys
void keyPressed() {
  switch (key) {
  case 's': 
    smoothEdges = !smoothEdges; 
    break;
  case 'a': 
    avoidWalls = !avoidWalls; 
    break;
  case 'd': 
    lighting = !lighting; 
    break;
  case '=': 
    flock1.add(); 
    break;
  case '-': 
    flock1.remove(); 
    break;
  }
}

//--------------------------------

void drawScene() {
  //cube lines  
  stroke(0, 255, 0);
  line(0, 0, 300, 0, height, 300);
  stroke(0, 0, 255);
  line(0, 0, 900, 0, height, 900);
  stroke(255, 0, 0);
  line(0, 0, 300, width, 0, 300);
  line(0, 0, 900, width, 0, 900);

  line(width, 0, 300, width, height, 300);
  line(width, 0, 900, width, height, 900);
  line(0, height, 300, width, height, 300);
  line(0, height, 900, width, height, 900);

  stroke(0, 0, 255);
  line(0, 0, 300, 0, 0, 900);
  stroke(255, 0, 0);
  line(0, height, 300, 0, height, 900);
  line(width, 0, 300, width, 0, 900);
  line(width, height, 300, width, height, 900);
  
  //cube sides
  noStroke();
  fill(255);
  beginShape(QUADS);
  //vertex(0, 0, 300);
  //vertex(0, height, 300);
  //vertex(width, height, 300);
  //vertex(width, 0, 300);
  
  vertex(0, 0, 300);
  vertex(0, height, 300);
  vertex(0, height, 900);
  vertex(0, 0, 900);
  endShape();
  
  beginShape(TRIANGLES);
  vertex(width/2, 0, 300);
  vertex(0, 0, 300);
  vertex(0, 0, 600);
  
  vertex(0, 0, 600);
  vertex(0, 0, 900);
  vertex(width/2, 0, 900);
  
  vertex(width/2, 0, 900);
  vertex(width, 0, 900);
  vertex(width, 0, 600);
  
  vertex(width, 0, 600);
  vertex(width, 0, 300);
  vertex(width/2, 0, 300);
  endShape();
  
  //other shapes
}

