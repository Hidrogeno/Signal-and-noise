// This is the code for the particle class. It has a position, velocity, and acceleration. It also has a method to update its position and a method to display itself.
class Particle {
    PVector position;
    PVector velocity;
    PVector acceleration;
    
    Particle(){
        position = new PVector(random(width), random(height));
        velocity = PVector.random2D().mult(random(1, 3)); // Creates random unitary vector and multiplies it by a random amount between 1 and 3 to give it some speed
        acceleration = new PVector(0, 0); // No acceleration for now
    }
    void applyForce(PVector force) {
        acceleration.add(force);
    }
    void update(){
        velocity.add(acceleration);
        velocity.limit(2); // Limit the velocity to prevent it from getting too fast
        position.add(velocity);
        acceleration.mult(0); // Reset acceleration after applying it 
    }
    
    void display(){
        fill(particleColor);
        ellipse(position.x, position.y, 4, 4);
    }
}