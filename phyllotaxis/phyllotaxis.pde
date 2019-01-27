// Phyllotaxis

int n = 0;
int c = 8;

float circle_r = 50;

float speed = -300;
void setup() {
  //size(1000, 1000);
  fullScreen();
  background(32,42,47);
  colorMode(HSB);
}

void draw() {
  background(32,42,47);
  float circle_dist = c * sqrt(n) / 2;
  float circle_a = radians(n*2);
  
  float circle_x = circle_dist * cos(circle_a) + width / 2;
  float circle_y = circle_dist * sin(circle_a) + height / 2;
  
  //circle_x = mouseX;
  //circle_y = mouseY;
  
  // points
  for (int i = 0; i < 5000; i++) {
    if (i < n || true) {
      float d = c *sqrt(i);
      float a = radians(i * 137.5);
      
      float x = d * cos(a) + width/2;
      float y = d * sin(a) + height/2;
      
      if (dist(x,y,circle_x,circle_y) < circle_r || true) {
        float offset = n*(1/d)*speed*sin(n * 0.01);
        if (offset < 1)  n = 1;
        a = radians(i * 137.5 + offset);
        //a = radians(i * 137.5 + 1000*sin(n * (1/d)));
        x = d * cos(a) + width/2;
        y = d * sin(a) + height/2;
      }
      fill(a % 256, 255, 255);
      noStroke();
      ellipse(x,y,6,6);
    }
  }
  n++;
  text(n, 10, 10 );
}
