class Vector
{
  private float x;
  private float y;
  
  public Vector(float xIn, float yIn)
  {
    x = xIn;
    y = yIn;
  }
  
  public Vector(float arg1, float arg2, String mode)
  {
    if (mode.equals("cartesian"))
    {
      x = arg1;
      y = arg2;
    }
    else if (mode.equals("polar"))
    {
      
      x = cos(arg1)*arg2;
      y = sin(arg1)*arg2;
    }
  }
  
  public float getXComp() { return x; }
  public float getYComp() { return y; }
  
  public float getMagnitude() { return sqrt(sq(x) + sq(y)); }
  public float getDirection()
  {
    if (x > 0 && y >= 0)
      return atan(y/x);
    else if (x > 0 && y < 0)
      return 2*PI + atan(y/x);
    else if (x < 0)
      return PI + atan(y/x);
    else if (x == 0 && y > 0)
      return PI/2;
    else if (x == 0 && y < 0)
      return 3*PI/2;
    else
      return 0;
  }
  
  public Vector inverse()
  {
    return new Vector(-x,-y);
  }
  
  public void add(Vector input)
  {
    x += input.getXComp();
    y += input.getYComp();
  }
  
  public void scalar(float scalar)
  {
    x *= scalar;
    y *= scalar;
  }
  
  public Vector getScaled(float scalar)
  {
    return new Vector(x * scalar, y * scalar);
  }
  
  public Vector getSum(Vector input)
  {
    return new Vector(x + input.getXComp(), y + input.getYComp());
  }
  
  public float dotProduct(Vector input)
  {
    return x*input.getXComp() + y*input.getYComp();
  }
  
  public Vector normalize()
  {
    return new Vector(getDirection(), getMagnitude());
  }
  
  public String toString()
  {
    //return "<" + x + "," + y + ">";
    return "(" + (getDirection()/PI*180) + "," + getMagnitude() + ")";
  }
  
}
