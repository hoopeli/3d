import peasy.*;
PeasyCam cam;

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
}

void draw() {  
  background(0); //clear screen

  //lighting
  if (lighting) {
    //valon suunta ylös, taakse, vasemmalle
    // valon sijainti oikealla, alhaalla, lähellä
    spotLight(200, 102, 126, 500, 400, 800, -1, -1, -1, PI/2, 2);
    
    spotLight(240, 52, 50, 100, 400, 400, 1, -1, 1, PI/2, 2);
    
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

  noStroke();
  fill(255);
  beginShape(QUADS);
  
  vertex(0, 0, 300); // vasen takakulma
  vertex(0, 0, 900); // vasen lahikulma
  vertex(600, 0, 900); // oikea lahikulma
  vertex(600, 0, 300); //oikea takakulma
  endShape();
  
  // vasemman sivun kolmiot
  beginShape(TRIANGLES);
  vertex(0, 0, 300);
  vertex(0, 300, 300);
  vertex(0, 0, 600);
  //takimmainen ylakulma
  
  vertex(0, 300, 300); 
  vertex(0, 600, 300);
  vertex(0, 600, 600);
  // takimmainen alakulma
  
  vertex(0, 600, 600);
  vertex(0, 600, 900);
  vertex(0, 300, 900);
  // lahella alakulma
  
  vertex(0, 0, 600);
  vertex(0, 0, 900);
  vertex(0, 300, 900);
  // lahella ylakulma
  endShape();
  
  // oikean sivun kolmiot
  beginShape(TRIANGLES);
  vertex(600, 0, 300);
  vertex(600, 300, 300);
  vertex(600, 0, 600);
  //takimmainen ylakulma
  
  vertex(600, 300, 300); 
  vertex(600, 600, 300);
  vertex(600, 600, 600);
  // takimmainen alakulma
  
  vertex(600, 600, 600);
  vertex(600, 600, 900);
  vertex(600, 300, 900);
  // lahella alakulma
  
  vertex(600, 0, 600);
  vertex(600, 0, 900);
  vertex(600, 300, 900);
  // lahella ylakulma
  endShape();
  
  //langat
  stroke(100);
  line(300, 0, 600, 300, 200, 600);
  line(400, 0, 700, 400, 250, 700);
  line(200, 0, 500, 200, 300, 500);


  //PALLOJA
  //keskella
  translate(300, 200, 600);
  noStroke();
  sphere(30);
  translate(-300, -200, -600);
  
  //taaempana
  translate(200, 300, 500);
  noStroke();
  sphere(30);
  translate(-200,-300,-500);
  
  translate(400, 250, 700);
  noStroke();
  sphere(30);
  translate(-400,-250,-700);
 
 //--------------------------
 
 //LATTIA
 // kai tän vois loopillakin tehdä
 stroke(100);
 line(0, 600, 300, 600, 600, 300);
 line(0, 600, 350, 600, 600, 350);
 line(0, 600, 400, 600, 600, 400);
 line(0, 600, 450, 600, 600, 450);
 line(0, 600, 500, 600, 600, 500);
 line(0, 600, 550, 600, 600, 550);
 line(0, 600, 600, 600, 600, 600);
 line(0, 600, 650, 600, 600, 650);
 line(0, 600, 700, 600, 600, 700);
 line(0, 600, 750, 600, 600, 750);
 line(0, 600, 800, 600, 600, 800);
 line(0, 600, 850, 600, 600, 850);
 line(0, 600, 900, 600, 600, 900);
 
 
}
