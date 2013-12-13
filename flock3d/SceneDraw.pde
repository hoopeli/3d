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
  translate(-200, -300, -500);

  translate(400, 250, 700);
  noStroke();
  sphere(30);
  translate(-400, -250, -700);

  //--------------------------


  //RUOHIKKO
  // ruohikon tekeminen jaettu kahteen vuorottelevaan riviin
  for (int x = 1; x < 600; x += 20) {
    for (int z = 300; z < 899; z += 20) {
      stroke(80, 210, 20);
      line(x, 600, z, x, 555, z);
    }
  }

  for (int x = 11; x < 600; x += 20) {
    for (int z = 310; z < 899; z += 20) {
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
  fill(200, 100, 100);
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
  pushMatrix();
  translate(-400, -250, -900);
  image(img, -200, 80, 1814, 933);
  popMatrix();
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

  //pohjan ja kannen välillä olevat tahkot
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
  for (float phi = 0.0; phi < HALF_PI; phi += f) {
    beginShape(QUAD_STRIP);
    for (float theta = 0.0; theta < TWO_PI + f; theta += f) {
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

void drawInstructions() {
  //fill(255,255,255); //Fade in from black

  cam.beginHUD();
  pushMatrix();
  fill(0);
  rect(0, 0, width, height);
  //fill(0);
  translate(10, 50);
  //fill(255,255,255);
  //rect(100,100,600,600);

  textFont(font);
  textSize(60);
  fill(255, 255, 255);
  text("Liisa ihmemaassa", 0, 0);
  textSize(30);
  text("Hiiri", 0, 40);
  textSize(20);
  text("Oikea - zoomaus...", 0, 70);
  text("Vasen - siirrä näkymää...", 0, 100);
  text("Center - Siirry kaksiulotteisesti...", 0, 130);
  textSize(30);
  text("Näppäimistö", 0, 160);
  textSize(20);
  text("A - Aktivoi törmäystarkastelu seiniin...", 0, 190);
  text("Q/W - Lisää/poista kortteja...", 0, 220);
  text("E - Sienet kasvaa...", 0, 250);
  textSize(40);
  text("Paina hiiren vasenta nappia jatkaaksesi...", 0, 290);
  popMatrix();
  cam.endHUD();
}

