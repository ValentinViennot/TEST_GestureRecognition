void setup() {
  size(600, 600);
  initShape();
}

final int LEARN_CIR = 0;
final int LEARN_REC = 1;
final int LEARN_TRI = 2;
final int TEST = 3;

int state = LEARN_CIR;
int result = -1;

Shape s;

Shape model_cir;
Shape model_rec;
Shape model_tri;

void draw() {
  String text = "";
  if (state < TEST) {
    String form = "NC";
    switch (state) {
      case LEARN_CIR:
        form = "CIRCLE";
        break;
      case LEARN_REC:
        form = "RECTANGLE";
        break;
      case LEARN_TRI:
        form = "TRIANGLE";
        break;
    }
    text = "PRESS SHIFT TO SAVE FORM : "+form;
  }
  else if (result >= 0) {
    String form = "NC";
    switch (result) {
      case LEARN_CIR:
        form = "CIRCLE";
        break;
      case LEARN_REC:
        form = "RECTANGLE";
        break;
      case LEARN_TRI:
        form = "TRIANGLE";
        break;
    }
    text = "FORM DETECTED : "+form;
  } else {
    text = "DRAW A SHAPE AND PRESS DOWN TO RECOGNIZE";
  }
  if (mousePressed) {
    rectMode(CENTER);
    fill(0);
    rect(mouseX,mouseY,10,10);
    s.addPoint(new Point(mouseX,mouseY));
  } else {
    background(255);
    s.draw();
  } 
  fill(0);
  text(text, 20, 30);
}

void mousePressed() {
  initShape();
}

void keyPressed() {
  if (keyCode == SHIFT) {
    switch (state) {
      case LEARN_CIR:
        model_cir = s;
        break;
      case LEARN_REC:
        model_rec = s;
        break;
      case LEARN_TRI:
        model_tri = s;
        break;
    }
    state++;
  }
  else if (keyCode == UP) {
    state = 0;    
  }
  else if (keyCode == DOWN) {
    if (result >= 0) {
      result = -1;
    } else {
      findForm();
    }
  }
  else if (s.size>1) s.nextStep();
}

void findForm() {
  int[] d = new int[3];
  d[LEARN_CIR] = s.distanceAt(model_cir);
  d[LEARN_REC] = s.distanceAt(model_rec);
  d[LEARN_TRI] = s.distanceAt(model_tri);
  int dm = d[0];
  result = 0;
  for (int i = 1; i < d.length; ++i) {
    if (d[i]<dm) {
      result = i;
      dm = d[i];
    }
  }
}

void initShape() {
 s = new Shape(); 
}