class FileImage extends FileWrap {
  
  private PImage img;
  
  FileImage(String path, String type) {
    super(path, type);
    
    img = loadImage(path);
    x = y = 0;
    w = img.width;
    h = img.height;
    
    v = true;
  }
  
  public void draw() {
    if(v == false) return;
    
    image(img, x, y, w, h);
  }
  
  public void visible(boolean b) {
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