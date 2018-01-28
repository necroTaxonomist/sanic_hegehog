abstract class Enemy extends Entity
{
  private boolean danger;
  private int points;
  
  private boolean seeSanic;
  private float sightRange;
  
  private PImage[] sprite;
  private int imageIndex;
  
  public Enemy(float x, float y, float w, float h, int pointsIn, PImage[] sprIn)
  {
    super(x,y,w,h,0,0);
    danger = true;
    points = pointsIn;
    
    seeSanic =  false;
    sightRange = width/zoom/4;
    
    sprite = sprIn;
    imageIndex = 0;
  }
  
  public boolean isDangerous() { return danger; }
  public void setDanger(boolean input) { danger = input; }
  public void fAdvance(int frames) { imageIndex = (imageIndex + frames)%sprite.length; }
  public boolean seenSanic() { return seeSanic; }
  
  public int getPoints() { return points; }
  
  public boolean searchForSanic(Actor sanic)
  {
    return distanceTo(sanic) <= sightRange;
  }
  
  public void die()
  {
    playSound(0);
    score(getX(), getY(), points);
    markForRemoval();
  }
  
  public void act(ArrayList<Actor> actors)
  {
    if (!onScreen())
      return;
    seeSanic = searchForSanic(sanic);
    super.act(actors);
  }
  
  public void command(String command)
  {
    if (command.equals("die"))
      die();
  }
  
  public void drawSelf(float x, float y)
  {
    drawSprite(sprite[imageIndex],x,y,getWidth(),getHeight());
    stroke(255,255,0);
    noFill();
    drawCircle(centerCoords(0),centerCoords(1),sightRange);
  }
  
}
