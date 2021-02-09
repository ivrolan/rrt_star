class Graph{

  ArrayList<Vertex> vertexes = new ArrayList<Vertex>();
  ArrayList<Edge> edges = new ArrayList<Edge>(); 
  
  
  
  void addVertex(Vertex v){
  
    vertexes.add(v);
    
  }
  
  
  void addEdge(Edge e){
  
    edges.add(e);
    
  }
  

  
  void removeEdge(Edge e_to_remove){
      
     for (int i =0; i < edges.size(); i++){
     
       if ((edges.get(i)).equals(e_to_remove)){
         edges.remove(i);
         println("removed");
         break;
       }
       
     }
     
    
  }
  
  ArrayList<Vertex> neighboursIn(float range, Vertex v_centered){
    //return the neighbours within the range given
    ArrayList<Vertex> neighbours = new ArrayList<Vertex>();
    for (Vertex v : vertexes){
      if(v.position.dist(v_centered.position) < range){
        neighbours.add(v);
      }
    }
    
    return neighbours;
  }
  
  Vertex compareBetterCost(ArrayList<Vertex> list, Vertex to_add){
    
    float best_cost = 99999999999999999.0;
    Vertex v_best_cost = null;
    for (Vertex v : list){
      float cost = v.cost + to_add.position.dist(v.position);
      if (cost < best_cost){
        v_best_cost = v;
        best_cost = cost;
      }
    }
    
    return v_best_cost;
  
  }
  
  void rewireNeighbours(Vertex v_center, ArrayList<Vertex> neighbours){
      float min_cost = 999999999.0;
      Vertex min_v = null;  
      for (Vertex v : neighbours){
        float cost = v.position.dist(v_center.position) + v_center.cost;
        
        if (cost < v.cost){ //then attach it to v_center
          if(cost < min_cost){
          min_cost = cost;
          min_v = v;
          }
          
        }
        
      }
      
      if (min_v != null){
        min_v.parent.children.remove(min_v);
          //edges.remove(new Edge(min_v.parent, min_v));
          g.removeEdge(new Edge(min_v.parent, min_v));
          min_v.parent = v_center;
          v_center.children.add(min_v);
          edges.add(new Edge(v_center, min_v));
          min_v.cost = min_cost;
          min_v.updateCosts();
      }
  
  
  
  }
  
  
  void addVertexToExistingVertex(Vertex v_in_graph, Vertex v_to_add){
    // assuming that vertex exists in our graph
    // add a vertex and an edge connecting it to the v_in_graph given
    Edge temp_e = new Edge(v_in_graph, v_to_add);
    v_in_graph.children.add(v_to_add);
    v_to_add.parent = v_in_graph;
    v_to_add.cost = v_to_add.position.dist(v_in_graph.position) + v_in_graph.cost;
    this.addVertex(v_to_add);
    this.addEdge(temp_e);
  
  }
  
  
  
  Vertex findNearestTo(PVector point){
    float min_distance = 9999999;
    Vertex nearest_v = new Vertex(0,0);
    for (Vertex v : vertexes){
      
      if(point.dist(v.position) < min_distance){
      
        nearest_v = v;
        min_distance = point.dist(v.position);
        
      }
    }
    
    return nearest_v;
  
  }
  
  Edge findEdgeWith(Vertex init, Vertex end){
  
    Edge e_found = new Edge(new Vertex(0,0),new Vertex(0,0));
    
    for (Edge e : edges){
    
      if(init.equals(e.v1) && end.equals(e.v2)){
        e_found = e;
        break;
      } 
    }
    return e_found;
    
  }
  
  void changePathToReached(Vertex last){
    
    color v_color = color(85,255,0); //color(0, 255, 20);
    color e_color = color(30,255,20);
    int strk = 3;
    
    while (last != init){
      last.clr = v_color;
      Edge e_to_change = findEdgeWith(last.parent, last);
      e_to_change.w = strk;
      e_to_change.clr = e_color;
      last = last.parent;
    }
  
  }
  
  void changePathToDefault(Vertex last){
    color v_color_def = color(0,179,149);
    color e_color_def = color(105, 5, 4);
    int strk_def = 1;
    
    while (last != init){
      last.clr = v_color_def;
      Edge e_to_change = findEdgeWith(last.parent, last);
      e_to_change.w = strk_def;
      e_to_change.clr = e_color_def;
      last = last.parent;
    }
    
  }
  
  // DRAW FUNCTIONS
  void drawEdges(){
  
    for(Edge e : edges){
      
      e.drawEdge();
      e.w = e.DEFAULT_W;
      e.clr = e.DEFAULT_COLOR; //change the color to default, 
                                  //if it's the way to reach the goal, 
                                  //the color will be changed on loop
    }
    
  }
  
  void drawVertexes(){
  
    for(Vertex v : vertexes){
      v.drawVertex();
    }
    
  }
  
  void drawGraph(){
  
    drawEdges();
    //drawVertexes();
  
  }


}
