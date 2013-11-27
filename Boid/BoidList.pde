/*BoidList object class
* Matt Wetmore
* Changelog
* ---------
* 12/18/09: Started work
*/

class BoidList
{
  ArrayList boids; //will hold the boids in this BoidList
  float h; //for color
  
  BoidList(int n,float ih)
  {
    boids = new ArrayList();
    h = ih;
    for(int i=0;i<n;i++)
      boids.add(new Boid(new PVector(width/2,height/2,600)));
  }
  
  void add()
  {
    boids.add(new Boid(new PVector(width/2,height/2,600)));
  }
  
  void addBoid(Boid b)
  {
    boids.add(b);
  }
  
  void run(boolean aW)
  {
    for(int i=0;i<boids.size();i++) //iterate through the list of boids
    {
      Boid tempBoid = (Boid)boids.get(i); //create a temporary boid to process and make it the current boid in the list
      tempBoid.h = h;
      tempBoid.avoidWalls = aW;
      tempBoid.run(boids); //tell the temporary boid to execute its run method
    }
  }
  
  Boid getBoid(int n)
  {
    if(n<boids.size())
      return (Boid)boids.get(n);
    return null;
  }
  
  void remove(int n)
  {
    if(n<boids.size())
      boids.remove(n);
  }
  
  void remove()
  {
    if(boids.size()>0)
      boids.remove(boids.size()-1);
  }
}
