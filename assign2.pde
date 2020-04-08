PImage bgImg;
PImage groundhogImg;
PImage lifeImg;
PImage robotImg;
PImage soilImg;
PImage soldierImg;

PImage titleImg;
PImage startNormalImg;
PImage startHoveredImg;

PImage restartNormalImg;
PImage restartHoveredImg;

PImage gameoverImg;

PImage cabbageImg;

  
int x, y;//size CENTER
  
int soldierX;
int soldierXspeed;
int soldierWidth;
float soldierY;

final int GAME_RUN = 0;
final int GAME_LOSE = 1;
final int GAME_START = 2;

int gameState = 2;

int startNormalX = 248;
int startNormalY = 360;
int startNormalW = 144;
int startNormalH = 60;

int life = 2;

int groundhogX = 360;
int groundhogY = 120;

float cabbageX = 0;
float cabbageY = 0;

boolean eatCabbage = false;
  
  

void setup() {
  size(640, 480, P2D);
  x = 320;
  y = 240;
  soldierX = 0;
  soldierXspeed = 2;
  soldierWidth = 80;
  soldierY = random(160,480);
  
  cabbageX = random(40,width - 40);
  cabbageY = random(160,480);

  bgImg = loadImage("img/bg.jpg");
  groundhogImg = loadImage("img/groundhogIdle.png");
  lifeImg = loadImage("img/life.png");
  soilImg = loadImage("img/soil.png");
  soldierImg = loadImage("img/soldier.png");
  robotImg = loadImage("img/robot.png");
  
  titleImg = loadImage("img/title.jpg");
  startNormalImg = loadImage("img/startNormal.png");
  startHoveredImg = loadImage("img/startHovered.png");
  
  restartNormalImg = loadImage("img/restartNormal.png");
  restartHoveredImg = loadImage("img/restartHovered.png");
  
  gameoverImg = loadImage("img/gameover.jpg");
  
  cabbageImg = loadImage("img/cabbage.png");
}

void draw() {
	switch(gameState){
		
    // Game Start
    case GAME_START:
    
     image(titleImg,0,0);
     image(startNormalImg,248,360);
     if(mouseX > startNormalX && mouseX < startNormalX + startNormalW
        && mouseY > startNormalY && mouseY < startNormalY + startNormalH){
        image(startHoveredImg,248,360);
        if(mousePressed == true){
          gameState = 0;
          }
        }
      break;

		// Game Run
    case GAME_RUN:
    
     imageMode(CENTER);
     image(bgImg,x,y);
  
     //sun
     fill(253,184,19);
     stroke(255,255,0);
     strokeWeight(5);
     ellipse(x+270,y-190,120,120);
  
     //grass
     fill(124,204,05);
     noStroke();
     rectMode(CENTER);
     rect(x,y-80,640,30);
     
     //soil
     image(soilImg,x,y+80);
     
     //groundhog
     image(groundhogImg,groundhogX,groundhogY);
     if(groundhogX < 0 + 40){
       groundhogX = 40;
     }
     
     if(groundhogX > width - 40){
       groundhogX = width - 40;
     }
     
     if(groundhogY < 120){
       groundhogY = 120;
     }
     
     if(groundhogY > height - 40){
       groundhogY = height - 40;
     }
    
     
     //life
     for(int i = 0; i < life; i++){
     image(lifeImg,40 + 70*i ,35);
     }
     
     //soldier
     soldierX = soldierX + soldierXspeed;
     soldierX = soldierX %(640+soldierWidth);
     if (soldierY < 240) {soldierY = 160;}
     else if (soldierY < 320){soldierY = 240;}
     else if (soldierY < 400){soldierY = 320;}
     else if (soldierY < 480){soldierY = 400;}
     image(soldierImg, soldierX++, soldierY + 40);
     
     if(groundhogX > soldierX - 80 && groundhogX < soldierX + 80
        && groundhogY + 40 > soldierY && groundhogY - 40 < soldierY + 80){
          life--;
          groundhogX = 360;
          groundhogY = 120;
        }
        
     if(life == 0){
       gameState = 1;
     }
     
     //cabbage
     if(eatCabbage == false){
       if (cabbageY < 240) {cabbageY = 160;}
       else if (cabbageY < 320){cabbageY = 240;}
       else if (cabbageY < 400){cabbageY = 320;}
       else if (cabbageY < 480){cabbageY = 400;}
       
       if (cabbageX < 80) {cabbageX = 0;}
       else if (cabbageX < 160){cabbageX = 80;}
       else if (cabbageX < 240){cabbageX = 160;}
       else if (cabbageX < 320){cabbageX = 240;}
       else if (cabbageX < 400){cabbageX = 320;}
       else if (cabbageX < 480){cabbageX = 400;}
       else if (cabbageX < 560){cabbageX = 480;}
       else if (cabbageX < 640){cabbageX = 560;}
       
       image(cabbageImg, cabbageX + 40, cabbageY + 40);
       
       if(groundhogX + 40 > cabbageX && groundhogX - 40 < cabbageX + 80
        && groundhogY + 40 > cabbageY && groundhogY - 40 < cabbageY + 80){
          eatCabbage = true;
          life++;
          
          break;
        }
     }
   
      break;

		// Game Lose
    case GAME_LOSE:
    
    imageMode(CORNER);
    image(gameoverImg,0,0);
     image(restartNormalImg,248,360);
     if(mouseX > startNormalX && mouseX < startNormalX + startNormalW
        && mouseY > startNormalY && mouseY < startNormalY + startNormalH){
        image(restartHoveredImg,248,360);
        if(mousePressed == true){
          gameState = 0;
          groundhogX = 360;
          groundhogY = 120;
          soldierX = 40;
          soldierY = random(160,480);
          life = 2;
          eatCabbage = false;
          cabbageX = random(40,width - 40);
          cabbageY = random(160,480);
          }
        }
    
      break;
  }
}

void keyPressed(){
  switch(keyCode){
   case UP: 
   if(groundhogY <= 120){
     groundhogY = 120;
   }
   else{
     groundhogY -= 80;
   }
  
   break;
   
   case DOWN: 
   if(groundhogY >= height - 40){
     groundhogY = height - 40;
   }
   else{
     groundhogY += 80;
   }
  
   break;
   
   case RIGHT: 
   if(groundhogX >= width - 40){
     groundhogX = width - 40;
   }
   else{
     groundhogX += 80;
   }
  
   break;
   
   case LEFT: 
   if(groundhogX <= 40){
     groundhogX = 40;
   }
   else{
     groundhogX -= 80;
   }
  
   break;
  }
}
////////
void keyReleased(){
}
