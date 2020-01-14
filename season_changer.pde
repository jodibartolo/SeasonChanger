

import java.awt.Graphics;
import processing.sound.*;
import javax.swing.JFrame;

color red = color(203, 80, 80);
color brown = color(150, 94, 0);
color yellow = color(255, 255, 73);
color green = color(170, 205, 150);
color silver = color(192, 192, 192);
color blue = color(173, 216, 230);
color orange = color(255, 165, 0);
color pink = color(255, 192, 203);
color maroon = color(128, 0, 0);
boolean snowing = false;
boolean fall = false;
boolean flowers = false;
boolean seasons = false;
boolean woah = false;
PShape plowing;
//PShape top; 
//PShape roller;
snowPlow plow;
int x = 50;
int y = 400;
AudioIn in;
FFT fft;
int bands = 512;
float[] spectrum = new float[bands];
Amplitude amp;
color[] colors = {red, silver, orange, maroon, pink, color(220, 220, 73),color(80, 80, 80),color(200, 255, 20),
color(95, 0, 200), blue};
int b = 0;
flower flow;




float a; 
int angle = 10;
snow ball = new snow();
//Pfont Verdana;

void setup() {
   size(1000, 800);
   plow = new snowPlow(50, 400);
   fft = new FFT(this, bands);
   in = new AudioIn(this, 0);
   amp = new Amplitude(this);
   in.start();
   fft.input(in);
   winter();
   amp.input(in);

   //flower flow = new flower();



   
 

}


void draw() {
    if (snowing) { 
      frameRate(40);
      plow.drawing();
      if (mouseY > 400) {
     noCursor(); 
      }
    if (mouseY < 400) {
      cursor();
      if (mousePressed == true) {
      strokeWeight(1);
      snow ball = new snow();
      cursor();
       ball.show();
       ball.update();
    }
    }
  }
  if (fall) {
    frameRate(5);
    cursor();
    snowing = false;
    fall();
    Leaf[] leaves = new Leaf[(int)(amp.analyze() * 300)];
    for (int i = 0; i < leaves.length; i++) {
      leaves[i] = new Leaf();
      //leaves[i].display();
  }
    
    for(int i = 0; i < leaves.length; i++) {
      leaves[i].setX((int)(600 * amp.analyze()) + (int)Math.floor(Math.random() * 1000));
      leaves[i].setY((int)(800 * amp.analyze()) + (int)Math.floor(Math.random() * 700));
      leaves[i].display();
     }
     
  }
  if (flowers) {
    cursor();
    frameRate(12);
    if (mouseY > 400) {
    if (mousePressed) {       
      flow = new flower();
      flow.show();
    }
         

              
 
                   
  }
  }
    

    

}

void mousePressed () {
    
 }
 

 void keyPressed() {
  
     if (key == '2') {
    fall();
  }
    else if (key == '3') {
      spring();
                

  }
       else if (key == '1') {
    winter();
       }
        if (snowing) {
    if(key == CODED) {
      
    if (keyCode == UP)
    {
      plow.moveUP();
    }
    else if (keyCode == DOWN)
    {
      plow.moveDOWN();
    }
    else if (keyCode == LEFT)
    {
      plow.moveLEFT();
    }
    else if (keyCode == RIGHT)
    {
      plow.moveRIGHT();
    }
 }

  }
 }




class Leaf {
  float xPos = (int)Math.floor(Math.random() * 1000);
  float yPos = (int)Math.floor(Math.random() * 400) + 400;
  float y = 0;
  color black = color(0,0,0);
  color[] colors = {red, silver, orange, maroon, pink, yellow};
  color c = colors[(int)Math.floor(Math.random() * colors.length)];
    

  Leaf() {
   
  }

  void display() {
    fill(c);
    stroke(c);
    ellipse(xPos, yPos, 12, 17);
    stroke(0,0,0);
    strokeWeight(1);
    line(xPos, yPos - 8, xPos, yPos + 13);
  }
  void setX(int x) {
    this.xPos = x;
  }
  void setY(int y) {
    this.yPos = y;
  }
}


void winter() {

  flowers = false;
  snowing = true;
  fall = false;

  background(255,255,255);
  strokeWeight(4);
  fill(blue);
  stroke(blue);
  rect(0,0, 1000, 400);
  fill(brown);
  rect(300, 200, 200, 200);
  fill(0,0,0);
  stroke(0,0,0);
  triangle(300, 200, 500, 200, 400, 100);
  fill(255,255,255);
  plow = new snowPlow(50, 400);
  plow.drawing(); 
  text("The season is winter. Snow has fallen and it is sub 0 degrees.", 350, 50);
  text("Move your snow plow around with the arrow keys to clear the snow. ", 450, 100);
  text("Click to place snowflakes in the sky.", 550, 150);
  text("Press 1 to start winter over.", 650, 200);
  text("Press 2 to go back in time to fall", 750, 250);
  text("Press 3 to move forward to spring", 800, 300);
  
}
 
class snow {
  int xPos = mouseX;
  int yPos = mouseY;
  int dian = 16;
  int dianY = 0;
  int fall = 5;
  snow()
  {
    
  }
  void update()
  {
    if (yPos < 700) {
    yPos+= fall;
    }
    
  }
  void show() {
    stroke(245);
    strokeWeight(1);
    fill(245);
    for (int i = 0; i < 4; i++) {
    line(mouseX - dian, yPos - dianY, mouseX + dian, yPos + dianY);
    line(mouseX - dianY, yPos + dian, mouseX + dianY, yPos - dian);
    dian -= 4;
    dianY += 4;
  }
  }
}

class snowPlow {
  int x = 50;
  int y = 400;

   snowPlow(int x, int y){
     this.x = x;
     this.y = y;
   }
  void drawing() {
  
  strokeWeight(10);
    stroke(green);
    line(x + 57, y + 5,x + 57, y + 35);
    //popMatrix();
  }
  void moveUP() {
    if (y > 410) {
    y-= 5;
    }
  }
    void moveDOWN()
  {
    
    y+= 5;
   
  }    
  void moveLEFT()
  {
    x-= 5;
  }    
  void moveRIGHT()
  {
    x+= 5;
  } 
}


void fall(){
  flowers = false;
    fall = true;
    snowing = false;
  strokeWeight(4);
  background(green);
  fill(blue);
  stroke(blue);
  rect(0,0, 1000, 400);
  fill(brown);
  rect(300, 200, 200, 200);
  fill(0,0,0);
  stroke(0,0,0);
  triangle(300, 200, 500, 200, 400, 100);
  fill(red);
  text("The season is autumn. The power of your voice controls how many leaves fall", 350, 50);
  text("Press 1 to start autumn over.", 500, 125);
  text("Press 2 to move into winter", 650, 200);
  text("Press 3 to go back in time to spring.", 750, 275);
  
}

void spring(){
  flowers = true;
    fall = false;
    snowing = false;
  strokeWeight(4);
  background(70, 205, 100);
  fill(blue);
  stroke(blue);
  rect(0,0, 1000, 400);
  fill(brown);
  rect(300, 200, 200, 200);
  fill(0,0,0);
  stroke(0,0,0);
  triangle(300, 200, 500, 200, 400, 100);
  fill(yellow);
  text("The season is spring. Click to plant flowers.", 350, 50);
  text("Press 1 to go back to winter.", 500, 125);
  text("Press 2 to move to autumn", 650, 200);
  text("Press 3 to start spring over.", 750, 275);
  
}
class flower {
  
  color c;

  
  
  flower() {
    this.c = colors[(int)Math.floor(Math.random() * colors.length)];
    
  }
    

  void show() {
    strokeWeight(1);
    fill(c);
    stroke(0,0,0);
    ellipse(mouseX + 6 , mouseY + 6, 15, 15);
    ellipse(mouseX + 6 , mouseY - 6, 15, 15);
    ellipse(mouseX - 6 , mouseY + 6, 15, 15);
    ellipse(mouseX - 6 , mouseY - 6, 15, 15);
    fill(yellow);
    ellipse(mouseX , mouseY, 12, 12);
    fill(green);
    stroke(green);
    line(mouseX, mouseY + 7, mouseX, mouseY + 26);

  }
  
  
 
}
