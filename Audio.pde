/*
CLASSE PER LA GESTIONE DELLE RISORSE AUDIO E DELLA LORO RIPRODUZIONE
*/
public class Audio{
  boolean playingMainTheme = false;
  boolean whistlePlayed = false;
  boolean finalWhistlePlayed = false;
  boolean goalPlayed = false;
  
  SoundFile mainTheme;
  SoundFile kick;
  SoundFile tackle;
  SoundFile hitPost;
  SoundFile whistle;
  SoundFile finalWhistle;
  SoundFile goal;
  
  private Audio(PApplet pa){
    mainTheme = new SoundFile(pa, "I_m_not_the_only_one.wav");
    mainTheme.amp(0.5);
    kick = new SoundFile(pa, "kick.wav");
    tackle = new SoundFile(pa, "tackle.wav");
    hitPost = new SoundFile(pa, "ballOnThePost.wav");
    whistle = new SoundFile(pa, "whistle.wav");
    finalWhistle = new SoundFile(pa, "finalWhistle.wav");
    goal = new SoundFile(pa, "Goal.wav");
    goal.amp(0.8);
  }
  
/*
METODI PER RIPRODURRE I SUONI
*/
  private void playMainTheme(){
    mainTheme.play();
  }
  
  private void stopMainTheme(){
    mainTheme.stop();
    this.setPlayingMainTheme(false);
  }
  
  private void playKick(){
    kick.play();
  }
  
  private void playTackle(){
    tackle.play();
  }
  
  private void playHitPost(){
    hitPost.play();
  }
  
  private void playWhistle(){
    whistle.play();
  }
  
  private void playFinalWhistle(){
    finalWhistle.play();
  }
  
  private void playGoal(){
    goal.play();
  }
  
/*
SETTER E GETTER CHE PERMETTONO DI VERIFICARE LA RIPRODUZIONE DEI SUONI
*/
  private void setPlayingMainTheme(boolean playmaintheme){
    this.playingMainTheme = playmaintheme;
  }
  
  private boolean getPlayingMainTheme(){
    return this.playingMainTheme;
  }
  
  private boolean getWhistleHasPlayed(){
    return this.whistlePlayed;
  }
  
  private void setWhistleHasPlayed(boolean whistle){
    this.whistlePlayed = whistle;
  }
  
  private boolean getFinalWhistleHasPlayed(){
    return this.finalWhistlePlayed;
  }
  
  private void setFinalWhistleHasPlayed(boolean finalWhistle){
    this.finalWhistlePlayed = finalWhistle;
  }
  
  private boolean getGoalHasPlayed(){
    return this.goalPlayed;
  }
  
  private void setGoalHasPlayed(boolean goal){
    this.goalPlayed = goal;
  }
  
}
