ArrayList<Particle> particles = new ArrayList<Particle>();
FlowField flowField;
color backgroundColor = color(0, 0, 0, 20);
color particleColor = color(205, 205, 205, 200);
void setup() {
    size(800, 800);
    pixelDensity(2);
    background(0);
    flowField = new FlowField(50);
    for(int i = 0; i < 1200; i++){
        particles.add(new Particle());
    }
}
void draw(){
    noStroke();
    fill(backgroundColor);
    rect(0, 0, width, height);
    for(Particle p : particles){
        if(mousePressed){
            PVector mousePos = new PVector(mouseX, mouseY);
            PVector distance = PVector.sub(mousePos, p.position);  
            PVector force = distance; // Vector pointing from particle to mouse position
            force.normalize();
            force.mult(10/distance.mag()*distance.mag()); // The closer the particle is to the mouse position, the stronger the force
            p.applyForce(force);
        }
        PVector jitter = PVector.random2D().mult(5); // Adding a random force makes the animation more lively.
        p.applyForce(jitter);
        p.applyForce(flowField.lookup(p.position).mult(7));// We look up the value of the force in that part of the flow field.
        p.update();
        p.display();
    }
}