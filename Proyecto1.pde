import java.util.HashSet;
import java.util.HashMap;
import java.util.ArrayList;

// Automata Object
Automata automata;

// Button sizes
int buttonWidth;
int buttonHeight;

// Button colors
color buttonColor;
color buttonHighlight;

// Height of all buttons
int buttonY;

// Button X locations
int statesButtonX;
int initStateButtonX;
int finalStatesButtonX;
int alphabetButtonX;
int transitionButtonX;

// Button over booleans
boolean statesOver     = false;
boolean initOver       = false;
boolean finalOver      = false;
boolean alphabetOver   = false;
boolean transitionOver = false;

// TextBox Info
TextBox[] textBoxes;    //Text boxes for requiring diffent inputs to the user
color textColor;
final int stateNormal           = 0;
final int stateInputBox         = 1;
final int stateInitialStateBox  = 2;
final int stateFinalStateBox    = 3;
final int alphabetStateBox      = 4;
final int transitionStateBox    = 5;
int state = stateNormal;

// NDFA Automata String info
int infoX;
int infoY; 
int infoSpacing;
String statesNDFA; 
String initialState;
String finalStates;
String alphabet;

// General visual automata parameters
int nodeWidth;
int distFromCenter;
int textOffsetX;
int textOffsetY;
int triangleSize;

// NDFA automata visual parameters
int centerX_NDFA;
int centerY_NDFA;
int[] xCoordsNDFA;
int[] yCoordsNDFA;

// DFA automata visual parameters
int centerX_DFA;
int centerY_DFA;
int[] xCoordsDFA;
int[] yCoordsDFA;

// Arrow offset to avoid overlapping when going both ways
int arrowVerticalOffset;


// Default Triangle coordinates for arrow point
int tx1;
int ty1;
int tx2;
int tx3;
int ty23;

// Booleans used to determine when to calculate DFA
boolean hasStates;
boolean hasInitial;
boolean hasFinal;
boolean hasAlphabet;
boolean hasTransitions;
boolean displayDFA;

// Mapping from arraylist of ids to index of each DFA node//
HashMap<String, Integer> stateMap;

void setup() {
  fullScreen();
  
  automata = new Automata();

  buttonWidth  = width/10;
  buttonHeight = height/15;
  
  buttonColor = color(0,128,0);
  buttonHighlight = color(0,192,0);
  
  buttonY = height/20;
  statesButtonX = width/6 + width/20;
  initStateButtonX = 2*width/6 + width/20;
  finalStatesButtonX = 3*width/6 + width/20;
  alphabetButtonX = 4*width/6 + width/20;
  transitionButtonX = 5*width/6 + width/20;
 
  textColor = color(255);
  textSize(16);
  
  rectMode(CORNER);
  textAlign(LEFT);
  
  textBoxes = new TextBox[5];
  instantiateBox(0, "Cuantos estados tiene su AFND?");
  instantiateBox(1, "Introduce el indice del estado inicial");
  instantiateBox(2, "Introduce los indices de los estados de aceptacion separados por comas");
  instantiateBox(3, "Introduce los simbolos del alfabeto separados por coma");
  instantiateBox(4, "Introduce una transicion con el formato  origen-simbolo-destino   e.g.         0-s-1,2");
  
  for (int i=0; i<5; i++){
    textBoxes[i].isFocused = true;
  }
  
  infoX = width/30;
  infoY = height/20;
  
  statesNDFA   = "[]";
  initialState = "";
  finalStates  = "[]";
  alphabet     = "[]"; 
  
  nodeWidth     = 60;
  distFromCenter = 150;
  
  textOffsetX = 10;
  textOffsetY = 5;
  triangleSize = 10;
  
  tx1 = 0;
  ty1 = 0;
  tx2 = tx1 -  (int)Math.sqrt(triangleSize*triangleSize/2);
  tx3 = tx1 +  (int)Math.sqrt(triangleSize*triangleSize/2);
  ty23 = ty1 + (int)Math.sqrt(triangleSize*triangleSize/2);
  
  centerX_NDFA = width/4;
  centerY_NDFA = 2*height/3;
  
  centerX_DFA = 3*width/4;
  centerY_DFA = 2*height/3;
  
  arrowVerticalOffset = 15;
  
  hasStates = false;
  hasInitial = false;
  hasFinal = false;
  hasAlphabet = false;
  hasTransitions = false;
  displayDFA = false;
}

void draw() {
  update(mouseX, mouseY);
  background(150);
  stroke(255);

  setFillColor(statesOver);
  rect(statesButtonX, buttonY , buttonWidth, buttonHeight);
  setFillColor(initOver);
  rect(initStateButtonX, buttonY , buttonWidth, buttonHeight);
  setFillColor(finalOver);
  rect(finalStatesButtonX, buttonY , buttonWidth, buttonHeight);
  setFillColor(alphabetOver);
  rect(alphabetButtonX, buttonY , buttonWidth, buttonHeight);
  setFillColor(transitionOver);
  rect(transitionButtonX, buttonY , buttonWidth, buttonHeight);
  
  fill(textColor);
  text("Num estados", statesButtonX + buttonWidth/20 , buttonY + buttonHeight/1.6); 
  text("Estado Inicial", initStateButtonX + buttonWidth/20 , buttonY + buttonHeight/1.6); 
  text("Estado Final", finalStatesButtonX + buttonWidth/20 , buttonY + buttonHeight/1.6); 
  text("Alfabeto", alphabetButtonX + buttonWidth/20 , buttonY + buttonHeight/1.6); 
  text("Transiciones", transitionButtonX + buttonWidth/20 , buttonY + buttonHeight/1.6); 
  
  if(state > 0)
  {
    textBoxes[state-1].display();
  }
  fill(0);
  text("Q = " + statesNDFA, infoX , infoY);
  text("q0 = " + initialState, infoX , 2*infoY); 
  text("F = " + finalStates, infoX , 3*infoY); 
  text("Sigma = " + alphabet, infoX , 4*infoY); 
  
  fill(255,165,0);
  drawNDFA();
  if(displayDFA){
    drawDFA();
  }
}

void update(int x, int y) {
  if ( overRect(statesButtonX, buttonY , buttonWidth, buttonHeight) ) {
    statesOver = true;
  } else {
    statesOver = false;
  }
  
   if ( overRect(initStateButtonX, buttonY , buttonWidth, buttonHeight) ) {
    initOver = true;
  } else {
    initOver = false;
  }
  
   if ( overRect(finalStatesButtonX, buttonY , buttonWidth, buttonHeight) ) {
    finalOver = true;
  } else {
    finalOver = false;
  }
  
   if ( overRect(alphabetButtonX, buttonY , buttonWidth, buttonHeight) ) {
    alphabetOver = true;
  } else {
    alphabetOver = false;
  }
  
   if ( overRect(transitionButtonX, buttonY , buttonWidth, buttonHeight) ) {
    transitionOver = true;
  } else {
    transitionOver = false;
  }
}

void mouseClicked() {
  if (statesOver) {
     state = stateInputBox;
  }
  if(initOver){
    state = stateInitialStateBox;
  }
   if(finalOver){
    state = stateFinalStateBox;
  }
   if(alphabetOver){
    state = alphabetStateBox;
  }
   if(transitionOver){
    textBoxes[transitionStateBox-1].txt = "";
    state = transitionStateBox;
  }
}

// Helper function to set fill color for each button
void setFillColor(boolean overButton)
{
  if(overButton){
    fill(buttonHighlight);
  }
  else{
    fill(buttonColor);
  }
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

//====================================================
void keyTyped() {
  if (state==stateNormal) {
    // do nothing
  } else if (state > stateNormal) {
    //
    textBoxes[state-1].tKeyTyped();
  }
}//func 
 
void keyPressed() {
  if (state==stateNormal) {
    //
  } else if (state > stateNormal) {
    //
    textBoxes[state-1].tKeyPressed();
  }
}

// Text Boxes for user input
void instantiateBox(int index, String message) {
  
  //statesTbox = new TextBox(
  textBoxes[index] = new TextBox(
    message, 
    width/4, height/4 + height/16, // x, y
    width/2, height/2 - height/4 - height/8, // w, h
    215, // lim
    0300 << 030, color(-1, 040), // textC, baseC
    color(-1, 0100), color(#FF00FF, 0200)); // bordC, slctC
}



// ===================================================

class TextBox {
 
  // demands rectMode(CORNER)
 
  final color textC, baseC, bordC, slctC;
  final short x, y, w, h, xw, yh, lim;
 
  boolean isFocused;
  String txt = "";
  String title; 
 
  TextBox(
    String tt, 
    int xx, int yy, 
    int ww, int hh, 
    int li, 
    color te, color ba, color bo, color se) {
 
    title=tt;
 
    x = (short) xx;
    y = (short) yy;
    w = (short) ww;
    h = (short) hh;
 
    lim = (short) li;
 
    xw = (short) (xx + ww);
    yh = (short) (yy + hh);
 
    textC = te;
    baseC = ba;
    bordC = bo;
    slctC = se;
  }
 
  void display() {
    stroke(isFocused? slctC : bordC);
 
    // outer 
    fill(baseC);
    rect(x-10, y-90, w+20, h+100);
 
    fill(0); 
    text(title, x, y-90+20);
 
    // main / inner
    fill(baseC);
    rect(x, y, w, h);
 
 
    fill(textC);
    text(txt + blinkChar(), x, y, w, h);
  }
 
  void tKeyTyped() {
 
    char k = key;
 
    if (k == ESC) {
      // println("esc 2");
      state=stateNormal; 
      key=0;
      return;
    } 
 
    if (k == CODED)  return;
 
    final int len = txt.length();
 
    if (k == BACKSPACE)  txt = txt.substring(0, max(0, len-1));
    else if (len >= lim)  return;
    else if (k == ENTER || k == RETURN) {
      // this ends the entering 
      println("RET ");
      
      if(state == stateInputBox){
        statesNDFA = automata.createStatesGUI(Integer.parseInt(txt));
        calculatePositionsNDFA();
        if(automata.statesNDFA != null)
          hasStates = true;
         else
           hasStates = false;
      }
      else if(state == stateInitialStateBox){
        initialState = automata.setInitialStateGUI(Integer.parseInt(txt)); 
        if(automata.initialState != null)
          hasInitial = true;
         else
           hasInitial = false;
      }
      else if(state == stateFinalStateBox){
        finalStates = automata.setAcceptanceStatesGUI(txt); 
        if(automata.finalStates != null)
          hasFinal = true;
         else
           hasFinal = false;
      }
      else if(state == alphabetStateBox){
        alphabet = automata.setAlphabetGUI(txt);
        if(automata.alphabet != null)
          hasAlphabet = true;
         else
           hasAlphabet = false;
      }
      else if(state == transitionStateBox){
        automata.addTransitionGUI(txt); 
        hasTransitions = true;
      }
      
      // If all inputs have been introduced calculate DFA
      if(hasStates && hasInitial && hasFinal && hasAlphabet && hasTransitions)
      {
         automata.convertToDFA();
         calculatePositionsDFA();
         displayDFA = true;
      }
      
      state  = stateNormal; // close input box 
      
    } else if (k == TAB & len < lim-3)  txt += "    ";
    else if (k == DELETE)  txt = "";
    else if (k >= ' ')     txt += str(k);
  }
 
 
  void tKeyPressed() {
    if (key == ESC) {
      println("esc 3");
      state=stateNormal;
      key=0;
    }
 
    if (key != CODED)  return;
 
    final int k = keyCode;
 
    final int len = txt.length();
 
    if (k == LEFT)  txt = txt.substring(0, max(0, len-1));
    else if (k == RIGHT & len < lim-3)  txt += "    ";
  }
 
  String blinkChar() {
    return isFocused && (frameCount>>2 & 1) == 0 ? "_" : "";
  }
 
  boolean checkFocus() {
    return isFocused = mouseX > x & mouseX < xw & mouseY > y & mouseY < yh;
  }
}

// Function for calculating node positions of NDFA
void calculatePositionsNDFA()
{
   xCoordsNDFA = new int[automata.statesNDFA.size()];
   yCoordsNDFA = new int[automata.statesNDFA.size()];
   double deltaAngle =  2*Math.PI/automata.statesNDFA.size();
   double currentAngle = 0;
    for (int i=0; i<automata.statesNDFA.size();i++)
    {
       //State state = automata.statesNDFA.get(i);
       int offsetX = (int)(distFromCenter*Math.cos(currentAngle));
       int offsetY = (int)(distFromCenter*Math.sin(currentAngle));
       xCoordsNDFA[i] = centerX_NDFA + offsetX;
       yCoordsNDFA[i] = centerY_NDFA + offsetY;
       currentAngle += deltaAngle;
    }
}

void calculatePositionsDFA()
{
   stateMap = new HashMap<String, Integer>();
   xCoordsDFA = new int[automata.statesDFA.size()];
   yCoordsDFA = new int[automata.statesDFA.size()];
   double deltaAngle =  2*Math.PI/automata.statesDFA.size();
   double currentAngle = 0;
   
    int i = 0;
    for (HashSet<State> stateSet : automata.statesDFA)
    {
       int offsetX = (int)(distFromCenter*Math.cos(currentAngle));
       int offsetY = (int)(distFromCenter*Math.sin(currentAngle));
       xCoordsDFA[i] = centerX_DFA + offsetX;
       yCoordsDFA[i] = centerY_DFA + offsetY;
       stateMap.put(stateSet.toString(), i);
       System.out.println("K: " + stateSet.toString() + " v: " + i);
       currentAngle += deltaAngle;
       i++;
    }
}

// Function for drawing automata
void drawNDFA()
{
  if (automata.statesNDFA.size()>0)
  {
    for (int i=0; i<automata.statesNDFA.size();i++)
    {
      State state = automata.statesNDFA.get(i);
      ArrayList<String> loopSymbols = new ArrayList<String>();
      
      fill(0);
      stroke(0);
      if(automata.alphabet != null)
      {
        // Draw arrows for each transition
        for(String symbol : automata.alphabet)
        {
          HashSet<State> destinationStates = state.transitions.get(symbol);
          if (destinationStates != null)
          {
            // Draw individual lines with corresponding symbol at the middle
            for (State destState : destinationStates)
            {

              
              int x1 = xCoordsNDFA[i];
              int y1 = yCoordsNDFA[i];
              int x2 = xCoordsNDFA[Integer.parseInt(destState.id)];
              int y2 = yCoordsNDFA[Integer.parseInt(destState.id)];
              float angle = (float)Math.atan2(y2-y1,x2-x1);          // Angle between nodes
              
              // Arrow vertical offset to avoid overlapping arrows
              int verticalOffset = arrowVerticalOffset;
              
              if (x1 < x2){
                verticalOffset = -verticalOffset;
              }
              
              // Draw arrow if nodes are different
              if(i != Integer.parseInt(destState.id))
              {
                int arrowOffsetX = (int)(-nodeWidth/2 * Math.cos(angle));
                int arrowOffsetY = (int)(-nodeWidth/2 * Math.sin(angle));
                
                line(x1, y1+verticalOffset, x2+arrowOffsetX, y2+arrowOffsetY+verticalOffset);
                text(symbol,(x1+x2)/2 , (y1+y2)/2 + verticalOffset);
                
                // Draw triangle in correct place by rotating and translating
                pushMatrix();
                translate(x2 + arrowOffsetX, y2 + arrowOffsetY+verticalOffset);                                 
                rotate((float)Math.PI/2 + angle);
                triangle(tx1,ty1, tx2, ty23, tx3, ty23);
                popMatrix();
              }
              
              // Add symbol to array of loopSymbols
              else{
                loopSymbols.add(symbol);
              }
            }

          }
        }
      }
      
      // Add "Loops" text on the right side if transition goes to the same node
      if(loopSymbols.size()>0){
         text("loops: " + loopSymbols, xCoordsNDFA[i] + 0.75*nodeWidth, yCoordsNDFA[i]);
      }
      
      // Draw arrow for initial state
      if(automata.initialState != null)
      {
        for (State inState : automata.initialState)
        {
          if(state == inState)
          {
            line(xCoordsNDFA[i] - 1.2*nodeWidth,yCoordsNDFA[i],xCoordsNDFA[i]- 0.5*nodeWidth,yCoordsNDFA[i]);
            pushMatrix();
            translate(xCoordsNDFA[i] - 0.5*nodeWidth, yCoordsNDFA[i]);                                 
            rotate((float)Math.PI/2);
            triangle(tx1,ty1, tx2, ty23, tx3, ty23);
            popMatrix();
          }
         break;
        }
      }
      
      fill(255,165,0);
      ellipse(xCoordsNDFA[i], yCoordsNDFA[i], nodeWidth, nodeWidth);
      fill(0);
      text(state.toString(), xCoordsNDFA[i] - textOffsetX , yCoordsNDFA[i] + textOffsetY); 
      
      //Draw circle outline for final states
      if(automata.finalStates != null)
      {
        for (State acState : automata.finalStates)
        {
          if(state == acState)
          {
            fill(0,0,0,1);
            ellipse(xCoordsNDFA[i], yCoordsNDFA[i], nodeWidth-10, nodeWidth-10);
            break;
          }
        }
      }
      fill(0);
    }
  }
}

// Function for drawing automata
void drawDFA()
{
    int i = 0;
    
    for (HashSet<State> stateSet : automata.statesDFA)
    {   
        fill(0);
        ArrayList<String> loopSymbols = new ArrayList<String>();
        for(String symbol : automata.alphabet)
        {
           
           HashSet<State> destinationSet = automata.findDestinationSetWithSymbol(stateSet, symbol);
           if(destinationSet.size()>0)
           {
              int destIndex = stateMap.get(destinationSet.toString());
              int x1 = xCoordsDFA[i];
              int y1 = yCoordsDFA[i];
              int x2 = xCoordsDFA[destIndex];
              int y2 = yCoordsDFA[destIndex];
              float angle = (float)Math.atan2(y2-y1,x2-x1);          // Angle between nodes
              
              // Arrow vertical offset to avoid overlapping arrows
              int verticalOffset = arrowVerticalOffset;
              
              if (x1 < x2){
                verticalOffset = -verticalOffset;
              }
              
              // Draw arrow if nodes are different
              if(stateSet.toString() != destinationSet.toString())
              {
                int arrowOffsetX = (int)(-nodeWidth/2 * Math.cos(angle));
                int arrowOffsetY = (int)(-nodeWidth/2 * Math.sin(angle));
                
                line(x1, y1+verticalOffset, x2+arrowOffsetX, y2+arrowOffsetY+verticalOffset);
                text(symbol,(x1+x2)/2 , (y1+y2)/2 + verticalOffset);
                
                // Draw triangle in correct place by rotating and translating
                pushMatrix();
                translate(x2 + arrowOffsetX, y2 + arrowOffsetY+verticalOffset);                                 
                rotate((float)Math.PI/2 + angle);
                triangle(tx1,ty1, tx2, ty23, tx3, ty23);
                popMatrix();
              }
              
              // Add symbol to array of loopSymbols
              else{
                loopSymbols.add(symbol);
              }
           }
       }
       
      // Add "Loops" text on the right side if transition goes to the same node
      if(loopSymbols.size()>0){
         text("loops: " + loopSymbols, xCoordsNDFA[i] + 0.75*nodeWidth, yCoordsNDFA[i]);
      }
       
      // Draw arrow for initial state
      for (State inState : automata.initialState)
      {
        for (State currentState : stateSet)
        { 
          
          if(currentState.id == inState.id)
          {
            System.out.println("HERE");
            line(xCoordsDFA[i] - 1.2*nodeWidth,yCoordsDFA[i],xCoordsDFA[i]- 0.5*nodeWidth,yCoordsDFA[i]);
            pushMatrix();
            translate(xCoordsDFA[i] - 0.5*nodeWidth, yCoordsDFA[i]);                                 
            rotate((float)Math.PI/2);
            triangle(tx1,ty1, tx2, ty23, tx3, ty23);
            popMatrix();
          }
          break;
        }
       break;
      }
       
       
       fill(255,165,0);
       ellipse(xCoordsDFA[i], yCoordsDFA[i], nodeWidth, nodeWidth);
       
       // Draw rectange representing set from NDFA
       rect(xCoordsDFA[i] - nodeWidth/2, yCoordsDFA[i] + nodeWidth/2, nodeWidth, nodeWidth/3);
       
       fill(0);
       textSize(12);
       text(stateSet.toString(), xCoordsDFA[i] - nodeWidth/3  - textOffsetX, yCoordsDFA[i] + 3*nodeWidth/4);
       textSize(16);
       text("c" + i, xCoordsDFA[i]  - textOffsetX, yCoordsDFA[i] + textOffsetY);
       
      //Draw circle outline for states that contain any of the final states
      for (State currentState : stateSet)
      { 
        for (State acState : automata.finalStates)
        {
          if(currentState.id == acState.id)
          {
            fill(0,0,0,1);
            ellipse(xCoordsDFA[i], yCoordsDFA[i], nodeWidth-10, nodeWidth-10);
            break;
          }
        }
      }
      fill(0);
      i++;
    }
}
