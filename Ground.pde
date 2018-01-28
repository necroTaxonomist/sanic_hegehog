class Ground extends Block
{
  float showHeight;
  
  public Ground(float x, float y, float w, float h)
  {
    super(x,y,w,h);
    showHeight = getHeight();
  }
  public Ground(float x, float y, float w, float h1, float h2)
  {
    super(x,y,w,h2);
    showHeight = h1*PIXELS_PER_METER;
  }
  
  public void drawSelf(float x, float y)
  {
   if (showHeight < PIXELS_PER_METER)
   {
     for (int i = 0; i < getWidth(); i += PIXELS_PER_METER)
     {
       if (tileOnScreen(x+i, y,PIXELS_PER_METER,PIXELS_PER_METER))
         drawSprite(tileset[0],x+i,y-.1*PIXELS_PER_METER,PIXELS_PER_METER,showHeight+8);
     }
     return;
   }
   
   for (int i = 0; i < getWidth(); i += PIXELS_PER_METER)
   {
     for (int j = 0; j < showHeight; j += PIXELS_PER_METER)
       {
        if (tileOnScreen(x+i, y+j,PIXELS_PER_METER,PIXELS_PER_METER))
        {
          if (j == 0)
            drawSprite(tileset[1],x+i,y+j-.1*PIXELS_PER_METER,PIXELS_PER_METER,1.140625*PIXELS_PER_METER);
          else
            drawSprite(tileset[0],x+i,y+j,PIXELS_PER_METER,PIXELS_PER_METER);
        }
     }
   }
  }
  
}
