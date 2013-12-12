import peasy.*;
PeasyCam cam;
PImage img;
PVector[] sphereVertexPoints;

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
  
  img = loadImage("katti2.jpg");
}

void draw() {  
  background(0); //clear screen

  //lighting
  if (lighting) {
    //valon suunta ylös, taakse, vasemmalle
    // valon sijainti oikealla, alhaalla, lähellä
    spotLight(200, 102, 126, 500, 400, 800, -1, -1, -1, PI/2, 2);
    spotLight(240, 52, 50, 100, 400, 400, 1, -1, 1, PI/2, 2);
    
    //valo joulupalloista
    pointLight(240, 52, 50, 300, 200, 600);
    pointLight(200, 52, 150, 200, 300, 500);
    pointLight(150, 52, 50, 400, 250, 700);
  }
  
  
  noFill();
  stroke(0);
  drawScene();
  
  //65 on puolet korkeudesta 130
  drawCylinder(10, 20, 130, width/2, width-65, 400);
  drawKupu(60.0, 2*PI/20, width/2, width-95, 400);
 
  drawCylinder(10, 30, 70, 430, width-35, 500);
  drawKupu(55.0, 2*PI/20, 430, width-65, 500);
  
  drawCylinder(10, 10, 60, 500, width-30, 800);
  drawKupu(32.0, 2*PI/20, 500, width-60, 800);
  
  drawCylinder(10, 15, 60, 100, width-30, 350);
  drawKupu(25.0, 2*PI/20, 100, width-60, 350);
  
  drawCylinder(10, 15, 150, 100, width-75, 770);
  drawKupu(40.0, 2*PI/20, 100, width-130, 770);
  
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

  //katto
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
  //stroke(240, 52, 50);
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
 
 //------------------------------
 
 // KATON RUUTUKUVIO
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
 
 image(img, 100, 100, 1067, 549);
}

void drawCylinder(int sides, float r, float h, int x1, int y1, int z1)
{
  
    float angle = 360 / sides;
    float halfHeight = h / 2;
    // kansi
    translate(x1, y1, z1);
    
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, -halfHeight, y );    
    }
    endShape(CLOSE);
    // pohja
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, halfHeight, y );    
    }
    endShape(CLOSE);
    
    //piirretaan lopuksi sivut
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
 

