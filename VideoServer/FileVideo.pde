import processing.video.*;

class FileVideo extends FileWrap {
  Movie video;
  boolean isPlay;

  FileVideo(PApplet parent, String path) {
    super(parent, path);
    
    video = new Movie(parent, path);
    video.loop();
    video.read();
    video.volume(0);
    video.pause();
    x = y = 0;
    sx = sy = a = 1;
    w = video.width;
    h = video.height;
    v = isPlay = false;
  }
  
  public void draw() {
    if(v == false) return;
    
    if (video.available() && isPlay) {
      video.read();
    }
    
    pushMatrix();
    translate(x, y);
    rotate(rx);
    tint(255, 255*a); 
    image(video, 0, 0, w*sx, h*sy);
    popMatrix();
  }
  
  public void visible(int b) {
    if(b == 0) v = false;
    else v = true;
  }
  
  public void position(float x, float y) {
    this.x = parent.width * x;
    this.y = parent.height * y;
  }
  
  public void scale(float x, float y) {
    this.sx = x;
    this.sy = y;
  }
  
  public void rotation(float x) {
    this.rx = TWO_PI * (x / 360);
  }
  
  public void alpha(float a) {
    this.a = a;
  }
  
  public void play() {
    isPlay = true;
    video.play();
  }
  
  public void stop() {
    isPlay = false;
    video.pause();
  }
  
  public void jump(float t) {
    video.jump(t);
  }
  
  public void volume(float t) {
    video.volume(t);
  }
}