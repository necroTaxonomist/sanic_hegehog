abstract class Liquid extends Actor
{
  private float dragConst;
  private float density;
  
  public Liquid(float x, float y, float w, float h, float dcIn, float denseIn)
  {
    super(x,y,w,h);
    dragConst = dcIn;
    density = denseIn;
  }
  
  public float getDrag(float area) { return area*dragConst; }
  public float getBouyancy(float area) { return area*density*GRAVITY*-1; }
  
  public void act(ArrayList<Actor> actors)
  {
    drawSelf();
  }
}
