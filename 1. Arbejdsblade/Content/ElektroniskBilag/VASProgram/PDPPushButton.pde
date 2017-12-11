/**
 * PDPPushButton enherits from PDPWidget. Unlike other widgets it changes its
 * colour if clicked on; see update2() and update(). bChecked is always false.
 * We also use bChecked although in principle a push button cannot be checked.
 * Instead we use bChecked by update2() as a notifier to isClicked(). This
 * means that the button wasn't clicked at the exact moment that isClicked()
 * was called but when update2() registered the click. If we don't do it like
 * that then we don't see (graphically) the click unless isClicked() is called
 * which is bad design. In other words; the push button looks clicked even
 * if isClicked() is never called.
 */

class PDPPushButton extends PDPWidget {
   boolean bClickish;
   PDPPushButton(int nX,int nY,int nWidth,int nHeight,String sLabel) {
      super(nX,nY,nWidth,nHeight,sLabel);
      nTextXPos=nX+nWidth/2;
      nTextYPos=nY+nHeight/2+nFontSize/3;
      bClickish=false;
   }
   void drawUpperLeftEdge(int nColour) {
      if (bEnabled) stroke(nColour);
      else stroke(nColour,nColour,nColour,75);
      line(nX,nY,nX+nWidth,nY);
      line(nX+1,nY+1,nX+nWidth-1,nY+1);      
      line(nX,nY,nX,nY+nHeight);
      line(nX+1,nY+1,nX+1,nY+nHeight-1);
   }
   void drawLowerRightEdge(int nColour) {
      if (bEnabled) stroke(nColour);
      else stroke(nColour,nColour,nColour,75);
      line(nX+1,nY+nHeight,nX+nWidth,nY+nHeight);
      line(nX+2,nY+nHeight-1,nX+nWidth,nY+nHeight-1);
      line(nX+nWidth,nY+1,nX+nWidth,nY+nHeight);
      line(nX+nWidth-1,nY+2,nX+nWidth-1,nY+nHeight);
   }
   void update2() {
      noStroke();
      rectMode(CORNER);
      rect(nX,nY,nWidth,nHeight);
      if (super.isClicked()) {
         bClickish=true;
         bChecked=true; // Used in the sense was-clicked
      }
      if (bClickish) {
         bClickish=false;
         drawUpperLeftEdge(83);
         drawLowerRightEdge(214);
      }
      else {      
         drawUpperLeftEdge(214);
         drawLowerRightEdge(83);
      }
      if (bEnabled) fill(0); // Black label
      else fill(0,0,0,75);
      textAlign(CENTER);
      textSize(nFontSize);
      text(sLabel,nTextXPos,nTextYPos);
   }
   @Override
   boolean isClicked() {
      if (bChecked) { // Used in the sense was-clicked
         bChecked=false;
         bClickish=true; // Makes impression of "pushed"
         return true; 
      }     
      return false;
   }
   @Override
   void update() {
      if (isMouseInside()) fill(180); // Hover effect
      else {
         if (bEnabled) fill(160); // Default button colour
         else fill(160,160,160,75);
      }
      update2();
   }
}