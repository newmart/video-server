class FileWrap {
  
  protected PApplet parent;
  protected String path;
  
  protected boolean v;   // visible
  protected float x;     // x
  protected float y;     // y
  protected float z;     // z
  protected float w;     // width
  protected float h;     // height
  protected float rx;    // rotate x
  protected float ry;    // rotate y
  protected float rz;    // rotate z
  protected float sx;    // scale x
  protected float sy;    // scale y
  protected float sz;    // scale z
  protected float a;     // alpha
  protected float seek;  // video seek position

  FileWrap(PApplet parent, String path) {
    this.parent = parent;
    this.path = path;
    println("wrap -> path : " + path);
  }
  
  public void draw() {
  }
  
  public void visible(int b) {
  }
  
  public void position(float x, float y) {
  }
  
  public void scale(float x, float y) {
  }
  
  public void rotation(float x) {
  }
  
  public void alpha(float a) {
  }
  
  public void play() {
  }
  
  public void stop() {
  }
  
  public void jump(float t) {
  }
  
  public void volume(float t) {
  }
}