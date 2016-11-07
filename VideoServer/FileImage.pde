class FileImage extends FileWrap {
  
  private PImage img;
  
  FileImage(PApplet parent, String path) {
    super(parent, path);
    
    img = loadImage(path);
    x = y = 0;
    w = img.width;
    h = img.height;
    v = false;
  }
  
  public void draw() {
    if(v == false) return;
    
    image(img, x, y, w, h);
  }
  
  public void visible(int b) {
    if(b == 0) v = false;
    else v = true;
  }
  
  public void position(float x, float y, float z) {
  }
  
  public void scale(float x, float y, float z) {
  }
  
  public void rotation(float x, float y, float z) {
  }
  
  public void alpha(float a) {
  }
  
}