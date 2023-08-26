//Capture the Sticky Note
//Bennett's Version

//Game data
int round = 1;
int roundSeed = 0;
int attempts = 0;
int percent = 0; //Amount of note covered
boolean roundOver = false;
boolean checkForCapture = false;

//Values' data
int valueBoxClicked = 0;
int [] value = new int[4];

//for celebratory message
float successMessageOpacity = 0;
float successMessageRotation = 0;
float successMessageSize = 0;
String successCaptureMessage = "GOOD JOB";

//Ellipse's data
int ellipseX, ellipseY, ellipseW, ellipseH;
color ellipseColor = color(random(255),random(255),random(255));

//Award data (has an extra slot that will not display - for sorting purposes)
int award[] = {0,0,0,0,0,0}; // 2: 7+ tries / 3: 4+ tries / 4: 2+ trues / 5: 1 try / 1: big chungus (total size > 120x120)

//Grid data
int gridOpacity = 0;
boolean usedGrid = false;

void setup()
{
  size(700,600);
  roundSeed = int(random(1000));
}

void draw()
{
  background(150);
  
  drawGameBox();
  drawGrid();
  placeTarget(roundSeed);
  drawEllipse();
  drawHUD();
  drawTitle();
  drawAwards();
  drawButtons();
  drawEllipseInput();
  
  if(checkForCapture)
    getPercent(); //don't want to loadPixels() every frame
  
  if(roundOver)
  {
    drawCelebration();
  }
}

//Draws box the note and ellipse appear in
void drawGameBox()
{
  fill(220,90,50);
  rect(25,95,510,310);
  fill(230);
  rect(30,100,500,300);
}

//Draws the ellipse
void drawEllipse()
{
  fill(ellipseColor);
  ellipse(ellipseX+25,ellipseY+95,ellipseW,ellipseH);
}

//Draws the cheater's grid (fades away)
void drawGrid()
{
  push();
  if( gridOpacity > 0 )
    gridOpacity-=3;
  stroke( 0, gridOpacity );
  for( int i = 0; i < 500; i += 50 )
    line(30+i,100,30+i,400);
  for( int i = 0; i < 400; i += 50 )
    line(30,100+i,530,100+i);
  pop();
}

//Places the sticky note based on round's seed
void placeTarget(int roundNumber)
{
  randomSeed(roundNumber * 97);
  fill(255, 255, 136);
  noStroke();
  float note = min(470, 200) / 10;
  rect(random(470 - note) + 30,
       random(200 - note) + 100,
       note,
       note );
  fill(255);
  stroke(0);
}

//Draws the game title
void drawTitle()
{
  push();
  stroke(0);
  strokeWeight(5);
  line(20,60,680,60);
  fill(220,90,50);
  textSize(57);
  text("Capture the Sticky Note!",15,55);
  pop(); 
}

//Draws the awards the player has won
void drawAwards()
{
  push();
  for( int i = 0; i < 5; i++ )
  {
    fill(220,90,50);
    rect(575,95+100*i,80,80);
    fill(120);
    rect(580,100+100*i,70,70);
  }
  pop();
  
  for( int i = 0; i < award.length-1; i++ )
  {
    push();
    textAlign(CENTER,CENTER);
    if( award[i] == 2 ) //Bronze
    {
      textSize(35);
      fill(#824A02);
      ellipse(615,135+100*i,60,60);
      fill(#A77044);
      ellipse(615,135+100*i,50,50);
      fill(#824A02);
      text("C",614,131+100*i);
    }
    if( award[i] == 3 ) //Silver
    {
      textSize(40);
      fill(#D7D7D7);
      ellipse(615,135+100*i,65,65);
      fill(#A7A7AD);
      ellipse(615,135+100*i,55,55);
      fill(#D7D7D7);
      text("B",615,130+100*i);
    }
    if( award[i] == 4 ) //Gold
    {
      textSize(45);
      fill(#D6AF36);
      ellipse(615,135+100*i,70,70);
      fill(#FEE101);
      ellipse(615,135+100*i,60,60);
      fill(#D6AF36);
      text("A",616,129+100*i);
    }
    if( award[i] == 5 ) //Platinum
    {
      textSize(50);
      fill(255);
      ellipse(615,135+100*i,75,75);
      fill(230);
      ellipse(615,135+100*i,65,65);
      fill(#D6AF36);
      text("S",615,128+100*i);
    }
    if( award[i] == 1 ) //Big Chungus
    {
      textSize(15);
      fill(#f59ace);
      ellipse(615,135+100*i,96,90);
      fill(#979696);
      ellipse(615,135+100*i,77,83);
      fill(#f59ace);
      text("BIG\nCHUNGUS\nAWARD",615,130+100*i);
    }
    pop();
  }
}

//Draws game data (blue box)
void drawHUD()
{
  //Cover ellipse that extends outside of box
  push();
  fill(150);
  noStroke();
  rect(0,0,25,height);
  rect(0,0,width,95);
  rect(0,405,width,height);
  rect(535,0,width,height);
  pop();
  
  //Progress Report
  push();
  strokeWeight(3);
  fill(50,50,250);
  rect(26,65,508,30);
  fill(0,255,0);
  textSize(20);
  text("Attempts: "+attempts,35,88);
  text("Round: "+round,205,88);
  text("Percent: "+percent+"%",375,88);
  pop();
  
  //Awards
  push();
  fill(0,0,100);
  textSize(20);
  text("Awards",580,90);
  pop();
}

//Draws the three buttons
void drawButtons()
{
  push();
  textSize(30);
  
  //Capture! button
  if( mouseX > 45 && mouseX < 245 && mouseY > 525 && mouseY < 585 && mousePressed )
    fill(50,150,50);
  else
    fill(50,200,50);
  rect(45,525,200,60,10);
  fill(0);
  text("Capture!",83,565);
  
  //Next Round button
  if( mouseX > 315 && mouseX < 515 && mouseY > 525 && mouseY < 585 && mousePressed )
    fill(150,50,50);
  else
    fill(200,50,50);
  rect(315,525,200,60,10);
  fill(0);
  text("New Round", 333,565);
  pop();
  
  //Grid Button
  fill(250,220,150);
  rect(265,540,30,30);
  stroke(100);
  for(int i = 5; i < 30; i+=5)
  {
    line( 265+i, 540, 265+i, 570 );
    line( 265, 540+i, 295, 540+i ); 
  }
}

//Draws the current inputs for the ellipse command
void drawEllipseInput()
{
  push();
  fill(0);
  textSize(55);
  text("ellipse(",10,485);
  text(");",530,485);
  
  //Draws boxes and then numbers
  fill(255);
  rect(200,442,80,50);
  rect(282.5,442,80,50);
  rect(365,442,80,50);
  rect(447.5,442,80,50);
  textSize(40); fill(0);
  text( value[0], 200,485);
  text( value[1], 282.5,485);
  if( value[2]*value[3] > 14400 ) fill(#f59ace); //Chungus warning
  text( value[2], 365,485);
  text( value[3], 447.5,485);
  
  if( valueBoxClicked > 0 ) //0 is no box; only highlights existing boxes
  {
    noFill();
    strokeWeight(4);
    stroke(0,0,250);
    rect(200+82.5*(valueBoxClicked-1),442,80,50);
  }
  
  //Commas
  fill(0);
  text(",",273,495);
  text(",",355.5,495);
  text(",",438,495);
  pop();
}

//Changes the selected box
void changeBox( int box )
{
  valueBoxClicked = box;
  if( valueBoxClicked == 0 )
    return;
  value[ valueBoxClicked-1 ] = 0;
}

//Player pushed capture button
void attemptCapture()
{
  attempts++;
  ellipseX = value[0];
  ellipseY = value[1];
  ellipseW = value[2];
  ellipseH = value[3];
  checkForCapture = true;
}

//Determines percent of sticky note colored pixels covered by ellipse
void getPercent()
{
  int totalPixels = 0;
  loadPixels();
  for(int i = 0; i < pixels.length; i++)
  {
    if( red(pixels[i]) == 255.0    //pixel matches
    &&  green(pixels[i]) == 255.0  //color of
    &&  blue(pixels[i]) == 136.0 ) //sticky note
      totalPixels++;
  }
  percent = int(100 - ( totalPixels/361.0*100 ) );
  
  if( percent >= 100 && !roundOver )
  {
    cueCelebration();
  }
}

//Begins the celebratory message
void cueCelebration()
{
  roundOver = true;
  successMessageOpacity = 500;
  successMessageRotation = 8*PI;
  successMessageSize = 0;
  giveAward();
}

//Determines the award and puts it in the correct spot on the wall
void giveAward()
{
  int awardToGive = 0; //<>//
  if( value[2]*value[3] > 14400 )     awardToGive = 1; //ellipse was too big
  else if( attempts >= 7 )            awardToGive = 2;
  else if( attempts >= 4 )            awardToGive = 3;
  else if( attempts >= 2 || usedGrid) awardToGive = 4; //can't perfect when using grid
  else                                awardToGive = 5;
  
  award[5] = awardToGive;
  int tempAward = 0;
  
  for(int i = 5; i > 0; i--) //sorts awards
  {
    if( award[i] > award[i-1] )
    {
      tempAward = award[i];
      award[i] = award[i-1];
      award[i-1] = tempAward;
    }
  }
}

//Resets data for a new round
void startNewRound()
{
  round++;
  roundSeed = int( random( 1000 ) );
  value[0]=value[1]=value[2]=value[3]=ellipseX=ellipseY=ellipseW=ellipseH=0;
  attempts = 0;
  ellipseColor = color( random(255), random(255), random(255) );
  roundOver = false;
  usedGrid = false;
  successCaptureMessage = randomMessage();
}

//Draws the celebratory text
void drawCelebration()
{
  successMessageOpacity-=2;
  if( successMessageRotation > 0 )
    successMessageRotation-=0.2;
  if( successMessageSize < 80 )
    successMessageSize+=0.5;
  
  push();
  textAlign(CENTER,CENTER);
  textSize(successMessageSize);
  translate(width/2,height/2);
  rotate(max(0,successMessageRotation));
  fill( random(250),random(250),random(250), successMessageOpacity );
  text(successCaptureMessage,0,0);
  pop();
}

//Selects a random victory message for next round
String randomMessage()
{
  switch( int( random(15) ) )
  {
    case 0: return "SUCCESS!";
    case 1: return "CAPTURED!";
    case 2: return "FULLY COVERED!";
    case 3: return "A WINNER IS YOU!";
    case 4: return "NOTE GET!";
    case 5: return "YOU GOT IT!";
    case 6: return "100%";
    case 7: return "MISSION\nCOMPLETE!";
    case 8: return "BIG BRAIN PLAY!";
    case 9: return "POSTING Ws!";
    default: return "GOOD JOB!";
  }
}

//Determines if the mouse is in a rectangle created by these parameters
boolean mouseInBox( float x, float y, float w, float h )
{
  if( mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h )
    return true;
  return false;
}

void mousePressed()
{
  //Checks for if you clicked in a box
  if( mouseInBox( 200,442,80,50 ) ) //x-box
    changeBox(1);
  else if( mouseInBox( 282.5,442,80,50 ) ) //y-box
    changeBox(2);
  else if( mouseInBox( 365,442,80,50 ) ) //width-box
    changeBox(3);
  else if( mouseInBox( 447.5,442,80,50 ) ) //height-box
    changeBox(4);
  else              // clicked outside box; de-selects
    changeBox(0);
    
  //Checks for if you clicked a button
  if( mouseInBox( 45,525,200,60 ) ) //Capture Button
    if( !roundOver )
      attemptCapture();
  if( mouseInBox( 315,525,200,60 ) ) //New Round
    startNewRound();
  if( mouseInBox( 265,540,30,30 ) ) //Grid
  {
    gridOpacity = 253;
    usedGrid = true;
  }
}//

void keyPressed()
{
  if( keyCode == ENTER ) //hitting enter de-selects the box
    changeBox(0);
  if( valueBoxClicked != 0 && (key-'0')<10 && (key-'0')>=0 ) //a legitimate box is selected and key was a number
  {
    //Increase decimal
    value[ valueBoxClicked-1 ] *= 10;
    //Add value
    value[ valueBoxClicked-1 ] += (key-'0');
    
    //De-select if third digit entered
    if( value[ valueBoxClicked-1 ] > 99 )
      changeBox(0);
  }
}
