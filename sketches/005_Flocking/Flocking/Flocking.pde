ArrayList<Boid> boids = new ArrayList<Boid>();
WindField wind;
void setup() {
    float separationStrength = 1.5;
    float alignmentStrength = 1.0;
    float cohesionStrength = 1.0;
    size(800, 800);
    pixelDensity(2);
    background(0);
    wind = new WindField(RESOLUTION);
    for (int i = 0; i < BOID_COUNT; i++) {
        boids.add(new Boid(separationStrength, alignmentStrength, cohesionStrength));
    }
}

void draw(){
    
    PVector windVector;
    fill(0, 50);
    rect(0, 0, width, height);
    for (Boid b : boids) {
        color boidColor = customBoidColor(b.position);
        windVector = wind.lookup(b.position);
        if(keyPressed){
            windVector = new PVector(0,0); // Apply no wind if pressed
        }
        b.flock(boids, windVector);
        b.update(); // Update the boid's position and velocity
        b.setBoidSize(map(b.velocity.mag(),0,b.maxSpeed,0,8)); // Set their size
        b.setBoidColor(boidColor); // Set their color
        // uncomment the following line to enable action-based coloring
        // b.lastActionColor(); // Set the color based on the last dominant action
        b.display();
    }
}

color customBoidColor(PVector pos) {
    float t = sin(frameCount * 0.035 + pos.y*0.01);
    return color(
        map(t, -1, 1, 142, 25), // R
        map(t, -1, 1, 3, 25), // G
        map(t, -1, 1, 32, 113), // B
        100 // Alpha
    );
}