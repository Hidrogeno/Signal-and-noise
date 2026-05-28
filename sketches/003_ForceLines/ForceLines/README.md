# 003 Flow Field:

![Flow Field Preview](../../../exports/gifs/003_FlowField.gif)

In this sketch we add forces that are dependent on the particle's position on a grid.
FlowField makes a grid from the canvas, calculates an "angle" derived from a function that goes from position to [0,2π], from that angle we apply a force to the generated particles.

As an additional force there is a jitter to keep things more visually interesting and an attractor can be created by clicking the mouse on the screen.

## Concepts:
- Vectors
- Velocity
- Fading trails
- Acceleration
- Forces
- Mapping
- Making a grid out of the canvas

## Controls:

- The particles will feel a force in the direction of the mouse when clicked.
