class Edge{

  color DEFAULT_COLOR = color(105, 5, 4);
  int DEFAULT_W = 1;
  Vertex v1;
  Vertex v2;
  color clr = color(105, 5, 4);
  int w = 1;
  Edge(Vertex v1_source, Vertex v2_source){
  
    v1 = v1_source;
    v2 = v2_source;
    
  }
  
  boolean equals(Edge e){
    return e.v1 == this.v1 && e.v2 == this.v2;
  }
  
  
  
  
  void drawEdge(){
    strokeWeight(w);
    stroke(clr);
    line(v1.position.x, v1.position.y, v2.position.x, v2.position.y);
    strokeWeight(1);
  }






}
