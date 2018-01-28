class Block extends Actor
{
  public Block(float x, float y, float w, float h)
  {
    super(x,y,w,h);
    setSolid(2);
  }
  
  public void act(ArrayList<Actor> actors)
  {
    drawSelf();
  }
  
  public void drawSelf(float x, float y)
  {
    noStroke(); // #360nostroke
    fill(0,0,0);
    rect((int)((x*zoom)-viewX),(int)((y*zoom)-viewY),(int)(getWidth()*zoom),(int)(getHeight()*zoom));
  }
}
