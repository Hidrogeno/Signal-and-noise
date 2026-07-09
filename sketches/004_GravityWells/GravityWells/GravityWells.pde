// Gravity Wells

//Lists of objects that will be generated, particles and attractors
ArrayList<Particle> particles = new ArrayList<Particle>();
ArrayList<Attractor> attractors = new ArrayList<Attractor>();

//Constants, modify these to change the behavior of the simulation
color backgroundColor = color(0, 0, 0, 20);
color particleColor = color(255, 255, 255, 100);

void setup(){
    size(800, 800);
    pixelDensity(2);
    background(0);
    for(int i = 0; i < 1200; i++){
        particles.add(new Particle());
    }
}

void draw(){
    pushStyle();
        fill(backgroundColor);
        rect(0, 0, width, height);
    popStyle();

    // First we display the attractors so that they are drawn behind the particles
    for(Attractor attractor : attractors){
        attractor.display();
    }
    // Now we update the particles, applying the forces from the attractors to each particle
    for(Particle p : particles){
        for(Attractor attractor : attractors){
            PVector displacement = PVector.sub(attractor.position, p.position);
            // We limit the distance to avoid extreme forces when particles are too close to the attractor
            // this has the added effect that particles will not clamp on the center of the attractor
            // therefore they will not explode as a single front on just one attactor when removed
            float distance = max(displacement.mag(), 10);
            // For the force we use a gravity-like formula 
            // proportional to mass and inversely proportional to the square of the displacement
            float forceMagnitude = (attractor.mass) / (distance * distance);
            PVector force = displacement.normalize().mult(forceMagnitude);
            p.applyForce(force);
        }
        p.update();
        p.display();
    }
}

void mousePressed(){
    float mass = random(50, 100);
    PVector mousePos = new PVector(mouseX, mouseY);
    if(mouseButton == LEFT){
        attractors.add(new Attractor(mousePos, mass));
    } else if(mouseButton == RIGHT){
        attractors.add(new Attractor(mousePos, -mass, color(255, 255, 255,100)));
    }
}

void keyPressed(){
    if((key == 'c' || key == 'C') && !attractors.isEmpty()){
        pushStyle();
            // We flash the screen to indicate the attractors exploded
            fill(255,100);
            rect(0, 0, width, height);
        popStyle();
        attractors.clear();
    }
}
