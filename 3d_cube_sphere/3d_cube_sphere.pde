float angle;
float ma = radians(35.264);
float rectWidth = 20;

int gridSize = 15;

void setup() {
  size(600,600,P3D);
}

void draw() {
  background(0);
  ortho(-width / 2, width / 2, -height / 2, height / 2);
  translate(width / 2, height / 2);
  rotateX(-ma);
  rotateY(-QUARTER_PI);
  
  //right
  directionalLight(230, 226, 185, -1, 0, 0);
  
  //left
  directionalLight(75, 95, 142, 0, 0, -1);

  //top
  directionalLight(147, 193, 188, 0, 1, 0);

  
  lightSpecular(0, 0, 0);
  background(251, 250, 251);
  noStroke();

  float offset;
  for(int i = -gridSize / 2; i < gridSize / 2; i++) {
    for(int j = -gridSize / 2; j < gridSize / 2; j++) {
      translate(i * rectWidth, 0, j * rectWidth);
      offset = dist(0, 0, i, j);
      float a = angle + offset*offset * .1;
      float h = map(sin(a), -1, 1, 50, 200);
      //box(rectWidth, h, rectWidth);
      box(rectWidth, h, rectWidth);
      translate(-i * rectWidth, 0, -j * rectWidth);
    }
  }
  angle -= .05;
}
