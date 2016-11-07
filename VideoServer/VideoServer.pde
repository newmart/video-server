import oscP5.*;

OscP5 oscP5;
FileWrap[] fileWrap;

void setup() {
  size(640, 480);
  //fullScreen(P2D);
  background(0);
  imageMode(CENTER);
  
  
  initOSC();
  loadData();
}

void draw() {
  background(0);
  for (int i=fileWrap.length-1; i>=0; i--) { // reverse 
    if(fileWrap[i] != null) fileWrap[i].draw();
  }
}

void loadData() {
  String path = sketchPath("data"); 
  File[] files = listFiles(path);

  print("path : " + path+"\n"); 
  print("length : " + files.length+"\n");
  
  fileWrap = new FileWrap[files.length];
  int count = 0;
  for(int i=0;i<files.length;i++) {
    String filePath = files[i].getPath();
    if (isImage(filePath)) {
      fileWrap[count] = new FileImage(this, filePath);
      count++;
    }
    else if(isVideo(filePath)) {
      fileWrap[count] = new FileVideo(this, filePath);
      count++;
    }
    else {
      println(files[i].getName() + " is not supported format.");
    }
  } //<>//
}

File[] listFiles(String dir) {
 File file = new File(dir);
 if (file.isDirectory()) {
   File[] files = file.listFiles();
   return files;
 } else {
   // If it's not a directory
   return null;
 }
}

boolean isImage(String loadPath) {
return (
   loadPath.endsWith(".jpg") ||
   loadPath.endsWith(".jpeg") ||
   loadPath.endsWith(".png")  ) ;
}

boolean isVideo(String loadPath) {
return (
   loadPath.endsWith(".mp4") ||
   loadPath.endsWith(".mov") ) ;
}

void initOSC() {
 oscP5 = new OscP5(this, 8000); 
}

void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  print(" typetag: "+theOscMessage.typetag());
  println(" ("+millis()+")");
  
  String[] pattern = theOscMessage.addrPattern().split("/");
  int id = int(pattern[1]);
  String cmd = pattern[2];
  if(fileWrap[id] != null){
    switch(cmd) {
      case "visible":
        if(theOscMessage.checkTypetag("i")==true)
          fileWrap[id].visible(theOscMessage.get(0).intValue());
        break;
      case "position":
        if(theOscMessage.checkTypetag("ff")==true)
            fileWrap[id].position(theOscMessage.get(0).floatValue(), 
              theOscMessage.get(1).floatValue());
        break;
      case "scale":
        if(theOscMessage.checkTypetag("ff")==true)
            fileWrap[id].scale(theOscMessage.get(0).floatValue(), 
              theOscMessage.get(1).floatValue());
        break;
      case "rotation":
        if(theOscMessage.checkTypetag("f")==true)
            fileWrap[id].rotation(theOscMessage.get(0).floatValue());
        break;
      case "alpha":
        if(theOscMessage.checkTypetag("f")==true)
            fileWrap[id].alpha(theOscMessage.get(0).floatValue());
        break;
      case "play":
          fileWrap[id].play();
        break;
      case "stop":
          fileWrap[id].stop();
        break;
      case "jump":
          if(theOscMessage.checkTypetag("f")==true)
            fileWrap[id].jump(theOscMessage.get(0).floatValue());
        break;
      case "volume":
          if(theOscMessage.checkTypetag("f")==true)
            fileWrap[id].volume(theOscMessage.get(0).floatValue());
        break;
    }
  }
}