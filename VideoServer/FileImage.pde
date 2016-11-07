class FileImage extends FileWrap {
  
  private PImage img;

  FileImage(PApplet parent, String path) {
    super(parent, path);
    
    img = loadImage(path);
    x = y = 0;
    sx = sy = a = 1;
    w = img.width;
    h = img.height;
    v = false;
  }
  
  public void draw() {
    if(v == false) return;
    pushMatrix();
    translate(x, y);
    rotate(rx);
    tint(255, 255*a); 
    image(img, 0, 0, w*sx, h*sy);
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
  
}