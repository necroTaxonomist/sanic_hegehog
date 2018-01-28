PImage[] sanicSprite = new PImage[23];
PImage shieldSprite;
PImage[] sparklySprites = new PImage[3];

PImage[] itemSprites = new PImage[2];
PImage[] monitorSprites = new PImage[4];

PImage spikeSprite;
PImage springSprite;

PImage[] wheelSprite = new PImage[2];
PImage[] caterpillarSprite = new PImage[2];

PImage[] tileset = new PImage[2];

PImage background;

public void loadImages()
{
  for (int s = 0; s < sanicSprite.length; s++)
    sanicSprite[s] = loadImage("./data/images/sanic/sanic" + s + ".png");
  
  shieldSprite = loadImage("./data/images/sanic/shield.png");
  
  for (int s = 0; s < sparklySprites.length; s++)
    sparklySprites[s] = loadImage("./data/images/sanic/sparklies" + s + ".png");
  
  for (int i = 0; i < itemSprites.length; i++)
    itemSprites[i] = loadImage("./data/images/items/item" + i + ".png");
  
  for (int m = 0; m < monitorSprites.length; m++)
    monitorSprites[m] = loadImage("./data/images/items/monitor" + m + ".png");
  
  spikeSprite = loadImage("./data/images/tiles/spike.png");
  springSprite = loadImage("./data/images/tiles/spring.png");
  
  wheelSprite[0] = loadImage("./data/images/enemy/wheel/wheel0.png");
  wheelSprite[1] = loadImage("./data/images/enemy/wheel/wheel1.png");
  caterpillarSprite[0] = loadImage("./data/images/enemy/caterpillar/caterpillar0.png");
  caterpillarSprite[1] = loadImage("./data/images/enemy/caterpillar/caterpillar1.png");
  
  loadTileset(act);
  
}

public void loadTileset(int level)
{
  if (level == 1)
    loadTileset("grinhall");
}

public void loadTileset(String level)
{
  for (int g = 0; g < tileset.length; g++)
    tileset[g] = loadImage("./data/images/tiles/" + level + "/" + level + g + ".png");
  background = loadImage("./data/images/backgrounds/" + level + ".png");
}

public void drawSprite(PImage sprite, float x, float y, float w, float h)
{
  resetMatrix();
  image(sprite,(int)((x*zoom)-viewX),(int)((y*zoom)-viewY),(int)(w*zoom),(int)(h*zoom));
}
public void drawSprite(PImage sprite, float x, float y, float w, float h, float rot)
{
  resetMatrix();
  
  translate((int)(w*zoom)/2.0,(int)(h*zoom)/2.0);
  translate((int)((x*zoom)-viewX),(int)((y*zoom)-viewY));
  
  pushMatrix();
  rotate(rot);
  
  image(sprite,-(int)(w*zoom)/2,-(int)(w*zoom)/2,(int)(w*zoom),(int)(h*zoom));
  popMatrix();
}

public void drawVector(Vector vector, float x, float y)
{
  resetMatrix();
  stroke(0);
  strokeWeight(10);
  line((int)((x*zoom)-viewX), (int)((y*zoom)-viewY), (int)(((x+vector.getXComp()*8)*zoom)-viewX), (int)(((y+vector.getYComp()*8)*zoom)-viewY));
}

public void drawRect(float x, float y, float w, float h)
{
  resetMatrix();
  rect((int)((x*zoom)-viewX),(int)((y*zoom)-viewY),(int)(w*zoom),(int)(h*zoom));
}

public void drawCircle(float x, float y, float r)
{
  resetMatrix();
  float w = r*2;
  float h = r*2;
  ellipse((int)((x*zoom)-viewX),(int)((y*zoom)-viewY),(int)(w*zoom),(int)(h*zoom));
}

public void drawBackground(PImage bg, float paralax)
{
  resetMatrix();
  float x = viewX*PIXELS_PER_METER*zoom;
  float y = viewY*PIXELS_PER_METER*zoom;
  
  image(bg,-(int)(viewX/paralax)%(int)bg.width, -(int)(viewY/paralax)%(int)bg.height, bg.width, bg.height);
  image(bg,-(int)(viewX/paralax)%(int)bg.width+bg.width, -(int)(viewY/paralax)%(int)bg.height, bg.width, bg.height);
  image(bg,-(int)(viewX/paralax)%(int)bg.width, -(int)(viewY/paralax)%(int)bg.height+height, bg.width, bg.height);
  image(bg,-(int)(viewX/paralax)%(int)bg.width+bg.width, -(int)(viewY/paralax)%(int)bg.height+height, bg.width, bg.height);
  
}

public void oldDrawBackground(PImage bg, float x, float y)
{
  for (float i = 0; i < (viewX + width)*PIXELS_PER_METER*zoom; i += bg.width/zoom)
  {
    for (float j = 0; j < (viewY + height)*PIXELS_PER_METER*zoom; j += bg.height/zoom)
    {
      drawSprite(bg,x+i,y+j,bg.width/zoom,bg.height/zoom);
    }
  }
}

public boolean tileOnScreen(float x, float y, float w, float h)
{
  return x + w > viewX/zoom && x - w < (viewX+width)/zoom && y + h > viewY/zoom && y - h < (viewY+height)/zoom;
}
