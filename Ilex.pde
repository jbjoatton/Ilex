int cols, rows;
int scl = 10;
int w = 1800;
int h = 1800;
float flying = 0;
var vizType = 1;
float rotX = -PI;
float rotY = PI;
float wind = 10;
float force = 20;
float temperature;
float[][] terrain;



 //save pdf
 $('#savePdf').click(function(){
  save("diagonal.png");
 });


$('input[type=radio][name=vizType]').change(function() {
  vizType = $('input[type=radio][name=vizType]:checked').attr('value');
});

$(document).on('input', '#force', function() {
  force = $(this).val();
  console.log(force);
});

$(document).on('input', '#wind', function() {
  wind = $(this).val();
  console.log(wind);
});

void setup() {
  size(900, 900, P3D);
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
}

void draw() {
  flying -= wind/4000;

  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -wind*force, wind*force);
      xoff += 0.02;
    }
    yoff += 0.01;
  }
  background(100);
  stroke(255);
  noFill();

  pushMatrix();
  translate(width/2, height/2+50);
  rotateX(PI/2-rotX);
  rotateZ(PI/2-rotY);
  if (mousePressed) {
    rotX = map(mouseY,0,height,0,PI);
    rotY = map(mouseX,0,width,0,PI);
  }
  translate(-w/2, -h/2);
  for (int y = 0; y < rows-1; y++) {

  // types
  if(vizType == 1){
    beginShape(POINTS);
    strokeWeight(2);
  }
  else if(vizType == 3 || vizType == 4){
    beginShape(LINES);
    strokeWeight(1);
  }
    for (int x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      if(vizType == 4){vertex(x*scl, y*scl, terrain[x][y]+50);}
    }
    endShape();
  }
popMatrix();

}
