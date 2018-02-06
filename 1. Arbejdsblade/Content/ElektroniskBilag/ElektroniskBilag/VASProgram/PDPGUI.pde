/**
 * The PDPGUI has two purposes only. It is a container of a number of PDPWidgets
 * from which all the specific PDP widgets enherit. The widgets are added
 * dynamically using Java's LinkedList class. Secondly, PDPGUI is responsible for
 * redrawing all the added widgets. This means that update() must be called at
 * least once from the main program's draw() function. It also means that the
 * application programmer should never call the widgets' own update() functions
 * explicitly.
 */


class PDPGUI {
   List<PDPWidget> w=new LinkedList<PDPWidget>();
   
   void addWidget(PDPWidget _w) {
      w.add(_w); // Widget dynamically added to the linked list - nice!
   }
  
   void removeWidget(PDPWidget _w) {
      w.clear(); // Widget dynamically added to the linked list - nice!
 }
   
 
 
   
   void update() {
      background(255); // This and all other colours in PDPGUI is inspired by Motif
    for (PDPWidget wCurrent : w) wCurrent.update(); // Display all widgets
   }
}