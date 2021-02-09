interface Obstacle{

boolean contains(Vertex v);
void drawObs();
}

class RectObst implements Obstacle{

  PVector upper_left_corner;
  PVector down_right_corner;
  color clr = color(153,102,255);
  RectObst(int x1, int y1, int x2, int y2){
  
    upper_left_corner = new PVector(x1, y1);
    down_right_corner = new PVector(x2, y2);
    
  }
  
  boolean contains(Vertex v){
  
    boolean  is_contained = false;
    if(v.position.x >= this.upper_left_corner.x && v.position.y >=this.upper_left_corner.y){
      if(v.position.x <= this.down_right_corner.x && v.position.y <=this.down_right_corner.y){
        is_contained = true;
      }
    }
    
    return is_contained;
    
  }
  
  void drawObs(){
  fill(clr);
  rect(upper_left_corner.x, upper_left_corner.y, down_right_corner.x - upper_left_corner.x, down_right_corner.y- upper_left_corner.y);
    
  }
  
}

class CircleObs implements Obstacle{
  
  PVector center;
  int d = 25;
  color clr = color(230,191,0);
  public CircleObs(int x1, int x2){
  center = new PVector(x1, x2);
  }
  
  public CircleObs(int x1, int x2, int diam){
  
    center = new PVector(x1, x2);
    d= diam;
  
  }
  
  boolean contains(Vertex v){
  
    boolean is_contained = false;
    
    if (center.dist(v.position) <= d/2.0){
      is_contained = true;
    }
    
    return is_contained;
  }
  
  void drawObs(){
    noStroke();
    fill(clr);
    circle(center.x, center.y, d);
  }

}


class Goal extends CircleObs{
  
  boolean reached = false;
  
  Goal(int x1, int x2, int diam){
    super(x1, x2, diam);
  }
}
