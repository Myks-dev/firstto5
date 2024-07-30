/*
CLASSE CONTENENTE ALCUNI METODI UTILI PER LA LOGICA DEL GIOCO
*/
public class Utility{
  PImage goalll;
  int x = 0;
  int y = 0;
  
  private Utility(){
    goalll = loadImage("GOAL!.png");
  }
  
//REIMPOSTA I VALORI DOPO CHE E' STATO SEGNATO UN GOAL
  void resetAfterGoal(Palla palla, Giocatore giocatore1, Giocatore giocatore2){
    palla.resetBall();
    palla.imFree = true;
    giocatore1.resetPlayer();
    giocatore2.resetPlayer();
  }
  
//REIMPOSTA I VALORI DOPO LA FINE DI UNA PARTITA PER UNA RIVINCITA
  void rematch(Palla palla, Giocatore giocatore1, Giocatore giocatore2, Tabellone tabellone){
    tabellone.resetScore();
    this.resetAfterGoal(palla, giocatore1, giocatore2);
    
  }
  
//METODO PER L'ANIMAZIONE E LA RIPRODUZIONE DEL SUONO QUANDO SI SEGNA
  boolean animazioneGoal(int goalDiChi){
      if(!gestoreAudio.getGoalHasPlayed()){
        gestoreAudio.playGoal();
        gestoreAudio.setGoalHasPlayed(true);
      }
      if(x <= 400 && y <= 300){
//PLAYER1      
        if(goalDiChi == 1){  
          image(goalll, width-unitaMisura-x,height/4,x,y);
        }
//PLAYER2        
        if(goalDiChi == 2){  
          image(goalll, unitaMisura,height/4,x,y);
        }
        x++;
        y++;
        return false;
      }
      else{
        x = 0;
        y = 0;
        gestoreAudio.setGoalHasPlayed(false);
        return true;
      }
    
  }
  
}
