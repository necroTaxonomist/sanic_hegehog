class DebugBlock extends Entity
{
  public DebugBlock(float x, float y, float dx, float dy)
  {
    super(x,y,2,2,dx,dy);
    bounciness = 0;
    roughness = .5;
  }
  
  public void act(ArrayList<Actor> actors)
  {
    super.act(actors);
  }
  
  public void drawSelf(float x, float y)
  {
    noStroke(); // #360nostroke
    fill(255,0,0);
    rect((int)((x*zoom)-viewX),(int)((y*zoom)-viewY),(int)(getWidth()*zoom),(int)(getHeight()*zoom));
  }
}
