ArrayList<Boid> boids = new ArrayList<Boid>();
color boidColor;
void setup() {
    float separationStrength = 1.5;
    float alignmentStrength = 1.0;
    float cohesionStrength = 1.0;
    size(800, 800);
    pixelDensity(2);
    background(0);
    for (int i = 0; i < 100; i++) {
        boids.add(new Boid(separationStrength, alignmentStrength, cohesionStrength));
    }
}

void draw(){
    boidColor = customBoidColor();
    fill(0, 50);
    rect(0, 0, width, height);
    for (Boid b : boids) {
        b.flock(boids); // Make boids flock together
        b.update(); // Update the boid's position and velocity
        b.setBoidSize(map(b.velocity.mag(),0,b.maxSpeed,1,8)); // Set their size
        b.setBoidColor(boidColor); // Set their color
        // uncomment the following line to enable action-based coloring
        // b.lastActionColor(); // Set the color based on the last dominant action
        b.display();
    }
}

color customBoidColor() {
    return color(
        map(sin(frameCount * 0.07), -1, 1, 50, 255), // R
        map(cos(frameCount * 0.05), -1, 1, 50, 255), // G
        map(sin(frameCount * 0.05 + PI/2), -1, 1, 50, 255), // B
        100 // Alpha
    );
}