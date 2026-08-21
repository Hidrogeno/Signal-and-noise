class Boid extends Body{
    float perceptionRadius = 80;
    float maxForce = 0.2;
    float separationStrength = 1;
    float alignmentStrength = 0.3;
    float cohesionStrength = 1;
    float boidSize = 4;
    color boidColor = color(255, 255, 255, 100);
    float [] lastForces; // Array to store the last forces applied for separation, alignment, and cohesion

    Boid(){
        // Basic constructor, just calls the super constructor of the Body class
        // Use this constructor if you want to use the default strengths for the three flocking behaviors
        super();
    }
    Boid(float separationStrength, float alignmentStrength, float cohesionStrength){
        // Constructor that allows you to set the strengths of the three flocking behaviors
        super();
        this.separationStrength = separationStrength;
        this.alignmentStrength = alignmentStrength;
        this.cohesionStrength = cohesionStrength;
    }

    void separate(ArrayList<Boid> boids){
        // This function makes each boid separate from neighbors to avoid crowding
        PVector steering = new PVector(0, 0);
        for(Boid other : boids){
            if(other != this){ // For all boids except itself
                float distance = PVector.dist(position, other.position);
                if(distance < perceptionRadius){ // If within perception radius
                    PVector diff = PVector.sub(position, other.position);
                    diff.normalize();
                    diff.div(distance);
                    steering.add(diff); // Add a steering force that is inversely proportional to the distance to the other boid
                }
            }
        }
        steering.mult(separationStrength); // Scale the steering force by the separation strength
        steering.limit(maxForce); // Limit the steering force to the maximum force
        applyForce(steering);
        lastForces[0] = steering.mag(); // Store the magnitude of the force applied for separation
    }
    void align(ArrayList<Boid> boids){
        // This function alligns the boid's velocity to the average of it's neighbors'
        PVector steering = new PVector(0, 0);
        PVector avgVelocity = new PVector(0, 0);
        int neighbors = 0; // Count of neighbors within perception radius
        for(Boid other : boids){
            if(other != this){ // For all boids except itself
                float distance = PVector.dist(position, other.position);
                if(distance < perceptionRadius){ // If within perception radius
                    avgVelocity.add(other.velocity); // Add the other boid's velocity to the average velocity
                    neighbors++;
                }
            }
        }
        if (neighbors > 0) {
            avgVelocity.div(neighbors); // Divide the sum of the velocities by the number of neighbors to get the average velocity
            steering = PVector.sub(avgVelocity, velocity); // Calculate steering force direction
            steering.mult(alignmentStrength); // Scale by the alignment strength
            steering.limit(maxForce);
            applyForce(steering); // Apply the force
            lastForces[1] = steering.mag(); // Store the magnitude of the force applied for alignment
        }
    }
    void cohere(ArrayList<Boid> boids){
        PVector steering = new PVector(0, 0);
        PVector avgPosition = new PVector(0, 0);
        int neighbors = 0; // Count of neighbors within perception radius
        for(Boid other : boids){
            if(other != this){ // For all boids except itself
                float distance = PVector.dist(position, other.position);
                if(distance < perceptionRadius){
                    avgPosition.add(other.position); // Add the other boid's position to the average position
                    neighbors++;
                }
            }
        }
        if (neighbors > 0) {
            avgPosition.div(neighbors); // Divide the sum of the positions by the number of neighbors to get the average position
            steering = PVector.sub(avgPosition, position);
            steering.mult(cohesionStrength); // Scale by the cohesion strength
            steering.limit(maxForce);
            applyForce(steering); // Apply the force
            lastForces[2] = steering.mag(); // Store the magnitude of the force applied for cohesion
        }
    }
    void flock(ArrayList<Boid> boids){
        lastForces = new float[]{0, 0, 0}; // Reset the last forces array at the beginning of each flocking step
        // This function combines the three flocking behaviors into one
        separate(boids);
        align(boids);
        cohere(boids);
    }
    void setBoidSize(float size){
        boidSize = size;
    }
    void setBoidColor(color c){
        boidColor = c;
    }
    void lastActionColor(){
        // This function sets the boid's color based on the last dominant action (separation, alignment, or cohesion)
        float maxLastForce = max(lastForces[0], max(lastForces[1], lastForces[2]));
        if(maxLastForce > lastForces[1] && maxLastForce > lastForces[2]){
            boidColor = color(255, 0, 0, 100); // Red for separation
        } else if(maxLastForce > lastForces[0] && maxLastForce > lastForces[2]){
            boidColor = color(0, 255, 0, 100); // Green for alignment
        } else if(maxLastForce > lastForces[0] && maxLastForce > lastForces[1]){
            boidColor = color(0, 0, 255, 100); // Blue for cohesion
        }
    }
    void display(){
        pushStyle();
            noStroke();
            fill(boidColor);
            ellipse(position.x, position.y, boidSize, boidSize);
        popStyle();
    }
}