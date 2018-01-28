int score;
int rings;
int time;
int lives;
int speed;
boolean shield;
int sparklies;

int act;

PFont font;

ArrayList<ScoreText> sText = new ArrayList<ScoreText>();

public void loadScores()
{
  score = 0;
  rings = 20;
  time = 0;
  lives = 9;
  speed = 0;
  shield = false;
  sparklies = 0;
  
  act = 1;
  
  chooseFont();
}

public void chooseFont()
{
  String[] fontList = PFont.list();
  String current = "";
  for (String f : fontList)
  {
    if (f.equals("Comic Sans"))
    {
      current = f;
    }
    else if (!current.equals("Comic Sans") && f.equals("Source Sans Pro"))
    {
      current = f;
    }
  }
  if (current == null)
    current = "Monospaced.plain";
  font = createFont(current, 32);
}

public void drawScore()
{
  resetMatrix();
  
  if (sparklies > 0)
  {
    sparklies--;
    if (sparklies <= 0)
      loadMusic(act);
  }
  
  for (int x = 0; x < sText.size(); x++)
  {
    sText.get(x).drawText();
    if (!sText.get(x).decrease())
    {
      sText.remove(x);
      x--;
    }
  }
  
  textSize(height/16);
  textAlign(LEFT,TOP);
  textFont(font);
  
  fill(192, 192, 0);
  text("SCOUR", height/64, 0); 
  text("THYME", height/64, height/16); 
  text("RANGS", height/64, height/8);
  
  fill(255,255,255);
  text(score, textWidth("SCOUR") + height/32, 0);
  text(convertTime(time), textWidth("THYME") + height/32, height/16);
  text(rings, textWidth("RANGS") + height/32, height/8);
  
  textSize(height/24);
  image(itemSprites[1], height/64, height - height/64 - height/12, height/12, height/12);
  
  fill(192, 192, 0);
  text("SANIC", height/64 + height/12, height - height/64 - height/12);
  
  fill(255,255,255);
  text("X", height/64 + height/12, height - height/64 - height/12 + height/24);
  
  textAlign(RIGHT,TOP);
  text(lives, height/64 + height/12 + textWidth("SANIC"), height - height/64 - height/12 + height/24);
  
  textSize(height/12);
  fill(192,192,0);
  text("MPH", width - height/64, height - height/64 - height/12);
  if (speed <= 2147483640)
    text((speed/10) + "." + (speed%10), width - height/64 - textWidth("MPH") , height - height/64 - height/12);
  else
    text("\u221e", width - height/64 - textWidth("MPH") , height - height/64 - height/12);
  
  if (speed > 7680 && time % (int)(FRAME_RATE/15) == 0)
  {
    boom(sanic.centerCoords(0)+((Entity)sanic).getXSpeed(), sanic.centerCoords(1)+((Entity)sanic).getYSpeed());
  }
  
}

public String convertTime(int timeIn)
{
  int minutes = (timeIn/(int)FRAME_RATE)/60;
  int seconds = (timeIn/(int)FRAME_RATE)%60;
  if (seconds < 10)
  {
    return "" + minutes + ":0" + seconds;
  }
  else
  {
    return "" + minutes + ":" + seconds;
  }
}

public void score(float x, float y, int value)
{
  sText.add(new ScoreText(x,y,value));
  score += value;
}
public void boom(float x, float y)
{
  sText.add(new SonicBoom(x,y));
  score += speed;
}

class ScoreText
{
  float x;
  float y;
  int value;
  int timeLeft;
  
  public ScoreText(float xIn, float yIn, int valIn)
  {
    x = xIn;
    y = yIn;
    value = valIn;
    timeLeft = (int)(FRAME_RATE*2);
  }
  public ScoreText(float xIn, float yIn, int valIn, int timeIn)
  {
    x = xIn;
    y = yIn;
    value = valIn;
    timeLeft = timeIn;
  }
  
  public boolean decrease()
  {
    timeLeft--;
    return timeLeft > 0;
  }
  
  public void drawText()
  {
    textSize(height/32);
    textAlign(LEFT,TOP);
    fill(255, 255, 255);
    text(value, (int)((x*zoom)-viewX), (int)((y*zoom)-viewY));
  }
  
}

class SonicBoom extends ScoreText
{
  float distance;
  
  public SonicBoom(float xIn, float yIn)
  {
    super(xIn, yIn, speed/(int)(FRAME_RATE), (int)(FRAME_RATE*5));
    distance = 0;
  }
  
  public boolean decrease()
  {
    timeLeft--;
    distance += (height/zoom)/(int)(FRAME_RATE);
    return timeLeft > 0;
  }
  
  public void drawText()
  {
    stroke(255, 255, 255);
    noFill();
    strokeWeight(20*zoom);
    ellipse((int)((x*zoom)-viewX), (int)((y*zoom)-viewY), distance, distance);
  }
  
}
