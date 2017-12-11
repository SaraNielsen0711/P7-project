class PDPVAS extends PDPWidget {
   String sLeftTickLabel,sRightTickLabel;
   int nVerticalCenter,nLeftTickCenter,nRightTickCenter,nResult,result;
   PImage imCross;
   PDPVAS(int nX,int nY,int nWidth,int nHeight,String sLabel,String _sLeftTickLabel,String _sRightTickLabel) {
      super(nX,nY,nWidth,nHeight,sLabel);
      sLeftTickLabel=_sLeftTickLabel;
      sRightTickLabel=_sRightTickLabel;
      nVerticalCenter=nY+nHeight/2;
      nLeftTickCenter=(int)(nX+0*nWidth); // Hardcoded to 0% inside the line
      nRightTickCenter=(int)(nX+1*nWidth); // Hardcoded to 100% inside the line
      nResult=-1;
    //imCross=loadImage("cross.png");
   }
   void update() {
      stroke(0);
      line(nX,nVerticalCenter,nX+nWidth,nVerticalCenter); // The vertical line
      line(nLeftTickCenter,nVerticalCenter-50,nLeftTickCenter,nVerticalCenter+50); // Left tick mark
      line(nRightTickCenter,nVerticalCenter-50,nRightTickCenter,nVerticalCenter+50); // Right tick mark
      fill(0);
      textAlign(CENTER);
      textSize(nFontSize);
      text(sLabel,nX+nWidth/2,nVerticalCenter-80);      
      text(sLeftTickLabel,nLeftTickCenter,nVerticalCenter+100); // Left tick label
      text(sRightTickLabel,nRightTickCenter,nVerticalCenter+100); // Right tick label
      if (nResult!=-1) {
         stroke(255,100,100);
         line(nResult,nVerticalCenter-20,nResult,nVerticalCenter+20); // Small cross
      //   line(nResult+4,nVerticalCenter-4,nResult-4,nVerticalCenter+4);
      }
      stroke(0);
      if (isClicked()) { 
        nResult=mouseX;
     result=int((mouseX-467)*0.055555); 
      }
      cursor(CROSS);
   }
   int getResult() {
      return result; // nResult should probably be converted to percentage or the like...
   }
}