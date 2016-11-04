class FileWrap {
  
  protected String type;
  protected String path;
  
  protected boolean v;   // visible
  protected float x;     // x
  protected float y;     // y
  protected float w;     // width
  protected float h;     // height
  protected float sx;    // scale x
  protected float sy;    // scale y
  protected float a;     // alpha
  protected float seek;  // video seek position

  FileWrap(String path, String type) {
    this.path = path;
    this.type = type;
    
    println("wrap -> path : " + path + ", type : " + type);
  }
  
  public void draw() {
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
  
  public void play() {
  }
  
  public void stop() {
  }
  
  public void seek() {
  }
}