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
    
    void update(){
        if (position.x < 0 || position.x > width) {
            // Makes it bounce off the walls
            velocity.x *= -1;
        }
        if (position.y < 0 || position.y > height) {
            // Makes it bounce off the floor and ceiling
            velocity.y *= -1;
        }
        velocity.add(acceleration); // Right now this does nothing since acceleration is (0, 0)
        position.add(velocity);
        acceleration.mult(0); // Reset acceleration after applying it (not necessary here since it's always zero, but good practice for when we add forces later)
    }
    
    void display(){
        fill(255);
        ellipse(position.x, position.y, 5, 5);
    }
}