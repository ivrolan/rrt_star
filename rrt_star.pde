/*
  Iván López Broceño
  RRT* (Rapidly exploring Random Tree) algorithm -> Pathfinding
  With rewiring to produce a convergence to an optimal solution
*/

//Vertex v1 = new Vertex(250, 250);
//Vertex v2 = new Vertex(300, 300);
//Edge e1 = new Edge(v1, v2);
//Graph g = new Graph();
//Vertex current = v2;
//Vertex v3 = new Vertex(0,0);

final int WIDTH = 1000;
final int HEIGHT = 700;
final int STEP = 20;
final float RANGE = 35;
final float N_slow = 0;
Vertex init = new Vertex(WIDTH/2, HEIGHT/2);
Graph g = new Graph();
Vertex current;
RectObst wall = new RectObst(0, 0, 0, 0);
int counter = 0;
int v_counter = 1;
boolean started = false;
Goal goal = new Goal(0, 0, 0);
Vertex v_reached;
float prev_cost_reached;

void mousePressed(){
wall.upper_left_corner = new PVector(mouseX, mouseY);
}
void mouseReleased(){
  wall.down_right_corner = new PVector(mouseX, mouseY);
  
}

void keyPressed(){
  if(key == 'a'){
    goal = new Goal(mouseX, mouseY, 60);
  }
  else{
  started = !started;
  }
}

void setup(){
 size(1000,700);
 background(255);
 
 g.addVertex(init);
 current = init;
}

void draw(){
  background(255);
  
  wall.drawObs();
  goal.drawObs();
  if(v_reached != null){
    g.changePathToReached(v_reached);
  
  }
  g.drawGraph();
  
  fill(0);
  text("N of vertex: " + str(v_counter), 10, 10, 80, 30);
  if (started && !goal.reached){
  rrt_algorithm();
  }
  
}

void rrt_algorithm(){

  // pick a random point
  PVector random_point = new PVector(random(WIDTH), random(HEIGHT));
  Vertex random_vertex = new Vertex(random_point.x, random_point.y);
  random_vertex.clr = color(240, 10, 55);
  random_vertex.drawVertex();
  // link this point to the nearest
  // this will define the direction to the next step
  Vertex nearest_vertex = g.findNearestTo(random_point);
  dottedLine(nearest_vertex.position.x, nearest_vertex.position.y, random_point.x, random_point.y);
  PVector relative_direction = (random_point.sub(nearest_vertex.position)).normalize();
  PVector dir_scaled = relative_direction.mult(STEP);
  PVector to_add_position = dir_scaled.add(nearest_vertex.position);
  
  
  Vertex to_add_vertex = new Vertex(to_add_position.x, to_add_position.y);
  Vertex to_visualize = new Vertex(to_add_position.x, to_add_position.y);
  to_visualize.clr = color(0, 255, 0);
  to_visualize.drawVertex();
  if(!wall.contains(to_add_vertex)){
    ArrayList<Vertex> neighbours = g.neighboursIn(RANGE, to_add_vertex);
    
    Vertex best_vertex = g.compareBetterCost(neighbours, to_add_vertex);
    
  g.addVertexToExistingVertex(best_vertex, to_add_vertex);
  g.rewireNeighbours(to_add_vertex, neighbours);
  if (best_vertex != nearest_vertex){
    println("rewiring!");
  }
  
  v_counter++;
  
  if(goal.contains(to_add_vertex)){
    //goal.reached = true;
    if (v_reached != null){
      if(to_add_vertex.cost < v_reached.cost){
        to_add_vertex.clr = color(23, 200, 70);
        g.changePathToDefault(v_reached);
        g.changePathToReached(to_add_vertex);
        v_reached = to_add_vertex;
        prev_cost_reached = v_reached.cost;
      }
    }
    else{
      g.changePathToReached(to_add_vertex);
      v_reached = to_add_vertex;
      prev_cost_reached = v_reached.cost;
    }
  }
  
  }
  if(counter < N_slow){
    delay(700);
  }
  else{
    delay(10);
  }
  counter++;
}

void randomWalk(){

  
  PVector random_dir = PVector.random2D();
  random_dir = random_dir.mult(STEP);
  
  PVector relative_random_dir = random_dir.add(current.position);
  Vertex random_vert = new Vertex(relative_random_dir.x, relative_random_dir.y);
  
  g.addVertexToExistingVertex(current, random_vert);
  current = random_vert;
  delay(700);


}

void dottedLine(float x1, float y1, float x2, float y2){
int STEPS = 7;
PVector dir = (new PVector(x2, y2)).sub(new PVector(x1, y1));
float mag = dir.mag();
PVector inc = dir.div(STEPS);
PVector actual = new PVector(x1, y1);
  for(int i = 0; i < STEPS; i++){
    PVector incremented = actual.copy().add(inc);
    if (i%2 == 0){
      
      line(actual.x, actual.y, incremented.x, incremented.y);
    
    }
    actual = incremented.copy();
  }


}
