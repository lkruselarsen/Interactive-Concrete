/**
  * This sketch demonstrates how to play a file with Minim. <br />
  * It's also a good example of how to draw waveforms using the sample buffers of an AudioSource.
  */

import ddf.minim.*;
import processing.serial.*;

Serial myPort;        
Minim minim;
AudioPlayer player;
float inVol;
void setup()
{
   
  size(512, 200, P3D);
  minim = new Minim(this);
  // load a file, give the AudioPlayer buffers that are 2048 samples long
  player = minim.loadFile("marcus_kellis_theme.mp3", 2048);
  // play the file
  player.play();
   myPort = new Serial(this, Serial.list()[4], 9600);
 // don't generate a serialEvent() unless you get a newline character:
 myPort.bufferUntil('\n');
}

void draw()
{
  background(0);
  stroke(255);
  // draw the waveforms
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  // note that if the file is MONO, left.get() and right.get() will return the same value
  for(int i = 0; i < player.bufferSize() - 1; i++)
  {
    float x1 = map(i, 0, player.bufferSize(), 0, width);
    float x2 = map(i+1, 0, player.bufferSize(), 0, width);
    line(x1, 50 + player.left.get(i)*50, x2, 50 + player.left.get(i+1)*50);
    line(x1, 150 + player.right.get(i)*50, x2, 150 + player.right.get(i+1)*50);
  }
}

 void serialEvent (Serial myPort) {
     // get the ASCII string:
     String inString = myPort.readStringUntil('\n');
     
     if (inString != null) {
     // trim off any whitespace:
     inString = trim(inString);
     // convert to an int and map to the screen height:
     
      
    
     float inByte = float(inString);

         
         if (inByte<60 && inByte>42){ 
     {            
              inVol=+1;
             }
          
         } else if (inByte<42 && inByte>35){
{ 
             inVol=+0.7;
             }
             
         } else if (inByte<35 && inByte>29){
{ 
             inVol=+0.5;
             }
         } else if (inByte<29 && inByte>23){
{ 
             inVol=+0.2;
             }
         } else if (inByte<23 && inByte>19){
{ 
             inVol=+0.1;
             }
         } else if (inByte<19 && inByte>16){
{ 
             inVol=-0.1;
             }
         } else if (inByte<16 && inByte>12){
{ 
             inVol=-0.2;
             }
          } else if (inByte<12 && inByte>8){
{ 
             inVol=-0.3;
             }
          } else if (inByte<8 && inByte>5){
{ 
             inVol=-0.5;
             }
           } else if (inByte<5){
{ 
             inVol=-1;
             }
           
         }
         
    
         player.setPan(inVol);
     println("volume: " + inVol);
     println();
     }
 }
void stop()
{
  // always close Minim audio classes when you are done with them
  player.close();
  // always stop Minim before exiting
  minim.stop();
  
  super.stop();
}
