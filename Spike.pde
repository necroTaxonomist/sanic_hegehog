class Spike extends Block
{
  public Spike(float x, float y)
  {
    super(x,y,1,1);
  }
  
  public void drawSelf(float x, float y)
  {
    drawSprite(spikeSprite,x,y,getWidth(),getHeight());
  }
}
