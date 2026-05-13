ArrayList<Particle> particles;

void setup(){
    size(800,800);
    pixelDensity(2);
    particles = new ArrayList<Particle>();
    for(int i = 0; i < 100; i++){
        particles.add(new Particle());
    }
    background(0);
}
void draw(){
    noStroke();
    fill(0, 20);
    rect(0, 0, width, height);
    for(Particle p : particles){
        p.update();
        p.display();
    }
    if(mousePressed == true){
        // Turns the lights off when the mouse is pressed
        background(0);
    }
}