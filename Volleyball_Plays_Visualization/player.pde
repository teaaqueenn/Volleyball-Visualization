import processing.core.PVector;

class Player {
  PVector position;
  String positionName;
  boolean highlighted;
  color playerColor;
  PVector startPosition;
  PVector targetPosition;
  float animationStartTime;
  float animationDuration; // in seconds
  boolean isAnimating; // Variable to track if animation is active


  Player(PVector position, String positionName) {
    this.position = position;
    this.positionName = positionName;
    this.highlighted = false;
    if(positionName == "Libero"){
      this.playerColor = color(126); 
    } else {
      this.playerColor = color(30, 42, 97); 
    }
  }

  void display() {
    // Set stroke color and weight based on whether the player is highlighted
    if (highlighted) {
      stroke(252, 186, 2); // Highlight color (yellow)
      strokeWeight(3);
    } else {
      stroke(0); // Default stroke color
      strokeWeight(1);
    }
    fill(playerColor);
    ellipse(position.x, position.y, 60, 60);
    fill(255);
    textAlign(CENTER, CENTER);
    text(positionName, position.x, position.y);
  }

  boolean isMouseOver() {
    float d = dist(mouseX, mouseY, position.x, position.y);
    return d < 60; // Radius of the player circle
  }

  void setHighlighted(boolean highlighted) {
    this.highlighted = highlighted;
  }
  
      public void animateTo(float targetX, float targetY, float durationInSeconds) {
        startPosition = new PVector(position.x, position.y);
        targetPosition = new PVector(targetX, targetY);
        animationStartTime = millis() / 1000.0f; // Convert millis to seconds
        animationDuration = durationInSeconds;
        isAnimating = true;
        if(startPosition.equals(targetPosition)) isAnimating = false;
    }

    public void updateAnimation() {
        if (!isAnimating) return;

        float currentTime = millis() / 1000.0f; // Convert millis to seconds
        float elapsedTime = currentTime - animationStartTime;

        if (elapsedTime >= animationDuration) {
            position.set(targetPosition.x, targetPosition.y);
            isAnimating = false; // End animation
        } else {
            float progress = elapsedTime / animationDuration;
            progress = easeInOut(progress);
            position.x = lerp(startPosition.x, targetPosition.x, progress);
            position.y = lerp(startPosition.y, targetPosition.y, progress);
        }
    }

    private float easeInOut(float t) {
        if (t == 0) return 0;
        if (t == 1) return 1;
        if (t < 0.5) return 8 * t * t * t * t;
        return 1 - 0.5 * pow(2, (-20 * t + 10));
    }
}
