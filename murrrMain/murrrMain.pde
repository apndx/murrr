import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import moonlander.library.*;

Moonlander moonlander;
PFont f;
Icosahedron ico;
Icosahedron ico2;
float noiseLevel;
float icosahedronRadius = 150.0;
float xRotationSpeed = 2.0;
float xRotationSpeedSilma = 0;


float icosahedronRadius2 = 1500.0;
float xRotationSpeed2 = 2.0;
float noiseLevel2;

PImage silma;
 int silmaOpacity= 80;



void settings() {
  // Set up the drawing area size and renderer (P2D / P3D).
  //size(1920/2, 1080/2, P3D); //this is the measurement ratio used @ Assembly screen
  fullScreen(P3D);

  silma = loadImage("silma.jpg");
 // silma.resize(1920, 1080);
}


void setup() {
  // noCursor();
  frameRate(60);
  // font = createFont("the_font_we_use.ttf", 64);  
  moonlander = Moonlander.initWithSoundtrack(this, "hajame-murrr1.2-82-BPM.mp3", 82, 2);
  background(255, 255, 255);
  smooth();
  noStroke();
  noiseLevel=0.0;
  moonlander.start();
  
  
  // Create the font
  printArray(PFont.list());
  f = createFont("SourceCodePro-Regular.ttf", 20);
  textFont(f);
  
}


void draw() { 
  moonlander.update(); 

  translate(width/2, height/2);
  scale(height / 1000.0);

  int scene = moonlander.getIntValue("main:scene"); 
  int headlineTextScene = moonlander.getIntValue("main:headlineTextScene"); 

  int silmaScene = moonlander.getIntValue("main:silmaScene"); 
  int silmaOpacity = (int) moonlander.getValue("silma:opacity");
  xRotationSpeedSilma = (float)moonlander.getValue("silma:xRotationSilma");
  
  
  icosahedronRadius = (float) moonlander.getIntValue("ico1:radius");
  noiseLevel = (float) moonlander.getValue("ico1:noise");
  xRotationSpeed = (float)moonlander.getValue("ico1:xRotation");
 
  

  //int updatebackground = moonlander.getIntValue("main:updatebackground");
  //int start = moonlander.getIntValue("main:start");
  //int end = moonlander.getIntValue("main:end");
   


  //if (updatebackground != 0) {  
  //  if (updatebackground == 1) {
  //   //  background(0);
  //  } else if (updatebackground == -1) {
  //    background(255);
  //  }
  //}
  
   if (scene==0) { 
      //drawKoosh(kooshX, kooshY, kooshR, kooshG, kooshB, kooshOpacity, kooshRotation, kooshCounter);
      //drawSphereComeHither(kooshX, kooshY, kooshR, kooshG, kooshB, kooshOpacity, sphereDetail);
     
  } 
  if (scene==1) {
      drawIcosahedron();
  }
    
    
  if (headlineTextScene==1) {
      drawHeadlineText();
   } 
      
   if (silmaScene == 1) {
   drawSilma(silmaOpacity, xRotationSpeedSilma);    
  }
  
   if (scene==666) {
      exit();
  }
}



void drawIcosahedron() {
  moonlander.update(); 

  
  
  icosahedronRadius2 = (float) moonlander.getIntValue("ico1:radius2");
  noiseLevel2 = (float) moonlander.getValue("ico1:noise2");
  xRotationSpeed2 = (float)moonlander.getValue("ico1:xRotation2");
  
  //create two icosahedrons with radius and noiseLevel
  ico = new Icosahedron(icosahedronRadius, noiseLevel);
  ico2 = new Icosahedron(icosahedronRadius2, noiseLevel2);
  //set background and initialize lights
  background(0);
  lights();
  //set origo to center of screen
  //translate(width/2, height/2);
  //increase noiselevel each draw
  noiseLevel =  noiseLevel + 0.01;
  
   //draw icosahedron____________________________________________________________________________
 
   pushMatrix();
   stroke(255,255,255);
   translate( width/10, height/10);
   rotateX(xRotationSpeed2);
   ico.create();
   popMatrix();
   
   pushMatrix(); 
   stroke(255,255,255);
   rotateX(xRotationSpeed);
   ico2.create();
  popMatrix();
    
}

//HEADLINE_________________________________________________________________________________
void drawHeadlineText() { 
  //text
  pushMatrix();
  translate( 0, -450);
  textAlign(RIGHT);
  drawType  (width * -0.3);//kuinka kaukana reunasta
  popMatrix();  
}
 void drawType(float x) {
  line(x, 0, x, 25);  
  line(x, 220, x, 2000); //?1000
  
  fill(255);
  textSize(50); 
  text("Murrr", x, 95);
  fill(150);
  textSize(30); 
  text("Asssembly", x, 145);
  
  textSize(30); 
  fill(150);
  text("2019", x, 180);
}

 
 
//SILMA_______________________________________________________________________________________
void drawSilma(int opacity, float xRotationSpeedSilma) {
    pushMatrix();
    rotateX(xRotationSpeedSilma);  
    image(silma, -width, -height, width*2, height*2);
    tint(255, opacity); 
    popMatrix();
} 
