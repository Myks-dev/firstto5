/*
CLASSE CHE GESTISCE IL MOVIMENTO E IL DISEGNO DELLA PALLA:
*/
public class Palla{
  float posX;
  float posY;
  
  float speedX;
  float speedY;
  
  int incrX;
  int incrY;
  
  int cosaDisegno = 0;
  
  int BallSize = 30;
  
  boolean imFree; // indica se la palla è controllata da uno dei due player
  
  PImage[] imgPalla = new PImage [4];
  
  private Palla(){
    this.posX = width/2;
    this.posY = height/2;
    this.speedX = 0;
    this.speedY = 0;
    this.incrX = 1;
    this.incrY = 1;
    this.imFree = true;
    imgPalla[0] = loadImage("ball_soccer_1.png");
    imgPalla[1] = loadImage("ball_soccer_2.png");
    imgPalla[2] = loadImage("ball_soccer_3.png");
    imgPalla[3] = loadImage("ball_soccer_4.png");
  }
  
//METODO PER DISEGNARE LA PALLA LIBERA O CONTROLLATA DA UNO DEI DUE PLAYER
  private void drawPalla(Giocatore giocatore1, Giocatore giocatore2){
    fill(255,255,255);
    strokeWeight(1);
    stroke(0);
    //text("posX:" +posX, posX, posY-30);
    //text("posY:" +posY, posX, posY+30);
    
    this.refreshAnimation();
    
    if(!this.imFree){
      if(giocatore1.getIsPlayerBall() && !giocatore1.hasScored){ //su questa linea: doppio controllo per evitare bug con gli autogoal
        
        this.setPosX(giocatore1.getPosXplayer()+50+this.BallSize/2);
        this.setPosY(giocatore1.getPosYplayer()+50/2);
        ellipse(posX, posY, BallSize, BallSize);
        image(imgPalla[this.cosaDisegno], posX-15, posY-15, BallSize, BallSize);
      }
      if(giocatore2.getIsPlayerBall() && !giocatore2.hasScored){ //su questa linea: doppio controllo per evitare bug con gli autogoal
        this.setPosX(giocatore2.getPosXplayer()-this.BallSize/2);
        this.setPosY(giocatore2.getPosYplayer()+50/2);
        ellipse(posX, posY, BallSize, BallSize);
        image(imgPalla[this.cosaDisegno], posX-15, posY-15, BallSize, BallSize);
      }
    }
    else{
      ellipse(posX, posY, BallSize, BallSize);
      image(imgPalla[this.cosaDisegno], posX-15, posY-15, BallSize, BallSize);
    }
    
    if(millis() > time + 50){
      if(this.getSpeedX() != 0 || this.getSpeedY() !=0){
        if(this.getIncrX() == 1){
          this.cosaDisegno++;
        }
        if(this.getIncrX() == -1){
          this.cosaDisegno--;
        }
        time =  millis();
      }
    }
  }
  
//AGGIORNA L'ANIMAZIONE DEL DISEGNO DELLA PALLA
  private void refreshAnimation(){
    if(this.cosaDisegno == 4){
      this.cosaDisegno = 0;
    }
    if(this.cosaDisegno == -1){
      this.cosaDisegno = 3;
    }
  }
  
//SETTER E GETTER PER GESTIRE LA PALLA
  private void setPosX(float xx){
    this.posX = xx;
  }
  
  private float getPosX(){
    return this.posX;
  }
  
  private void setPosY(float yy){
    this.posY = yy;
  }
  
  private float getPosY(){
    return this.posY;
  }
  
  private void setSpeedX(float speedX){
    this.speedX = speedX;
  }
  
  private float getSpeedX(){
    return this.speedX;
  }
  
  private void setSpeedY(float speedY){
    this.speedY = speedY;
  }
  
  private float getSpeedY(){
    return this.speedY;
  }
  
  private void setIncrX(int incremX){
    this.incrX = incremX;
  }
  
  private int getIncrX(){
    return this.incrX;
  }
  
  private void setIncrY(int incremY){
    this.incrY = incremY;
  }
  
  private int getIncrY(){
    return this.incrY;
  }
  
  private void resetBall(){
    this.posX = width/2;
    this.posY = height/2;
    this.speedX = 0;
    this.speedY = 0;
    this.incrX = 1;
    this.incrY = 1;
  }
  
}
