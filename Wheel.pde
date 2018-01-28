class Wheel extends Enemy
{
  
  private float maxSpeed;
  private int direction;
  
  public Wheel(float x, float y, int dirIn)
  {
    super(x,y,2,2,100,wheelSprite);
    bounciness = .25;
    fallSpeed = 2;
    
    maxSpeed = getWidth()/64;
    direction = dirIn*(int)FRAME_RATE*3+1;
  }
  
  public void act(ArrayList<Actor> actors)
  {
    if (onScreen() && isOnGround())
    {
      if (!seenSanic())
      {
        if (abs(getXSpeed()) < maxSpeed)
        {
          accelerate(GRAVITY / ( FRAME_RATE / GAME_SPEED ) * roughness * 2 * (direction/abs(direction)),0);
        }
        else
        {
          //accelerate(GRAVITY / ( FRAME_RATE / GAME_SPEED ) * roughness * (direction/abs(direction)),0);
        }
        
        if (direction > 1)
          direction--;
        else if (direction < -1)
          direction++;
        else if (abs(direction) == 1)
        {
          direction *= ((int)FRAME_RATE*3+1);
          direction *= -1;
          setSpeed(0,getYSpeed());
        }
      }
      else
      {
        float sanicDirection = (sanic.getX() - this.getX()) / abs(sanic.getX() - this.getX());
        if (abs(getXSpeed()) < maxSpeed)
        {
          accelerate(GRAVITY / ( FRAME_RATE / GAME_SPEED ) * roughness * 2 * (sanicDirection/abs(sanicDirection)),0);
        }
      }
    }
    super.act(actors);
  }
  
}
