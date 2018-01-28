class Spring extends Block
{
  int angle;
  float bounciness;
  
  public Spring(float x, float y, int angleIn)
  {
    super(x,y,2,2);
    angle = angleIn;
    bounciness = 15;
  }
  public Spring(float x, float y, int angleIn, float bounceIn)
  {
    super(x,y,2,2);
    angle = angleIn;
    bounciness = bounceIn;
  }
  
  public float getBounce()
  {
    return bounciness;
  }
  
  public void drawSelf(float x, float y)
  {
    drawSprite(springSprite,x,y,getWidth(),getHeight(),2*PI*(angle/4.0));
  }
}
