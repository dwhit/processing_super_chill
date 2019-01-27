int num_rings = 10000;
float l = 8;
float r = 30;
int num_circles = 4;

float t = 0;
float speed = 0.02;

void setup(){
  size(600,600);
  background(61, 137, 160);
}

void draw() {
  background(61, 137, 160);
  translate(width / 2, height / 2);
  for(int i = 1; i < num_rings; i++) {
    float c = 0;
    if(360 % i == 0) {
      c = radians(360 / float(i));
    } else {
      break;
    }   
    float a = 0;
    while(a < 2*PI) {
      float x = r*i * cos(a + t*speed*(1/float(i)));
      float y = r*i * sin(a + t*speed*(1/float(i)));
  
      noStroke();
      ellipse(x,y,10,10);
      a += c;
    }
    num_circles++;
  }
  t++;
}
