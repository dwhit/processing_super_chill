int cols, rows;
int scl = 20;
int w = 1800;
int h = 2000;

float[][] terrain;
float flying = 0;


void setup() {
  size(600, 600, P3D);
  //frameRate(1);
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
  
}

void draw() {
  
  flying -= 0.1;
  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -70, 70);
      xoff += 0.2;
    }
    yoff += 0.2;
  }
  background(255);
  stroke(0);
  fill(200);
  lights();
  translate(width/2, height/2+50);
  rotateX(PI/2.25);
  translate(-w/2, -h/2);
  for (int y = 0; y < rows - 1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
}