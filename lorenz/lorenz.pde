import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;


float x = 0.01;
float y = 0;
float z = 0;

float a = 10;
float b = 28;
float c = 8.0/3.0;

float dt = 0.01;

PeasyCam cam;

ArrayList<PVector> points = new ArrayList<PVector>();

void setup() {
  size(800, 600, P3D);
  colorMode(HSB);
  cam = new PeasyCam(this, 500);
}


void draw() {
  background(0);
  
  float dx = (a * (y - x)) * dt;
  float dy = (x * (b - z) - y) * dt;
  float dz = (x * y - c * z) * dt;
  
  x = x + dx;
  y = y + dy;
  z = z + dz;
  
  points.add(new PVector(x, y, z));
  
  //translate(width/2, height/2);
  scale(5);
  stroke(255);
  noFill();
  float hue = 0;
  beginShape();
  for (PVector v : points) {
    stroke(hue, 255, 255);
    vertex(v.x, v.y, v.z);
    PVector offset = PVector.random3D();
    offset.mult(0.1);
    v.add(offset);
    hue += 0.1;
    if (hue > 255) {
      hue = 0;
    }
  }
  endShape();
  
}