int gridNo;
int squareSize;
int[][] grid;
int[][] next;

void setup() {
  size(800, 800);
  gridNo = 200;
  grid = new int[gridNo][gridNo];
  next = new int[gridNo][gridNo];
  squareSize = width / gridNo;
  randomise();
}

void draw() {
  noStroke();
  drawGrid();
  calculateGrid();
}

void randomise() {
 for(int j = 0; j < gridNo; j++) {
  for(int i = 0; i < gridNo; i++) {
    float r = random(0, 1);
    if(r > 0.65) 
      grid[i][j] = 1;
  }
 }
}

void drawGrid() {
  for(int j = 0; j < gridNo; j++) {
    for(int i = 0; i < gridNo; i++) {
      if(grid[i][j] == 0) {
        fill(0);  
      } else if(grid[i][j] == 1){
        fill(255);
      } else {
        fill(0, 0, 180);
      }
      rect(squareSize * i, squareSize * j, squareSize, squareSize);  
    }
  }
}

// Cell States: 0 = DEAD, 1 = LIVE, 2 = DYING
void calculateGrid() { 
  boolean leastOne = false;
  for(int j = 1; j < gridNo - 1; j++) {
    for(int i = 1; i < gridNo - 1; i++) {
      int neighbours = 0;
      if(grid[i - 1][j + 1] == 1) neighbours++;
      if(grid[i][j + 1] == 1) neighbours++;
      if(grid[i + 1][j + 1] == 1) neighbours++;
      if(grid[i - 1][j] == 1) neighbours++;
      if(grid[i + 1][j] == 1) neighbours++;
      if(grid[i - 1][j - 1] == 1) neighbours++;
      if(grid[i][j - 1] == 1) neighbours++;
      if(grid[i + 1][j - 1] == 1) neighbours++;
      
      if(grid[i][j] == 0 && neighbours == 2) {
        next[i][j] = 1;
        leastOne = true;
      }
      else if(grid[i][j] == 2) next[i][j] = 0;
      else if(grid[i][j] == 1) next[i][j] = 2;
    }
  }
  grid = next;
  next = new int[gridNo][gridNo];
  
  if(!leastOne) randomise();
}