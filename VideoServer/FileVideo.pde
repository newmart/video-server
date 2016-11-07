import processing.video.*;

class FileVideo extends FileWrap {
  Movie video;

  FileVideo(PApplet parent, String path) {
    super(parent, path);
    
    video = new Movie(parent, path);
    video.loop();
    video.read();
    video.volume(0);
    x = y = 0;
    w = video.width;
    h = video.height;
    v = false;
  }
  
  public void draw() {
    if(v == false) return;
    
    if (video.available()) {
      video.read();
    }
    image(video, x, y, w, h);
  }
  
}