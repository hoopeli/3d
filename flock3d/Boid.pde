//Boidit ovat lentäviä objekteja, jotka meidän ohjelmamme tapauksessa ovat pelikortteja

class Boid
{
  //fields
  PVector pos,vel,acc,ali,coh,sep; //pos, velocity, and acceleration in a vector datatype
  float neighborhoodRadius; //radius in which it looks for fellow boids
  float maxSpeed = 4; //maximum magnitude for the velocity vector
  float maxSteerForce = .1; //maximum magnitude of the steering vector
  float h; //hue
  float sc=9; //scale factor for the render of the boid
  float flap = 0;
  float t=0;
  int card = 0; //card's suit
  boolean avoidWalls = false;
  
  //constructors
  Boid(PVector inPos)
  {
    pos = new PVector();
    pos.set(inPos);
    vel = new PVector(random(-1,1),random(-1,1),random(1,-1));
    acc = new PVector(0,0,0);
    neighborhoodRadius = 100;
    
    //randomize the suit of the card
    card = int(random(4));
  }
  Boid(PVector inPos,PVector inVel,float r)
  {
    pos = new PVector();
    pos.set(inPos);
    vel = new PVector();
    vel.set(inVel);
    acc = new PVector(0,0);
    neighborhoodRadius = r;
    
    //randomize the suit of the card
    card = int(random(4));
  }
  
  void run(ArrayList bl)
  {
    t+=.1;
    flap = 4*sin(t);
    
    if(avoidWalls)
    {
      acc.add(PVector.mult(avoid(new PVector(pos.x,height,pos.z),true),5));
      acc.add(PVector.mult(avoid(new PVector(pos.x,0,pos.z),true),5));
      acc.add(PVector.mult(avoid(new PVector(width,pos.y,pos.z),true),5));
      acc.add(PVector.mult(avoid(new PVector(0,pos.y,pos.z),true),5));
      acc.add(PVector.mult(avoid(new PVector(pos.x,pos.y,300),true),5));
      acc.add(PVector.mult(avoid(new PVector(pos.x,pos.y,900),true),5));
    }else{
      PVector v1 = new PVector(mouseX, 0, 0);
      PVector v2 = new PVector(0, mouseY, 0); 
      acc.add(steer(new PVector(mouseX,mouseY,v1.dot(v2)),true));
    }
    flock(bl);
    move();
    checkBounds();
    render();
  }
  
  /////-----------behaviors---------------
  void flock(ArrayList bl)
  {
    ali = alignment(bl);
    coh = cohesion(bl);
    sep = seperation(bl);
    acc.add(PVector.mult(ali,1));
    acc.add(PVector.mult(coh,3));
    acc.add(PVector.mult(sep,8));
  }
  
  void scatter()
  {
    
  }
  ////------------------------------------
    
  void move()
  {
    vel.add(acc); //add acceleration to velocity
    vel.limit(maxSpeed); //make sure the velocity vector magnitude does not exceed maxSpeed
    pos.add(vel); //add velocity to position
    acc.mult(0); //reset acceleration
  }
  
  void checkBounds()
  {
    if(pos.x>width) pos.x=0;
    if(pos.x<0) pos.x=width;
    if(pos.y>height) pos.y=0;
    if(pos.y<0) pos.y=height;
    if(pos.z>900) pos.z=300;
    if(pos.z<300) pos.z=900;
  }
  
  void render()
  {
    
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    rotateY(atan2(-vel.z,vel.x));
    rotateZ(asin(vel.y/vel.mag()));
    stroke(h);
    noFill();
    noStroke();
    fill(h);
    
    //draw cards
    beginShape(QUADS);
    vertex(0,0,-2*sc);
    vertex(-3*sc,0,-2*sc);
    vertex(-3*sc,0,2*sc);
    vertex(0,0,2*sc);
    endShape();
    
    beginShape(TRIANGLES);
    vertex(0,0,0);
    vertex(0,0,-2*sc);
    vertex(3*sc,0,0);
    
    vertex(0,0,0);
    vertex(0,0,2*sc);
    vertex(3*sc,0,0);
    
    // wings
    vertex(3*sc,flap,-2*sc);
    vertex(0,0,-2*sc);
    vertex(3*sc,0,0);
    
    vertex(3*sc,flap,2*sc);
    vertex(0,0,2*sc);
    vertex(3*sc,0,0);
    
    endShape();
    
    //suits
    fill(255,0,0);
    
    //diamonds
    if (card == 0) {
      beginShape(QUADS);
      vertex(-1.5*sc,0.01,0);
      vertex(0,0.01,-1*sc);
      vertex(1.5*sc,0.01,0);
      vertex(0,0.01,1*sc);
      endShape();
    }
    
    //hearts
    if (card == 1) {
      beginShape(TRIANGLES);
      vertex(0.5*sc,0.01,-1*sc);
      vertex(0.5*sc,0.01,1*sc);
      vertex(-1.5*sc,0.01,0);
      endShape();
      
      beginShape();
      curveVertex(-3*sc,0.01,0*sc);
      curveVertex(0.5*sc,0.01,-1*sc);
      curveVertex(0.5*sc,0.01,0);
      curveVertex(-3*sc,0.01,-1*sc);
      endShape();
      
      beginShape();
      curveVertex(-3*sc,0.01,1*sc);
      curveVertex(0.5*sc,0.01,0);
      curveVertex(0.5*sc,0.01,1*sc);
      curveVertex(-3*sc,0.01,0*sc);
      endShape();
    }
    
    fill(0);
    
    //clubs
    if (card == 2) {
      beginShape(TRIANGLES);
      vertex(-0.5*sc,0.01,0);
      vertex(-1.5*sc,0.01,-0.3*sc);
      vertex(-1.5*sc,0.01,0.3*sc);
      
      vertex(-0.5*sc,0.01,-1*sc);
      vertex(1.5*sc,0.01,0);
      vertex(-0.5*sc,0.01,1*sc);
      endShape();
      
      //left
      beginShape();
      curveVertex(3*sc,0.01,0);
      curveVertex(-0.5*sc,0.01,0);
      curveVertex(-0.5*sc,0.01,-1*sc);
      curveVertex(3*sc,0.01,-1*sc);
      endShape();
      
      beginShape();
      curveVertex(-2*sc,0.01,1*sc);
      curveVertex(-0.5*sc,0.01,-1*sc);
      curveVertex(0.5*sc,0.01,-0.5*sc);
      curveVertex(-0.5*sc,0.01,1*sc);
      endShape();
      
      //middle
      beginShape();
      curveVertex(-0.5*sc,0.01,1*sc);
      curveVertex(0.5*sc,0.01,-0.5*sc);
      curveVertex(1.5*sc,0.01,0);
      curveVertex(0.5*sc,0.01,1*sc);
      endShape();
      
      beginShape();
      curveVertex(0.5*sc,0.01,-1*sc);
      curveVertex(1.5*sc,0.01,0);
      curveVertex(0.5*sc,0.01,0.5*sc);
      curveVertex(-0.5*sc,0.01,-1*sc);
      endShape();
      
      //right
      beginShape();
      curveVertex(-0.5*sc,0.01,-1*sc);
      curveVertex(0.5*sc,0.01,0.5*sc);
      curveVertex(-0.5*sc,0.01,1*sc);
      curveVertex(-2*sc,0.01,-1*sc);
      endShape();
      
      beginShape();
      curveVertex(3*sc,0.01,1*sc);
      curveVertex(-0.5*sc,0.01,1*sc);
      curveVertex(-0.5*sc,0.01,0);
      curveVertex(3*sc,0.01,0);
      endShape();
    }
    
    //spades
    if (card == 3) {
      beginShape(TRIANGLES);
      vertex(-0.5*sc,0.01,0);
      vertex(-1.5*sc,0.01,-0.3*sc);
      vertex(-1.5*sc,0.01,0.3*sc);
      
      vertex(-0.5*sc,0.01,-1*sc);
      vertex(1.5*sc,0.01,0);
      vertex(-0.5*sc,0.01,1*sc);
      endShape();
      
      beginShape();
      curveVertex(3*sc,0.01,0);
      curveVertex(-0.5*sc,0.01,0);
      curveVertex(-0.5*sc,0.01,-1*sc);
      curveVertex(3*sc,0.01,-1*sc);
      endShape();
      
      beginShape();
      curveVertex(3*sc,0.01,1*sc);
      curveVertex(-0.5*sc,0.01,1*sc);
      curveVertex(-0.5*sc,0.01,0);
      curveVertex(3*sc,0.01,0);
      endShape();
    }
    
    popMatrix();
  }
  
  //steering. If arrival==true, the boid slows to meet the target
  PVector steer(PVector target,boolean arrival)
  {
    PVector steer = new PVector(); //creates vector for steering
    if(!arrival)
    {
      steer.set(PVector.sub(target,pos)); //steering vector points towards target (switch target and pos for avoiding)
      steer.limit(maxSteerForce); //limits the steering force to maxSteerForce
    }
    else
    {
      PVector targetOffset = PVector.sub(target,pos);
      float distance=targetOffset.mag();
      float rampedSpeed = maxSpeed*(distance/100);
      float clippedSpeed = min(rampedSpeed,maxSpeed);
      PVector desiredVelocity = PVector.mult(targetOffset,(clippedSpeed/distance));
      steer.set(PVector.sub(desiredVelocity,vel));
    }
    return steer;
  }
  
  //avoid. If weight == true avoidance vector is larger the closer the boid is to the target
  PVector avoid(PVector target,boolean weight)
  {
    PVector steer = new PVector(); //creates vector for steering
    steer.set(PVector.sub(pos,target)); //steering vector points away from target
    if(weight)
      steer.mult(1/sq(PVector.dist(pos,target)));
    return steer;
  }
  
  PVector seperation(ArrayList boids)
  {
    PVector posSum = new PVector(0,0,0);
    PVector repulse;
    for(int i=0;i<boids.size();i++)
    {
      Boid b = (Boid)boids.get(i);
      float d = PVector.dist(pos,b.pos);
      if(d>0&&d<=neighborhoodRadius)
      {
        repulse = PVector.sub(pos,b.pos);
        repulse.normalize();
        repulse.div(d);
        posSum.add(repulse);
      }
    }
    return posSum;
  }
  
  PVector alignment(ArrayList boids)
  {
    PVector velSum = new PVector(0,0,0);
    int count = 0;
    for(int i=0;i<boids.size();i++)
    {
      Boid b = (Boid)boids.get(i);
      float d = PVector.dist(pos,b.pos);
      if(d>0&&d<=neighborhoodRadius)
      {
        velSum.add(b.vel);
        count++;
      }
    }
    if(count>0)
    {
      velSum.div((float)count);
      velSum.limit(maxSteerForce);
    }
    return velSum;
  }
  
  PVector cohesion(ArrayList boids)
  {
    PVector posSum = new PVector(0,0,0);
    PVector steer = new PVector(0,0,0);
    int count = 0;
    for(int i=0;i<boids.size();i++)
    {
      Boid b = (Boid)boids.get(i);
      float d = dist(pos.x,pos.y,b.pos.x,b.pos.y);
      if(d>0&&d<=neighborhoodRadius)
      {
        posSum.add(b.pos);
        count++;
      }
    }
    if(count>0)
    {
      posSum.div((float)count);
    }
    steer = PVector.sub(posSum,pos);
    steer.limit(maxSteerForce); 
    return steer;
  }
}
