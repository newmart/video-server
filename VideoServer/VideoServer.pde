import oscP5.*;
import controlP5.*;

OscP5 oscP5;
FileWrap[] fileWrap;
PFont f;
boolean debug = false;
int logLine = 0;

ControlP5 cp5;
Textarea debugTextarea;

void setup() {
  //size(640, 480, P2D);
  fullScreen(P2D);
  background(0);
  imageMode(CENTER);
  
  cp5 = new ControlP5(this);
  debugTextarea = cp5.addTextarea("txt")
                  .setPosition(10,10)
                  .setSize(400,200)
                  .setFont(createFont("arial",12))
                  .setLineHeight(14)
                  .setColor(color(128))
                  .setColorBackground(color(0,220))
                  .setColorForeground(color(255,200));
  debugTextarea.hide();
  
  initOSC();
  loadData();
}

void draw() {
  background(0);
  for (int i=fileWrap.length-1; i>=0; i--) { // reverse 
    if(fileWrap[i] != null) fileWrap[i].draw();
  }
}

void keyPressed() {
  if(key == ' ' ){
    debug = !debug;
  } else if ( key == '1' ){
    fileWrap[4].play();
  } else if ( key == '2' ) {
    fileWrap[4].stop();
  } else if ( key == 'c' ) {
    debugTextarea.clear();
  }
  
  if(debug) debugTextarea.show();
  else debugTextarea.hide();
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
      log("[Image] " + files[i].getName() + " added.\n");
    }
    else if(isVideo(filePath)) {
      fileWrap[count] = new FileVideo(this, filePath);
      count++;
      log("[Video] " + files[i].getName() + " added.\n");
    }
    else {
      println(files[i].getName() + " is not supported format.");
      log(files[i].getName() + " is not supported format.\n");
    }
  } //<>//
  
  log(count + "files added.");
  
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
   loadPath.endsWith(".wmv") ||
   loadPath.endsWith(".mp4") ||
   loadPath.endsWith(".mov") ) ;
}

void initOSC() {
  oscP5 = new OscP5(this, 8000); 
}

void oscStatus(OscStatus theStatus) {
  println("status : " + theStatus.id());
}

void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  print(" typetag: "+theOscMessage.typetag());
  println(" ("+millis()+")");
  
  String l = theOscMessage.addrPattern() + " ";
  
  String[] pattern = theOscMessage.addrPattern().split("/");
  int id = int(pattern[1]);
  String cmd = pattern[2];
  if(fileWrap[id] != null){
    switch(cmd) {
      case "visible":
        if(theOscMessage.checkTypetag("i")==true)
          fileWrap[id].visible(theOscMessage.get(0).intValue());
          if(debug) l += theOscMessage.get(0).intValue(); 
        break;
      case "position":
        if(theOscMessage.checkTypetag("ff")==true)
            fileWrap[id].position(theOscMessage.get(0).floatValue(), 
              theOscMessage.get(1).floatValue());
            if(debug) l += theOscMessage.get(0).floatValue() + ", " + theOscMessage.get(1).floatValue();
        break;
      case "scale":
        if(theOscMessage.checkTypetag("ff")==true)
            fileWrap[id].scale(theOscMessage.get(0).floatValue(), 
              theOscMessage.get(1).floatValue());
            if(debug) l += theOscMessage.get(0).floatValue() + ", " + theOscMessage.get(1).floatValue();
        break;
      case "rotation":
        if(theOscMessage.checkTypetag("f")==true)
            fileWrap[id].rotation(theOscMessage.get(0).floatValue());
            if(debug) l += theOscMessage.get(0).floatValue();
        break;
      case "alpha":
        if(theOscMessage.checkTypetag("f")==true)
            fileWrap[id].alpha(theOscMessage.get(0).floatValue());
            if(debug) l += theOscMessage.get(0).floatValue();
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
            if(debug) l += theOscMessage.get(0).floatValue();
        break;
      case "volume":
          if(theOscMessage.checkTypetag("f")==true)
            fileWrap[id].volume(theOscMessage.get(0).floatValue());
            if(debug) l += theOscMessage.get(0).floatValue();
        break;
    }
    
    if(debug) log(l+" ("+millis()+")\n");
  }
}

void log(String msg) {
  debugTextarea.append(msg, logLine);
  debugTextarea.scroll(logLine);
  logLine++;
  if(logLine>100) {
    debugTextarea.clear();
    logLine = 0;
  } 
}