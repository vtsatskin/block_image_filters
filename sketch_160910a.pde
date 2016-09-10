// TODO:
//* [x] Split grid into rectangles
//* [x] calculate occurances of colors
//* [x] select two colors
//* [ ] consider quantizing colors
//* [ ] draw elipses
//* [ ] get directions
//* [ ] rotate ellipses based on direction
//* [ ] webcam feed

import java.util.Map;

PImage img;
int canvas_width = 825;
int canvas_height = 825;
int block_size = 12;

void setup() {  
  size(825, 825);
  img = loadImage("val.jpg");
  
  noLoop();
}

void draw() {
  image(img, 0, 0);
  
  for(int y = 0; y < img.height; y += block_size) {
    for(int x = 0; x < img.width; x += block_size) {
      pushMatrix();
      translate(x, y);
      
      IntDict hist = countColors(img.get(x, y, block_size, block_size));
      println(hist);
      println(hist.keyArray()[0], ": ", str(hist.valueArray()[0]));
      
      String[] colors = hist.keyArray();
      color c1 = unhex(colors[0]);
      color c2 = unhex(colors[colors.length/2]);
      color c3 = unhex(colors[colors.length/2 + colors.length/4]);
      
      noStroke();
      
      fill(red(c2), green(c2), blue(c2));
      rect(0, 0, block_size, block_size);
      
      fill(red(c1), green(c1), blue(c1));
      translate(block_size/2, block_size/2);
      rotate(PI/3.0);
      ellipse(0, 0, block_size/3+1, block_size/2+1);
      
      fill(red(c3), green(c3), blue(c3));
      ellipse(0, 0, (block_size/3+1)/2, (block_size/2+1)/2);
      
      fill(red(c1), green(c1), blue(c1));
      ellipse(0, 0, (block_size/3+1)/4, (block_size/2+1)/4);
      
      popMatrix();
    } 
  }
}

IntDict countColors(PImage img) {
  IntDict a = new IntDict();
  color[] pixels = img.pixels;
  
  for(int i = 0; i < img.height * img.width; i += 1) {
    String colorStr = hex(pixels[i]);
    if(a.hasKey(colorStr)) {
      a.set(colorStr, a.get(colorStr) + 1);
    }
    else {
      a.set(colorStr, 1);
    }
  }
  a.sortValuesReverse();
  return a;
}