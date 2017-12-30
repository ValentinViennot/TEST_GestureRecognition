class Shape {
  
  final int DRAW = 0;
  final int PROCESSED = 1;
  final int EXTENDED = 2;
  final int MINIMIZED = 3;
  
  int state;
  
  Point[] points;
  int size;
  
  Shape() {
    points = new Point[25];
    size = 0;
    state = DRAW;
  }
  
  void draw() {
    if (state == DRAW) fill(255,0,255);
    else if (state == PROCESSED) fill(0,0,255);
    else if (state == EXTENDED) fill(0,255,255);
    else if (state == MINIMIZED) fill(255,255,0);
    else fill(0);
    rectMode(CENTER);
    for (int i = 0; i < size; ++i)
      rect(points[i].x,points[i].y,5,5);
  }
  
  void nextStep() {
    if (state == DRAW)
      identifyCharPts();
    else if (state == PROCESSED)
      extendModel();
    else if (state == EXTENDED)
      minimize();
  }
  
  final int MODEL_SIZE = 20;
  final int MIN_SIZE = 3*MODEL_SIZE;
  void extendModel() {
    while (size<MIN_SIZE) {
      Point[] result = new Point[2*size-1];
      for (int i=0; i<size-1; ++i) {
        result[2*i] = points[i];
        result[2*i+1] = new Point((points[i].x+points[i+1].x)/2,(points[i].y+points[i+1].y)/2);
      }
      result[result.length-1] = points[size-1];
      size = result.length;
      points = result;
    }
    state = EXTENDED;
  }
  
  void minimize() {
    while(size>MODEL_SIZE) {
      // on cherche la plus petite distance entre deux points
      float d = 0.0f;
      float dmin = 1000000000.0f;
      int index = 0, i = 0;
      do {
        d = distanceBetweenPts(points[i],points[i+1]);
        if (d<dmin) {
          dmin = d;
          index = i+1;
        }
        ++i;
      } while (i<size-1);
      delPoint(index);
    }
    state = MINIMIZED;
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
    result[index] = points[size-1]; index++;
    //
    size = index;
    this.points = result;
    ajustSize();
    state = PROCESSED;
  }
  
  final float da_min = 0.67f;
  final float d_min = 50.0f;
  boolean isCharacteristic(Point a, Point b, Point c) {
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
  
  void addPoint(Point p) {
    if (size==0||(points[size-1].x!=p.x||points[size-1].y!=p.y)) {
      if (size >= points.length)
      doubleSize();
      points[size] = p;
      size++;
    }
  }
  
  void delPoint(int index) {
    for (int i = index; i<size-1; ++i)
      points[i] = points[i+1];
    points[size-1] = null;
    size--;
  }
  
  void doubleSize() {
    Point[] points = new Point[2*this.points.length];
    for (int i = 0; i < size; ++i)
      points[i] = this.points[i];
    this.points = points;
  }
  
  int distanceAt(Shape s) {
    if (this.size != MODEL_SIZE || s.size != MODEL_SIZE)
      return -1;
    int distance = 0;
    for (int i = 0; i < MODEL_SIZE; ++i) {
      distance += distanceBetweenPts(points[i],s.points[i]);
    }
    return distance;
  }
  
}