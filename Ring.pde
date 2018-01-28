class Ring extends Item
{
  private boolean canCollect;
  
  public Ring(float x, float y)
  {
    super(x,y);
    fallSpeed = 0;
    canCollect = true;
  }
  
  public Ring(float x, float y, float dx, float dy)
  {
    super(x,y);
    setX(x);
    setY(y);
    setSpeed(dx,dy);
    fallSpeed = .5;
    canCollect = false;
    despawnTime = (int)FRAME_RATE*5;
  }
  
  public void act(ArrayList<Actor> actors)
  {
    super.act(actors);
    if (!canCollect && isOnGround())
    {
      canCollect = true;
    }
    
    if (getSpeed() < .05)
    {
      setSpeed(0,0);
      fallSpeed = 0;
    }
  }
  
  public void collect()
  {
    if (canCollect)
    {
      rings++;
      playRandomOneLiner();
      super.collect();
    }
  }
  
  public void drawSelf(float x, float y)
  {
    drawSprite(itemSprites[0],x,y,getWidth(),getHeight());
  }
  
}
