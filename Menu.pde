/*
CLASSE DEDICATA AL MENU INIZIALE
*/
public class Menu{
  final String[] menuStringhe = new String[3];
  final String naviga = "NAVIGA NEL MENù";
  final String conferma = "CONFERMA";
  final String indietro = "VAI INDIETRO";
  final int LUNGHEZZA = 740;
  final int ALTEZZA = 100;
  PImage background;
  PImage rettangolo;
  PImage wasd;
  PImage tasto_E;
  PImage tasto_Q;
  
  int highlightVoice = 0;
  
  private Menu(){
    menuStringhe[0] = "NUOVA PARTITA";
    menuStringhe[1] = "INFORMAZIONI";
    menuStringhe[2] = "ESCI DAL GIOCO";
    
    background = loadImage("backgroundMenu.jpg");
    rettangolo = loadImage("Rettangolo.png");
    wasd  = loadImage("WASD.png");
    tasto_E = loadImage("TASTO_E.png");
    tasto_Q = loadImage("TASTO_Q.png");
  }
  
//DISEGNA IL MENU PRINCIPALE
  private void drawMenu(){
    this.updateDrawMenu();
    
    textSize(15);
    fill(255);
    
    image(background, 0, 0, width, height);
    
    image(wasd, unitaMisura*5, height-unitaMisura);
    text(naviga, unitaMisura*4.7, height-unitaMisura*1.1);
    
    image(tasto_E, unitaMisura*7.7, height-unitaMisura);
    text(conferma, unitaMisura*7.7, height-unitaMisura*1.1);
    
    image(tasto_Q, unitaMisura*10.7, height-unitaMisura);
    text(indietro, unitaMisura*10.7, height-unitaMisura*1.1);
    
    
    textAlign(BASELINE);
    fill(0);
    strokeWeight(3);
    textSize(40);
    
    if(highlightVoice == 0){
      image(rettangolo, unitaMisura/2, unitaMisura*2, LUNGHEZZA, ALTEZZA);
      fill(255,200,0);
      textSize(75);
      text(menuStringhe[0], unitaMisura, unitaMisura*3);
      if(multiKeysPressed[E] && millis() > time + 200){
        selectCharacter = new SelezionePersonaggi();
        gameMode = 0;
      }
    }
    else{
      fill(255);
      textSize(65);
      text(menuStringhe[0], unitaMisura, unitaMisura*3);
    }
    
    if(highlightVoice == 1){
      image(rettangolo, unitaMisura/2, unitaMisura*4, LUNGHEZZA, ALTEZZA);
      fill(255,200,0);
      textSize(75);
      text(menuStringhe[1], unitaMisura, unitaMisura*5);
      if(multiKeysPressed[E] && millis() > time + 200){
        gameMode = 2;
      }
    }
    else{
      fill(255);
      textSize(65);
      text(menuStringhe[1], unitaMisura, unitaMisura*5);
    }
    
    if(highlightVoice == 2){
      image(rettangolo, unitaMisura/2, unitaMisura*6, LUNGHEZZA, ALTEZZA);
      fill(255,200,0);
      textSize(75);
      text(menuStringhe[2], unitaMisura, unitaMisura*7);
      if(multiKeysPressed[E]){
        exit();
      }
    }
    else{
      fill(255);
      textSize(65);
      text(menuStringhe[2], unitaMisura, unitaMisura*7);
    }
    
    
  }
  
//AGGIORNA IL MENU PRINCIPALE
  private void updateDrawMenu(){
    if(multiKeysPressed[W] && highlightVoice > 0){
      if(millis() > time + 200){
        highlightVoice -= 1;
        time = millis();
      }
    }
    if(multiKeysPressed[S] && highlightVoice < 2){
      if(millis() > time + 200){
        highlightVoice += 1;
        time = millis();
      }
    }
  }
}
