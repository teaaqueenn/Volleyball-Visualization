import controlP5.*;

ControlPanel controlPanel;

// Create players
public Player player1;
public Player player2;
public Player player3;
public Player player4;
public Player player5;
public Player player6;
public Player player7;

// Variables
public float courtWidth;
public float courtHeight;
public float centerX;
public float centerY;
public float frontRowY;
public float backRowY;
public float leftX;
public float midX;
public float rightX;
public float offCourt;
public float threeMLine;

public float tempo1 = 0.4;
public float tempo2 = 0.7;
public float tempo3 = 1.3;
public float oos = 1.8;



void setup() {
  size(1000, 800); // Set the size of the window
  
  // Recalculate position variables based on window size
  courtWidth = width * 2 / 3; // 2/3 of the screen's width
  courtHeight = height - 50; // Padding from the top and bottom
  centerX = width / 2 - 120;
  centerY = height / 2;
  frontRowY = centerY - courtHeight / 4; // Front row y-coordinate
  backRowY = centerY + courtHeight / 4; // Back row y-coordinate

  leftX = centerX - courtWidth / 3; // Position for left players
  midX = leftX + courtWidth / 3;
  rightX = leftX + 2 * courtWidth / 3;
  offCourt = courtWidth + 90;
  threeMLine = centerY*2 - (2*courtHeight/3); // 3m line y-coordinate
  
  // Player Base Positions
  player1 = new Player(new PVector(leftX, frontRowY), "OHO"); // Front row, left
  player2 = new Player(new PVector(midX, frontRowY), "M2"); // Front row, center
  player3 = new Player(new PVector(rightX, frontRowY), "OPP"); // Front row, right
  player4 = new Player(new PVector(midX, backRowY), "OHD"); // Back row, middle
  player5 = new Player(new PVector(offCourt, centerY), "M1"); // Off the court
  player6 = new Player(new PVector(rightX, backRowY), "Setter"); // Back row, right
  player7 = new Player(new PVector(leftX, backRowY), "Libero"); // Back row, left
 

  // Initialize the ControlPanel
  controlPanel = new ControlPanel(this);
}

void draw() {
  strokeWeight(1);
  background(200);
  drawCourt();
  player1.display();
  player2.display();
  player3.display();
  player4.display();
  player5.display();
  player6.display();
  player7.display();
  controlPanel.draw();
  player1.updateAnimation();
  player2.updateAnimation();
  player3.updateAnimation();
  player4.updateAnimation();
  player5.updateAnimation();
  player6.updateAnimation();
  player7.updateAnimation();
}

void drawCourt() {
  // Draw half of the court 
  stroke(0);
  fill(255);

  // Draw court background
  rect(centerX - courtWidth / 2, centerY - courtHeight / 2, courtWidth, courtHeight);

  // Draw the net (horizontal line at the top)
  float lineY = centerY - courtHeight / 2 + 100;
  stroke(255, 0, 0); // Red color for the 3-meter line
  line(centerX - courtWidth / 2, lineY, centerX + courtWidth / 2, lineY);

  // Draw 3 m line (horizontal, in the middle of the court)
  stroke(0);
  line(centerX - courtWidth / 2, threeMLine, centerX + courtWidth / 2, threeMLine);
}

void mouseClicked() {
  Player[] players = {player1, player2, player3, player4, player5, player6, player7};

  // Deselect all players and remove highlighting
  for (Player p : players) {
    p.setHighlighted(false);
  }

  // Check if any player is clicked
  for (Player p : players) {
    if (p.isMouseOver()) {
      p.setHighlighted(true); // Highlight the player
      break; // Stop checking after the first clicked player
    } else {
      player1.setHighlighted(false);
      player2.setHighlighted(false);
      player3.setHighlighted(false);
      player4.setHighlighted(false);
      player5.setHighlighted(false);
      player6.setHighlighted(false);
      player7.setHighlighted(false);
    }
  }
}
