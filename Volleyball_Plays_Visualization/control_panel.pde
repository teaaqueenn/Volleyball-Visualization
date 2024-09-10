import controlP5.*;

public float netLoc = 170;
public float leftEdge = 50;
public float rightEdge = 710;
public float loc42 = leftEdge + 80;
public float locOMMid = loc42 + 80;

public class ControlPanel {

    private ControlP5 cp5;
    private Player selectedPlayer;
    private PApplet parent;

    ControlPanel(PApplet p) {
        parent = p;
        cp5 = new ControlP5(parent);

        // Draw Route Button
        cp5.addButton("execute")
           .setLabel("Execute")
           .setPosition(parent.width - 150, 50)
           .setSize(120, 40)
           .addListener(e -> execute());

        // Switch Rows Button
        cp5.addButton("switchRows")
           .setLabel("Switch Rows")
           .setPosition(parent.width - 150, 230)
           .setSize(120, 40)
           .addListener(e -> switchRows());

        // Routes Drop-Down
        cp5.addDropdownList("routes")
           .setLabel("Routes")
           .setPosition(parent.width - 150, 330)
           .setSize(120, 160)
           .addItem("Double Quick", 0)
           .addItem("3-Stack", 1)
           .addItem("Overtop", 2)
           .addItem("Reverse 3 Stack", 3)
           .addItem("Outside Quick", 4)
           .addItem("Flood", 5)
           .addItem("Default", 6)
           .addListener(e -> selectRoute());
           
        // Reset Button
        cp5.addButton("reset")
           .setLabel("Reset")
           .setPosition(parent.width - 150, 140)
           .setSize(120, 40)
           .addListener(e -> reset());
    }

    void draw() {
        cp5.draw();
    }

    void updatePlayerSelection(Player p) {
        if (selectedPlayer != null) {
            selectedPlayer.setHighlighted(false);
        }
        selectedPlayer = p;
        if (selectedPlayer != null) {
            selectedPlayer.setHighlighted(true);
        }
    }

    private void execute() {
        if (selectedPlayer != null) {
            // Placeholder for draw route functionality
            println("Draw Route for " + selectedPlayer.positionName);
        } else {
            println("No player selected for drawing route.");
        }
        float excecutionRoute = getSelectedRoute(); // Get selected route
        executePlay(excecutionRoute);
    }

    private float getSelectedRoute() {
        return cp5.getValue("routes");
    }

    private void executePlay(float route){

        int thePlay = (int)route;

        switch (thePlay) {
            case 0:
                player1.animateTo(player1.position.x + 40, netLoc , oos);
                player2.animateTo(player2.position.x, netLoc , tempo1);
                player3.animateTo(player3.position.x - 40, netLoc , tempo1);
                println("double quick run");
                break;

            case 1:
                /*animate player 1, 2, and 3 to the desired positions using easing */
                player1.animateTo(player1.position.x + 40, netLoc , tempo3);
                player2.animateTo(player2.position.x, netLoc , tempo2);
                player3.animateTo(player3.position.x - 40, netLoc , tempo1);
                println("3-stack run");
                break;

            case 2:
                /*animate player 1, 2, 3 and 4 to the desired positions using easing */
                player1.animateTo(player1.position.x + 40, netLoc , oos);
                player2.animateTo(player2.position.x, netLoc , tempo1);
                player3.animateTo(player3.position.x - 40, netLoc , oos);
                player4.animateTo(player4.position.x, threeMLine, (tempo2+tempo3)/2);
                println("Overtop run");
                break;

            case 3:
                /*animate player 1, 2, and 3 to the desired positions using easing */
                player1.animateTo(player1.position.x, netLoc , tempo1);
                player2.animateTo(player2.position.x, netLoc , tempo2);
                player3.animateTo(player3.position.x - 40, netLoc , tempo3);
                println("Reverse 3-stack run");
                break;

            case 4:
                /*animate player 1, 2, and 3 to the desired positions using easing */
                player1.animateTo(player2.position.x, netLoc , tempo1);
                player2.animateTo(player1.position.x + 40, netLoc , (tempo2+tempo3)/2);
                player3.animateTo(player3.position.x - 40, netLoc , oos);
                println("Outside Quick run");
                break;

            case 5:
                /*animate player 1, 2, and 3 to the desired positions using easing */
                player1.animateTo(player2.position.x, netLoc , tempo2);
                player2.animateTo(player1.position.x + 40, netLoc , tempo1);
                player3.animateTo(player3.position.x - 40, netLoc , oos);
                println("Flood run");
                break;
        
            case 6:
                /*animate player 1, 2, 3, 4, and 6 to the desired positions using easing */
                player1.animateTo(player1.position.x + 40, netLoc , tempo3);
                player2.animateTo(player2.position.x, netLoc , tempo1);
                player3.animateTo(player3.position.x - 40, netLoc , tempo3);
                player4.animateTo(player4.position.x, threeMLine , oos);
                println("default run");
                break;
        
        }
    }
    
    private void switchRows() {
        // Swap the players between rows
        PVector temp;

        // Swap M1 and M2
        temp = player5.position;
        player5.position = player2.position;
        player2.position = temp;

        // Swap Setter and OPP
        temp = player6.position;
        player6.position = player3.position;
        player3.position = temp;
        
        println("Rows have been switched.");
    }

    private void selectRoute() {
        float selectedRoute = getSelectedRoute(); // Get selected route
        changePos(selectedRoute);
    }
  
    private void changePos(float play) {
        // Reset all players to their default positions
        resetPlayersToDefault();
        
        int currentPlay = (int)play;

        switch (currentPlay) {
            case 0:
                player1.position.set(leftEdge, threeMLine); // OHO transitions back
                player2.position.y = threeMLine; //Middle transitions back
                player3.position.y = threeMLine; //OOP transitions directly back
                player6.position.set((midX + rightX)/2, netLoc); //setter
                println("double quick");
                break;
                
            case 1:
                player6.position.set(rightEdge, netLoc); //setter
                player2.position.x -= 50;
                player2.position.y = threeMLine; //Middle transitions back
                player3.position.y = threeMLine; // OPP moves to 3 m line
                player1.position.set(leftEdge, threeMLine); // OHO transitions back
                println("3-stack");
                break;

            case 2:
                player6.position.set((midX + rightX)/2, netLoc); //setter
                player2.position.y = threeMLine;
                player3.position.set(rightEdge, threeMLine);
                player1.position.set(leftEdge, threeMLine); // OHO transitions back
                println("Overtop");
                break;

            case 3:
                player6.position.set(leftEdge, netLoc); //setter
                player2.position.y = threeMLine; //Middle transitions back
                player3.position.set(rightEdge, threeMLine); // OPP transitions back
                player1.position.set(loc42, threeMLine); // OHO transitions back
                println("Reverse 3-stack");
                break;

            case 4:
                player6.position.set((midX + rightX)/2, netLoc); //setter
                player1.position.set(locOMMid, threeMLine); // OH
                player2.position.y = threeMLine; // MH
                player3.position.set(rightEdge, threeMLine); // OPP transitions back
                println("Outside Quick");
                break;

            case 5:
                player6.position.set((midX + rightX)/2, netLoc); //setter
                player1.position.set(locOMMid, threeMLine); // OH
                player2.position.y = threeMLine; // MH
                player3.position.set(rightEdge, threeMLine); // OPP transitions back
                println("Flood");
                break;
        
            case 6:
                // Reset to default positions
                player1.position.set(leftEdge, threeMLine); // OHO transitions back
                player2.position.y = threeMLine; // MH
                player3.position.set(rightEdge, threeMLine);
                player6.position.set((midX + rightX)/2, netLoc);
                println("default");
                break;
        
        }
    }

    private void resetPlayersToDefault() {
        // Reset player positions to default
        player1.position.set(leftX, frontRowY); // Front row, left
        player2.position.set(midX, frontRowY); // Front row, center
        player3.position.set(rightX, frontRowY); // Front row, right
        player4.position.set(midX, backRowY); // Back row, middle
        player5.position.set(offCourt, centerY); // Off the court
        player6.position.set(rightX, backRowY); // Back row, right
        player7.position.set(leftX, backRowY); // Back row, left
    }
    
    private void reset(){
        resetPlayersToDefault();
        println("reset");
    }
}
