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
           .setLabel("Execute Play")
           .setPosition(parent.width - 150, 50)
           .setSize(120, 40)
           .addListener(e -> execute());
        
        cp5.addButton("executeRot")
           .setLabel("Execute Rotation")
           .setPosition(parent.width - 150, 140)
           .setSize(120, 40)
           .addListener(e -> executeRot());

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
           .setPosition(parent.width - 150, 700)
           .setSize(120, 40)
           .addListener(e -> reset());
           
        cp5.addDropdownList("rotation")
           .setLabel("Rotaions")
           .setPosition(parent.width - 150, 500)
           .setSize(120, 160)
           .addItem("Rotaion 1 SR", 7)
           .addItem("Rotaion 2 SR", 8)
           .addItem("Rotaion 3 SR", 9)
           .addItem("Rotaion 4 SR", 10)
           .addItem("Rotaion 5 SR", 11)
           .addItem("Rotaion 6 SR", 12)
           .addItem("Rotaion 1 S", 13)
           .addItem("Rotaion 2 S", 14)
           .addItem("Rotaion 3 S", 15)
           .addItem("Rotaion 4 S", 16)
           .addItem("Rotaion 5 S", 17)
           .addItem("Rotaion 6 S", 18)
           .addListener(e -> rotation());
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
        float excecutionRoute = getSelectedRoute(); // Get selected route
        executePlay(excecutionRoute);
    }
    
    private void executeRot() {
        float excecutionRot = getSelectedRotation();
        executeRot(excecutionRot);
    }

    private float getSelectedRoute() {
        return cp5.getValue("routes");
    }
    
    private float getSelectedRotation() {
        return cp5.getValue("rotation");
    }
    
    private void executeRot(float rot){
      int rotation = (int)rot;
      switch (rotation) {
            //SR
            case 0:
                player4.animateTo(rightEdge, threeMLine, tempo1);
                player1.animateTo(midX, backRowY, tempo1);
                player7.animateTo(leftX, backRowY, tempo1);
                player6.animateTo(rightX, threeMLine + 60, tempo1); //setter
                println("Serve Recieve Rotation 1");
                break;
                
            case 1:
                player1.animateTo(leftEdge, threeMLine, tempo1);
                player2.animateTo(midX, threeMLine, tempo1);
                player3.animateTo(rightEdge, threeMLine, tempo1);
                player4.animateTo(midX, backRowY, tempo1);
                player7.animateTo(leftX, backRowY, tempo1);
                player6.animateTo(midX + 80, netLoc, tempo1);
                println("Serve Recieve Rotation 2");
                break;

            case 2:
                player6.position.set(leftX - 70, netLoc + 70); //setter
                player2.position.set(offCourt, centerY);
                player3.position.y = netLoc;
                player3.position.set(rightX + 100, threeMLine); // OPP moves to 3 m line
                player1.position.set(leftX, backRowY); // OHO transitions back
                player7.position.x = rightX;
                player4.position.x = midX;
                player5.position.set(leftX - 60, netLoc);
                println("Serve Recieve Rotation 3");
                break;

            case 3:
                player5.position.set(leftX - 70, netLoc + 70); //setter
                player2.position.set(offCourt, centerY);
                player3.position.y = netLoc;
                player3.position.set(rightX + 80, backRowY + 100); // OPP moves to 3 m line
                player1.position.set(leftX, backRowY); // OHO transitions back
                player7.position.x = rightX;
                player4.position.x = midX;
                player6.position.set(leftX - 60, netLoc);
                println("Serve Recieve Rotation 4");
                break;

            case 4:
                player5.position.set(rightX, threeMLine); //middle 1
                player2.position.set(offCourt, centerY); // middle 2
                player3.position.set(midX + 80, backRowY + 100); // OPP 
                player1.position.set(rightX, backRowY); // OHO 
                player7.position.x = midX; //Libero
                player4.position.x = leftX; //OHD
                player6.position.set(midX + 80, netLoc); // Setter
                println("Serve Recieve Rotation 5");
                break;

            case 5:
                player5.position.set(offCourt, centerY); //middle 1
                player2.position.set(leftX - 70, threeMLine); // middle 2
                player3.position.set(midX - 80, backRowY + 100); // OPP 
                player1.position.set(midX, backRowY); // OHO 
                player7.position.x = rightX; //Libero
                player4.position.x = leftX; //OHD
                player6.position.set(midX + 80, netLoc); // Setter
                println("Serve Recieve Rotation 5");
                break;
                
            //serve
            case 6:
                player5.position.set(offCourt, centerY); //middle 1
                player2.position.set(midX, netLoc); // middle 2
                player3.position.set(midX - 80, netLoc + 80); // OPP 
                player1.position.set(leftX, backRowY); // OHO 
                player7.position.x = midX; //Libero
                player4.position.set(midX + 80, netLoc + 80); //OHD
                player6.position.set(rightX, centerY*1.93); // Setter
                println("Serve Rotation 1");
                break;
            case 7:
                player5.position.set(offCourt, centerY); //middle 1
                player2.position.set(midX, netLoc); // middle 2
                player3.position.set(midX - 80, netLoc + 80); // OPP 
                player1.position.set(leftX - 80, threeMLine); // OHO 
                player7.position.x = leftX; //Libero
                player4.position.set(rightX, centerY*1.93); //OHD
                player6.position.set(rightX, threeMLine); // Setter
                println("Serve Rotation 2");
                break;
            case 8:
                player5.position.set(midX, netLoc); //middle 1
                player2.position.set(rightX, centerY*1.93); // middle 2
                player3.position.set(rightX + 80, threeMLine); // OPP 
                player1.position.set(midX + 80, threeMLine - 40); // OHO 
                player7.position.set(offCourt, centerY); //Libero
                player4.position.set(midX, backRowY); //OHD
                player6.position.set(midX - 80, backRowY - 100); // Setter
                println("Serve Rotation 3");
                break;
            case 9:
                player2.position.set(offCourt, centerY); //middle 2
                player5.position.set(midX, netLoc); // middle 1
                player6.position.set(midX - 80, netLoc + 80); // Setter 
                player4.position.set(leftX, backRowY); // OHD
                player7.position.x = midX; //Libero
                player1.position.set(midX + 80, netLoc + 80); //OHO
                player3.position.set(rightX, centerY*1.93); // Oppo
                println("Serve Rotation 4");
                break;
           case 10:
                player2.position.set(offCourt, centerY); //middle 2
                player5.position.set(midX, netLoc); // middle 1
                player6.position.set(midX - 80, netLoc + 80); // Setter 
                player4.position.set(leftX - 80, threeMLine); // OHD
                player7.position.x = leftX; //Libero
                player1.position.set(rightX, centerY*1.93); //OHO
                player3.position.set(rightX, threeMLine); // Oppo
                println("Serve Rotation 5");
                break;
           case 11:
                player2.position.set(midX, netLoc); //middle 2
                player5.position.set(rightX, centerY*1.93); // middle 1
                player6.position.set(rightX + 80, threeMLine); // Setter 
                player4.position.set(midX + 80, threeMLine - 40); // OHD
                player7.position.set(offCourt, centerY); //Libero
                player1.position.set(midX, backRowY); //OHO
                player3.position.set(midX - 80, backRowY - 100); // Oppo
                println("Serve Rotation 6");
                break;
        
        }
      
    }

    private void executePlay(float route){

        int thePlay = (int)route;

        switch (thePlay) {
            case 0:
                player6.animateTo((midX + rightX)/2, netLoc, tempo1);
                delay(100);
                player1.animateTo(player1.position.x + 40, netLoc , oos);
                player2.animateTo(player2.position.x, netLoc , tempo1);
                player3.animateTo(player3.position.x - 40, netLoc , tempo1);
                println("double quick run");
                break;

            case 1:
                /*animate player 1, 2, and 3 to the desired positions using easing */
                player6.animateTo(rightEdge, netLoc, tempo1);
                delay(100);
                player1.animateTo(player1.position.x + 40, netLoc , tempo3);
                player2.animateTo(player2.position.x, netLoc , tempo2);
                player3.animateTo(player3.position.x - 40, netLoc , tempo1);
                println("3-stack run");
                break;

            case 2:
                /*animate player 1, 2, 3 and 4 to the desired positions using easing */
                player6.animateTo((midX + rightX)/2, netLoc, tempo1);
                delay(100);
                player1.animateTo(player1.position.x + 40, netLoc , oos);
                player2.animateTo(player2.position.x, netLoc , tempo1);
                player3.animateTo(player3.position.x - 40, netLoc , oos);
                player4.animateTo(player4.position.x, threeMLine, (tempo2+tempo3)/2);
                println("Overtop run");
                break;

            case 3:
                /*animate player 1, 2, and 3 to the desired positions using easing */
                player6.animateTo(leftEdge, netLoc, tempo1);
                delay(100);
                player1.animateTo(player1.position.x, netLoc , tempo1);
                player2.animateTo(player2.position.x, netLoc , tempo2);
                player3.animateTo(player3.position.x - 40, netLoc , tempo3);
                println("Reverse 3-stack run");
                break;

            case 4:
                /*animate player 1, 2, and 3 to the desired positions using easing */
                player6.animateTo((midX + rightX)/2, netLoc, tempo1);
                delay(100);
                player1.animateTo(player2.position.x, netLoc , tempo1);
                player2.animateTo(player1.position.x + 40, netLoc , (tempo2+tempo3)/2);
                player3.animateTo(player3.position.x - 40, netLoc , oos);
                println("Outside Quick run");
                break;

            case 5:
                /*animate player 1, 2, and 3 to the desired positions using easing */
                player6.animateTo((midX + rightX)/2, netLoc, tempo1);
                delay(100);
                player1.animateTo(player2.position.x, netLoc , tempo2);
                player2.animateTo(player1.position.x + 40, netLoc , tempo1);
                player3.animateTo(player3.position.x - 40, netLoc , oos);
                println("Flood run");
                break;
        
            case 6:
                /*animate player 1, 2, 3, 4, and 6 to the desired positions using easing */
                player6.animateTo((midX + rightX)/2, netLoc, tempo1);
                delay(100);
                if(getSelectedRotation()== 0){
                  player4.animateTo(player1.position.x - 40, netLoc , oos);
                  player2.animateTo(player2.position.x, netLoc , tempo1);
                  player3.animateTo(player3.position.x + 40, netLoc , tempo3);
                  player1.animateTo(player4.position.x, threeMLine , tempo3);
                  println("default run");
                } else {
                  player1.animateTo(player1.position.x + 40, netLoc , tempo3);
                  player2.animateTo(player2.position.x, netLoc , tempo1);
                  player3.animateTo(player3.position.x - 40, netLoc , tempo3);
                  player4.animateTo(player4.position.x, threeMLine , oos);
                  println("default run");
                  break;
                }
        
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
    
    private void rotation() {
        float selectedRotation = getSelectedRotation(); // Get selected route
        changeRot(selectedRotation);
    }
    
    private void changeRot(float rotation) {
        // Reset all players to their default positions
        resetPlayersToDefault();
        
        int currentRot = (int)rotation;

        switch (currentRot) {
            //SR
            case 0:
                player4.position.set(rightX, backRowY); // OHO transitions back
                player2.position.y = threeMLine; //Middle 
                player3.position.set(leftEdge, threeMLine); //OOP 
                player6.position.set(rightX + 60, backRowY + 60); //setter
                player7.position.x = midX;
                player1.position.set(leftX, backRowY);
                println("Serve Recieve Rotation 1");
                break;
                
            case 1:
                player6.position.set(midX, netLoc + 30); //setter
                player2.position.x += 170;
                player2.position.y = threeMLine; //Middle transitions back
                player3.position.y = netLoc;
                player3.position.x -= 150; // OPP moves to 3 m line
                player1.position.set(leftX, backRowY - 20); // OHO transitions back
                player7.position.x = midX;
                player4.position.x = rightX;
                println("Serve Recieve Rotation 2");
                break;

            case 2:
                player6.position.set(leftX - 70, netLoc + 70); //setter
                player2.position.set(offCourt, centerY);
                player3.position.y = netLoc;
                player3.position.set(rightX + 100, threeMLine); // OPP moves to 3 m line
                player1.position.set(leftX, backRowY); // OHO transitions back
                player7.position.x = rightX;
                player4.position.x = midX;
                player5.position.set(leftX - 60, netLoc);
                println("Serve Recieve Rotation 3");
                break;

            case 3:
                player5.position.set(leftX - 70, netLoc + 70); //setter
                player2.position.set(offCourt, centerY);
                player3.position.y = netLoc;
                player3.position.set(rightX + 80, backRowY + 100); // OPP moves to 3 m line
                player1.position.set(leftX, backRowY); // OHO transitions back
                player7.position.x = rightX;
                player4.position.x = midX;
                player6.position.set(leftX - 60, netLoc);
                println("Serve Recieve Rotation 4");
                break;

            case 4:
                player5.position.set(rightX, threeMLine); //middle 1
                player2.position.set(offCourt, centerY); // middle 2
                player3.position.set(midX + 80, backRowY + 100); // OPP 
                player1.position.set(rightX, backRowY); // OHO 
                player7.position.x = midX; //Libero
                player4.position.x = leftX; //OHD
                player6.position.set(midX + 80, netLoc); // Setter
                println("Serve Recieve Rotation 5");
                break;

            case 5:
                player5.position.set(offCourt, centerY); //middle 1
                player2.position.set(leftX - 70, threeMLine); // middle 2
                player3.position.set(midX - 80, backRowY + 100); // OPP 
                player1.position.set(midX, backRowY); // OHO 
                player7.position.x = rightX; //Libero
                player4.position.x = leftX; //OHD
                player6.position.set(midX + 80, netLoc); // Setter
                println("Serve Recieve Rotation 5");
                break;
                
            //serve
            case 6:
                player5.position.set(offCourt, centerY); //middle 1
                player2.position.set(midX, netLoc); // middle 2
                player3.position.set(midX - 80, netLoc + 80); // OPP 
                player1.position.set(leftX, backRowY); // OHO 
                player7.position.x = midX; //Libero
                player4.position.set(midX + 80, netLoc + 80); //OHD
                player6.position.set(rightX, centerY*1.93); // Setter
                println("Serve Rotation 1");
                break;
            case 7:
                player5.position.set(offCourt, centerY); //middle 1
                player2.position.set(midX, netLoc); // middle 2
                player3.position.set(midX - 80, netLoc + 80); // OPP 
                player1.position.set(leftX - 80, threeMLine); // OHO 
                player7.position.x = leftX; //Libero
                player4.position.set(rightX, centerY*1.93); //OHD
                player6.position.set(rightX, threeMLine); // Setter
                println("Serve Rotation 2");
                break;
            case 8:
                player5.position.set(midX, netLoc); //middle 1
                player2.position.set(rightX, centerY*1.93); // middle 2
                player3.position.set(rightX + 80, threeMLine); // OPP 
                player1.position.set(midX + 80, threeMLine - 40); // OHO 
                player7.position.set(offCourt, centerY); //Libero
                player4.position.set(midX, backRowY); //OHD
                player6.position.set(midX - 80, backRowY - 100); // Setter
                println("Serve Rotation 3");
                break;
            case 9:
                player2.position.set(offCourt, centerY); //middle 2
                player5.position.set(midX, netLoc); // middle 1
                player6.position.set(midX - 80, netLoc + 80); // Setter 
                player4.position.set(leftX, backRowY); // OHD
                player7.position.x = midX; //Libero
                player1.position.set(midX + 80, netLoc + 80); //OHO
                player3.position.set(rightX, centerY*1.93); // Oppo
                println("Serve Rotation 4");
                break;
           case 10:
                player2.position.set(offCourt, centerY); //middle 2
                player5.position.set(midX, netLoc); // middle 1
                player6.position.set(midX - 80, netLoc + 80); // Setter 
                player4.position.set(leftX - 80, threeMLine); // OHD
                player7.position.x = leftX; //Libero
                player1.position.set(rightX, centerY*1.93); //OHO
                player3.position.set(rightX, threeMLine); // Oppo
                println("Serve Rotation 5");
                break;
           case 11:
                player2.position.set(midX, netLoc); //middle 2
                player5.position.set(rightX, centerY*1.93); // middle 1
                player6.position.set(rightX + 80, threeMLine); // Setter 
                player4.position.set(midX + 80, threeMLine - 40); // OHD
                player7.position.set(offCourt, centerY); //Libero
                player1.position.set(midX, backRowY); //OHO
                player3.position.set(midX - 80, backRowY - 100); // Oppo
                println("Serve Rotation 6");
                break;
        
        }
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
