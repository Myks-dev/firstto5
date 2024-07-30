/*
CLASSE CHE CREA E GESTISCE TUTTE LE FEATURE DEL GIOCATORE
TRA CUI TIRO, DASH, TACKLE, MOVIMENTO E GESTIONE DELLE HITBOXES
*/
public class Giocatore{
  final int SOPRA = 1;
  final int DESTRA = 2;
  final int SOTTO = 3;
  final int SINISTRA = 4;
  
  boolean sonoP2 = false; //booleano per identificare il player2
  boolean isPlayerBall = false; //la palla è del giocatore?
  boolean hasScored = false; //indica se un giocatore ha segnato
  boolean tackleRange = false; //permette di sapere se si è in range per togliere palla all'avversario
  
  boolean imTackling = false;  //indica se il giocatore sta eseguendo il tackle per aggiornare l'animazione
  
  boolean funziona = false;   //indica che il giocatore ha perso palla e deve essere spostato indietro
  int vadoIndietro = 0; //valore indicativo per spostare il player all'indietro
  
  boolean imMoving = false;  //indica se il giocatore si sta muovendo per aggiornare l'animazione delle gambe
  int qualeGamba = 1; //valore indicativo per la frequenza d'aggiornamento dell'animazione delle gambe
  
  float speedPlayer;
  
  float posXplayer;
  float posYplayer;
  
  PImage legendStill;
  PImage legendGamba;
  PImage legendTackle;
  PImage legendTOBENCH;
  
  Talento talenti;
  
  private Giocatore(Talento talentiDaAssegnare_P1, PImage omino_P1, PImage gamba_P1, PImage tackle_P1, PImage ominoBENCH_P1){
    talenti = talentiDaAssegnare_P1;
    this.posXplayer = width/8;   //width/8
    this.posYplayer = (height/2)-25;  //height/2
    this.legendStill = omino_P1;
    this.legendGamba = gamba_P1;
    this.legendTackle = tackle_P1;
    this.legendTOBENCH = ominoBENCH_P1;
    if(talenti.arraySelectedP1[0]){
      this.speedPlayer = 5.5;
    }
    else{
      this.speedPlayer = 5;
    }
    
  }
  
  private Giocatore(boolean bool, Talento talentiDaAssegnare_P2, PImage omino_P2, PImage gamba_P2, PImage tackle_P2, PImage ominoBENCH_P2){
    talenti = talentiDaAssegnare_P2;
    this.posXplayer = width - (width/8) - 50;
    this.posYplayer = (height/2)-25;
    this.sonoP2 = bool;
    this.legendStill = omino_P2;
    this.legendGamba = gamba_P2;
    this.legendTackle = tackle_P2;
    this.legendTOBENCH = ominoBENCH_P2;
    if(talenti.arraySelectedP2[0]){
      this.speedPlayer = 5.5;
    }
    else{
      this.speedPlayer = 5;
    }
    
  }
  
/*  
METODO PER DISEGNARE IL GIOCATORE CON O SENZA LA PALLA AL PIEDE
*/  
  private void drawGiocatore(){
    this.animTackleIndietro();
    
    textSize(30);
    
    if(this.getIsPlayerBall()){
      strokeWeight(6);
      noFill();
      stroke(250,200,0);
      circle(this.getPosXplayer()+25, this.getPosYplayer()+25, 53);
    }
    if(this.tackleRange){
      strokeWeight(5);
      noFill();
      stroke(250,0,0);
      circle(this.getPosXplayer()+25, this.getPosYplayer()+25, 50);
      
    }

    fill(0,0,200);
    //text("posX:" +(this.getPosXplayer()), this.getPosXplayer(), this.getPosYplayer()-20);
    //text("posY:" +(this.getPosYplayer()), this.getPosXplayer(), this.getPosYplayer()+80);
    
    this.refreshGamba();

    if(this.imMoving && !this.sonoP2){
      if(this.qualeGamba < 13){
        image(this.legendGamba, this.getPosXplayer()+38, this.getPosYplayer()+25, 20, 20);
      }
      else{
        image(this.legendGamba, this.getPosXplayer()+38, this.getPosYplayer()+5, 20, 20);
      }
    }
    if(this.imMoving && this.sonoP2 && !this.imTackling){
      if(this.qualeGamba < 13){
        image(this.legendGamba, this.getPosXplayer()-8, this.getPosYplayer()+5, 20, 20);
      }
      else{
        image(this.legendGamba, this.getPosXplayer()-8, this.getPosYplayer()+25, 20, 20);
      }
    }
    
    if(this.imTackling && !this.getIsPlayerBall()){
      if(!this.sonoP2){
        image(this.legendTackle, this.getPosXplayer(), this.getPosYplayer(), 80, 50);
      }
      else{
        image(this.legendTackle, this.getPosXplayer() - 30, this.getPosYplayer(), 80, 50);
      }
    }
    else{
      image(this.legendStill, this.getPosXplayer(), this.getPosYplayer(), 50, 50);
    }
    
    this.qualeGamba++;
  }
  
  private void drawGiocatoreTOBENCH(){
    if(!this.sonoP2){
      image(this.legendTOBENCH, unitaMisura*7, unitaMisura/5, 45, 45);
    }
    else{
      image(this.legendTOBENCH, unitaMisura*10.1, unitaMisura/5, 45, 45);
    }
  }
  
/*
METODO PER L'ANIMAZIONE DI SPINTA ALL'INDIETRO QUANDO SI PERDE PALLA
*/  
  private void animTackleIndietro(){
    if(this.funziona){
      if(this.vadoIndietro < 15){
        if(this.sonoP2 && this.sonoNelCampo(DESTRA)){
          if(talenti.arraySelectedP2[2]){
            this.setPosXplayer(this.getPosXplayer() + this.speedPlayer*5);
          }
          else{
            this.setPosXplayer(this.getPosXplayer() + this.speedPlayer*3);
          }
        }
        if(!this.sonoP2 && this.sonoNelCampo(SINISTRA)){
          if(talenti.arraySelectedP1[2]){
            this.setPosXplayer(this.getPosXplayer() - this.speedPlayer*5);
          }
          else{
            this.setPosXplayer(this.getPosXplayer() - this.speedPlayer*3);
          }
        }
        this.vadoIndietro++;
      }
      else{
        this.funziona = false;
        this.vadoIndietro = 0;
      }
    }
  }
  
/*
SEMPLICE METODO PER AGGIORNARE L'ANIMAZIONE DELLE GAMBE DEL GIOCATORE
*/
  private void refreshGamba(){
    if(this.qualeGamba == 24){
      this.qualeGamba = 1;
    }
  }
  
/*
SEMPLICE METODO PER VERIFICARE SE SI STA ESEGUENDO IL TACKLE
*/  
  private void checkTackling(){
    if(!this.sonoP2){
      if(multiKeysPressed[M]){
        this.imTackling = true;
      }
      else{
        this.imTackling = false;
      }
    }
    else{
      if(multiKeysPressed[P]){
        this.imTackling = true;
      }
      else{
        this.imTackling = false;
      }
    }
  }
  
/*
METODO CHE VERIFICA SE CI SI STA MUOVENDO
*/
  private void checkMovement(){
    if(!this.sonoP2){
      if(multiKeysPressed[W] == true || multiKeysPressed[A] == true || multiKeysPressed[S] == true || multiKeysPressed[D] == true){
        this.imMoving = true;
      }
      else{
        this.imMoving = false;
      }
    }
    else{
      if(multiKeysPressed[frecciaUp] == true || multiKeysPressed[frecciaSx] == true || multiKeysPressed[frecciaDown] == true || multiKeysPressed[frecciaDx] == true){
        this.imMoving = true;
      }
      else{
        this.imMoving = false;
      }
    }
  }
  
/*
QUESTO METODO moveGiocatore GESTISCE IL MOVIMENTO DEI GIOCATORI: PER FARLO VERIFICA CHE DAVANTI AL GIOCATORE NON CI SIANO OSTACOLI(IL PLAYER AVVERSARIO O I LIMITI DEL CAMPO)
E NEL CASO VENGONO SUPERATI TUTTI I CONTROLLI SPOSTA IL GIOCATORE
*/
  
  private void moveGiocatore(Giocatore giocatore){
//-----PLAYER1

   if(multiKeysPressed[W] && !this.sonoP2){
     if(this.P1_collisione_UP(giocatore) && this.sonoNelCampo(SOPRA)){
       this.setPosYplayer(this.getPosYplayer() - this.speedPlayer);
     }
   }
     
   if(multiKeysPressed[A] && !this.sonoP2){
     if(this.P1_collisione_LEFT(giocatore) && this.sonoNelCampo(SINISTRA)){
       this.setPosXplayer(this.getPosXplayer() - this.speedPlayer);
     }
   }
   
   if(multiKeysPressed[S] && !this.sonoP2){
     if(this.P1_collisione_DOWN(giocatore) && this.sonoNelCampo(SOTTO)){
       this.setPosYplayer(this.getPosYplayer() + this.speedPlayer);
     }
   }
     
   if(multiKeysPressed[D] && !this.sonoP2){
      if(this.P1_collisione_RIGHT(giocatore) && this.sonoNelCampo(DESTRA)){
        this.setPosXplayer(this.getPosXplayer() + this.speedPlayer);
      }
   }
     
//-----PLAYER2

   if(multiKeysPressed[frecciaUp] && this.sonoP2){
     if(P2_collisione_UP(giocatore) && this.sonoNelCampo(SOPRA)){
       this.setPosYplayer(this.getPosYplayer() - this.speedPlayer);
     }
   }
   
   
   if(multiKeysPressed[frecciaSx] && this.sonoP2){
     if(P2_collisione_LEFT(giocatore) && this.sonoNelCampo(SINISTRA)){
       this.setPosXplayer(this.getPosXplayer() - this.speedPlayer);
     }
   }
   
   
   if(multiKeysPressed[frecciaDown] && this.sonoP2){
      if(P2_collisione_DOWN(giocatore) && this.sonoNelCampo(SOTTO)){
        this.setPosYplayer(this.getPosYplayer() + this.speedPlayer);
      }
   }
    
    
    if(multiKeysPressed[frecciaDx] && this.sonoP2){
      if(P2_collisione_RIGHT(giocatore) && this.sonoNelCampo(DESTRA)){
        this.setPosXplayer(this.getPosXplayer() + this.speedPlayer);
      }
    }
  }
  
/*
METODO PER EFFETTUARE TACKLE
*/
  private void doTackle(Giocatore altroGiocatore){
    if(multiKeysPressed[M]  && !this.sonoP2){
      if(!this.getIsPlayerBall() && altroGiocatore.getIsPlayerBall() && this.tackleRange){
        gestoreAudio.playTackle();
        this.setIsPlayerBall(true);
        altroGiocatore.setIsPlayerBall(false);
        //altroGiocatore.setPosXplayer(altroGiocatore.getPosXplayer() + 150);
        altroGiocatore.funziona = true;
      }
    }
    if(multiKeysPressed[P]  && this.sonoP2){
      if(!this.getIsPlayerBall() && altroGiocatore.getIsPlayerBall() && this.tackleRange){
        gestoreAudio.playTackle();
        this.setIsPlayerBall(true);
        altroGiocatore.setIsPlayerBall(false);
        //altroGiocatore.setPosXplayer(altroGiocatore.getPosXplayer() - 150);
        altroGiocatore.funziona = true;
      }
    }
  }
  
/*
METODO PER TIRARE: IL TIRO PUO' ESSERE ORIZZONTALE (QUINDI NIENTE TIRI VERTICALI) O DIAGONALE, LA PALLA ANDRA' SEMPRE IN AVANTI.
*/
  private void shootBall(Palla palla){
//-----PLAYER1
   
   if(multiKeysPressed[B] && (multiKeysPressed[W] && multiKeysPressed[D]) && !this.sonoP2 && this.getIsPlayerBall()){
     gestoreAudio.playKick();
     this.setIsPlayerBall(false);
     palla.imFree = true;
     if(talenti.arraySelectedP1[1] && talenti.arraySelectedP1[3]){
       palla.setSpeedX(24);
       palla.setSpeedY(15);
       
     }
     if(talenti.arraySelectedP1[1] && !talenti.arraySelectedP1[3]){
       palla.setSpeedX(22);
       palla.setSpeedY(22);

     }
     if(!talenti.arraySelectedP1[1] && talenti.arraySelectedP1[3]){
       palla.setSpeedX(22);
       palla.setSpeedY(15);

     }
     if(!talenti.arraySelectedP1[1] && !talenti.arraySelectedP1[3]){
       palla.setSpeedX(20);
       palla.setSpeedY(20);
     }
     palla.setIncrX(1);
     palla.setIncrY(-1);
     
   }
   
   if(multiKeysPressed[B] && (multiKeysPressed[S] && multiKeysPressed[D]) && !this.sonoP2 && this.getIsPlayerBall()){
     gestoreAudio.playKick();
     this.setIsPlayerBall(false);
     palla.imFree = true;
     if(talenti.arraySelectedP1[1] && talenti.arraySelectedP1[3]){
       palla.setSpeedX(24);
       palla.setSpeedY(15);
     }
     if(talenti.arraySelectedP1[1] && !talenti.arraySelectedP1[3]){
       palla.setSpeedX(22);
       palla.setSpeedY(22);
     }
     if(!talenti.arraySelectedP1[1] && talenti.arraySelectedP1[3]){
       palla.setSpeedX(22);
       palla.setSpeedY(15);
     }
     if(!talenti.arraySelectedP1[1] && !talenti.arraySelectedP1[3]){
       palla.setSpeedX(20);
       palla.setSpeedY(20);
     }
     palla.setIncrX(1);
     palla.setIncrY(1);
     
   }
   
   if(multiKeysPressed[B] && multiKeysPressed[A] && !this.sonoP2 && this.getIsPlayerBall()){
     gestoreAudio.playKick();
     this.setIsPlayerBall(false);
     palla.imFree = true;
     if(talenti.arraySelectedP1[1]){
       palla.setSpeedX(12);
     }
     else{
       palla.setSpeedX(10);
     }
     palla.setIncrX(1);
     
   }
   
   if(multiKeysPressed[B] && multiKeysPressed[D] && !this.sonoP2 && this.getIsPlayerBall()){
     gestoreAudio.playKick();
     this.setIsPlayerBall(false);
     palla.imFree = true;
     if(talenti.arraySelectedP1[1]){
       palla.setSpeedX(22);
     }
     else{
       palla.setSpeedX(20);
     }
     palla.setIncrX(1);
     
   }
   
   if(multiKeysPressed[B] && !this.sonoP2 && this.getIsPlayerBall() && !(multiKeysPressed[W] && multiKeysPressed[A] && multiKeysPressed[S] && multiKeysPressed[D])){
     gestoreAudio.playKick();
     this.setIsPlayerBall(false);
     palla.imFree = true;
     palla.setSpeedX(5);
     palla.setIncrX(1);
   }
   
//-----PLAYER2
   
   if(multiKeysPressed[I] && (multiKeysPressed[frecciaSx] && multiKeysPressed[frecciaUp]) && this.sonoP2 && this.getIsPlayerBall()){
     gestoreAudio.playKick();
     this.setIsPlayerBall(false);
     palla.imFree = true;
     if(talenti.arraySelectedP2[1] && talenti.arraySelectedP2[3]){
       palla.setSpeedX(24);
       palla.setSpeedY(15);
     }
     if(talenti.arraySelectedP2[1] && !talenti.arraySelectedP2[3]){
       palla.setSpeedX(22);
       palla.setSpeedY(22);
     }
     if(!talenti.arraySelectedP2[1] && talenti.arraySelectedP2[3]){
       palla.setSpeedX(22);
       palla.setSpeedY(15);
     }
     if(!talenti.arraySelectedP2[1] && !talenti.arraySelectedP2[3]){
       palla.setSpeedX(20);
       palla.setSpeedY(20);
     }
     palla.setIncrX(-1);
     palla.setIncrY(-1);
   }
   
   if(multiKeysPressed[I] && (multiKeysPressed[frecciaSx] && multiKeysPressed[frecciaDown]) && this.sonoP2 && this.getIsPlayerBall()){
     gestoreAudio.playKick();
     this.setIsPlayerBall(false);
     palla.imFree = true;
     if(talenti.arraySelectedP2[1] && talenti.arraySelectedP2[3]){
       palla.setSpeedX(24);
       palla.setSpeedY(15);
     }
     if(talenti.arraySelectedP2[1] && !talenti.arraySelectedP2[3]){
       palla.setSpeedX(22);
       palla.setSpeedY(22);
     }
     if(!talenti.arraySelectedP2[1] && talenti.arraySelectedP2[3]){
       palla.setSpeedX(22);
       palla.setSpeedY(15);
     }
     if(!talenti.arraySelectedP2[1] && !talenti.arraySelectedP2[3]){
       palla.setSpeedX(20);
       palla.setSpeedY(20);
     }
     palla.setIncrX(-1);
     palla.setIncrY(1);
   }
   
   if(multiKeysPressed[I] && multiKeysPressed[frecciaDx] && this.sonoP2 && this.getIsPlayerBall()){
     gestoreAudio.playKick();
     this.setIsPlayerBall(false);
     palla.imFree = true;
     if(talenti.arraySelectedP2[1]){
       palla.setSpeedX(12);
     }
     else{
       palla.setSpeedX(10);
     }
     palla.setIncrX(-1);
   }
   
   if(multiKeysPressed[I] && multiKeysPressed[frecciaSx] && this.sonoP2 && this.getIsPlayerBall()){
     gestoreAudio.playKick();
     this.setIsPlayerBall(false);
     palla.imFree = true;
     if(talenti.arraySelectedP2[1]){
       palla.setSpeedX(22);
     }
     else{
       palla.setSpeedX(20);
     }
     palla.setIncrX(-1);
   }
   
   if(multiKeysPressed[I] && this.sonoP2 && this.getIsPlayerBall() && !(multiKeysPressed[frecciaSx] && multiKeysPressed[frecciaDx] && multiKeysPressed[frecciaUp] && multiKeysPressed[frecciaDown])){
     gestoreAudio.playKick();
     this.setIsPlayerBall(false);
     palla.imFree = true;
     palla.setSpeedX(5);
     palla.setIncrX(-1);
   }
   
  }
  
/*
METODO PER CORRERE E DASHARE SULL'AVVERSARIO: SE CI SI TROVA ABBASTANZA
VICINI AL PROPRIO AVVERSARIO LO SI SUPERA
*/
  private void dashForward(Giocatore altroGiocatore){
//-----PLAYER1
  if(!this.sonoP2){ 
    if(multiKeysPressed[N] && multiKeysPressed[D]){
      if(this.P1_collisione_RIGHT(altroGiocatore) && this.sonoNelCampo(DESTRA)){
        this.setPosXplayer(this.getPosXplayer() + 1);
      }
      if(!this.P1_collisione_RIGHT(altroGiocatore) && this.sonoNelCampoConPlayerDavanti(DESTRA)){
        this.setPosXplayer(this.getPosXplayer() + 40);
      }
    }
    if(multiKeysPressed[N] && multiKeysPressed[A]){
      if(this.P1_collisione_LEFT(altroGiocatore) && this.sonoNelCampo(SINISTRA)){
        this.setPosXplayer(this.getPosXplayer() - 1);
      }
      if(!this.P1_collisione_LEFT(altroGiocatore) && this.sonoNelCampoConPlayerDavanti(SINISTRA)){
        this.setPosXplayer(this.getPosXplayer() - 40);
      }
    }
    if(multiKeysPressed[N] && multiKeysPressed[W]){
      if(this.P1_collisione_UP(altroGiocatore) && this.sonoNelCampo(SOPRA)){
        this.setPosYplayer(this.getPosYplayer() - 1);
      }
      if(!this.P1_collisione_UP(altroGiocatore) && this.sonoNelCampoConPlayerDavanti(SOPRA)){
        this.setPosYplayer(this.getPosYplayer() - 40);
      }
    }
    if(multiKeysPressed[N] && multiKeysPressed[S]){
      if(this.P1_collisione_DOWN(altroGiocatore) && this.sonoNelCampo(SOTTO)){
        this.setPosYplayer(this.getPosYplayer() + 1);
      }
      if(!this.P1_collisione_DOWN(altroGiocatore) && this.sonoNelCampoConPlayerDavanti(SOTTO)){
        this.setPosYplayer(this.getPosYplayer() + 40);
      }
    }
  }

    
//-----PLAYER2
  if(this.sonoP2){
    if(multiKeysPressed[O] && multiKeysPressed[frecciaDx]){
      if(this.P2_collisione_RIGHT(altroGiocatore) && this.sonoNelCampo(DESTRA)){
        this.setPosXplayer(this.getPosXplayer() + 1);
      }
      if(!this.P2_collisione_RIGHT(altroGiocatore) && this.sonoNelCampoConPlayerDavanti(DESTRA)){
        this.setPosXplayer(this.getPosXplayer() + 40);
      }
    }
    if(multiKeysPressed[O] && multiKeysPressed[frecciaSx]){
      if(this.P2_collisione_LEFT(altroGiocatore) && this.sonoNelCampo(SINISTRA)){
        this.setPosXplayer(this.getPosXplayer() - 1);
      }
      if(!this.P2_collisione_LEFT(altroGiocatore) && this.sonoNelCampoConPlayerDavanti(SINISTRA)){
        this.setPosXplayer(this.getPosXplayer() - 40);
      }
    }
    if(multiKeysPressed[O] && multiKeysPressed[frecciaUp]){
      if(this.P2_collisione_UP(altroGiocatore) && this.sonoNelCampo(SOPRA)){
        this.setPosYplayer(this.getPosYplayer() - 1);
      }
      if(!this.P2_collisione_UP(altroGiocatore) && this.sonoNelCampoConPlayerDavanti(SOPRA)){
        this.setPosYplayer(this.getPosYplayer() - 40);
      }
    }
    if(multiKeysPressed[O] && multiKeysPressed[frecciaDown]){
      if(this.P2_collisione_DOWN(altroGiocatore) && this.sonoNelCampo(SOTTO)){
        this.setPosYplayer(this.getPosYplayer() + 1);
      }
      if(!this.P2_collisione_DOWN(altroGiocatore) && this.sonoNelCampoConPlayerDavanti(SOTTO)){
        this.setPosYplayer(this.getPosYplayer() + 40);
      }
    }
  }
 }
  
/*
METODO CHE RESTITUISCE TRUE SE IL PLAYER NON STA OLTREPASSANDO I CONSENTITI DEL CAMPO
ALTRIMENTI RESTITUISCE FALSE
NOTA: SE IL P1 HA LA PALLA VIENE EFFETTUATO IL CONTROLLO MENTRE VA VERSO DESTRA CON LA PALLA
      ANALOGAMENTE SI CONTROLLA SE IL P2 HA LA PALLA MENTRE VA VERSO SINISTRA
*/
  private boolean sonoNelCampo(int DIREZIONE){
    if(DIREZIONE == 1){
      if(this.getPosYplayer() > unitaMisura){
        return true;
      }
      else{
        //this.setPosYplayer(this.getPosYplayer() + 5);
        return false;
      }
    }
    if(DIREZIONE == 2){
      if((!this.getIsPlayerBall()) || (this.sonoP2 && this.getIsPlayerBall())){  //se nessuno dei due ha la palla OPPURE se sono p2 e ho la palla mentre vado verso DESTRA
        if((this.getPosXplayer() + 50) < width-unitaMisura){
          return true;
        }
        else{
          //this.setPosXplayer(this.getPosXplayer() - 5);
          return false;
        }
      }
      if(!this.sonoP2 && this.getIsPlayerBall()){  //se sono p1 e ho la palla
        if((this.getPosXplayer() + 50 + 30 < width-unitaMisura) || (this.getPosYplayer() >= unitaMisura*3.5 && this.getPosYplayer()+50 <= unitaMisura*6.5)){
          return true;
        }
        else{
          return false;
        }
      }
    }
    if(DIREZIONE == 3){
      if((this.getPosYplayer() + 50) < height-unitaMisura){
        return true;
      }
      else{
        //this.setPosYplayer(this.getPosYplayer() - 5);
        return false;
      }
    }
    if(DIREZIONE == 4){
      if((!this.getIsPlayerBall()) || (!this.sonoP2 && this.getIsPlayerBall())){ //se nessuno dei due ha la palla OPPURE se sono p1 e ho la palla mentre vado verso SINISTRA
        if(this.getPosXplayer() > unitaMisura){
          return true;
        }
        else{
          //this.setPosXplayer(this.getPosXplayer() + 5);
          return false;
        }
      }
      if(this.sonoP2 && this.getIsPlayerBall()){ //se sono p2 e ho la palla mentre vado a SINISTRA
        if((this.getPosXplayer()-30 > unitaMisura) || (this.getPosYplayer() >= unitaMisura*3.5 && this.getPosYplayer()+50 <= unitaMisura*6.5)){
          return true;
        }
        else{
          return false;
        }
      }
    }
    return true;
  }
  
/*  
COME IL METODO PRECEDENTE MA IN PIU' CONTROLLA SE CI SI TROVA VICINO AL BORDO DEL CAMPO
CON IL PLAYER AVVERSARIO DAVANTI PER IMPEDIRE DI DASHARE AL DI FUORI DEL CAMPO
*/
  private boolean sonoNelCampoConPlayerDavanti(int DIREZIONE){
    if(DIREZIONE == 1){
      if(this.getPosYplayer() - 50 > unitaMisura){
        return true;
      }
      else{
        return false;
      }
    }
    if(DIREZIONE == 2){
      if((!this.getIsPlayerBall()) || (this.sonoP2 && this.getIsPlayerBall())){  //se nessuno dei due ha la palla OPPURE se sono p2 e ho la palla mentre vado verso DESTRA
        if((this.getPosXplayer() + 100) < width-unitaMisura){
          return true;
        }
        else{
          return false;
        }
      }
      if(!this.sonoP2 && this.getIsPlayerBall()){  //se sono p1 e ho la palla
        if((this.getPosXplayer() + 50 + 30 + 50 < width-unitaMisura) || (this.getPosYplayer() >= unitaMisura*3.5 && this.getPosYplayer()+50 <= unitaMisura*6.5)){
          return true;
        }
        else{
          return false;
        }
      }
    }
    if(DIREZIONE == 3){
      if((this.getPosYplayer() + 100) < height-unitaMisura){
        return true;
      }
      else{
        return false;
      }
    }
    if(DIREZIONE == 4){
      if((!this.getIsPlayerBall()) || (!this.sonoP2 && this.getIsPlayerBall())){ //se nessuno dei due ha la palla OPPURE se sono p1 e ho la palla mentre vado verso SINISTRA
        if(this.getPosXplayer() - 50 > unitaMisura){
          return true;
        }
        else{
          return false;
        }
      }
      if(this.sonoP2 && this.getIsPlayerBall()){ //se sono p2 e ho la palla mentre vado a SINISTRA
        if((this.getPosXplayer()-30-50-50 > unitaMisura) || (this.getPosYplayer() >= unitaMisura*3.5 && this.getPosYplayer()+50 <= unitaMisura*6.5)){
          return true;
        }
        else{
          return false;
        }
      }
    }
    return true;
  }
  
/*
SERIE DI METODI CHE PERMETTONO DI CONTROLLARE SE IL PLAYER 1 E IL PLAYER 2 ENTRANO IN CONTATTO E DA QUALE DIREZIONE AVVIENE IL CONTATTO
ESEMPIO: IL METODO P1_collisione_UP CONTROLLA CHE IL PLAYER 1 MENTRE VA UP NON STIA SBATTENDO SULL'ALTRO PLAYER, SE STA SBATTENDO, RESTITUISCE FALSE
*/
  private boolean P1_collisione_UP(Giocatore altroGiocatore){
    if(this.getPosYplayer() - (altroGiocatore.getPosYplayer() + 50) >= this.speedPlayer || altroGiocatore.getPosYplayer() - (this.getPosYplayer() + 50) >= 0 || 
       altroGiocatore.getPosXplayer() - (this.getPosXplayer() + 50) >= 0 || this.getPosXplayer() - (altroGiocatore.getPosXplayer() + 50) >= 0){
      return true;
    }
    else{
      return false;
    }
  }
  
  private boolean P1_collisione_LEFT(Giocatore altroGiocatore){
    if(altroGiocatore.getPosXplayer() - (this.getPosXplayer() + 50) >= 0 || this.getPosXplayer() - (altroGiocatore.getPosXplayer() + 50) >= this.speedPlayer || 
       altroGiocatore.getPosYplayer() - (this.getPosYplayer() + 50) >= 0 || this.getPosYplayer() - (altroGiocatore.getPosYplayer() + 50) >= 0){
      return true;
    }
    else{
      return false;
    }
  }
  
  private boolean P1_collisione_DOWN(Giocatore altroGiocatore){
    if(this.getPosYplayer() - (altroGiocatore.getPosYplayer() + 50) >= 0 || altroGiocatore.getPosYplayer() - (this.getPosYplayer() + 50) >= this.speedPlayer || 
       altroGiocatore.getPosXplayer() - (this.getPosXplayer() + 50) >= 0 || this.getPosXplayer() - (altroGiocatore.getPosXplayer() + 50) >= 0){
      return true;
    }
    else{
      return false;
    }
  }
  
  private boolean P1_collisione_RIGHT(Giocatore altroGiocatore){
// nessuno dei due ha la palla
    if(!altroGiocatore.getIsPlayerBall() && !this.getIsPlayerBall()){
      if(altroGiocatore.getPosXplayer() - (this.getPosXplayer() + 50) >= this.speedPlayer || this.getPosXplayer() - (altroGiocatore.getPosXplayer() + 50) >= 0 || 
         altroGiocatore.getPosYplayer() - (this.getPosYplayer() + 50) >= 0 || this.getPosYplayer() - (altroGiocatore.getPosYplayer() + 50) >= 0){
        return true;
      }
      else{
        return false;
      }
    }
// uno dei due ha la palla    
    if(altroGiocatore.getIsPlayerBall() || this.getIsPlayerBall()){
      if(altroGiocatore.getPosXplayer() - (this.getPosXplayer() + 50) >= this.speedPlayer + 30 || this.getPosXplayer() - (altroGiocatore.getPosXplayer() + 50) >= 0 || 
         altroGiocatore.getPosYplayer() - (this.getPosYplayer() + 50) >= 0 || this.getPosYplayer() - (altroGiocatore.getPosYplayer() + 50) >= 0){
        return true;
      }
      else{
        return false;
      }
    }
    return true;
  }
  
  
  
  private boolean P2_collisione_UP(Giocatore altroGiocatore){
    if(this.getPosYplayer() - (altroGiocatore.getPosYplayer() + 50) >= this.speedPlayer || altroGiocatore.getPosYplayer() - (this.getPosYplayer() + 50) >= 0 || 
       altroGiocatore.getPosXplayer() - (this.getPosXplayer() + 50) >= 0 || this.getPosXplayer() - (altroGiocatore.getPosXplayer() + 50) >= 0){
      return true;
    }
    else{
      return false;
    }
  }
  
  private boolean P2_collisione_LEFT(Giocatore altroGiocatore){
// nessuno dei due ha la palla
    if(!altroGiocatore.getIsPlayerBall() && !this.getIsPlayerBall()){
      if(altroGiocatore.getPosXplayer() - (this.getPosXplayer() + 50) >= 0 || this.getPosXplayer() - (altroGiocatore.getPosXplayer() + 50) >= this.speedPlayer || 
         altroGiocatore.getPosYplayer() - (this.getPosYplayer() + 50) >= 0 || this.getPosYplayer() - (altroGiocatore.getPosYplayer() + 50) >= 0){
        return true;
      }
      else{
        return false;
      }
    }
// uno dei due ha la palla    
    if(altroGiocatore.getIsPlayerBall() || this.getIsPlayerBall()){
      if(altroGiocatore.getPosXplayer() - (this.getPosXplayer() + 50) >= 0 || this.getPosXplayer() - (altroGiocatore.getPosXplayer() + 50) >= this.speedPlayer + 30 || 
         altroGiocatore.getPosYplayer() - (this.getPosYplayer() + 50) >= 0 || this.getPosYplayer() - (altroGiocatore.getPosYplayer() + 50) >= 0){
        return true;
      }
      else{
        return false;
      }
    }
    return true;
  }
  
  private boolean P2_collisione_DOWN(Giocatore altroGiocatore){
    if(this.getPosYplayer() - (altroGiocatore.getPosYplayer() + 50) >= 0 || altroGiocatore.getPosYplayer() - (this.getPosYplayer() + 50) >= this.speedPlayer || 
       altroGiocatore.getPosXplayer() - (this.getPosXplayer() + 50) >= 0 || this.getPosXplayer() - (altroGiocatore.getPosXplayer() + 50) >= 0){
      return true;
    }
    else{
      return false;
    }
  }
  
  private boolean P2_collisione_RIGHT(Giocatore altroGiocatore){
    if(altroGiocatore.getPosXplayer() - (this.getPosXplayer() + 50) >= this.speedPlayer || this.getPosXplayer() - (altroGiocatore.getPosXplayer() + 50) >= 0 || 
       altroGiocatore.getPosYplayer() - (this.getPosYplayer() + 50) >= 0 || this.getPosYplayer() - (altroGiocatore.getPosYplayer() + 50) >= 0){
      return true;
    }
    else{
      return false;
    }
  }
  
/*
INSIEME DI SETTER E GETTER PER GESTIRE ALCUNI ASPETTI DEL GIOCATORE
*/
  private void setPosXplayer(float xx){
    this.posXplayer = xx;
  }
  
  private float getPosXplayer(){
    return this.posXplayer;
  }
  
  private void setPosYplayer(float yy){
    this.posYplayer = yy;
  }
  
  private float getPosYplayer(){
    return this.posYplayer;
  }
  
  private float getSpeedPlayer(){
    return this.speedPlayer;
  }
  
  private void setIsPlayerBall(boolean isBall){
    this.isPlayerBall = isBall;
  }
  
  private boolean getIsPlayerBall(){
    return this.isPlayerBall;
  }
  
  private void resetPlayer(){
    if(!this.sonoP2){
      this.posXplayer = width/8;
      this.posYplayer = (height/2)-25;
    }
    else{
      this.posXplayer = width - (width/8) - 50;
      this.posYplayer = (height/2)-25;
    }
    this.setIsPlayerBall(false);
    this.hasScored = false;
  }
  
}
