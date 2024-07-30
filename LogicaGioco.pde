/*
CLASSE CHE PERMETTE DI CREARE UNA NUOVA PARTITA E DI GESTIRE
I MENU DI PAUSA E DI FINE PARTITA
*/
public class LogicaGioco{
  boolean gameOver = false;
  boolean gamePaused = false;
  int highlightDecisionMenuPausa = 0;
  int highlightDecisionMenuFinePartita = 0;
  
  Utility util;
  Campo campo;
  Collisioni collisions;
  Palla ball;
  Giocatore player1;
  Giocatore player2;
  
//COSTRUTTORE CON PASSAGGIO DI OMINI  
  private LogicaGioco(Talento talentiDaAssegnare, PImage P1_omino, PImage P2_omino, PImage P1_gamba, PImage P2_gamba, PImage P1_tackle, PImage P2_tackle, PImage P1_ominoTOBENCH, PImage P2_ominoTOBENCH){
    campo = new Campo(talentiDaAssegnare);
    collisions = new Collisioni();
    player1 = new Giocatore(talentiDaAssegnare, P1_omino, P1_gamba, P1_tackle, P1_ominoTOBENCH);
    player2 = new Giocatore(true, talentiDaAssegnare, P2_omino, P2_gamba, P2_tackle, P2_ominoTOBENCH);
    ball = new Palla();
    util = new Utility();
  }
    
//AVVIA UNA NUOVA PARTITA
  private void newGame(){
    this.isGameOver();
    this.pausa();
    
    if(!gestoreAudio.getWhistleHasPlayed()){
      gestoreAudio.playWhistle();
      gestoreAudio.setWhistleHasPlayed(true);
    }
    
    campo.drawCampo();
    ball.drawPalla(player1, player2);
    
    if(!gameOver){
      player1.drawGiocatore();
      player2.drawGiocatore();
      
      if(!gamePaused){
        collisions.checkBallMovement(ball);
        collisions.checkHitboxPlayers(player1, player2);
        collisions.checkHitboxBall(player1, ball);
        collisions.checkHitboxBall(player2, ball);
        player1.checkMovement();
        player2.checkMovement();
        player1.checkTackling();
        player2.checkTackling();
        player1.moveGiocatore(player2);
        player2.moveGiocatore(player1);
        player1.shootBall(ball);
        player2.shootBall(ball);
        player1.dashForward(player2);
        player2.dashForward(player1);
        player1.doTackle(player2);
        player2.doTackle(player1);
      }
      else{
        this.drawMenuPausa();
      }
    }
    else{
      if(!gestoreAudio.getFinalWhistleHasPlayed()){
        gestoreAudio.playFinalWhistle();
      }
      gestoreAudio.setFinalWhistleHasPlayed(true);
      player1.drawGiocatoreTOBENCH();
      player2.drawGiocatoreTOBENCH();
      this.menuFinePartita();
        
    }
    campo.drawPorta();
    campo.checkGoal(ball, player1, player2);
    
  }
  
//CONTROLLA SE UNO DEI DUE PLAYER HA VINTO LA PARTITA  
  private void isGameOver(){
    if(campo.tabella.scoreP1 == 5 || campo.tabella.scoreP2 == 5){
      gameOver = true;
    }
  }
  
//CONTROLLA SE SI STA CERCANDO DI METTERE PAUSA  
  private void pausa(){
    if(multiKeysPressed[K] && !gamePaused && ball.getSpeedX() == 0 && ball.getSpeedY() == 0 && !player1.hasScored && !player2.hasScored){
      gamePaused = true;
    }
  }
  
//DISEGNA IL MENU DI PAUSA
  private void drawMenuPausa(){
    this.updateMenuPausa();
    
    textSize(35);
    strokeWeight(1);
    stroke(255,200,0);
    fill(0,0,100);
    rect((width/2)-unitaMisura*2, (height/2)-unitaMisura, unitaMisura*4, unitaMisura*2.2, 10);
    fill(150,255,0);
    text("PAUSA", width/2, height/2.3);
    if(highlightDecisionMenuPausa == 0){
      textSize(30);
      fill(255,200,0);
      text("CONTINUA", width/2, height/2);
      if(multiKeysPressed[E]){
        if(millis() > time + 200){
          gamePaused = false;
        }
      }
    }
    else{
      textSize(25);
      fill(255);
      text("CONTINUA", width/2, height/2);
    }
    if(highlightDecisionMenuPausa == 1){
      textSize(30);
      fill(255,200,0);
      text("ESCI", width/2, height/1.8);
      if(multiKeysPressed[E]){
        if(millis() > time + 200){
          gestoreAudio.setWhistleHasPlayed(false);
          gestoreAudio.setFinalWhistleHasPlayed(false);
          gameMode = -1;
          mainMenu = new Menu();
          delay(100);
        }
      }
    }
    else{
      textSize(25);
      fill(255);
      text("ESCI", width/2, height/1.8);
    }
  }
  
//AGGIORNA IL MENU DI PAUSA
  private void updateMenuPausa(){
    if(multiKeysPressed[W] && highlightDecisionMenuPausa > 0){
      if(millis() > time + 200){
        highlightDecisionMenuPausa -= 1;
        time = millis();
      }
    }
    if(multiKeysPressed[S] && highlightDecisionMenuPausa < 1){
      if(millis() > time + 200){
        highlightDecisionMenuPausa += 1;
        time = millis();
      }
    }
  }
  
//DISEGNA IL MENU DI FINE PARTITA
  private void menuFinePartita(){
    this.updateMenuFinePartita();
    
    textSize(35);
    strokeWeight(1);
    stroke(255,200,0);
    fill(0,0,100);
    rect((width/2)-unitaMisura*2, (height/2)-unitaMisura, unitaMisura*4, unitaMisura*2.2, 10);
    fill(200,0,0);
    text("GAME OVER", width/2, height/2.3);
    
    if(highlightDecisionMenuFinePartita == 0){
      textSize(30);
      fill(255,200,0);
      text("REMATCH", width/2, height/2);
      if(multiKeysPressed[E]){
        if(millis() > time + 200){
          campo.utile.rematch(ball, player1, player2, campo.tabella);
          gestoreAudio.setWhistleHasPlayed(false);
          gestoreAudio.setFinalWhistleHasPlayed(false);
          gameOver = false;
        }
      }
    }
    else{
      textSize(25);
      fill(255);
      text("REMATCH", width/2, height/2);
    }
    
    if(highlightDecisionMenuFinePartita == 1){
      textSize(30);
      fill(255,200,0);
      text("TORNA AL MENU'", width/2, height/1.8);
      if(multiKeysPressed[E]){
        if(millis() > time + 200){
          gestoreAudio.setWhistleHasPlayed(false);
          gestoreAudio.setFinalWhistleHasPlayed(false);
          gameMode = -1;
          mainMenu = new Menu();
          time = millis();
        }
      }
    }
    else{
      textSize(25);
      fill(255);
      text("TORNA AL MENU'", width/2, height/1.8);
    }
    
    
  }
  
//AGGIORNA IL MENU DI FINE PARTITA
  private void updateMenuFinePartita(){
    if(multiKeysPressed[W] && highlightDecisionMenuFinePartita > 0){
      if(millis() > time + 200){
        highlightDecisionMenuFinePartita -= 1;
        time = millis();
      }
    }
    if(multiKeysPressed[S] && highlightDecisionMenuFinePartita < 1){
      if(millis() > time + 200){
        highlightDecisionMenuFinePartita += 1;
        time = millis();
      }
    }
  }
}
