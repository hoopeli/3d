import peasy.*;
import ddf.minim.*;

PeasyCam cam;
PImage img;
PVector[] sphereVertexPoints;

int initBoidNum = 200; //amount of boids to start the program with
BoidList flock1; //,flock2,flock3;
boolean smoothEdges = false, avoidWalls = false, lighting = true; //some booleans for user settings

int kor1 = 150;
int kor2 = 90;
int kor3 = 80;
int kor4 = 80;
int kor5 = 170;
int startTime;
int growTime;

PFont font;

//music
Minim minim;
AudioPlayer aplayer;

void setup() {
  size(600, 600, P3D);

  //create and fill the list of boids
  flock1 = new BoidList(initBoidNum, 255);
  //flock2 = new BoidList(100,0);
  //flock3 = new BoidList(100,128);

  //peasycam
  cam = new PeasyCam(this, 300, 300, 600, 800);
  cam.setMaximumDistance(4000);

  img = loadImage("katti2.jpg");
  font = loadFont("Aparajita-48.vlw");

  //music
  minim = new Minim(this);
  aplayer = minim.loadFile("Waltzinblack.mp3"); //The Stranglers - Waltzinblack
  aplayer.play(); // play music
  aplayer.loop(); // loop song
  //aplayer.setGain(50); // more volume

  startTime = millis();
  growTime = millis();
}

void draw() {  
  background(0); //clear screen

  //lighting
  if (lighting) {
    // valon suunta ylös, taakse, vasemmalle
    // valon sijainti oikealla, alhaalla, lähellä
    spotLight(200, 102, 166, 500, 400, 800, -1, -1, -1, PI/2, 2);
    spotLight(240, 52, 50, 100, 400, 400, 1, -1, 1, PI/2, 2);

    // joulupallojen valoja
    pointLight(240, 52, 50, 300, 200, 600);
    pointLight(200, 52, 150, 200, 300, 500);
    pointLight(120, 52, 100, 400, 250, 700);
  }


  noFill();
  stroke(0);
  drawScene();

  // Alkuohjeet, valaistus pitää ottaa pois, jottei varjossa oleminen haittaa
  if (startTime < 10000) {
    lighting = false;  
    drawInstructions(); //Title and instructions
  }
  //lighting takaisin päälle
  if (startTime > 10000) {
    lighting = true;
  }
  
  //Sienet
  drawCylinder(10, 20, kor1, width/2, width-(kor1/2), 400);
  drawKupu(60.0, 2*PI/20, width/2, width-kor1, 400);

  drawCylinder(10, 30, kor2, 430, width-(kor2/2), 500);
  drawKupu(55.0, 2*PI/20, 430, width-kor2, 500);

  drawCylinder(10, 10, kor3, 500, width-(kor3/2), 800);
  drawKupu(32.0, 2*PI/20, 500, width-kor3, 800);

  drawCylinder(10, 15, kor4, 100, width-(kor4/2), 350);
  drawKupu(25.0, 2*PI/20, 100, width-kor4, 350);

  drawCylinder(10, 15, kor5, 100, width-(kor5/2), 770);
  drawKupu(40.0, 2*PI/20, 100, width-kor5, 770);

  flock1.run(avoidWalls);
  //flock2.run(avoidWalls);
  //flock3.run(avoidWalls);

  /* // antialiasing
  if (smoothEdges){
  smooth();
  }
  
  else {
  noSmooth();
  }
  */
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
  case 'q': 
    flock1.add(); 
    break;
  case 'w': 
    flock1.remove(); 
    break;
  case 'e':
    for (int i = 10; i < 20; i++) {
      if (millis() > growTime + 10) {
        if (kor2 < 500) {
          growTime = millis();
          // lisäys sienien korkeuksiin
          kor1 = kor1 + i;
          kor2 = kor2 + 2*i;
          kor3 = kor3 + 2*i;
          kor4 = kor4 + 2*i;
          kor5 = kor5 + i;
        }
      }
    }
    break;
  }
}
void mousePressed() {
  if(startTime < 11000){
    startTime = 20000;
  }
}
