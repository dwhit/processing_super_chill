import processing.opengl.*;
import SimpleOpenNI.*;
 
SimpleOpenNI  kinect;
int userID;
int[] userMap;
int randomNum; 
float red;
float green;
float blue;
PImage rgbImage;
PImage glitchImage;
 
int count;
 
void setup() {
  size(512, 424, P3D);
  kinect = new SimpleOpenNI(this);
  kinect.setMirror(true);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.enableRGB();
  
  glitchImage = createImage(640, 480, RGB);
}
 
void draw() {  
  kinect.update();  
  rgbImage = kinect.rgbImage().copy();
  
  rgbImage.resize(512,424);
  image(rgbImage, 0, 0);
 
 int[] userList = kinect.getUsers(); 
  for(int i=0;i<userList.length;i++)
  {
   int glitch =  users.get(i).glitchid;
   if (glitch == 1)
   {
     crt();
   }
   else
  {
    crtcolor();
  }
  }
 
  stroke(100); 
  smooth();
}
 
void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  User u = new User(curContext, userId); 
  users.add(u); 
  println("glitchid " + u.glitchid); 
  curContext.startTrackingSkeleton(userId);
}
 
void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}
 
 
void crtcolor()
{
  color randomColor = color(random(255), random(255), random(255), 255);
  boolean flag = false;
  if (kinect.getNumberOfUsers() > 0) {  
    userMap = kinect.userMap();   
    loadPixels();
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        int loc = x + y * width;
        if (userMap[loc] !=0) { 
          if (random(100) < 50 || (flag == true && random(100) < 80))
          {
            flag = true;
            color pixelColor = pixels[loc];
            float mixPercentage = .5 + random(50)/100;
            pixels[loc] =  lerpColor(pixelColor, randomColor, mixPercentage);
          } else
          {
            flag = false;
            randomColor = color(random(255), random(255), random(255), 255);
          }
        }
      }
    }   
    updatePixels();
  }
}
 
void crt()
{
  if (kinect.getNumberOfUsers() > 0) {  
    userMap = kinect.userMap();  
    glitchImage.loadPixels();
    for (int x = 0; x < 640; x++) {
      for (int y = 0; y < 480; y++) {
        int loc = x + y * 640;
        if (userMap[loc] !=0) { 
          glitchImage.pixels[loc] = color(random(255) );
        }
        else {
          glitchImage.pixels[loc] = color(0);
        }
      }
    }
    glitchImage.updatePixels();
  }
}
