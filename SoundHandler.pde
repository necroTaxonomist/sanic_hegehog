Minim minim;
AudioPlayer music;
int currentTrack = -1;

AudioPlayer oneLiners;
int currentOneLiner = -1;

AudioSample[] fx = new AudioSample[2];

public void loadSounds()
{
  minim = new Minim(this);
  
  for (int f = 0; f < fx.length; f++)
    fx[f] = minim.loadSample( "./data/sounds/fx/fx" + f + ".wav", 512);
}

public void loadMusic(int trackNum)
{
  if (music != null)
    stopMusic();
  music = minim.loadFile("./data/sounds/music/music" + trackNum + ".wav");
  music.setGain(-10);
  currentTrack = trackNum;
  restartMusic();
}

public void restartMusic()
{
  music.rewind();
  if (!music.isPlaying())
    music.play();
}

public void stopMusic()
{
  music.pause();
}

public int getCurrentTrack()
{
  return currentTrack;
}

public void playOneLiner(int index)
{
  if (oneLiners != null)
    oneLiners.pause();
  if (index != currentOneLiner)
  {
    currentOneLiner = index;
    oneLiners = minim.loadFile("./data/sounds/voice/oneliner" + index + ".wav");
  }
  oneLiners.rewind();
  if (!oneLiners.isPlaying())
    oneLiners.play();
}

public void playRandomOneLiner()
{
  int toPlay = (int)random(13);
  println(toPlay);
  if (oneLiners == null || !oneLiners.isPlaying())
    playOneLiner(toPlay);
}

public void playSound(int index)
{
  fx[index].trigger();
}
