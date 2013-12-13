
import peasy.*;
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
  
  startTime = millis();
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
    //pointLight(240, 52, 50, 300, 200, 600);
   // pointLight(200, 52, 150, 200, 300, 500);
    pointLight(120, 52, 100, 400, 250, 700);
    
  }
  
  
  noFill();
  stroke(0);
  drawScene();
  
  // piirtää sienet
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
  case 'q': 
    flock1.add(); 
    break;
  case 'w': 
    flock1.remove(); 
    break;
  case 'e':
    for (int i = 10; i < 20; i++) {
    if (millis() > startTime + 10){
      if (kor2 < 500) {
      startTime = millis();
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

//--------------------------------

void drawScene() {

  // KATTO
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
  
 // OIKEAN SIVUN SYDANIKKUNA
  beginShape();
  vertex(600, 0, 750);
  curveVertex(600, 0, 750);
  curveVertex(600, 60, 865);
  curveVertex(600, 200, 900);
  curveVertex(600, 200, 900);
  vertex(600, 0, 900);
  
  vertex(600, 0, 750);
  curveVertex(600, 0, 750);
  curveVertex(600, 20, 670);
  curveVertex(600, 140, 600);
  curveVertex(600, 140, 600);
  vertex(600, 0, 600);
  endShape();
  
  beginShape();
  vertex(600, 600, 600);
  vertex(600, 600, 900);
  vertex(600, 200, 900);
  endShape();
  
  beginShape();
  vertex(600, 200, 300);
  curveVertex(600, 200, 300);
  curveVertex(600, 60, 335);
  curveVertex(600, 0, 450);
  curveVertex(600, 0, 450);
  vertex(600, 0, 300);
  endShape();
  
  beginShape();
  vertex(600, 0, 450);
  curveVertex(600, 0, 450);
  curveVertex(600, 20, 530);
  curveVertex(600, 140, 600);
  curveVertex(600, 140, 600);
  vertex(600, 0, 600);
  endShape();
   
  beginShape();
  vertex(600, 600, 600);
  vertex(600, 600, 300);
  vertex(600, 200, 300);
  endShape();
  
  //LANGAT
  stroke(100);
  line(300, 0, 600, 300, 200, 600);
  line(400, 0, 700, 400, 250, 700);
  line(200, 0, 500, 200, 300, 500);


  //PALLOJA
  translate(300, 200, 600);
  noStroke();
  sphere(30);
  translate(-300, -200, -600);
  
  translate(200, 300, 500);
  noStroke();
  sphere(30);
  translate(-200,-300,-500);
  
  translate(400, 250, 700);
  noStroke();
  sphere(30);
  translate(-400,-250,-700);
 
 //--------------------------
 
 
 //RUOHIKKO
 // ruohikon tekeminen jaettu kahteen vuorottelevaan riviin
 for(int x = 1; x < 600; x += 20) {
    for(int z = 300; z < 899; z += 20) {
      stroke(80, 210, 20);
      line(x, 600, z, x, 555, z);
    }
  }
  
  for(int x = 11; x < 600; x += 20) {
    for(int z = 310; z < 899; z += 20) {
      stroke(80, 210, 20);
      line(x, 600, z, x, 555, z);
    }
  }
 
 
 //------------------------------
 
 // KATON RUUTUKUVIO
 // kolmiot
 beginShape(TRIANGLES);
 fill(200, 100, 100);
 noStroke();
 vertex(0, 1, 900);
 vertex(100, 1, 800);
 vertex(0, 1, 700);
 
 vertex(600, 1, 900);
 vertex(600, 1, 700);
 vertex(500, 1, 800);
 
 vertex(0, 1, 700);
 vertex(100, 1, 600);
 vertex(0, 1, 500);
 
 vertex(600, 1, 700);
 vertex(600, 1, 500);
 vertex(500, 1, 600);
 
 vertex(0, 1, 500);
 vertex(100, 1, 400);
 vertex(0, 1, 300);
 
 vertex(600, 1, 500);
 vertex(600, 1, 300);
 vertex(500, 1, 400);
 endShape();
 
 // neliöt
 beginShape(QUADS);
 fill(200,100,100);
 noStroke();
 vertex(200, 1, 900);
 vertex(100, 1, 800);
 vertex(200, 1, 700);
 vertex(300, 1, 800);
 
 vertex(300, 1, 800);
 vertex(400, 1, 900);
 vertex(500, 1, 800);
 vertex(400, 1, 700);
 
 vertex(100, 1, 600);
 vertex(200, 1, 700);
 vertex(300, 1, 600);
 vertex(200, 1, 500);
 
 vertex(300, 1, 600);
 vertex(400, 1, 700);
 vertex(500, 1, 600);
 vertex(400, 1, 500);
 
 vertex(100, 1, 400);
 vertex(200, 1, 500);
 vertex(300, 1, 400);
 vertex(200, 1, 300);
 
 vertex(300, 1, 400);
 vertex(400, 1, 500);
 vertex(500, 1, 400);
 vertex(400, 1, 300);
 endShape();
 
 //------------------------------
 
 //KISSA
 image(img, -200, 80, 1067, 549);
}

void drawCylinder(int sides, float r, float h, int x1, int y1, int z1)
{
    float angle = 360 / sides;
    float halfHeight = h / 2;
   
    translate(x1, y1, z1);
    
    // kansi, monikulmio
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, -halfHeight, y );    
    }
    endShape(CLOSE);
    
    // pohja, monikulmio
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, halfHeight, y );    
    }
    endShape(CLOSE);
    
     // pohjan ja kannen välillä olevat tahkot
beginShape(TRIANGLE_STRIP);
for (int i = 0; i < sides + 1; i++) {
    float x = cos( radians( i * angle ) ) * r;
    float y = sin( radians( i * angle ) ) * r;
    vertex( x, halfHeight, y);
    vertex( x, -halfHeight, y);    
}
endShape(CLOSE);
translate(-x1, -y1, -z1);
}


void drawKupu(float r, float f, int x1, int y1, int z1) {
  noStroke();
  fill(200, 30, 49);
  
  float rho = r;
  float x, y, z;
  
  translate(x1, y1, z1);
  
  // puolipallon piirtäminen kartionsiivu kerrallaan
  for(float phi = 0.0; phi < HALF_PI; phi += f) {
    beginShape(QUAD_STRIP);
    for(float theta = 0.0; theta < TWO_PI + f; theta += f) {
      x = rho * sin(phi) * cos(theta);
      z = rho * sin(phi) * sin(theta);
      y = -rho * cos(phi);
      
      vertex(x, y, z);
      
      x = rho * sin(phi + f) * cos(theta);
      z = rho * sin(phi + f) * sin(theta);
      y = -rho * cos(phi + f);
      
      vertex(x, y, z);
    }
    endShape(CLOSE);
  }

  translate(-x1, -y1, -z1);
}

