/*
CLASSE CONTENENTE IMMAGINI E INFORMAZIONI RELATIVE AI TALENTI
*/
public class Talento{
  PImage[] icone = new PImage[4];
  String[] nomeTalento = new String[4];
  boolean[] arraySelectedP1 = new boolean[4];
  boolean[] arraySelectedP2 = new boolean[4];

  
  private Talento(){
    icone[0] = loadImage("lightning.png");
    icone[1] = loadImage("tiger.png");
    icone[2] = loadImage("shield.png");
    icone[3] = loadImage("curved-arrow.png");
    
    this.nomeTalento[0] = "Velocità Flash";
    this.nomeTalento[1] = "Tiro della Tigre";
    this.nomeTalento[2] = "Scuderia Difesa";
    this.nomeTalento[3] = "Il Tiro a Giro";
    
    for(int a=0; a<4; a++){
      arraySelectedP1[a] = false;
      arraySelectedP2[a] = false;
    }
  }
  
}
