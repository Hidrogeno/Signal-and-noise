class WindField {
PVector[][] field;
int cols, rows;
float resolutionX, resolutionY;
    WindField(float resolution) {
        this.resolutionX = resolution;
        this.resolutionY = resolution;
        cols = width / (int)resolution;
        rows = height / (int)resolution;
        field = new PVector[cols][rows];
        init();
    }
    WindField(float resolutionX, float resolutionY) {
        this.resolutionX = resolutionX;
        this.resolutionY = resolutionY;
        cols = width / (int)resolutionX;
        rows = height / (int)resolutionY;
        field = new PVector[cols][rows];
        init();
    }

    void init() {
        for (int i = 0; i < cols; i++){
            for (int j = 0; j < rows; j++){
                PVector position = new PVector(i*resolutionX, j*resolutionY);
                field[i][j] = windDirection(position).mult(windMagnitude(position));
            }
        }
    }
    PVector windDirection(PVector position){
        PVector center = new PVector(width/2 +noise(frameCount*0.01)*50, height/2 +noise(frameCount*0.01)*50);
        PVector radial = PVector.sub(position, center);
        PVector dir = new PVector(-radial.y, radial.x);
        dir.add(PVector.random2D());
        dir.normalize();
        return dir;
    }
    float windMagnitude(PVector position){
        return WIND_STRENGTH*-0.2*noise(position.x*0.01, position.y*0.01);
    }
    PVector lookup(PVector position) {
        int column = (int)constrain(position.x / resolutionX, 0, cols - 1);
        int row = (int)constrain(position.y / resolutionY, 0, rows - 1);
        return field[column][row].copy();
  }
}