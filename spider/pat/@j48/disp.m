function disp(b),
%% Function DISP(b)
%%
%% Shows a graphical representation of the tree in a separate window
%%
%% Usage: 
%%          a=j48;
%%          [r,a]=train(a,d);
%%          a.disp();
%%
jtmp = b.tree;
np = weka.gui.treevisualizer.PlaceNode2();
at = weka.gui.treevisualizer.TreeVisualizer([],jtmp.graph(),np);
at.setSize(800,600);
f = javax.swing.JFrame();
c = f.getContentPane();
c.add(at);
f.setSize(800,600);
f.setVisible(1);
