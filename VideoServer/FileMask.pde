import processing.video.*;

class FileMask extends FileWrap {
  
  PImage white;
  Movie video;
  boolean isPlay;
  boolean inited;
  float volume;

  FileMask(PApplet parent, String path) {
    super(parent, path);
    
    video = new Movie(parent, path);
    video.loop();
    position(0.5, 0.5);
    scale(1, 1); 
    volume = 0;
    a = 1;
    v = isPlay = inited = false;
  }
  
  void createWhite() {
    white = createImage((int)w, (int)h, RGB);
    white.loadPixels();
    for (int i = 0; i < white.pixels.length; i++) {
      white.pixels[i] = color(255, 255, 255); 
    }
    white.mask(video);
  }
  
  public void draw() {
    // video init
    if( video.available() && inited == false ) {
      video.read();
      video.volume(volume);
      video.pause();
      
      w = video.width;
      h = video.height;
      
      inited = true;
      createWhite();
      
      println("inited : w : "+w+", h : "+h);
    }
    
    if(v == false) return;
    if (video.available()) {
      video.read();
      white.mask(video);
    }
    
    pushMatrix();
    translate(x, y);
    rotate(rx);
    tint(255*a, 255); 
    //image(video, 0, 0, w*sx, h*sy);
    image(white, 0, 0, w*sx, h*sy);
    popMatrix();
    
    //println("isPlay : "+isPlay+", x : "+x+", y : "+y+", sx : "+sx+", sy : "+sy+", a : "+a);
  }
  
  public void visible(int b) {
    if(b == 0) {
      v = false;
      video.volume(0);
    } else {
      v = true;
      video.volume(volume);
    }
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
    video.jump(t*video.duration());
    video.read();
  }
  
  public void volume(float t) {
    volume = t;
    video.volume(volume);
  }
}