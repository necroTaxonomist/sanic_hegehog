class Caterpillar extends Enemy
{
  
  private int direction;
  private int beatMax;
  private int beat;
  private int oscillate;
  
  public Caterpillar(float x, float y, int dirIn, int beatIn)
  {
    super(x,y,1,1.5,100,caterpillarSprite);
    bounciness = 0;
    fallSpeed = 2;
    
    direction = dirIn;
    beatMax = beatIn;
    beat = 0;
    oscillate = direction;
  }
  
  public void act(ArrayList<Actor> actors)
  {
    if (onScreen() && isOnGround())
    {
      beat++;
      if (beat >= beatMax)
      {
        beat = 0;
        if (oscillate == direction)
        {
          accelerate(getWidth()/12*oscillate,0);
        }
        else
        {
          accelerate(getWidth()/14*oscillate,0);
        }
        oscillate *= -1;
      }
      
    }
    super.act(actors);
  }
  
}
