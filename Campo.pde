/*
CLASSE PER IL DISEGNO E LA GESTIONE DEL CAMPO E DELLE PORTE(IL TABELLONE
VIENE CREATO E INIZIALIZZATO QUI DENTRO PER FACILITARE L'UPDATE DEL PUNTEGGIO)
*/
public class Campo{
  final int DIMENSIONEBANDIERINA = 40;
  final int DIMENSIONEPALO = 10;
  
  float paloAltoPortaDX;
  float paloBassoPortaDX;
  float lineaPortaDestra; 
  
  float paloAltoPortaSX;
  float paloBassoPortaSX;
  float lineaPortaSinistra;
  
  PImage grass;
  PImage panchina;
  PImage portaSX;
  PImage portaDX;
  
  PImage[] bandierine = new PImage[4];
  
  Tabellone tabella;
  Utility utile;
  
  private Campo(Talento iconeTalentiDaMostrare){
    paloAltoPortaDX = unitaMisura*3.5;
    paloBassoPortaDX = unitaMisura*6.5;
    lineaPortaDestra = width-unitaMisura;
    
    paloAltoPortaSX = unitaMisura*3.5;
    paloBassoPortaSX = unitaMisura*6.5;
    lineaPortaSinistra = unitaMisura;
    
    //luci = loadImage("Luci.png");
    grass = loadImage("pitchGrass3.png");
    portaSX = loadImage("PortaSX.png");
    portaDX = loadImage("PortaDX.png");
    panchina = loadImage("panchina.png");
    
    bandierine[0] = loadImage("flag_checkered_1.png");
    bandierine[1] = loadImage("flag_checkered_2.png");
    bandierine[2] = loadImage("flag_checkered_3.png");
    bandierine[3] = loadImage("flag_checkered_4.png");
    
    
    utile = new Utility();
    tabella = new Tabellone(iconeTalentiDaMostrare);
    
  }  

  void drawCampo(){
   noStroke();
   image(grass, 0, 0);
   
//LINEE BORDOCAMPO
   strokeWeight(4);
   stroke(255);
   noFill();
   rect(unitaMisura, unitaMisura, width-(unitaMisura*2), height-(unitaMisura*2));
  
//LINEA METACAMPO
   line(width/2, unitaMisura, width/2, height-(unitaMisura));

//CERCHIO METACAMPO
   noFill();
   circle(width/2, height/2, 200);
   
//AREE DI RIGORE
   rect(unitaMisura, unitaMisura*2, unitaMisura*3, unitaMisura*6);
   rect(width-(unitaMisura*4), unitaMisura*2, unitaMisura*3, unitaMisura*6);
   
//DISCHETTI
   fill(255);
   circle(width/2, height/2, 10);
   circle(width-256, height/2, 10);
   circle(256, height/2, 10);
   
//BANDIERINE
   image(bandierine[0], unitaMisura/2, unitaMisura/2 + 8, DIMENSIONEBANDIERINA, DIMENSIONEBANDIERINA);
   image(bandierine[1], width-unitaMisura - 3, unitaMisura/2 + 8, DIMENSIONEBANDIERINA, DIMENSIONEBANDIERINA);
   image(bandierine[2], unitaMisura/2, height-unitaMisura - 9, DIMENSIONEBANDIERINA, DIMENSIONEBANDIERINA);
   image(bandierine[3], width-unitaMisura - 3, height-unitaMisura - 9, DIMENSIONEBANDIERINA, DIMENSIONEBANDIERINA);
   
//PANCHINA
   image(panchina, unitaMisura*3.5, 0, 300, 200);
   image(panchina, unitaMisura*10.1, 0, 300, 200);
   
   tabella.drawTabellone();
  }
  
/*
METODO PER DISEGNARE LA PORTA A SCHERMO
REALIZZATO A PARTE DAL DISEGNO DEL CAMPO PER PERMETTERE DI VISUALIZZARE
CORRETTAMENTE GLI ELEMENTI A SCHERMO ESSENDO LA RETE SEMITRASPARENTE
*/
  
  private void drawPorta(){
    
    image(portaSX, 0, unitaMisura*3.4);
    
    image(portaDX, width-unitaMisura, unitaMisura*3.4);
    
  }
  
//FUNZIONE PER SAPERE IN QUALE PORTA SIA ENTRATA LA PALLA

  int goalQualePorta(Palla palla){
    int ao = 0;
    if(palla.getPosX() - palla.BallSize/2 > lineaPortaDestra+3 && (palla.getPosY() - palla.BallSize/2 > paloAltoPortaDX + DIMENSIONEPALO/2 && palla.getPosY() + palla.BallSize/2 < paloBassoPortaDX - DIMENSIONEPALO/2)){
     ao = 1;
    }
    if(palla.getPosX() + palla.BallSize/2 < lineaPortaSinistra-3 && (palla.getPosY() - palla.BallSize/2 > paloAltoPortaSX + DIMENSIONEPALO/2 && palla.getPosY() + palla.BallSize/2 < paloBassoPortaSX - DIMENSIONEPALO/2)){
     ao = 2;
    }
    
    return ao;
  }
  
/*
CONTROLLA SE C'E' STATO UN GOAL
SE QUALCUNO HA SEGNATO, FERMA LA PALLA E IMPOSTA TRUE I BOOLEANI HASSCORED PER EVITARE CHE LA PALLA POSSA ESSERE TOLTA DALLA PORTA
E FA PARTIRE L'ANIMAZIONE DEL GOAL PER POI RESETTARE AL CALCIO D'INIZIO 
*/

  void checkGoal(Palla palla, Giocatore giocatore1, Giocatore giocatore2){
    int golol = this.goalQualePorta(palla);
    
    if(golol != 0){
       palla.setSpeedX(0);
       palla.setSpeedY(0);
       giocatore1.hasScored = true;
       giocatore2.hasScored = true;
      if(utile.animazioneGoal(golol)){
        tabella.updateScore(golol);
        utile.resetAfterGoal(palla, giocatore1, giocatore2);
        delay(300);
      }
    }
  }
}
