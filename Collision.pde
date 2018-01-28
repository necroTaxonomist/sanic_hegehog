class Collision
{
  private float dx, dy;
  private float depth;
  private float angle;
  
  public Collision(float dx, float dy, float angle)
  {
    this.dx = dx;
    this.dy = dy;
    this.angle = angle;
    depth = sqrt(sq(dx)+sq(dy));
    
    /*if (dx > 0 && dy > 0)
        this.angle = 2*PI - atan(dy/dx);
      else if (dx > 0 && dy < 0)
        this.angle = 0 - atan(dy/dx);
      else if (dx < 0 && dy > 0)
        this.angle = PI - atan(dy/dx);
      else if (dx < 0 && dy < 0)
        this.angle = PI - atan(dy/dx);
      else if (dx == 0 && dy > 0)
        this.angle = 3*PI/2;
      else if (dx == 0 && dy < 0)
        this.angle = PI/2;
      else
        this.angle = 90;*/
    
  }
  
  public float getDX() { return dx; }
  public float getDY() { return dy; }
  public float getDepth() { return depth; }
  public float getAngle() { return angle; }
  
  public Collision opposite()
  {
    return new Collision(-dx,-dy,angle+PI/2);
  }
  
  public String toString()
  {
    return "Collision with dx=" + dx + ", dy=" + dy + ", depth=" + depth + ", angle=" + (angle/PI*180) + "d";
  }
  
}
