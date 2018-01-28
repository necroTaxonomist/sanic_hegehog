final int[] KEY_INPUTS = {UP,DOWN,LEFT,RIGHT};
boolean[] heldKeys = {false,false,false,false};
boolean[] prevHeldKeys = {false,false,false,false};

void keyPressed()
{
  if (key == CODED)
  {
    for (int x = 0; x < KEY_INPUTS.length; x++)
    {
      if (!heldKeys[x] && keyCode == KEY_INPUTS[x])
      {
        //prevHeldKeys[x] = heldKeys[x];
        heldKeys[x] = true;
      }
    }
  }
  if (key == 'p')
  {
    frameRate(frameRate + 10);
    println(frameRate);
  }
}

void keyReleased()
{
  if (key == CODED)
  {
    for (int x = 0; x < KEY_INPUTS.length; x++)
    {
      if (heldKeys[x] && keyCode == KEY_INPUTS[x])
      {
        //prevHeldKeys[x] = heldKeys[x];
        heldKeys[x] = false;
      }
    }
  }
}

boolean pressedKeys(int input)
{
  return heldKeys[input] && !prevHeldKeys[input];
}

boolean releasedKeys(int input)
{
  return !heldKeys[input] && prevHeldKeys[input];
}

void printInputs()
{
  print("\n Previous: ");
  for (boolean b : prevHeldKeys)
    print(b + " ");
  print("\n HeldKeys: ");
  for (boolean b : heldKeys)
    print(b + " ");
}
