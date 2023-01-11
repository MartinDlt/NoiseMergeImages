PImage img1;
PImage img2;
OpenSimplexNoise n;

void setup(){

  size(800, 800);
  n = new OpenSimplexNoise();
  img1 = loadImage("inf.png");
  img2 = loadImage("smallomega.png");
  
  img1.filter(GRAY);
  img1.loadPixels();
  
  img2.filter(GRAY);
  img2.loadPixels();

}

float sineMap(float value, float low, float high, float nlow, float nhigh){
  
  float phase = high - low;
  float phaseOffset = low;
  float amplitude = (nhigh - nlow) / 2;
  float vertOffset = amplitude + nlow;
  return amplitude * sin((value - phaseOffset) * PI / phase - PI/2) + vertOffset;
  
}

int round(float value, float threshold){

  return value < threshold ? floor(value) : ceil(value);
  
}

void draw(){

  float thresh = sineMap(frameCount, 1, 41, 0, 1);
  
  loadPixels();
  for(int x = 0; x < width; x++){
  
    for(int y = 0; y < height; y++){
    
      float noiseVal = (float)n.eval(x / 60.0, y / 60.0, frameCount * 0.05);
      
      //int image1State = img1.pixels[x + y * width] > 125 ? 0 : 1;
      //int image2State = img2.pixels[x + y * width] > 125 ? 0 : 1;
      
      int image1State = red(img1.pixels[x + y * width]) > 125 ? 0 : 1; //<>//
      int image2State = red(img2.pixels[x + y * width]) > 125 ? 0 : 1; //<>//
      
      float cThresh = lerp(image1State, image2State, thresh); //<>//
      var nVal = round(map(noiseVal, -1, 1, 0, 1), cThresh); //<>//
     
      pixels[x + y * width] = color(nVal * 255);
      
    }
    
  }
  updatePixels();
  
  
}
