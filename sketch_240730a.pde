import processing.sound.*;

boolean [] multiKeysPressed = new boolean[17];
int unitaMisura;
int time;
int gameMode = -1;

int W = 0;
int A = 1;
int S = 2;
int D = 3;
int frecciaUp = 4;
int frecciaSx = 5;
int frecciaDown = 6;
int frecciaDx = 7;
int B = 8;
int N = 9;
int M = 10;
int I = 11;
int O = 12;
int P = 13;
int K = 14; // PER LA PAUSA
int E = 15;
int Q = 16;

PFont font;

Audio gestoreAudio;

private Menu mainMenu;
private SelezionePersonaggi selectCharacter;
private ComandiRegole comandiRegole;
private LogicaGioco game;

void setup(){
  size(1280,720);
  frameRate(60);
  time = millis();
  unitaMisura = height/10;
  ellipseMode(CENTER);
  font = createFont("LEMONMILK-Bold.otf", 20);
  textFont(font);
  
  gestoreAudio = new Audio(this);
  comandiRegole = new ComandiRegole();
  mainMenu = new Menu();
  
}

void draw(){
  background(0);
  
  
  
  if(gameMode == -1){
    if(!gestoreAudio.getPlayingMainTheme()){
      gestoreAudio.playMainTheme();
      gestoreAudio.setPlayingMainTheme(true);
    }
    mainMenu.drawMenu();
  }
  if(gameMode == 0){
    selectCharacter.drawSelezionePersonaggi();
  }
  if(gameMode == 2){
    comandiRegole.showComandiRegole();
  }
  if(gameMode == 5){
    gestoreAudio.stopMainTheme();
    game.newGame();
  }
  
}

void keyPressed(){
   if(key == 'k'){
     multiKeysPressed[K] = true;
   }
   if(key == 'e'){
     multiKeysPressed[E] = true;
   }
   if(key == 'q'){
     multiKeysPressed[Q] = true;
   }
   
   
   if(key == 'w'){
      multiKeysPressed[W] = true;
     }
   if(key == 'a'){
      multiKeysPressed[A] = true;
     }
   if(key == 's'){
      multiKeysPressed[S] = true;
     }
   if(key == 'd'){
      multiKeysPressed[D] = true;
     }
     
   if(key == 'b'){
     multiKeysPressed[B] = true;
    }
    
    if(key == 'n'){
      multiKeysPressed[N] = true;
    }
    
    if(key == 'm'){
      multiKeysPressed[M] = true;
    }
    
    if(key == CODED){
      if(keyCode == UP){
        multiKeysPressed[frecciaUp] = true;
      }
      if(keyCode == LEFT){
        multiKeysPressed[frecciaSx] = true;
      }
      if(keyCode == DOWN){
        multiKeysPressed[frecciaDown] = true;
      }
      if(keyCode == RIGHT){
        multiKeysPressed[frecciaDx] = true;
      }
    }
    
    if(key == 'i'){
     multiKeysPressed[I] = true;
    }
    
    if(key == 'o'){
      multiKeysPressed[O] = true;
    }
    
    if(key == 'p'){
      multiKeysPressed[P] = true;
    }
    
}

void keyReleased(){
  if(key == 'k'){
     multiKeysPressed[K] = false;
   }
   if(key == 'e'){
     multiKeysPressed[E] = false;
   }
   if(key == 'q'){
     multiKeysPressed[Q] = false;
   }
   
  if(key == 'w'){
      multiKeysPressed[W] = false;
     }
   if(key == 'a'){
      multiKeysPressed[A] = false;
     }
   if(key == 's'){
      multiKeysPressed[S] = false;
     }
   if(key == 'd'){
      multiKeysPressed[D] = false;
     }
     
   if(key == 'b'){
     multiKeysPressed[B] = false;
    }
   
   if(key == 'n'){
      multiKeysPressed[N] = false;
    }
    
    if(key == 'm'){
      multiKeysPressed[M] = false;
    }
     
   if(key == CODED){
      if(keyCode == UP){
        multiKeysPressed[frecciaUp] = false;
      }
      if(keyCode == LEFT){
        multiKeysPressed[frecciaSx] = false;
      }
      if(keyCode == DOWN){
        multiKeysPressed[frecciaDown] = false;
      }
      if(keyCode == RIGHT){
        multiKeysPressed[frecciaDx] = false;
      }
    }
    
    if(key == 'i'){
     multiKeysPressed[I] = false;
    }
    
    if(key == 'o'){
      multiKeysPressed[O] = false;
    }
    
    if(key == 'p'){
      multiKeysPressed[P] = false;
    }
}
