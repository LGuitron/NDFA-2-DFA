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
int nodeRadius;
int distFromCenter;
int textOffsetX;
int textOffsetY;

// NDFA automata visual parameters
int centerX_NDFA;
int centerY_NDFA;

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
 
  textColor = color(0);
  textSize(16);
  
  rectMode(CORNER);
  textAlign(LEFT);
  
  textBoxes = new TextBox[5];
  instantiateBox(0, "Cuantos estados tiene su AFND?");
  instantiateBox(1, "Introduce el indice del estado inicial");
  instantiateBox(2, "Introduce los indices de los estados de aceptacion separados por comas");
  instantiateBox(3, "Introduce los simbolos del alfabeto separados por coma");
  
  
  for (int i=0; i<4; i++){
    textBoxes[i].isFocused = true;
  }
  
  infoX = width/30;
  infoY = height/20;
  
  statesNDFA   = "[]";
  initialState = "";
  finalStates  = "[]";
  alphabet     = "[]"; 
  
  nodeRadius     = 60;
  distFromCenter = 150;
  
  textOffsetX = 10;
  textOffsetY = 5;
  
  centerX_NDFA = width/4;
  centerY_NDFA = 2*height/3;
}

void draw() {
  update(mouseX, mouseY);
  background(102);
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
  
  text("Q = " + statesNDFA, infoX , infoY);
  text("q0 = " + initialState, infoX , 2*infoY); 
  text("F = " + finalStates, infoX , 3*infoY); 
  text("Sigma = " + alphabet, infoX , 4*infoY); 
  
  fill(255,165,0);
  drawNDFA();
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
      }
      else if(state == stateInitialStateBox){
        initialState = automata.setInitialStateGUI(Integer.parseInt(txt)); 
      }
      else if(state == stateFinalStateBox){
        finalStates = automata.setAcceptanceStatesGUI(txt); 
      }
      else if(state == alphabetStateBox){
        alphabet = automata.setAlphabetGUI(txt); 
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



//========================
// Function for drawing automata
void drawNDFA()
{
  if (automata.statesNDFA.size()>0)
  {
    //Angle difference between nodes
    double deltaAngle =  2*Math.PI/automata.statesNDFA.size();
    double currentAngle = 0;
    for (State state : automata.statesNDFA)
    {
      int offsetX = (int)(distFromCenter*Math.cos(currentAngle));
      int offsetY = (int)(distFromCenter*Math.sin(currentAngle));
      ellipse(centerX_NDFA + offsetX, centerY_NDFA + offsetY, nodeRadius, nodeRadius);
      fill(0);
      text(state.toString(), centerX_NDFA + offsetX - textOffsetX , centerY_NDFA + offsetY + textOffsetY); 
      fill(255,165,0);
      currentAngle += deltaAngle;
    }
  }
}
