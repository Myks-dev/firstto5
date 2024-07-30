/*
SEMPLICE CLASSE PER MOSTRARE LA SCHERMATA CON REGOLE E COMANDI
*/
public class ComandiRegole{
  PImage comandi_regole;
  
  private ComandiRegole(){
    comandi_regole = loadImage("PIZZA.png");
  }
  
  private void showComandiRegole(){
    this.updateShowComandiRegole();
    image(comandi_regole, 0, 0);
  }
  
  private void updateShowComandiRegole(){
    if(multiKeysPressed[Q] && millis() > time + 200){
      gameMode = -1;
    }
  }
}
