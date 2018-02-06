
//Change subjectID!!!
int subjectID=50;

PDPGUI gui;
PDPPushButton pbNext, pbBack;
PDPVAS vas, vas1, vas2, vas3, vas4, vas5, vas6, vas7, vas8, vas9, vas10, vas11, vas12, vas13, vas14, vas15, vas16, vas17, vas18, vas19, vas20, vas21, vas22, vas23, vas24, vas25;

import java.util.LinkedList;
import java.util.List;
  int screen=1;
  float [] Results =new float[30];
  String progress;
  Table saveResults=new Table();
  TableRow newRow = saveResults.addRow();
  String filePath = "data/Subject_";
  
void setup() {
   pbNext=new PDPPushButton(width-350,height-200,300,100,"Næste");
   pbBack=new PDPPushButton(50,height-200,300,100,"Tilbage");
  
   fullScreen();
   strokeWeight(6);
   gui=new PDPGUI();
  
  vas1=new PDPVAS(467,180,1800,150,"Jeg synes robotten stoppede...","Alt for tæt på","Alt for langt væk");
  vas2=new PDPVAS(467,530,1800,150,"Jeg synes, at robottens hastighed er...","Alt for langsom","Alt for hurtig");
  vas3=new PDPVAS(467,880,1800,150,"Jeg synes, at robottens højde er...","Alt for lav","Alt for høj");
  vas4=new PDPVAS(467,180,1800,150,"Jeg føler, at robotten kan hjælpe mig","Helt uenig","Helt enig");
  vas5=new PDPVAS(467,530,1800,150,"Jeg synes, at robotten stod i vejen","Helt uenig","Helt enig");
  vas6=new PDPVAS(467,880,1800,150,"Jeg føler mig tryg ved robotten","Helt uenig","Helt enig");
  vas7=new PDPVAS(467,180,1800,150,"Robotten gjorde mig forskrækket","Helt uenig","Helt enig");
  vas8=new PDPVAS(467,530,1800,150,"Jeg kan godt lide at blive betjent af robotten","Helt uenig","Helt enig");  
  vas9=new PDPVAS(467,880,1800,150,"Jeg regnede med, at robotten fulgte mig hen til det sted jeg valgte","Helt uenig","Helt enig");
  vas10=new PDPVAS(467,180,1800,150,"Hvor personlig oplevede du robottens hjælp?","Slet ikke personlig","Ekstremt personlig");
  vas11=new PDPVAS(467,530,1800,150,"Hvor overrasket blev du over robottens henvendelse?","Slet ikke overrasket","Ekstremt overrasket");
  vas23=new PDPVAS(467,180,1800,150,"Hvordan synes du skærmen reagerede?","Ekstremt dårligt","Ekstremt godt");
  vas12=new PDPVAS(467,530,1800,150,"Hvordan oplevede du robotten?","Ekstremt afvisende","Ekstremt imødekommende");
  vas13=new PDPVAS(467,880,1800,150,"Hvordan var det at bruge robotten?","Ekstremt svært","Ekstremt nemt");  
  vas14=new PDPVAS(467,1230,1800,150,"Hvordan oplevede du robottens bevægelser?","Ekstremt rolige","Ekstremt vilde");
  vas15=new PDPVAS(467,180,1800,150,"Hvad synes du om robotten?","Slet ikke irriterende","Ekstremt irriterende");
  vas16=new PDPVAS(467,530,1800,150,"","Slet ikke elegant","Ekstremt elegant");
  vas17=new PDPVAS(467,880,1800,150,"","Slet ikke spændende","Ekstremt spændende");
  vas18=new PDPVAS(467,1230,1800,150,"","Slet ikke sød","Ekstremt sød");
  vas19=new PDPVAS(467,180,1800,150,"Hvad synes du ellers om robotten?","Slet ikke sej","Ekstremt sej");
  vas20=new PDPVAS(467,530,1800,150,"","Slet ikke anmassende","Ekstremt anmassende");
  vas21=new PDPVAS(467,880,1800,150,"","Slet ikke sjov","Ekstremt sjov");
  vas22=new PDPVAS(467,1230,1800,150,"","Slet ikke menneskelig","Ekstremt menneskelig");
  
  
   saveResults.addColumn("ID");
   saveResults.addColumn("Age");
   saveResults.addColumn("Sex");
   saveResults.addColumn("Travel");
   saveResults.addColumn("Height");
   saveResults.addColumn("Tech");
   saveResults.addColumn("Q1");
   saveResults.addColumn("Q2");
   saveResults.addColumn("Q3");
   saveResults.addColumn("Q4");
   saveResults.addColumn("Q5");
   saveResults.addColumn("Q6");
   saveResults.addColumn("Q7");
   saveResults.addColumn("Q8");
   saveResults.addColumn("Q9");
   saveResults.addColumn("Q10");
   saveResults.addColumn("Q11");
   saveResults.addColumn("Q12");
   saveResults.addColumn("Q13");
   saveResults.addColumn("Q14");  
   saveResults.addColumn("Q15");
   saveResults.addColumn("Q16");
   saveResults.addColumn("Q17");
   saveResults.addColumn("Q18");
   saveResults.addColumn("Q19");
   saveResults.addColumn("Q20");
   saveResults.addColumn("Q21");
   saveResults.addColumn("Q22");
   saveResults.addColumn("Q23");
   saveResults.addColumn("Q24");   
}

void draw() {
  if(screen==1){   
   gui.update();
   progress="Side " + screen + " af 7";
   text(progress, 1367,height-150);
   line(1367, 210+150/2,1367,150+150/2);
   line(1367, 560+150/2,1367,500+150/2);
   line(1367, 910+150/2,1367,850+150/2);
   line(1367, 1260+150/2,1367,1200+150/2);
   gui.addWidget(vas23);
   gui.addWidget(vas12);
   gui.addWidget(vas13);
   gui.addWidget(vas14);
   gui.addWidget(pbNext);
   //gui.addWidget(pbBack);
   if (pbNext.isClicked()) {
     Results[22]=vas23.getResult();
     Results[11]=vas12.getResult();
     Results[12]=vas13.getResult();   
     Results[13]=vas14.getResult();
     newRow.setFloat("Q23",  Results[22]);
     newRow.setFloat("Q12", Results[11]);
     newRow.setFloat("Q13", Results[12]);
     newRow.setFloat("Q14", Results[13]);
  
 saveTable (saveResults, filePath + subjectID + ".csv");
     screen = screen + 1;
     gui.removeWidget(vas);
   } 
   }

  if(screen==2){
   gui.update();
   progress="Side " + screen + " af 7";
   text(progress, 1367,height-150);
   line(1367, 210+150/2,1367,150+150/2);
   
   line(1367, 560+150/2,1367,500+150/2);
   text("Fin",1367,530+(150/2)+100);
   
   line(1367, 910+150/2,1367,850+150/2);
   text("Fin",1367,880+(150/2)+100);   
  
   gui.addWidget(vas1);
   gui.addWidget(vas2);
   gui.addWidget(vas3);
   gui.addWidget(pbNext);
   gui.addWidget(pbBack);
   
   if (pbNext.isClicked()) {
   Results[0]=vas1.getResult();
   Results[1]=vas2.getResult();   
   Results[2]=vas3.getResult();
  newRow.setFloat("Q1",  Results[0]);
  newRow.setFloat("Q2", Results[1]);
  newRow.setFloat("Q3", Results[2]);
  
 saveTable (saveResults, filePath + subjectID + ".csv");
    screen = screen + 1;
     println(screen);
     gui.removeWidget(vas); 
   }
   if (pbBack.isClicked()) {
   screen=screen-1;
   gui.removeWidget(vas); 
   }
  }
 
 
 if(screen==3){   
   gui.update();
   progress="Side " + screen + " af 7";
   text(progress, 1367,height-150);    
   line(1367, 210+150/2,1367,150+150/2);
   line(1367, 560+150/2,1367,500+150/2);
   line(1367, 910+150/2,1367,850+150/2);
   gui.addWidget(vas4);
   gui.addWidget(vas5);
   gui.addWidget(vas6);
   gui.addWidget(pbBack);
   gui.addWidget(pbNext);
   if (pbNext.isClicked()) {
      Results[3]=vas4.getResult();
      Results[4]=vas5.getResult();   
      Results[5]=vas6.getResult();
      newRow.setFloat("Q4",  Results[3]);
      newRow.setFloat("Q5", Results[4]);
      newRow.setFloat("Q6", Results[5]);
      saveTable (saveResults, filePath + subjectID + ".csv");
      screen = screen + 1;
      gui.removeWidget(vas);
   }
  if (pbBack.isClicked()) {
      screen=screen-1;
      gui.removeWidget(vas); 
   }
}
if(screen==4){   
   gui.update();
   progress="Side " + screen + " af 7";
    text(progress, 1367,height-150);
    
   line(1367, 210+150/2,1367,150+150/2);
   
   line(1367, 560+150/2,1367,500+150/2);
   line(1367, 910+150/2,1367,850+150/2);
//    gui.removeWidget(vas);
   gui.addWidget(vas7);
   gui.addWidget(vas8);
   gui.addWidget(vas9);
   gui.addWidget(pbNext);
   gui.addWidget(pbBack);
   if (pbNext.isClicked()) {
     Results[6]=vas7.getResult();
   Results[7]=vas8.getResult();   
   Results[8]=vas9.getResult();
  newRow.setFloat("Q7",  Results[6]);
  newRow.setFloat("Q8", Results[7]);
  newRow.setFloat("Q9", Results[8]);
  
 saveTable (saveResults, filePath + subjectID + ".csv");
     screen = screen + 1;
     gui.removeWidget(vas);
   
   }
  if (pbBack.isClicked()) {
   screen=screen-1;
   gui.removeWidget(vas); 
   }
   
}
if(screen==5){   
   gui.update();
   progress="Side " + screen + " af 7";
    text(progress, 1367,height-150);
   //    gui.removeWidget(vas);
   gui.addWidget(vas10);
   gui.addWidget(vas11);
   gui.addWidget(pbNext);
   gui.addWidget(pbBack);
   if (pbNext.isClicked()) {
     screen = screen + 1;
     gui.removeWidget(vas);
     Results[9]=vas10.getResult();
   Results[10]=vas11.getResult();
  newRow.setFloat("Q10",  Results[9]);
  newRow.setFloat("Q11", Results[10]);
  
 saveTable (saveResults, filePath + subjectID + ".csv");
   } 
  if (pbBack.isClicked()) {
   screen=screen-1;
   gui.removeWidget(vas); 
   }
}
  
  if(screen==6){   
   gui.update();
   progress="Side " + screen + " af 7";
    text(progress, 1367,height-150);
    // gui.removeWidget(vas);
   gui.addWidget(vas15);
   gui.addWidget(vas16);
   gui.addWidget(vas17);
   gui.addWidget(vas18);
   
   gui.addWidget(pbNext);
   gui.addWidget(pbBack);
   if (pbNext.isClicked()) {
     screen = screen + 1;
     Results[14]=vas15.getResult();
   Results[15]=vas16.getResult();   
   Results[16]=vas17.getResult();
   Results[17]=vas18.getResult();
  newRow.setFloat("Q15",  Results[14]);
  newRow.setFloat("Q16", Results[15]);
  newRow.setFloat("Q17", Results[16]);
  newRow.setFloat("Q18", Results[17]);
  
 saveTable (saveResults, filePath + subjectID + ".csv");
     gui.removeWidget(vas);
   
   }
     if (pbBack.isClicked()) {
   screen=screen-1;
   gui.removeWidget(vas); 
   }
} 
  if(screen==7){   
   gui.update();
   progress="Side " + screen + " af 7";
    text(progress, 1367,height-150);
   
 //gui.removeWidget(vas);
   gui.addWidget(vas19);
   gui.addWidget(vas20);
   gui.addWidget(vas21);
   gui.addWidget(vas22);
   
   gui.addWidget(pbNext);
   gui.addWidget(pbBack);
   if (pbNext.isClicked()) {
    screen = screen + 1;
     Results[18]=vas19.getResult();
     Results[19]=vas20.getResult();
   Results[20]=vas21.getResult();   
   Results[21]=vas22.getResult();
  newRow.setFloat("Q19",  Results[18]);
  newRow.setFloat("Q20",  Results[19]);
  newRow.setFloat("Q21", Results[20]);
  newRow.setFloat("Q22", Results[21]);
 saveTable (saveResults, filePath + subjectID + ".csv");
     gui.removeWidget(vas); 
  
 }
    if (pbBack.isClicked()) {
   screen=screen-1;
   gui.removeWidget(vas); 
   }
  }
  if(screen==8){
    background(255);
    textSize(80);
    text("Tak for hjælpen!",1367,912);
  } 
}