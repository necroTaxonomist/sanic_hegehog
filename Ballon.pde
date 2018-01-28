class Ballon extends Entity
{
  public Ballon(float x, float y)
  {
    super(x,y,1,1,0,0);
    fallSpeed = -.25;
    bounciness = .8;
    setSolid(1);
  }
  
  public void act(ArrayList<Actor> actors)
  {
    if (randomBool())
      accelerate(random(getWidth()/100),0);
    else
      accelerate(random(getWidth()/-100),0);
    
    super.act(actors);
  }
  
  public void drawSelf(float x, float y)
  {
    fill(255,0,0);
    stroke(0);
    drawRect(x,y,getWidth(),getHeight());
  }
  
}
