/*
SEMPLICE CLASSE PER IL TABELLONE E L'AGGIORNAMENTO DEL PUNTEGGIO
VIENE INIZIALIZZATA ALL'INTERNO DEL COSTRUTTORE DELLA CLASSE CAMPO
*/
public class Tabellone{
  int scoreP1;
  int scoreP2;
  String scoreP1Stringa;
  String scoreP2Stringa;
  String Player1 = "PLAYER 1";
  String Player2 = "PLAYER 2";
  
  Talento iconeTalenti;
  PImage talento1_P1;
  PImage talento2_P1;
  PImage talento1_P2;
  PImage talento2_P2;
  
  int p1_n1 = -1;
  int p2_n1 = -1;
  
  private Tabellone(Talento iconeTalentiScelti){
    this.scoreP1 = 0;
    this.scoreP2 = 0;
    iconeTalenti = iconeTalentiScelti;
    for(int a=0; a<4; a++){
      if(iconeTalenti.arraySelectedP1[a]){
        if(p1_n1 == -1){
          talento1_P1 = iconeTalenti.icone[a];
          p1_n1 = a;
          continue;
        }
        else{
          talento2_P1 = iconeTalenti.icone[a];
          break;
        }
      }
    }
    for(int b=0; b<4; b++){
      if(iconeTalenti.arraySelectedP2[b]){
        if(p2_n1 == -1){
          talento1_P2 = iconeTalenti.icone[b];
          p2_n1 = b;
          continue;
        }
        else{
          talento2_P2 = iconeTalenti.icone[b];
          break;
        }
      }
    }
    
  }
  
//METODO PER IL DISEGNO DEL TABELLONE
  private void drawTabellone(){
    scoreP1Stringa = str(scoreP1);
    scoreP2Stringa = str(scoreP2);
// RETTANGOLO TABELLONE
    strokeWeight(1);
    stroke(255,200,0);
    fill(0,0,100);
    rect(unitaMisura*2, height-unitaMisura/1.5, width-(unitaMisura*4), unitaMisura-30, 10);

//LINEA SEPARA P1 E P2 E LINEE PER I PUNTEGGI
    line(width/2, height-unitaMisura/1.5, width/2, height-unitaMisura/1.5 + (unitaMisura-30));
    line((width/2)-unitaMisura, height-unitaMisura/1.5, (width/2)-unitaMisura, height-unitaMisura/1.5 + (unitaMisura-30));
    line((width/2)+unitaMisura, height-unitaMisura/1.5, (width/2)+unitaMisura, height-unitaMisura/1.5 + (unitaMisura-30));
    
//STRINGHE A SCHERMO
    textSize(24);
    
    fill(255,200,0);
    textAlign(CENTER, CENTER);
    text(Player1, unitaMisura*2, height-unitaMisura/1.5, (width/2)-unitaMisura*3, unitaMisura-35);
    
    //rect((width/2)+unitaMisura, 0, (width/2)-unitaMisura*3, unitaMisura-35);
    text(Player2, (width/2)+unitaMisura, height-unitaMisura/1.5, (width/2)-unitaMisura*3, unitaMisura-35);
    
    textAlign(CENTER,CENTER);
    fill(255);
    textSize(25);
    //rect((width/2)-unitaMisura, 0, unitaMisura, unitaMisura-30);
    text(scoreP1Stringa, (width/2)-unitaMisura, height-unitaMisura/1.5, unitaMisura, unitaMisura-35);
    text(scoreP2Stringa, width/2, height-unitaMisura/1.5, unitaMisura, unitaMisura-35);
    
//ICONE TALENTI SCELTI
    image(talento1_P1, unitaMisura*2.1, height-unitaMisura/1.5 +2, 20, 20);
    image(talento2_P1, unitaMisura*2.1, height-unitaMisura/1.5 +22, 20, 20);
    
    image(talento1_P2, unitaMisura*15.45, height-unitaMisura/1.5 +2, 20, 20);
    image(talento2_P2, unitaMisura*15.45, height-unitaMisura/1.5 +22, 20, 20);
  }
  
//METODO PER AGGIORNARE IL PUNTEGGIO
  void updateScore(int golChi){
    if(golChi == 1){
      this.scoreP1 += 1;
    }
    if(golChi == 2){
      this.scoreP2 += 1;
    }
  }
  
//METODO PER RESETTARE IL PUNTEGGIO
  void resetScore(){
    this.scoreP1 = 0;
    this.scoreP2 = 0;
  }
  
}
