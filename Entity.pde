abstract class Entity extends Actor
{
  private float dx;
  private float dy;
  private boolean onGround;
  
  protected float bounciness;
  protected float roughness;
  protected float fallSpeed;
  protected float mass;
  
  public Entity(float x, float y, float w, float h, float dx, float dy)
  {
    super(x,y,w,h);
    this.dx = dx;
    this.dy = dy;
    onGround = false;
    bounciness = 0;
    roughness = 1.0;
    fallSpeed = 1.0;
    mass = 1.0;
  }
  
  public void act(ArrayList<Actor> actors)
  {
    dy += GRAVITY / ( FRAME_RATE / GAME_SPEED ) * fallSpeed;
    move(dx / ( FRAME_RATE / GAME_SPEED ),dy / ( FRAME_RATE / GAME_SPEED ));
    onGround = false;
    if (actors != null)
    {
      for (Actor a: actors)
      {
        if (a != this)
          processActor(a);
      }
    }
    drawSelf();
  }
  
  public void processActor(Actor a)
  {
    Collision c;
    if (a.getSlope() != 0)
      c = this.slopeCollision(a,a.getSlope());
    else
      c = this.checkCollision(a);
    
    if (c != null)
    {
      if (isSolid() < 2 && a.isSolid() > 0)
      {
        
        if (a instanceof Entity)
        {
          bounce(c,(bounciness+((Entity)a).bounciness)/2, a.isSolid() > 0);
          rub(c,roughness*((Entity)a).roughness);
        }
        else
        {
          bounce(c, a.isSolid() > 0);
          rub(c);
        }
      }
      
      if (a instanceof Liquid)
      {
        drag((Liquid)a);
      }
    }
    
    
  }
  
  public float getXSpeed() { return dx; }
  public float getYSpeed() { return dy; }
  public float getSpeed() { return sqrt(sq(dx)+sq(dy)); }
  public Vector getSpeedVect() { return new Vector(dx,dy); }
  public float getDirection() { return atan2(dy,dx); }
  public boolean isOnGround() { return onGround; }
  public float getMass() { return mass; }
  public float getMPH() { return 3600*getSpeed()/1609.344/2; }
  
  public void setSpeed(float dx, float dy)
  {
    this.dx = dx;
    this.dy = dy;
  }
  public void setSpeed(Vector v)
  {
    dx = v.getXComp();
    dy = v.getYComp();
  }
  
  
  public void accelerate(float dx, float dy)
  {
    this.dx += dx;
    this.dy += dy;
  }
  public void accelerate(Vector v)
  {
    dx += v.getXComp();
    dy += v.getYComp();
  }
  
  public void force(float dx, float dy)
  {
    this.dx += dx/mass;
    this.dy += dy/mass;
  }
  
  public void bounce(Collision c, boolean solid) { bounce(c,bounciness, solid); }
  public void bounce(Collision c, float bounceAmount, boolean solid)
  {
    if (c != null)
    {
      exitCollision(c);
      if (c.getDX() == 0)
        dy = dy*-1*bounceAmount/mass;
      else if (c.getDY() == 0)
      {
        dx = dx*-1*bounceAmount/mass;
      }
      else if (abs(c.getDX()) < abs(c.getDY()))
      {
        dx = dx*-1*bounceAmount/mass;
      }
      else if (abs(c.getDY()) < abs(c.getDX()))
      {
        dy = dy*-1*bounceAmount/mass;
        if (solid && c.getDY() > 0)
        {
          onGround = true;
        }
      }
      else
      {
        dx = dx*-1*bounceAmount/mass;
        dy = dy*-1*bounceAmount/mass;
      }
    }
  }
  
  public void rub(Collision c) { rub(c,roughness); }
  public void rub(Collision c, float friction)
  {
    if (c != null)
    {
      if (c.getDX() == 0 || abs(c.getDY()) < abs(c.getDX()) || abs(c.getDY()) == abs(c.getDX()))
      {
        float maxFric = GRAVITY / ( FRAME_RATE / GAME_SPEED ) * friction;
        if (abs(dx) < maxFric)
          dx = 0;
        else
        {
          if (dx > 0)
            dx -= maxFric;
          else if (dx < 0)
            dx += maxFric;
        }
      }
    }
  }
  
  public void repel(Collision c, float accel)
  {
    if (c != null)
    {
      float xSign = c.getDX()/abs(c.getDX())/-mass;
      float ySign = c.getDY()/abs(c.getDY())/-mass;
      exitCollision(c);
      if (c.getDX() == 0)
        dy = ySign*accel;
      else if (c.getDY() == 0)
      {
        dx = xSign*accel;
      }
      else if (abs(c.getDX()) < abs(c.getDY()))
      {
        dx = xSign*accel;
      }
      else if (abs(c.getDY()) < abs(c.getDX()))
      {
        dy = ySign*accel;
      }
      else
      {
        dx = xSign*accel;
        dy = ySign*accel;
      }
    }
  }
  
  public void drag(Liquid l)
  {
    float area = getHeight() * getWidth() / sq(PIXELS_PER_METER);
    float accel = l.getDrag(area);
    float buoyancy = l.getBouyancy(area);
    
    force(0,buoyancy);
    if (accel < getSpeed())
      force(-accel*cos(getDirection()), -accel*sin(getDirection()));
    else
      setSpeed(0,0);
  }
}
