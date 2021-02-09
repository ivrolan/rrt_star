import java.util.Stack;

class Vertex{

  PVector position;
  static final int SIZE = 10;
  color clr = color(0,179,149);//color(89, 176, 194);
  ArrayList<Vertex> children = new ArrayList<Vertex>();
  Vertex parent;
  float cost = 0; //needed to rewire the graph
  
  Vertex(float px, float py){
  
    position = new PVector(px, py); 
  
  }
  
  boolean equals(Vertex to_compare){
  
    return this.position.x == to_compare.position.x && this.position.y == to_compare.position.y;
  }
  
  // THE USE OF RECURSION MAKES THE PROGRAM CRASH IF THE AMOUNT OF NODES IS BIG
  
  //void updateCosts(){
  //  //the parent vertex cost has changed -> update the children costs
  //  for (Vertex v : children){
  //    v.cost = this.cost + this.position.dist(v.position);
  //    v.updateCosts();
  //  }
  //}
  
  void updateCosts(){
    Stack<Vertex> v_stack = new Stack<Vertex>();
    v_stack.push(this);
    
    while(!v_stack.empty()){
      Vertex current = v_stack.pop();
      if (current != this){
        current.cost = current.parent.cost + current.position.dist(current.parent.position);
      }
      for (Vertex v : current.children){
        v_stack.push(v);
      }
    }
  
  }
  
  void drawVertex(){
    fill(clr);
    stroke(0);
    circle(position.x, position.y, SIZE);
    
  }

}
