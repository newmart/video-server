int fileNum = 10;
FileWrap[] fileWrap = new FileWrap[fileNum];

void setup() {
  size(640, 480);
  //fullScreen(P2D);
  background(0);
  
  loadData();
}

void draw() {
  for (FileWrap wrap : fileWrap) { 
    if(wrap != null) wrap.draw();
  }
}

void loadData() {
  String path = sketchPath("data"); 
  File[] files = listFiles(path);

  print("path : " + path+"\n"); 
  print("length : " + files.length+"\n"); //how many files are here
  
  int count = 0;
  for(int i=0;i<files.length;i++) {
    if (count > fileNum) break;
    String filePath = files[i].getPath();
    if (isImage(filePath)) {
      fileWrap[count] = new FileImage(this, filePath);
    }
    else if(isVideo(filePath)) {
      fileWrap[count] = new FileVideo(this, filePath); //<>//
    }
    else {
      println(files[i].getName() + " is not supported format.");
    }
     
    count++;
  }
  
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