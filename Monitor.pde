class Monitor extends Actor
{
  private int type;
  protected boolean collected;
  
  public Monitor(float x, float y, int typeIn)
  {
    super(x,y,2,2);
    setSolid(2);
    
    type = typeIn;
    collected = false;
  }
  
  public void act(ArrayList<Actor> actors)
  {
    drawSelf();
  }
  
  public void collect()
  {
    if (!collected)
    {
      playSound(0);
      if (type == 0)
      {
        rings += 10;
        playRandomOneLiner();
      }
      if (type == 1)
      {
        shield = true;
      }
      if (type == 2)
      {
        lives++;
      }
      if (type == 3)
      {
        sparklies += 20*FRAME_RATE;
        loadMusic(10);
      }
      
      collected = true;
      markForRemoval();
    }
  }
  
  public void drawSelf(float x, float y)
  {
    drawSprite(monitorSprites[type],x,y,getWidth(),getHeight());
  }
  
  public void command(String command)
  {
    if (command.equals("collect") && !collected)
      collect();
  }
  
}
