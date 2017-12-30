void setup() {
  size(600, 600);
  initShape();
}

Shape s;

void draw() {
  if (mousePressed) {
    rectMode(CENTER);
    fill(0);
    rect(mouseX,mouseY,10,10);
    s.addPoint(new Point(mouseX,mouseY));
  } else {
    background(255);
    s.draw();
  }
}

void mousePressed() {
  initShape();
}

void keyReleased() {
  s.nextStep();  
}

void initShape() {
 s = new Shape(); 
}