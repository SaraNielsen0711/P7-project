/**
 * Abstract super class for all widgets in the PDPGUI system. It holds all
 * the basic information and functionality of a widget. The update() method
 * has no body and is declared abstract. This means that all classes that
 * enherits from PDPWidget must contain its own update() method (override)
 * or else a compiler error appears. A PDPWidget should never be declared
 * by the application programmer. It is considered good programming style
 * to write "@Override" in a line just above the update() methods in the
 * subclasses.
 */

abstract class PDPWidget {
   int nX,nY,nWidth,nHeight,nFontSize,nTextXPos,nTextYPos;
   boolean bChecked,bEnabled;
   String sLabel;
   PDPWidget(int _nX,int _nY,int _nWidth,int _nHeight,String _sLabel) {
      bChecked=false;
      bEnabled=true;
      nX=_nX;
      nY=_nY;
      nWidth=_nWidth;
      nHeight=_nHeight;
      nFontSize=35;
      sLabel=_sLabel;

 }
   boolean isMouseInside() {
      if (!bEnabled) return false;
      if ((mouseX>nX) && (mouseX<nX+nWidth) && (mouseY>nY) && (mouseY<nY+nHeight)) return true;
      return false;
   }
   boolean isChecked() {
      return bChecked;
   }
   boolean isClicked() {
      if (isMouseInside() && mousePressed) {
         mousePressed=false;
         return true;
      }
      return false;
   }
   void toggleEnabled() {
      if (bEnabled) bEnabled=false;
      else bEnabled=true;
   }
   abstract void update();
}