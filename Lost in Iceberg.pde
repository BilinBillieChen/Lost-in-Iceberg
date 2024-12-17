import processing.video.*;

Capture cam;

void setup() {
  size(800, 600);
  cam = new Capture(this, width, height * 3/4);
  cam.start();
}

void draw() {
  background(0, 119, 190); 


  if (cam.available()) {
    cam.read();
  }


  applyMosaicAndBrightness(cam);
  

  stroke(255);
  strokeWeight(2);
  line(0, height / 4, width, height / 4); 
  

  drawTrianglesOnLine();
}


void drawTrianglesOnLine() {
  int numTriangles = 10; 
  for (int i = 0; i < numTriangles; i++) {
    fill(random(255), random(255), random(255)); 
    noStroke();
    

    float x1 = random(width);
    float y1 = height / 4;
    float baseLength = random(50, 150);
    float heightTriangle = random(50, 150);
    
    float x2 = x1 + baseLength;
    float y2 = y1;
    float x3 = (x1 + x2) / 2;
    float y3 = y1 - heightTriangle;
    
    triangle(x1, y1, x2, y2, x3, y3);
  }
}


void applyMosaicAndBrightness(Capture cam) {
  int mosaicSize = 20; 
  cam.loadPixels();
  for (int y = 0; y < cam.height; y += mosaicSize) {
    for (int x = 0; x < cam.width; x += mosaicSize) {
      int i = x + y * cam.width;
      color c = cam.pixels[i];
      

      float brightnessFactor = 0.15; 
      c = color(red(c) * brightnessFactor, green(c) * brightnessFactor, blue(c) * brightnessFactor);
      

      fill(c);
      noStroke();
      rect(x, height / 4 + y, mosaicSize, mosaicSize); 
    }
  }
}
