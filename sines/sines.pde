public static final int CANVAS_WIDTH = 1920;
public static final int CANVAS_HEIGHT = 1080;
public static final int FRAMERATE_FPS = 60;
public static final float DELTA = 1.0 / FRAMERATE_FPS;
public static final int N_SINES = 20;
public static final int SINE_SIZE = CANVAS_HEIGHT / N_SINES;
public static final int SINE_AMPLITUDE = SINE_SIZE / 2;

public static final int MAX_COLOR_VALUE = CANVAS_WIDTH; // Because Canvas width is bigger than height probably

class Context {
  private float time;
  private ArrayList<Sine> sines;
  
  public Context() {
    this.time = 0;
    this.sines = new ArrayList<Sine>(N_SINES);
    for (int s = 0; s < N_SINES; s++) { 
      sines.add(s, new Sine());
    }
  }
 
  public float time() { return time; }
  public void step() { time += DELTA; }
  public Sine getSine(int s) { return sines.get(s); }
  
  private int replaceIndex = 0;
  public void replaceSine(Sine s) {
    sines.set(replaceIndex, s);
    replaceIndex = (replaceIndex + 1) % N_SINES;
  }
}

enum Shape {
  C,
  S,
  M,
}

public boolean flipCoin() {
  return random(1) < 0.5;
}

class Sine {
  private final int nCycles;
  private final float cycleOffset;
  private final int radius;
  private final float speedMultiplier;
  private final float amplitude;
  private final int distance;
  
  private final int startHueValue;
  private final int endHueValue;
  private final int hueRange;
  
  private final Shape shape;
  
  public Sine() {
    this.nCycles = 1 + floor(random(12));
    this.cycleOffset = random(2 * PI);
    this.radius = 1 + floor(random(SINE_AMPLITUDE / 1.5));
    this.speedMultiplier = 1 + random(FRAMERATE_FPS * 1.25);
    this.amplitude = random(SINE_AMPLITUDE / 4, SINE_SIZE * 2);
    this.distance = floor(random(MAX_COLOR_VALUE / 3));
    
    this.startHueValue = floor(random(MAX_COLOR_VALUE));
    this.endHueValue = floor(random(MAX_COLOR_VALUE));
    this.hueRange = this.endHueValue - this.startHueValue;
    
    int shapeValue = floor(random(4));
    this.shape = shapeValue == 0 ? Shape.C : shapeValue == 1 ? Shape.S : Shape.M;
  }
  
  public int getNCycles() { return this.nCycles; }
  public float getCycleOffset() { return this.cycleOffset; }
  public int getRadius() { return this.radius; }
  public float getSpeedMultiplier() { return this.speedMultiplier; }
  public float getAmplitude() { return this.amplitude; }
  public int getDistance() { return this.distance; }
  
  public int getHue(float x) {
    int result = this.startHueValue + floor(this.hueRange * (x / (CANVAS_WIDTH - 1)));
    if (result < 0) {
      result += MAX_COLOR_VALUE;
    }
    return result;
  }
  
  public Shape getShape() { return this.shape; }
}

private Context context;

void setup() {
  fullScreen();
  context = new Context();  
  colorMode(HSB, MAX_COLOR_VALUE);
  frameRate(FRAMERATE_FPS);
  surface.setSize(CANVAS_WIDTH, CANVAS_HEIGHT);
  noSmooth();
}
 
int frameNum = 0;
int realTime = 0;
void draw() {
  
  background(0);
  
  for (int sineNum = 0; sineNum < N_SINES; sineNum++) {
    Sine s = context.getSine(sineNum);
    int yOffset = floor(s.getAmplitude() + sineNum * s.getAmplitude() * 2);
    
    float maxRadians = s.getNCycles() * 2 * PI;

    int pointNum = 0;
    for (int x = 0; x < CANVAS_WIDTH; x++) {
      if ((1 * x) % s.getRadius() != 0) {
        continue;
      }
      
      float asdf = (maxRadians * x) / (float) CANVAS_WIDTH;
      if (sineNum % 4 == 0 || sineNum % 4 == 1) {
        asdf *= -1;
      }
      float t = sineNum % 2 == 0 ? -1 * context.time() : context.time();
      int y = yOffset + floor((s.getAmplitude() + s.getAmplitude() / 4 * sine(N_SINES - sineNum - 1, 2 * DELTA * s.getSpeedMultiplier() * t)) * sine(sineNum, asdf + t + s.getCycleOffset()));
      y += floor(s.getSpeedMultiplier() * context.time());
      y = y % CANVAS_HEIGHT;
      if (sineNum % 2 == 0) {
        y = CANVAS_HEIGHT - y;
      }
      
      int h = (s.getHue(x) + floor(s.getSpeedMultiplier() * context.time())) % MAX_COLOR_VALUE;
      fill(h, MAX_COLOR_VALUE - s.getDistance(), MAX_COLOR_VALUE - s.getDistance());
      stroke(MAX_COLOR_VALUE - h - 1, MAX_COLOR_VALUE - s.getDistance(), MAX_COLOR_VALUE - s.getDistance());
      strokeWeight(s.getRadius() / 8);
      
      int r = s.getRadius();
      int x0 = x;
      int y0 = y;
      switch (s.getShape()) {
        case C:
          circle(x0, y0, r);
          break;
        case S:
          square(x0 - r / 2, y0 - r / 2, r);
          //square(x, y, r);
          break;
        case M:
          if ((pointNum + sineNum) % 2 == 0) {
            circle(x0, y0, r);
          } else {
            square(x0 - r / 2, y0 - r / 2, r);
            //square(x, y, r);
          }
          break;
      }
      
      if (sineNum % 4 == 0) {
        x0 = CANVAS_WIDTH - x0;
        y0 = CANVAS_HEIGHT - y0;
        //h = MAX_COLOR_VALUE - h - 1;
        //fill(h, MAX_COLOR_VALUE - s.getDistance(), MAX_COLOR_VALUE - s.getDistance());
        //stroke(MAX_COLOR_VALUE - h - 1, MAX_COLOR_VALUE - s.getDistance(), MAX_COLOR_VALUE - s.getDistance());
        //strokeWeight(s.getRadius() / 8);
        switch (s.getShape()) {
          case C:
            circle(x0, y0, r);
            break;
          case S:
            square(x0 - r / 2, y0 - r / 2, r);
            //square(x, y, r);
            break;
          case M:
            if ((pointNum + sineNum) % 2 == 0) {
              circle(x0, y0, r);
            } else {
              square(x0 - r / 2, y0 - r / 2, r);
              //square(x, y, r);
            }
            break;
        }
      }
      
      
      pointNum++;
    }
  }

  context.step();
  frameNum++;
  //if (frameNum % (FRAMERATE_FPS * 60) == 0) {
  //  context.replaceSine(new Sine());
  //}
}

float sine(int sineNum, float x) {
  if (sineNum % 4 == 0) {
    return sin(x);    
  } else if ((sineNum + 1) % 4 == 0) {
    return cos(x);
  } else if ((sineNum + 2) % 4 == 0) {
    return -1 * sin(x);
  }
  return -1 * cos(x);
}  //<>//
