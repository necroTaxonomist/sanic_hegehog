abstract class Item extends Entity
{
  protected boolean collected;
  protected int despawnTime;
  
  public Item(float x, float y)
  {
    super(x,y,1,1,0,0);
    setX(x*PIXELS_PER_METER);
    setY(y*PIXELS_PER_METER);
    bounciness = .5;
    roughness = .5;
    fallSpeed = 0;
    collected = false;
    despawnTime = -1;
  }
  
  public void act(ArrayList<Actor> actors)
  {
    super.act(actors);
    if (despawnTime > 0)
      despawnTime--;
    if (despawnTime == 0)
      markForRemoval();
  }
  
  public void collect()
  {
    markForRemoval();
    collected = true;
  }
  
  public boolean isCollected() { return collected; }
  
  public void command(String command)
  {
    if (command.equals("collect"))
      collect();
  }
}
