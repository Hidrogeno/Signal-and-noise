ArrayList<Particle> particles = new ArrayList<Particle>();
PVector centralAttractor;
color backgroundColor = color(1,38,65, 30);
color attractorColor = color(#EE005A, 128);
color particleColor = color(205, 205, 205, 200);
void setup() {
    size(800,800);
    pixelDensity(2);
    background(backgroundColor);
    centralAttractor = new PVector(width/2, height/2); // Vector in the middle of the screen
    for (int i = 0; i < 120; i++) {
        particles.add(new Particle());
    }
}

void draw() {
    noStroke();
    fill(backgroundColor);
    rect(0, 0, width, height);
    drawAttractor(); // Draw the central attractor with some jitter to make it look more dynamic
    for (Particle p : particles) {
        PVector force = calculateAttractionForce(p);
        p.applyForce(force);
        p.update();
        p.display();
    }
    // if(frameCount < 500){
    //     saveFrame("frames/frame-####.png");
    // }
}

void drawAttractor() {
    pushStyle();
    stroke(attractorColor);
    strokeWeight(2);
    noFill();
    float jitterX = random(-3, 3);
    float jitterY = random(-3, 3);
    ellipse(centralAttractor.x, centralAttractor.y, 15+jitterX, 15+jitterY);
    popStyle();
}

PVector calculateAttractionForce(Particle p) {
    // We are going to return the force of attraction therefore we need to calculate the vector pointing from the particle to the central attractor
    // then we need to normalize it and multiply it by the magnitude of the force which is determined by the distance to the central attractor. 
    PVector force = PVector.sub(centralAttractor, p.position); // Vector pointing from particle to "origin" (not really the origin, but the central attractor)
    float distance = force.mag();
    distance = constrain(distance, 40, 80);
    float magnitude = 80/(distance*distance); // The closer the particle is to the central attractor, the stronger the force
    force.normalize(); 
    force.mult(magnitude);
    return force;
}