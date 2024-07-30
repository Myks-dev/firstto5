/*
CLASSE CONTENENTE IMMAGINI E INFORMAZIONI RELATIVE AGLI OMINI
*/
public class Omini{
  PImage[] arrayOminiSX = new PImage[5];
  PImage[] arrayOminiDX = new PImage[5];
  
  PImage[] arrayGambaOminiSX = new PImage[5];
  PImage[] arrayGambaOminiDX = new PImage[5];
  
  PImage[] arrayTackleOminiSX = new PImage[5];
  PImage[] arrayTackleOminiDX = new PImage[5];
  
  PImage[] arrayOminiTOBENCH = new PImage[5];
  
  boolean[] arraySelectedSX = new boolean[5];
  boolean[] arraySelectedDX = new boolean[5];
  
  private Omini(){
    arrayOminiSX[0] = loadImage("rosso1SX.png");
    arrayOminiSX[1] = loadImage("blu1SX.png");
    arrayOminiSX[2] = loadImage("bianco1SX.png");
    arrayOminiSX[3] = loadImage("lime1SX.png");
    arrayOminiSX[4] = loadImage("nero1SX.png");
    
    arrayOminiDX[0] = loadImage("rosso1DX.png");
    arrayOminiDX[1] = loadImage("blu1DX.png");
    arrayOminiDX[2] = loadImage("bianco1DX.png");
    arrayOminiDX[3] = loadImage("lime1DX.png");
    arrayOminiDX[4] = loadImage("nero1DX.png");
    
    arrayGambaOminiSX[0] = loadImage("rossoGambaSX.png");
    arrayGambaOminiSX[1] = loadImage("bluGambaSX.png");
    arrayGambaOminiSX[2] = loadImage("biancoGambaSX.png");
    arrayGambaOminiSX[3] = loadImage("limeGambaSX.png");
    arrayGambaOminiSX[4] = loadImage("neroGambaSX.png");
    
    arrayGambaOminiDX[0] = loadImage("rossoGambaDX.png");
    arrayGambaOminiDX[1] = loadImage("bluGambaDX.png");
    arrayGambaOminiDX[2] = loadImage("biancoGambaDX.png");
    arrayGambaOminiDX[3] = loadImage("limeGambaDX.png");
    arrayGambaOminiDX[4] = loadImage("neroGambaDX.png");
    
    arrayTackleOminiSX[0] = loadImage("rosso1SX_TACKLE.png");
    arrayTackleOminiSX[1] = loadImage("blu1SX_TACKLE.png");
    arrayTackleOminiSX[2] = loadImage("bianco1SX_TACKLE.png");
    arrayTackleOminiSX[3] = loadImage("lime1SX_TACKLE.png");
    arrayTackleOminiSX[4] = loadImage("nero1SX_TACKLE.png");
    
    arrayTackleOminiDX[0] = loadImage("rosso1DX_TACKLE.png");
    arrayTackleOminiDX[1] = loadImage("blu1DX_TACKLE.png");
    arrayTackleOminiDX[2] = loadImage("bianco1DX_TACKLE.png");
    arrayTackleOminiDX[3] = loadImage("lime1DX_TACKLE.png");
    arrayTackleOminiDX[4] = loadImage("nero1DX_TACKLE.png");
    
    arrayOminiTOBENCH[0] = loadImage("rosso1TOBENCH.png");
    arrayOminiTOBENCH[1] = loadImage("blu1TOBENCH.png");
    arrayOminiTOBENCH[2] = loadImage("bianco1TOBENCH.png");
    arrayOminiTOBENCH[3] = loadImage("lime1TOBENCH.png");
    arrayOminiTOBENCH[4] = loadImage("nero1TOBENCH.png");
    
    for(int i=0; i<5; i++){
      arraySelectedSX[i] = false;
      arraySelectedDX[i] = false;
    }
  }
}
