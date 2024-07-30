/*
CLASSE PER GESTIRE LA SCHERMATA DI SELEZIONE DEGLI OMINI E DEI TALENTI
*/
public class SelezionePersonaggi{
  final String SELEZIONE_PERSONAGGI = "SELEZIONE PERSONAGGI E TALENTI";
  final String PLAYER_1 = "PLAYER 1";
  final String PLAYER_2 = "PLAYER 2";
  final String CONFERMA = "CONFERMA";
  final String READY = "READY";
  final int RETTANGOLOWIDTH = 250;
  final int RETTANGOLOHEIGHT = 150;
  final int FRECCIAWIDTH = 60;
  final int FRECCIAHEIGHT = 50;
  
  Omini listaOmini;
  Talento listaTalenti;
  
  boolean P1_ready = false;
  boolean P2_ready = false;
  
  PImage sfondoMenu;
  PImage rettangoloArancione;
  PImage frecciaBiancaDX;
  PImage frecciaBiancaSX;
  PImage frecciaArancioneDX;
  PImage frecciaArancioneSX;
  
  int highlightArrowP1 = 0;
  boolean highlightArrowOrangeSXP1 = false;
  boolean highlightArrowOrangeDXP1 = false;
  
  int highlightArrowP2 = 0;
  boolean highlightArrowOrangeSXP2 = false;
  boolean highlightArrowOrangeDXP2 = false;
  
  int ominoToShowSX = 0;
  int ominoToShowDX = 0;
  
  int talentoToShowSX_n1 = 0;
  int talentoToShowDX_n1 = 0;
  
  int talentoToShowSX_n2 = 1;
  int talentoToShowDX_n2 = 1;
  
  PImage ominoSelected_P1;
  PImage ominoSelected_P2;
  PImage gambaSelected_P1;
  PImage gambaSelected_P2;
  PImage ominoTackleSelected_P1;
  PImage ominoTackleSelected_P2;
  PImage ominoTOBENCH_P1;
  PImage ominoTOBENCH_P2;
  
  private SelezionePersonaggi(){
    sfondoMenu = loadImage("sfondoMenu.png");
    rettangoloArancione = loadImage("Rettangolo.png");
    frecciaBiancaSX = loadImage("ArrowSX.png");
    frecciaBiancaDX = loadImage("ArrowDX.png");
    frecciaArancioneSX = loadImage("ArrowOrangeSX.png");
    frecciaArancioneDX = loadImage("ArrowOrangeDX.png");
    
    listaOmini = new Omini();
    listaTalenti = new Talento();
    
    listaOmini.arraySelectedSX[ominoToShowSX] = true;
    listaOmini.arraySelectedDX[ominoToShowDX] = true;
    
    listaTalenti.arraySelectedP1[talentoToShowSX_n1] = true;
    listaTalenti.arraySelectedP2[talentoToShowDX_n1] = true;
    
    listaTalenti.arraySelectedP1[talentoToShowSX_n2] = true;
    listaTalenti.arraySelectedP2[talentoToShowDX_n2] = true;
  }
  
/*
DISEGNA L'INTERFACCIA DELLA SCHERMATA E IMPOSTA LE SCELTE DEI GIOCATORI
CHE VERRANNO PASSATI AL COSTRUTTORE DI LOGICAPARTITA
*/
  private void drawSelezionePersonaggi(){
    noStroke();
    image(sfondoMenu, 0, 0);
    textSize(50);
    
    fill(255,200,0);
    textAlign(CENTER);
    text(SELEZIONE_PERSONAGGI, width/2, unitaMisura/1.5);
    
    textAlign(BASELINE);
    text(PLAYER_1, unitaMisura*2.1, unitaMisura*1.8);
    text(PLAYER_2, unitaMisura*12, unitaMisura*1.8);
    
    if(this.P1_ready && this.P2_ready){
      ominoSelected_P1 = listaOmini.arrayOminiSX[ominoToShowSX];
      ominoSelected_P2 = listaOmini.arrayOminiDX[ominoToShowDX];
      gambaSelected_P1 = listaOmini.arrayGambaOminiSX[ominoToShowSX];
      gambaSelected_P2 = listaOmini.arrayGambaOminiDX[ominoToShowDX];
      ominoTackleSelected_P1 = listaOmini.arrayTackleOminiSX[ominoToShowSX];
      ominoTackleSelected_P2 = listaOmini.arrayTackleOminiDX[ominoToShowDX];
      ominoTOBENCH_P1 = listaOmini.arrayOminiTOBENCH[ominoToShowSX];
      ominoTOBENCH_P2 = listaOmini.arrayOminiTOBENCH[ominoToShowDX];
      
      if(millis() > time + 200){
        game = new LogicaGioco(listaTalenti, ominoSelected_P1, ominoSelected_P2, gambaSelected_P1, gambaSelected_P2, ominoTackleSelected_P1, ominoTackleSelected_P2, ominoTOBENCH_P1, ominoTOBENCH_P2);
        gameMode = 5;
        this.resetPlayersReady();
        delay(200);
      }
    }
    
//PLAYER1
    image(rettangoloArancione, unitaMisura*2, unitaMisura*2, RETTANGOLOWIDTH, RETTANGOLOHEIGHT);
    image(rettangoloArancione, unitaMisura*2, unitaMisura*4, RETTANGOLOWIDTH, RETTANGOLOHEIGHT);
    image(rettangoloArancione, unitaMisura*2, unitaMisura*6, RETTANGOLOWIDTH, RETTANGOLOHEIGHT);
    if(highlightArrowP1 == 0){
      if(highlightArrowOrangeSXP1){
        if(ominoToShowSX != 0){
          image(frecciaArancioneSX, unitaMisura/2, unitaMisura*2.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
        if(ominoToShowSX != 4){
          image(frecciaBiancaDX, unitaMisura*6, unitaMisura*2.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
      }
      else if(highlightArrowOrangeDXP1){
        if(ominoToShowSX != 0){
          image(frecciaBiancaSX, unitaMisura/2, unitaMisura*2.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
        if(ominoToShowSX != 4){
          image(frecciaArancioneDX, unitaMisura*6, unitaMisura*2.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
      }
      else{
        if(ominoToShowSX != 0){
          image(frecciaBiancaSX, unitaMisura/2, unitaMisura*2.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
        if(ominoToShowSX != 4){
          image(frecciaBiancaDX, unitaMisura*6, unitaMisura*2.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
      }
    }
    else{
      if(ominoToShowSX != 0){
        image(frecciaBiancaSX, unitaMisura/1.1, unitaMisura*2.5, FRECCIAWIDTH-20, FRECCIAHEIGHT-20);
      }
      if(ominoToShowSX != 4){
        image(frecciaBiancaDX, unitaMisura*6, unitaMisura*2.5, FRECCIAWIDTH-20, FRECCIAHEIGHT-20);
      }
    }
    
    if(highlightArrowP1 == 1){
      if(highlightArrowOrangeSXP1){
        if(talentoToShowSX_n1 !=0){
          image(frecciaArancioneSX, unitaMisura/2, unitaMisura*4.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
        if(talentoToShowSX_n1 !=3){
          image(frecciaBiancaDX, unitaMisura*6, unitaMisura*4.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
      }
      else if(highlightArrowOrangeDXP1){
        if(talentoToShowSX_n1 !=0){
          image(frecciaBiancaSX, unitaMisura/2, unitaMisura*4.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
        if(talentoToShowSX_n1 !=3){
          image(frecciaArancioneDX, unitaMisura*6, unitaMisura*4.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
      }
      else{
        if(talentoToShowSX_n1 !=0){
          image(frecciaBiancaSX, unitaMisura/2, unitaMisura*4.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
        if(talentoToShowSX_n1 !=3){
          image(frecciaBiancaDX, unitaMisura*6, unitaMisura*4.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
      }
    }
    else{
      if(talentoToShowSX_n1 !=0){
        image(frecciaBiancaSX, unitaMisura/1.1, unitaMisura*4.5, FRECCIAWIDTH-20, FRECCIAHEIGHT-20);
      }
      if(talentoToShowSX_n1 !=3){
        image(frecciaBiancaDX, unitaMisura*6, unitaMisura*4.5, FRECCIAWIDTH-20, FRECCIAHEIGHT-20);
      }
    }
    
    if(highlightArrowP1 == 2){
      if(highlightArrowOrangeSXP1){
        if(talentoToShowSX_n2 !=0){
          image(frecciaArancioneSX, unitaMisura/2, unitaMisura*6.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
        if(talentoToShowSX_n2 !=3){
          image(frecciaBiancaDX, unitaMisura*6, unitaMisura*6.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
      }
      else if(highlightArrowOrangeDXP1){
        if(talentoToShowSX_n2 !=0){
          image(frecciaBiancaSX, unitaMisura/2, unitaMisura*6.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
        if(talentoToShowSX_n2 !=3){
          image(frecciaArancioneDX, unitaMisura*6, unitaMisura*6.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
      }
      else{
        if(talentoToShowSX_n2 !=0){
          image(frecciaBiancaSX, unitaMisura/2, unitaMisura*6.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
        if(talentoToShowSX_n2 !=3){
          image(frecciaBiancaDX, unitaMisura*6, unitaMisura*6.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
      }
    }
    else{
      if(talentoToShowSX_n2 !=0){
        image(frecciaBiancaSX, unitaMisura/1.1, unitaMisura*6.5, FRECCIAWIDTH-20, FRECCIAHEIGHT-20);
      }
      if(talentoToShowSX_n2 !=3){
        image(frecciaBiancaDX, unitaMisura*6, unitaMisura*6.5, FRECCIAWIDTH-20, FRECCIAHEIGHT-20);
      }
    }
    
    textSize(40);
    
    if(highlightArrowP1 == 3 && !this.P1_ready){
      fill(255,200,0);
      text(CONFERMA, unitaMisura*2, unitaMisura*9);
    }
    else if(highlightArrowP1 == 3 && this.P1_ready){
      fill(200,255,0);
      text(READY, unitaMisura*2, unitaMisura*9);
    }
    else{
      fill(255);
      text(CONFERMA, unitaMisura*2, unitaMisura*9);
    }
    
//PLAYER2
    image(rettangoloArancione, unitaMisura*12, unitaMisura*2, RETTANGOLOWIDTH, RETTANGOLOHEIGHT);
    image(rettangoloArancione, unitaMisura*12, unitaMisura*4, RETTANGOLOWIDTH, RETTANGOLOHEIGHT);
    image(rettangoloArancione, unitaMisura*12, unitaMisura*6, RETTANGOLOWIDTH, RETTANGOLOHEIGHT);
    if(highlightArrowP2 == 0){
      if(highlightArrowOrangeSXP2){
        if(ominoToShowDX != 0){
          image(frecciaArancioneSX, unitaMisura*10.5, unitaMisura*2.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
        if(ominoToShowDX != 4){
          image(frecciaBiancaDX, unitaMisura*16, unitaMisura*2.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
      }
      else if(highlightArrowOrangeDXP2){
        if(ominoToShowDX != 0){
          image(frecciaBiancaSX, unitaMisura*10.5, unitaMisura*2.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
        if(ominoToShowDX != 4){
          image(frecciaArancioneDX, unitaMisura*16, unitaMisura*2.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
      }
      else{
        if(ominoToShowDX != 0){
          image(frecciaBiancaSX, unitaMisura*10.5, unitaMisura*2.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
        if(ominoToShowDX != 4){
          image(frecciaBiancaDX, unitaMisura*16, unitaMisura*2.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
      }
    }
    else{
      if(ominoToShowDX != 0){
        image(frecciaBiancaSX, unitaMisura*10.9, unitaMisura*2.5, FRECCIAWIDTH-20, FRECCIAHEIGHT-20);
      }
      if(ominoToShowDX != 4){
        image(frecciaBiancaDX, unitaMisura*16, unitaMisura*2.5, FRECCIAWIDTH-20, FRECCIAHEIGHT-20);
      }
    }
    
    if(highlightArrowP2 == 1){
      if(highlightArrowOrangeSXP2){
        if(talentoToShowDX_n1 != 0){
          image(frecciaArancioneSX, unitaMisura*10.5, unitaMisura*4.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
        if(talentoToShowDX_n1 != 3){
          image(frecciaBiancaDX, unitaMisura*16, unitaMisura*4.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
      }
      else if(highlightArrowOrangeDXP2){
        if(talentoToShowDX_n1 != 0){
          image(frecciaBiancaSX, unitaMisura*10.5, unitaMisura*4.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
        if(talentoToShowDX_n1 != 3){
          image(frecciaArancioneDX, unitaMisura*16, unitaMisura*4.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
      }
      else{
        if(talentoToShowDX_n1 != 0){
          image(frecciaBiancaSX, unitaMisura*10.5, unitaMisura*4.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
        if(talentoToShowDX_n1 != 3){
          image(frecciaBiancaDX, unitaMisura*16, unitaMisura*4.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
      }
    }
    else{
      if(talentoToShowDX_n1 != 0){
        image(frecciaBiancaSX, unitaMisura*10.9, unitaMisura*4.5, FRECCIAWIDTH-20, FRECCIAHEIGHT-20);
      }
      if(talentoToShowDX_n1 != 3){
        image(frecciaBiancaDX, unitaMisura*16, unitaMisura*4.5, FRECCIAWIDTH-20, FRECCIAHEIGHT-20);
      }
    }
    
    if(highlightArrowP2 == 2){
      if(highlightArrowOrangeSXP2){
        if(talentoToShowDX_n2 != 0){
          image(frecciaArancioneSX, unitaMisura*10.5, unitaMisura*6.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
        if(talentoToShowDX_n2 != 3){
          image(frecciaBiancaDX, unitaMisura*16, unitaMisura*6.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
      }
      else if(highlightArrowOrangeDXP2){
        if(talentoToShowDX_n2 != 0){
          image(frecciaBiancaSX, unitaMisura*10.5, unitaMisura*6.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
        if(talentoToShowDX_n2 != 3){
          image(frecciaArancioneDX, unitaMisura*16, unitaMisura*6.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
      }
      else{
        if(talentoToShowDX_n2 != 0){
          image(frecciaBiancaSX, unitaMisura*10.5, unitaMisura*6.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
        if(talentoToShowDX_n2 != 3){
          image(frecciaBiancaDX, unitaMisura*16, unitaMisura*6.5, FRECCIAWIDTH, FRECCIAHEIGHT);
        }
      }
    }
    else{
      if(talentoToShowDX_n2 != 0){
        image(frecciaBiancaSX, unitaMisura*10.9, unitaMisura*6.5, FRECCIAWIDTH-20, FRECCIAHEIGHT-20);
      }
      if(talentoToShowDX_n2 != 3){
        image(frecciaBiancaDX, unitaMisura*16, unitaMisura*6.5, FRECCIAWIDTH-20, FRECCIAHEIGHT-20);
      }
    }
    
    if(highlightArrowP2 == 3 && !this.P2_ready){
      fill(255,200,0);
      text(CONFERMA, unitaMisura*12, unitaMisura*9);
    }
    else if(highlightArrowP2 == 3 && this.P2_ready){
      fill(200,255,0);
      text(READY, unitaMisura*12, unitaMisura*9);
    }
    else{
      fill(255);
      text(CONFERMA, unitaMisura*12, unitaMisura*9);
    }
    this.updateDrawSelezionePersonaggi();
    this.drawOmini();
    this.drawTalenti();
    
  }
  
//AGGIORNA LA SCHERAMATA DI SELEZIONE PERSONAGGI
  private void updateDrawSelezionePersonaggi(){
    
    if(multiKeysPressed[Q]){
      gameMode = -1;
      mainMenu = new Menu();
    }
    
//PLAYER1
    if(!this.P1_ready){
      if(multiKeysPressed[W] && highlightArrowP1 > 0){
        if(millis() > time + 200){
          highlightArrowP1 -= 1;
          time = millis();
        }
      }
      
      if(multiKeysPressed[S] && highlightArrowP1 < 3){
        if(millis() > time + 200){
          highlightArrowP1 += 1;
          time = millis();
        }
      }
      
      if(multiKeysPressed[A]){
        if(millis() > time + 200){
          this.updateDrawOmini();
          this.updateDrawTalenti();
          highlightArrowOrangeSXP1 = true;
          time = millis();
        }
      }
      else{
        highlightArrowOrangeSXP1 = false;
      }
      
      if(multiKeysPressed[D]){
        if(millis() > time + 200){
          this.updateDrawOmini();
          this.updateDrawTalenti();
          highlightArrowOrangeDXP1 = true;
          time = millis();
        }
      }
      else{
        highlightArrowOrangeDXP1 = false;
      }
      
      if(multiKeysPressed[E] && highlightArrowP1 == 3){
        if(millis() > time + 200){
          this.P1_ready = true;
          time = millis();
        }
      }
    }
    else{
      if(multiKeysPressed[E] && highlightArrowP1 == 3){
        if(millis() > time + 200){
          this.P1_ready = false;
          time = millis();
        }
      }
    }

    
//PLAYER2
    if(!this.P2_ready){
      if(multiKeysPressed[frecciaUp] && highlightArrowP2 > 0){
        if(millis() > time + 200){
          highlightArrowP2 -= 1;
          time = millis();
        }
      }
      
      if(multiKeysPressed[frecciaDown] && highlightArrowP2 < 3){
        if(millis() > time + 200){
          highlightArrowP2 += 1;
          time = millis();
        }
      }
      
      if(multiKeysPressed[frecciaSx]){
        if(millis() > time + 200){
          this.updateDrawOmini();
          this.updateDrawTalenti();
          highlightArrowOrangeSXP2 = true;
          time = millis();
        }
      }
      else{
        highlightArrowOrangeSXP2 = false;
      }
      
      if(multiKeysPressed[frecciaDx]){
        if(millis() > time + 200){
          this.updateDrawOmini();
          this.updateDrawTalenti();
          highlightArrowOrangeDXP2 = true;
          time = millis();
        }
      }
      else{
        highlightArrowOrangeDXP2 = false;
      }
      
      if(multiKeysPressed[I] && highlightArrowP2 == 3){
        if(millis() > time + 200){
          this.P2_ready = true;
          time = millis();
        }
      }
    }
    else{
      if(multiKeysPressed[I] && highlightArrowP2 == 3){
        if(millis() > time + 200){
          this.P2_ready = false;
          time = millis();
        }
      }
    }
  }
  
//DISEGNA GLI OMINI ATTUALMENTE SELEZIONATI
  private void drawOmini(){
    image(listaOmini.arrayOminiSX[ominoToShowSX], unitaMisura*3.6, unitaMisura*2.8,30,30);
    image(listaOmini.arrayOminiDX[ominoToShowDX], unitaMisura*13.6, unitaMisura*2.8,30,30);
  }
  
//AGGIORNA GLI OMINI DA DISEGNARE
  private void updateDrawOmini(){
    if(multiKeysPressed[A] && highlightArrowP1 == 0 && ominoToShowSX > 0){
      listaOmini.arraySelectedSX[ominoToShowSX] = false;
      ominoToShowSX -= 1;
      listaOmini.arraySelectedSX[ominoToShowSX] = true;
      
    }
    if(multiKeysPressed[D] && highlightArrowP1 == 0 && ominoToShowSX < 4){
      listaOmini.arraySelectedSX[ominoToShowSX] = false;
      ominoToShowSX += 1;
      listaOmini.arraySelectedSX[ominoToShowSX] = true;
      
    }
    if(multiKeysPressed[frecciaSx] && highlightArrowP2 == 0 && ominoToShowDX > 0){
      listaOmini.arraySelectedDX[ominoToShowDX] = false;
      ominoToShowDX -= 1;
      listaOmini.arraySelectedDX[ominoToShowDX] = true;
      
    }
    if(multiKeysPressed[frecciaDx] && highlightArrowP2 == 0 && ominoToShowDX < 4){
      listaOmini.arraySelectedDX[ominoToShowDX] = false;
      ominoToShowDX += 1;
      listaOmini.arraySelectedDX[ominoToShowDX] = true;
      
    }
    
  }
  
//DISEGNA I TALENTI ATTUALMENTE SELEZIONATI
  private void drawTalenti(){
    textSize(15);
    
    fill(255);
    
    image(listaTalenti.icone[talentoToShowSX_n1], unitaMisura*3.5, unitaMisura*4.7, 40,40);
    text(listaTalenti.nomeTalento[talentoToShowSX_n1], unitaMisura*2.8, unitaMisura*4.5);
    
    image(listaTalenti.icone[talentoToShowDX_n1], unitaMisura*13.5, unitaMisura*4.7, 40,40);
    text(listaTalenti.nomeTalento[talentoToShowDX_n1], unitaMisura*12.8, unitaMisura*4.5);
    
    image(listaTalenti.icone[talentoToShowSX_n2], unitaMisura*3.5, unitaMisura*6.7, 40,40);
    text(listaTalenti.nomeTalento[talentoToShowSX_n2], unitaMisura*2.8, unitaMisura*6.5);
    
    image(listaTalenti.icone[talentoToShowDX_n2], unitaMisura*13.5, unitaMisura*6.7, 40,40);
    text(listaTalenti.nomeTalento[talentoToShowDX_n2], unitaMisura*12.8, unitaMisura*6.5);
  }
  
//AGGIORNA I TALENTI DA DISEGNARE
  private void updateDrawTalenti(){
//PLAYER1-TALENTO1
    if(multiKeysPressed[A] && highlightArrowP1 == 1 && talentoToShowSX_n1 > 0){
      if(!listaTalenti.arraySelectedP1[talentoToShowSX_n1 - 1]){
        listaTalenti.arraySelectedP1[talentoToShowSX_n1] = false;
        talentoToShowSX_n1 -= 1;
        listaTalenti.arraySelectedP1[talentoToShowSX_n1] = true;
      }
      else{
        if(talentoToShowSX_n1 - 2 >= 0){
          listaTalenti.arraySelectedP1[talentoToShowSX_n1] = false;
          talentoToShowSX_n1 -= 2;
          listaTalenti.arraySelectedP1[talentoToShowSX_n1] = true;
        }
      }
    }
    
    if(multiKeysPressed[D] && highlightArrowP1 == 1 && talentoToShowSX_n1 < 3){
      if(!listaTalenti.arraySelectedP1[talentoToShowSX_n1 + 1]){
        listaTalenti.arraySelectedP1[talentoToShowSX_n1] = false;
        talentoToShowSX_n1 += 1;
        listaTalenti.arraySelectedP1[talentoToShowSX_n1] = true;
      }
      else{
        if(talentoToShowSX_n1 + 2 <= 3){
          listaTalenti.arraySelectedP1[talentoToShowSX_n1] = false;
          talentoToShowSX_n1 += 2;
          listaTalenti.arraySelectedP1[talentoToShowSX_n1] = true;
        }
      }
    }

//PLAYER2-TALENTO1
    if(multiKeysPressed[frecciaSx] && highlightArrowP2 == 1 && talentoToShowDX_n1 > 0){
      if(!listaTalenti.arraySelectedP2[talentoToShowDX_n1 - 1]){
        listaTalenti.arraySelectedP2[talentoToShowDX_n1] = false;
        talentoToShowDX_n1 -= 1;
        listaTalenti.arraySelectedP2[talentoToShowDX_n1] = true;
      }
      else{
        if(talentoToShowDX_n1 - 2 >= 0){
          listaTalenti.arraySelectedP2[talentoToShowDX_n1] = false;
          talentoToShowDX_n1 -= 2;
          listaTalenti.arraySelectedP2[talentoToShowDX_n1] = true;
        }
      }
    }
    
    if(multiKeysPressed[frecciaDx] && highlightArrowP2 == 1 && talentoToShowDX_n1 < 3){
      if(!listaTalenti.arraySelectedP2[talentoToShowDX_n1 + 1]){
        listaTalenti.arraySelectedP2[talentoToShowDX_n1] = false;
        talentoToShowDX_n1 += 1;
        listaTalenti.arraySelectedP2[talentoToShowDX_n1] = true;
      }
      else{
        if(talentoToShowDX_n1 + 2 <= 3){
          listaTalenti.arraySelectedP2[talentoToShowDX_n1] = false;
          talentoToShowDX_n1 += 2;
          listaTalenti.arraySelectedP2[talentoToShowDX_n1] = true;
        }
      }
    }
   
//PLAYER1-TALENTO2
    if(multiKeysPressed[A] && highlightArrowP1 == 2 && talentoToShowSX_n2 > 0){
      if(!listaTalenti.arraySelectedP1[talentoToShowSX_n2 - 1]){
        listaTalenti.arraySelectedP1[talentoToShowSX_n2] = false;
        talentoToShowSX_n2 -= 1;
        listaTalenti.arraySelectedP1[talentoToShowSX_n2] = true;
      }
      else{
        if(talentoToShowSX_n2 - 2 >= 0){
          listaTalenti.arraySelectedP1[talentoToShowSX_n2] = false;
          talentoToShowSX_n2 -= 2;
          listaTalenti.arraySelectedP1[talentoToShowSX_n2] = true;
        }
      }
    }
    
    if(multiKeysPressed[D] && highlightArrowP1 == 2 && talentoToShowSX_n2 < 3){
      if(!listaTalenti.arraySelectedP1[talentoToShowSX_n2 + 1]){
        listaTalenti.arraySelectedP1[talentoToShowSX_n2] = false;
        talentoToShowSX_n2 += 1;
        listaTalenti.arraySelectedP1[talentoToShowSX_n2] = true;
      }
      else{
        if(talentoToShowSX_n2 + 2 <= 3){
          listaTalenti.arraySelectedP1[talentoToShowSX_n2] = false;
          talentoToShowSX_n2 += 2;
          listaTalenti.arraySelectedP1[talentoToShowSX_n2] = true;
        }
      }
    }
    
//PLAYER2-TALENTO2
    if(multiKeysPressed[frecciaSx] && highlightArrowP2 == 2 && talentoToShowDX_n2 > 0){
      if(!listaTalenti.arraySelectedP2[talentoToShowDX_n2 - 1]){
        listaTalenti.arraySelectedP2[talentoToShowDX_n2] = false;
        talentoToShowDX_n2 -= 1;
        listaTalenti.arraySelectedP2[talentoToShowDX_n2] = true;
      }
      else{
        if(talentoToShowDX_n2 - 2 >= 0){
          listaTalenti.arraySelectedP2[talentoToShowDX_n2] = false;
          talentoToShowDX_n2 -= 2;
          listaTalenti.arraySelectedP2[talentoToShowDX_n2] = true;
        }
      }
    }
    
    if(multiKeysPressed[frecciaDx] && highlightArrowP2 == 2 && talentoToShowDX_n2 < 3){
      if(!listaTalenti.arraySelectedP2[talentoToShowDX_n2 + 1]){
        listaTalenti.arraySelectedP2[talentoToShowDX_n2] = false;
        talentoToShowDX_n2 += 1;
        listaTalenti.arraySelectedP2[talentoToShowDX_n2] = true;
      }
      else{
        if(talentoToShowDX_n2 + 2 <= 3){
          listaTalenti.arraySelectedP2[talentoToShowDX_n2] = false;
          talentoToShowDX_n2 += 2;
          listaTalenti.arraySelectedP2[talentoToShowDX_n2] = true;
        }
      }
    }
  }
  
//METODO CHE RESETTA LO STATO DI "PRONTO" DEI GIOCATORI
  private void resetPlayersReady(){
    this.P1_ready = false;
    this.P2_ready = false;
    highlightArrowP1 = 0;
    highlightArrowP2 = 0;
  }
}
