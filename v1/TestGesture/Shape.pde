class Shape {
  
  final int DRAW = 0;
  final int PROCESSED = 1;
  final int RECOGNIZED = 2;
  
  final int NOT_KNOWN = -1;
  final int LIGNE = 2;
  final int TRIANGL = 3;
  final int RECTANGLE = 4;
  final int CIRCLE = 5;
  
  int state;
  int shape = NOT_KNOWN;
  
  Point[] points;
  int size;
  
  Shape() {
    points = new Point[25];
    size = 0;
    state = DRAW;
  }
  
  void addPoint(Point p) {
    if (size==0||(points[size-1].x!=p.x||points[size-1].y!=p.y)) {
      if (size >= points.length)
      doubleSize();
      points[size] = p;
      size++;
    }
  }
  
  void doubleSize() {
    Point[] points = new Point[2*this.points.length];
    for (int i = 0; i < size; ++i)
      points[i] = this.points[i];
    this.points = points;
  }
  
  void draw() {
    if (state == DRAW) fill(255,0,255);
    else if (state == PROCESSED) fill(0,0,255);
    else if (state == RECOGNIZED) fill(255,0,0);
    rectMode(CENTER);
    for (int i = 0; i < size; ++i)
      rect(points[i].x,points[i].y,5,5);
    if (state == RECOGNIZED) {
      switch(shape) {
        case LIGNE:
          text("LIGNE",100,40);
          break;
        case RECTANGLE:
          text("RECTANGLE",100,40);
          break;
        case CIRCLE:
          text("CERCLE",100,40);
          break;
        case TRIANGL:
          text("TRIANGLE",100,40);
          break;
      }
    }
  }
  
  void nextStep() {
    if (state == DRAW)
      identifyCharPts();
    else if (state == PROCESSED)
      recognize();
    else if (state == RECOGNIZED) {
      points = new Point[0];
      size = 0;
    }
  }
  
  void recognize() {
    switch(size) {
      case 2:
        shape = LIGNE;
        break;
      case 3:
        shape = TRIANGL;
        break;
      case 4:
        shape = RECTANGLE;
        break;
      case 5:
      case 6:
        shape = CIRCLE;
        break;
      default:
        shape = NOT_KNOWN;
    }
    state = RECOGNIZED;
  }
  
  void identifyCharPts() {
    int index = 0;
    Point[] result = new Point[size];
    Point lastCharPnt = points[0];
    result[index] = lastCharPnt; index++;
    for (int i = 1; i < size-1; ++i) {
      if (isCharacteristic(points[i],lastCharPnt,points[i+1])) {
        lastCharPnt = points[i];
        result[index] = lastCharPnt; index++;
      }
    }
    if (isCharacteristic(points[0],points[size-1],points[size-1]))
      { result[index] = points[size-1]; index++; }
    //
    size = index;
    this.points = result;
    ajustSize();
    state = PROCESSED;
  }
  
  boolean isCharacteristic(Point a, Point b, Point c) {
    final float da_min = 0.67f;
    final float d_min = 50.0f;
    float da = diffAngle(b,a,a,c);
    float d = distanceBetweenPts(b,a);
    return (da > da_min && d > d_min);//&& (PI-da) > da_min
  }
  
  float diffAngle(Point a1, Point a2, Point b1, Point b2) {
    Point a = new Point(a2.x-a1.x,a2.y-a1.y);
    Point b = new Point(b2.x-b1.x,b2.y-b1.y);
    float norm_a = sqrt(pow(a.x,2)+pow(a.y,2));
    float norm_b = sqrt(pow(b.x,2)+pow(b.y,2));
    float dot_ab = a.x*b.x + a.y*b.y;
    return acos(dot_ab/(norm_a*norm_b));
  }
  
  float distanceBetweenPts(Point a, Point b) {
    return sqrt(pow(a.x-b.x,2)+pow(a.y-b.y,2));
  }
  
  void ajustSize() {
    Point[] points = new Point[size];
    for (int i = 0; i < size; ++i)
      points[i] = this.points[i];
    this.points = points;
  }
  
  int getSize() {
    return size;
  }
  
}