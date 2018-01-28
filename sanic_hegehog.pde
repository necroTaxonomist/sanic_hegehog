import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

//constants
float PIXELS_PER_METER = 64;
float GRAVITY = 9.8;
float GAME_SPEED = 1.0;
float GROUND_LEVEL = 126;
float FRAME_RATE = 60;
float VIEW_SCROLL_RATE = 2;

//camera
float viewX;
float viewY;
float zoom;

//actors
ArrayList<Actor> actors;
ArrayList<Actor> additions;
Actor sanic;

public void setup()
{
  frameRate(FRAME_RATE);
  
  size(640,480);
  loadScores();
  loadImages();
  loadSounds();
  loadMusic(act);
  
  viewX = 15;
  viewY = 0;
  zoom = .5;
  
  actors = new ArrayList<Actor>();
  additions = new ArrayList<Actor>();
  sanic = new Sanic(5,GROUND_LEVEL-4);
  
  actors.add(new Ground(12,GROUND_LEVEL-4,10,4,.5));
  actors.add(new Ground(26,GROUND_LEVEL-7,10,7,.5));
  
  actors.add(new Ground(2,GROUND_LEVEL,2000,12.5));
  //actors.add(new Ground(2,GROUND_LEVEL-20,32,2));
  actors.add(new Ground(0,GROUND_LEVEL-20,4,80));
  
  //actors.add(new Water(4, GROUND_LEVEL-30, 30, 30));
  
  //actors.add(new Ground(32,GROUND_LEVEL-20,2,80,grinHallTileset));
  
  //for (int p = 0; p < 4; p++)
    //actors.add(new Ground(8 + 3*p, GROUND_LEVEL - 2 - 3*p, 2, .25, grinHallTileset));
  
  for (int r = 0; r < 4; r++)
  {
      //actors.add(new Monitor(14 + 5*r, GROUND_LEVEL-2, r));
      actors.add(new Caterpillar(14 + 5*r, GROUND_LEVEL-2, -1, (int)FRAME_RATE));
      //actors.add(new Spring(14 + 5*r, GROUND_LEVEL-2, r));
  }
  
  actors.add(sanic);
    
}

public void draw()
{
  
  if (viewX < 0)
    viewX = 0;
  
  drawBackground(background,8);
  
  for (int a = 0; a < actors.size(); a++)
  {
    if (actors.get(a) instanceof Block)
      actors.get(a).act(null);
    else
      actors.get(a).act(actors);
    
    if (actors.get(a).shouldRemove())
    {
      actors.remove(a);
      a--;
    }
  }
  
  for (Actor a : additions)
  {
    actors.add(a);
  }
  
  additions = new ArrayList<Actor>();
    
  
  for (int x = 0; x < KEY_INPUTS.length; x++)
    prevHeldKeys[x] = heldKeys[x];
  
  time++;
  
  drawScore();
}

public boolean randomBool() { return random(1) < .5; }
