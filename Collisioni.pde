/*
CLASSE PER LA GESTIONE DELLE COLLISIONI DELLA PALLA CON I BORDI DEL CAMPO, TRA I DUE PLAYER
E TRA PLAYER E PALLA PER POTERLA CONTROLLARE
*/
public class Collisioni{
  int no = 0;
  
  private Collisioni(){
    this.no = 1;
  }
  
/*  
METODO CHE VERIFICA LA POSIZIONE DELLA PALLA RISPETTO AI BORDI DEL CAMPO
E RISPETTO AI PALI, ANDANDO AD IMPOSTARE VELOCITA' E IL TIPO DI RIMBALZO
*/  
  private void checkBallMovement(Palla palla){
    if((palla.getPosX()+(palla.BallSize/2) > width-unitaMisura-2 || palla.getPosX()-(palla.BallSize/2) < unitaMisura+2) && (palla.getPosY()+palla.BallSize/2 <= unitaMisura*3.5 - 5 || palla.getPosY()-palla.BallSize/2 >= unitaMisura*6.5 + 5)){
      palla.incrX *= -1;
    }
    
    if(palla.getPosY()+(palla.BallSize/2) > height-unitaMisura-2 || palla.getPosY()-(palla.BallSize/2) < unitaMisura+2){
      palla.incrY *= -1;
    }
      
    for(int x=1; x<palla.BallSize; x++){
      if(palla.getPosX()-(palla.BallSize/2) < unitaMisura){
        if(palla.getPosY() + palla.BallSize/2 - x >= 246 && palla.getPosY() + palla.BallSize/2 - x <= 251){
          gestoreAudio.playHitPost();
          palla.setSpeedX(10);
          palla.setSpeedY(10);
          palla.setIncrX(1);
          palla.setIncrY(-1);
          break;
        }
        
        if(palla.getPosY() - palla.BallSize/2 + x >= 254 && palla.getPosY() - palla.BallSize/2 + x <= 258){
          gestoreAudio.playHitPost();
          palla.setSpeedX(10);
          palla.setSpeedY(10);
          palla.setIncrX(1);
          palla.setIncrY(1);
          break;
        }
        
        if(palla.getPosY() >= 252 && palla.getPosY() + palla.BallSize/2 <= 253){
          gestoreAudio.playHitPost();
          palla.setSpeedX(10);
          palla.setIncrX(1);
          break;
        }
        
        if(palla.getPosY() + palla.BallSize/2 - x >= 462 && palla.getPosY() + palla.BallSize/2 - x <= 467){
          gestoreAudio.playHitPost();
          palla.setSpeedX(10);
          palla.setSpeedY(10);
          palla.setIncrX(1);
          palla.setIncrY(-1);
          break;
        }
        
        if(palla.getPosY() - palla.BallSize/2 + x >= 470 && palla.getPosY() - palla.BallSize/2 + x <= 474){
          gestoreAudio.playHitPost();
          palla.setSpeedX(10);
          palla.setSpeedY(10);
          palla.setIncrX(1);
          palla.setIncrY(1);
          break;
        }
        
        if(palla.getPosY() >= 468 && palla.getPosY() + palla.BallSize/2 <= 469){
          gestoreAudio.playHitPost();
          palla.setSpeedX(10);
          palla.setIncrX(1);
          break;
        }
      }
      if(palla.getPosX() + palla.BallSize/2 > width-unitaMisura){
        if(palla.getPosY() + palla.BallSize/2 - x >= 246 && palla.getPosY() + palla.BallSize/2 - x <= 251){
          gestoreAudio.playHitPost();
          palla.setSpeedX(10);
          palla.setSpeedY(10);
          palla.setIncrX(-1);
          palla.setIncrY(-1);
          break;
        }
        
        if(palla.getPosY() - palla.BallSize/2 + x >= 254 && palla.getPosY() - palla.BallSize/2 + x <= 258){
          gestoreAudio.playHitPost();
          palla.setSpeedX(10);
          palla.setSpeedY(10);
          palla.setIncrX(-1);
          palla.setIncrY(1);
          break;
        }
        
        if(palla.getPosY() >= 252 && palla.getPosY() + palla.BallSize/2 <= 253){
          gestoreAudio.playHitPost();
          palla.setSpeedX(10);
          palla.setIncrX(-1);
          break;
        }
        
        if(palla.getPosY() + palla.BallSize/2 - x >= 462 && palla.getPosY() + palla.BallSize/2 - x <= 467){
          gestoreAudio.playHitPost();
          palla.setSpeedX(10);
          palla.setSpeedY(10);
          palla.setIncrX(-1);
          palla.setIncrY(-1);
          break;
        }
        
        if(palla.getPosY() - palla.BallSize/2 + x >= 470 && palla.getPosY() - palla.BallSize/2 + x <= 474){
          gestoreAudio.playHitPost();
          palla.setSpeedX(10);
          palla.setSpeedY(10);
          palla.setIncrX(-1);
          palla.setIncrY(1);
          break;
        }
        
        if(palla.getPosY() >= 468 && palla.getPosY() + palla.BallSize/2 <= 469){
          gestoreAudio.playHitPost();
          palla.setSpeedX(10);
          palla.setIncrX(-1);
          break;
        }
      }
    }
    
    palla.setPosX(palla.getPosX() + (palla.getSpeedX() * palla.getIncrX()));
    palla.setPosY(palla.getPosY() + (palla.getSpeedY() * palla.getIncrY()));
    
    if(abs(palla.getSpeedX()) > 0 || abs(palla.getSpeedY()) > 0){
      if(palla.getSpeedX() > 0){
        palla.setSpeedX(palla.getSpeedX()-0.5);
      }
      else{
        palla.setSpeedX(palla.getSpeedX()+0.5);
      }
      if(palla.getSpeedY() >0){
        palla.setSpeedY(palla.getSpeedY()-0.5);
      }
      else{
        palla.setSpeedY(palla.getSpeedY()+0.5);
      }
    }
  }
  
/*
METODO PER VERIFICARE CHE I DUE GIOCATORI SIANO VICINI E IMPOSTARE IL BOOLEAN PER IL TACKLE
*/
  private void checkHitboxPlayers(Giocatore io, Giocatore avversario){
    if(!io.P1_collisione_UP(avversario) ||
    !io.P1_collisione_DOWN(avversario)  || 
    !io.P1_collisione_LEFT(avversario)  ||
    !io.P1_collisione_RIGHT(avversario) ||
    !avversario.P2_collisione_UP(io) ||
    !avversario.P2_collisione_DOWN(io) ||
    !avversario.P2_collisione_LEFT(io) ||
    !avversario.P2_collisione_RIGHT(io)){
      io.tackleRange = true;
      avversario.tackleRange = true;
    }
    else{
      io.tackleRange = false;
      avversario.tackleRange = false;
    }
  }
  
/*
QUESTO METODO PERMETTE DI CAPIRE SE IL PLAYER E' NEL RANGE DELLA PALLA PER POTERLA CONTROLLARE
*/
  private void checkHitboxBall(Giocatore io, Palla palla){
    if((palla.getPosX()-15 - (io.getPosXplayer()+50) <= 0 && palla.getPosX()+15 - io.getPosXplayer() >= -1) && (palla.getPosY()-15 - (io.getPosYplayer()+50) <= 1 && palla.getPosY()+15 - io.getPosYplayer() >= -5) && !io.sonoP2 && palla.imFree){
      if(!io.hasScored){
        io.setIsPlayerBall(true);
        palla.imFree = false;
        palla.setSpeedX(0);
        palla.setSpeedY(0);
        palla.setIncrX(0);
        palla.setIncrY(0);
        
      }
    }
    if((palla.getPosX()-15 - (io.getPosXplayer()+50) <= -1 && palla.getPosX()+15 - io.getPosXplayer() >= 0) && (palla.getPosY()-15 - (io.getPosYplayer()+50) <= 1 && palla.getPosY()+15 - io.getPosYplayer() >= -5) && io.sonoP2 && palla.imFree){
      if(!io.hasScored){
        io.setIsPlayerBall(true);
        palla.imFree = false;
        palla.setSpeedX(0);
        palla.setSpeedY(0);
        palla.setIncrX(0);
        palla.setIncrY(0);
      }
    }
  }
}
