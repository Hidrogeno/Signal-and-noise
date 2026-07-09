class Attractor{
    PVector position;
    float mass;
    color attractorColor, outlineColor;

    Attractor(PVector position, float mass){
        this.position = position;
        this.mass = mass;
        this.attractorColor = color(0,100);
    }

    // We add a constructor that allows to specify the color of the attractor, so that we can create repellers with a different color
    // eventually this could help the class to be reused in other sketches.
    Attractor(PVector position, float mass, color attractorColor){
        this.position = position;
        this.mass = mass;
        this.attractorColor = attractorColor;
    }
    void display(){
        float jitter = random(0, abs(mass)/10); // Adding a little jitter to the size of the attractor makes it look more organic
        float radius = (abs(mass)+jitter)*0.5; // The radius of the attractor is proportional to its mass
        pushStyle();
            outlineColor = _invertColor(attractorColor);
            stroke(outlineColor);
            strokeWeight(1);
            fill(attractorColor);
            ellipse(position.x, position.y, radius, radius);
        popStyle();
    }

    color _invertColor(color c){
        // This function inverts the color of the attractor to create a contrasting outline
        // eventually a function like this should be moved into a utility library so that it can be reused in other sketches.
        return color(
            255 - red(c),
            255 - green(c),
            255 - blue(c)
        );
    }
}