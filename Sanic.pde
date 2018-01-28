class Sanic extends Entity
{
  private boolean inControl;
  private float prevXSpeed;
  private int imageIndex;
  private int hitstun;
  private int invincibility;
  private Vector speedVect;
  
  private float jumpAmount;
  private float jumpStrength;
  
  private int spinning;
  
  private boolean inWater;
  private int drowning;
  
  public Sanic(float x, float y)
  {
    super(x,y,2,2,0,0);
    bounciness = 0;
    roughness = .75;
    fallSpeed = 1;
    
    inControl = true;
    prevXSpeed = 0;
    imageIndex = 0;
    hitstun = 0;
    invincibility = 0;
    
    jumpAmount = 0;
    jumpStrength = GRAVITY*fallSpeed/3.75;
    
    spinning = 0;
    
    inWater = false;
    drowning = -1;
    
    moveCamera(1);
  }
  
  public void act(ArrayList<Actor> actors)
  {
    speed = round(getFast()*10);
    
    
    if (spinning > 0)
    {
      imageIndex = (imageIndex + 1)%23;
      if (spinning == 1 && isOnGround())
        spinning = 0;
    }
    else
    {
      if (heldKeys[2] && getXSpeed() > 0)
        imageIndex = 22;
      else if (heldKeys[3] && getXSpeed() < 0)
        imageIndex = 1;
      else
        imageIndex = 0;
    }
    
    prevXSpeed = getXSpeed();
    
    if (hitstun > 0)
      hitstun--;
    if (invincibility > 0)
      invincibility--;
    
    inWater = false;
    super.act(actors);
    if (inWater)
    {
      if (drowning == -1)
        drowning = 18*(int)FRAME_RATE;
      else if (drowning > 0)
        drowning--;
      else
      {
      }
      
      if (drowning == 11*(int)FRAME_RATE)
        loadMusic(9);
    }
    else if (drowning > -1)
    {
      if (drowning <= 11*(int)FRAME_RATE)
        loadMusic(act);
      drowning = -1;
    }
    
    //println(getXSpeed() + " " + getYSpeed());
    //println(this);
    
    if (inControl && hitstun <= 0)
      useInputs();
    
    moveCamera(1);
    //wrap();
    
    //println(isOnGround());
    
  }
  
  public void processActor(Actor a)
  {
    Collision c = checkCollision(a);
    if (c != null)
    {
      if (a instanceof Liquid)
      {
        inWater = true;
      }
      if (a instanceof Item)
      {
        a.command("collect");
      }
      if (a instanceof Monitor && spinning > 0)
      {
        bounce(c, 1, false);
        a.command("collect");
      }
      if (invincibility <= 0)
      {
        if (a instanceof Spike)
        {
          hit((int)FRAME_RATE, (int)FRAME_RATE*3);
          exitCollision(c);
          repel(c,2*jumpStrength);
        }
        if (a instanceof Enemy)
        {
          if (sparklies <=  0)
          {
            if (getSpeed() < getWidth()/128)
              repel(c,getWidth()/16);
            else
              bounce(c, 1, false);
          }
            
          if (spinning > 0 || sparklies > 0)
          {
            a.command("die");
          }
          else if (((Enemy)a).isDangerous())
          {
            hit((int)(FRAME_RATE/3), (int)FRAME_RATE*3);
          }
        }
      }
      if (a instanceof Spring)
      {
        repel(c,((Spring)a).getBounce());
      }
      else
        super.processActor(a);
    }
  }
  
  public void command(String command)
  {
    if (command.substring(0,3).equals("hit"))
    {
      if (invincibility <= 0)
        hit(parseInt(command.substring(3))/3, parseInt(command.substring(3)));
    }
  }
  
  public void drawSelf(float x, float y)
  {
    fill(255);
    if (invincibility <= 0 || invincibility % 2 == 0)
      drawSprite(sanicSprite[0],x,y,getWidth(),getHeight(),2*PI*imageIndex/24.0);
    if (sparklies > 0)
      drawSprite(sparklySprites[(sparklies/(int)(FRAME_RATE/4))%3],x,y,getWidth(),getHeight());
    else if (shield && randomBool())
      drawSprite(shieldSprite,x,y,getWidth(),getHeight());
    
    //speedVect = new Vector(getXSpeed(),getYSpeed());
    //drawVector(speedVect,x,y);
  }
  
  public void useInputs()
  {
    //if (pressedKeys(0) && isOnGround())
    if (heldKeys[0] && isOnGround())
    {
      jumpAmount = -jumpStrength;
    }
    if (heldKeys[0])
    {
      accelerate(0,jumpAmount);
      if (jumpAmount < 0)
      {
        spinning = 1;
        jumpAmount += jumpStrength/6.4;
      }
      if (jumpAmount > 0)
        jumpAmount = 0;
    }
    else if (jumpAmount < 0)
      jumpAmount = 0;
    
    if (heldKeys[1] && abs(getXSpeed()) > getWidth()/128)
    {
      if (spinning == 0)
        spinning = 2;
    }
    else
    {
      if (spinning == 2)
        spinning = 0;
      if (!heldKeys[1] && isOnGround())
      {
        if (heldKeys[2])
          accelerate(-.25,0);
        if (heldKeys[3])
          accelerate(.25,0);
      }
      else
      {
        if (heldKeys[2])
          accelerate(-.075,0);
        if (heldKeys[3])
          accelerate(.075,0);
      }
      
    }
  }
  
  public void hit(int stun, int iFrames)
  {
    hitstun = stun;
    invincibility = iFrames;
    
    if (shield)
      shield = false;
    else
    {
      playSound(1);
      
      while (rings > 0)
      {
        additions.add(new Ring(getX() + getWidth()/2 - .5, getY() + getHeight()/2 - .5*PIXELS_PER_METER, -10 + random(20), -random(5)));
        rings--;
      }
    }
  }
  
  public void moveCamera(int type)
  {
    if (type == 0)
    {
      float cameraDist = 0;
      float cameraDir;
      float moveDir;
      
      if (abs(getXSpeed()/(width/zoom/2)*100) < .5)
        cameraDist = 0;
      else
      {
        if (getXSpeed() > 0)
          cameraDist = (getXSpeed()/(width/zoom/2)*100)-.5;
        if (getXSpeed() < 0)
          cameraDist = (getXSpeed()/(width/zoom/2)*100)+.5;
      }
      if (cameraDist < -2)
        cameraDist = -2;
      if (cameraDist > 2)
        cameraDist = 2;
      
      println(cameraDist);
      float viewTo = (getX() + getWidth()/2 - width/zoom/2 + width/zoom/8*cameraDist)*zoom;
      cameraDir = (viewTo-viewX)/abs(viewTo-viewX);
      moveDir = getXSpeed()/abs(getXSpeed());
      
      if (abs(getXSpeed()) > VIEW_SCROLL_RATE)
        viewX = (getX() + getWidth()/2 - width/zoom/2 + width/zoom/8*cameraDist)*zoom;
      else
      {
        if (viewX > viewTo)
          viewX -= VIEW_SCROLL_RATE;
        if (viewX < viewTo)
          viewX += VIEW_SCROLL_RATE;
      }
      
      if (getY() < viewY/zoom + height/zoom/2)
        viewY = (getY() - height/zoom/2)*zoom;
      if (getY()+getHeight() > viewY/zoom + 3*height/zoom/4)
        viewY = (getY()+getHeight() - 3*height/zoom/4)*zoom;
    }
    if (type == 1)
    {
      if (getX() < viewX/zoom + width/zoom/2.5 && viewX > 0)
        viewX = (getX() - width/zoom/2.5)*zoom;
      if (getX()+getWidth() > viewX/zoom + width/zoom*.6)
        viewX = (getX()+getWidth() - width/zoom*.6)*zoom;
      if (getY() < viewY/zoom + height/zoom/2)
        viewY = (getY() - height/zoom/2)*zoom;
      if (getY()+getHeight() > viewY/zoom + 3*height/zoom/4)
        viewY = (getY()+getHeight() - 3*height/zoom/4)*zoom;
    }
    
  }
  
  public void wrap()
  {
    if (getX() < viewX/zoom - getWidth())
      setX(viewX/zoom + width/zoom);
    else if (getX() > viewX/zoom + width/zoom)
      setX(viewX/zoom - getWidth());
  }
  
  public float getFast()
  {
    float raw = getMPH();
    return raw * pow(4, raw/15 - 2);
  }
  
}
