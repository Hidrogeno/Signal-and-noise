class FlowField {
  PVector[][] field;
  int cols, rows;
  float resolution;

  FlowField(float resolution) {
    this.resolution = resolution;
    cols = width / (int)resolution;
    rows = height / (int)resolution;
    field = new PVector[cols][rows];
    init();
  }

  void init() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        float u = map(i, 0, cols, 0, TWO_PI);
        float v = map(j, 0, rows, 0, TWO_PI);
        float angle = // In the end this is just a function from R2 to [0, 2π].
          sin(u * 2.0 + v * 1.0) * 1.2 +
          cos(u * 1.0 - v * 2.0) * 1.0 -
          sin(u * 3.0 + v * 6.0) * 0.4;
        field[i][j] = PVector.fromAngle(angle);// We create a vector from the angle.
      }
    }
  }

  PVector lookup(PVector position) {
    int column = (int)constrain(position.x / resolution, 0, cols - 1);
    int row = (int)constrain(position.y / resolution, 0, rows - 1);
    return field[column][row].copy();
  }
}