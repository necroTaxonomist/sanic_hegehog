class Water extends Liquid
{
  public Water(float x, float y, float w, float h)
  {
    super(x,y,w,h,.015, .002);
  }
  
  public void drawSelf(float x, float y)
  {
    noStroke(); // #360nostroke
    fill(0, 0, 255, 64);
    rect((int)((x*zoom)-viewX),(int)((y*zoom)-viewY),(int)(getWidth()*zoom),(int)(getHeight()*zoom));
  }
}
