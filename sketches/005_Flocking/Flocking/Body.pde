class Body{
    PVector position;
    PVector velocity;
    PVector acceleration;
    float maxSpeed = 2;
    Body(){
        position = new PVector(random(width), random(height));
        velocity = PVector.random2D().mult(random(1, 3)); // Creates random unitary vector and multiplies it by a random amount between 1 and 3 to give it some speed
        acceleration = new PVector(0, 0); // No acceleration for now
    }
    void applyForce(PVector force) {
        acceleration.add(force);
    }
    void update(){
        // Makes it clip through the walls and reappear on the other side
        if (position.x < 0) {
            position.x = width;
        }
        if (position.x > width) {
            position.x = 0;
        }
        if (position.y < 0 ) {
            position.y = height;
        }
        if (position.y > height) {
            position.y = 0;
        }
        velocity.add(acceleration);
        velocity.limit(maxSpeed); // Limit the velocity to prevent it from getting too fast
        position.add(velocity);
        acceleration.mult(0); // Reset acceleration after applying it 
    }
}