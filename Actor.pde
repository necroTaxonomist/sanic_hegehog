abstract class Actor
{
  private float x, y;
  private float w, h;
  private int solid;
  private boolean markedForRemoval;
  private int slopeDir;
  
  public Actor(float x, float y, float w, float h)
  {
    this.x = x*PIXELS_PER_METER;
    this.y = y*PIXELS_PER_METER;
    this.w = w*PIXELS_PER_METER;
    this.h = h*PIXELS_PER_METER;
    this.solid = 0;
    this.markedForRemoval = false;
    this.slopeDir = 0;
  }
  
  public float getX() { return x; }
  public float getY() { return y; }
  public float getWidth() { return w; }
  public float getHeight() { return h; }
  public int isSolid() { return solid; }
  public boolean shouldRemove() { return markedForRemoval; }
  public int getSlope() { return slopeDir; }
  
  public void setX(float input) { x = input; }
  public void setY(float input) { y = input; }
  public void setWidth(float input) { w = input; }
  public void setHeight(float input) { h = input; }
  public void setSolid(int input) { solid = input; }
  public void markForRemoval() { markedForRemoval = true; }
  public void setSlope(int input) { slopeDir = input; }
  
  public void move(float byX, float byY)
  {
    x += byX*PIXELS_PER_METER;
    y += byY*PIXELS_PER_METER;
  }
  
  public Collision checkCollision(Actor other)
  {
    //println("" + x + "<" + (other.getX() + other.getWidth()));
    if (x < other.getX() + other.getWidth() && other.getX() < x + w &&
           y < other.getY() + other.getHeight() && other.getY() < y + h)
    {
      float dx, dy;      
      
      if (x == other.getX())
        dx = 0;
      else if (x < other.getX())
        dx = x + w - other.getX();
      else if (x > other.getX())
        dx = -1*(other.getX() + other.getWidth() - x);
      else
        dx = 0;
      
      if (y == other.getY())
        dy = 0;
      else if (y + h < other.getY() + other.getHeight())
        dy = y + h - other.getY();
      else if (y + h > other.getY() + other.getHeight())
        dy = -1*(other.getY() + other.getHeight() - y);
      else
        dy = 0;
        
      float distX, distY, angle;
      distX = (other.getX() + other.getWidth() / 2) - (x + w / 2);
      distY = (other.getY() + other.getHeight() / 2) - (y + h / 2);
      
      if (distX > 0 && distY > 0)
        angle = 2*PI - atan(distY/distX);
      else if (distX > 0 && distY < 0)
        angle = 0 - atan(distY/distX);
      else if (distX < 0 && distY > 0)
        angle = PI - atan(distY/distX);
      else if (distX < 0 && distY < 0)
        angle = PI - atan(distY/distX);
      else if (distX == 0 && distY > 0)
        angle = 3*PI/2;
      else if (distX == 0 && distY < 0)
        angle = PI/2;
      else
        angle = 90;
      
      return new Collision(dx,dy, angle);
    }
    else
      return null;
  }
  
  public Collision exitCollision(Collision c)
  {
    if (c == null)
      return c;
    
    /*if ((45 < c.getAngle() && c.getAngle() < 135) || (225 < c.getAngle() && c.getAngle() < 315))
    {
      y -= c.getDY();
    }
    if ((c.getAngle() < 45 || c.getAngle() > 315) || (135 < c.getAngle() && c.getAngle() < 225))
    {
      x -= c.getDX();
    }*/
    
    if (c.getDX() == 0)
      y -= c.getDY();
    else if (c.getDY() == 0)
      x -= c.getDX();
    else if (abs(c.getDX()) < abs(c.getDY()))
      x -= c.getDX();
    else if (abs(c.getDY()) < abs(c.getDX()))
      y -= c.getDY();
    else
    {
      x -= c.getDX();
      y -= c.getDY();
    }
    
    return c;
  }
  
  public Collision exitActor(Actor a)
  {
    return exitCollision(checkCollision(a));
  }
  
  public Collision slopeCollision(Actor other, int direction)
  {
    float topBound = 0.0, leftBound = 0.0, rightBound = 0.0;
    
    if (direction == 1) //facing right
    {
      if (x < other.getX())
        topBound = other.getY();
      else
        topBound = other.getHeight()/other.getWidth()*(x - other.getX()) + other.getY();
      
      leftBound = other.getX();
      
      if (y + h > other.getY() + other.getHeight())
        rightBound = other.getX() + other.getWidth();
      else
        rightBound = other.getWidth()/other.getHeight()*((y+h) - other.getY()) + other.getX();
    }
    if (direction == -1)
    {
      if (x + w > other.getX() + other.getWidth())
        topBound = other.getY();
      else
        topBound = other.getY() + other.getHeight() - other.getHeight()/other.getWidth()*((x+w) - other.getX());

      /*if (y < other.getY())
        leftBound = other.getX();
      else*/
        leftBound = other.getX() + other.getWidth() - other.getWidth()/other.getHeight()*((y+h) - other.getY());
      
      rightBound = other.getX() + other.getWidth();
    }
    
    if (x < rightBound && leftBound < x + w &&
           y < other.getY() + other.getHeight() && topBound < y + h)
    {
      float dx, dy;      
      
      if (x == leftBound)
        dx = 0;
      else if (x < leftBound)
        dx = x + w - leftBound;
      else if (x > leftBound)
        dx = -1*(rightBound - x);
      else
        dx = 0;
      
      if (y == topBound)
        dy = 0;
      else if (y + h < other.getY() + other.getHeight())
        dy = y + h - topBound;
      else if (y + h > other.getY() + other.getHeight())
        dy = -1*(other.getY() + other.getHeight() - y);
      else
        dy = 0;
        
      float distX, distY, angle;
      distX = (other.getX() + other.getWidth() / 2) - (x + w / 2);
      distY = (other.getY() + other.getHeight() / 2) - (y + h / 2);
      
      if (distX > 0 && distY > 0)
        angle = 2*PI - atan(distY/distX);
      else if (distX > 0 && distY < 0)
        angle = 0 - atan(distY/distX);
      else if (distX < 0 && distY > 0)
        angle = PI - atan(distY/distX);
      else if (distX < 0 && distY < 0)
        angle = PI - atan(distY/distX);
      else if (distX == 0 && distY > 0)
        angle = 3*PI/2;
      else if (distX == 0 && distY < 0)
        angle = PI/2;
      else
        angle = 90;
      
      return new Collision(dx,dy, angle);
    }
    else
      return null;
  }
  
  
  public void act()
  {
    act(null);
  }
  public abstract void act(ArrayList<Actor> actors);
  
  public void drawSelf()
  {
    drawSelf(x,y);
  }
  public abstract void drawSelf(float x, float y);
  
  public void command(String command)
  {
  }
  
  public float distanceTo(Actor a)
  {
    float xs = sq( x+w/2 - (a.getX()+a.getWidth()/2) );
    float ys = sq( y+h/2 - (a.getY()+a.getHeight()/2) );
    return sqrt(xs + ys);
  }
  
  public boolean onScreen()
  {
    return tileOnScreen(x,y,w,h);
  }
  
  public float[] centerCoords()
  {
    float[] coords = new float[2];
    coords[0] = x+w/2;
    coords[1] = y+h/2;
    return coords;
  }
  public float centerCoords(int which)
  {
    if (which == 0)
      return x+w/2;
    else if (which == 1)
      return y+h/2;
    else
      return -1;
  }
  
  public String toString()
  {
    return "Actor at " + "(" + x + ", " + y + ")";
  }
}
