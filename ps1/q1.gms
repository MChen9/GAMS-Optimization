nonnegative variables
x1, x2, x3;
variables z      Objective level;

equations
condef   Constraint definition,
objdef   Objective defination;

 x1.UP= 3;
 x2.UP= 3;
 x3.UP= 3;
condef.. 2*x1-x2-x3=G= 0;
objdef.. 5*x1-x2+11*x3=e= z;

model q1/
condef,
objdef/ ;

option LP=cplex;

solve q1 using LP maximazing z;
parameter report;

report('X1','cplex') = X1.L;
report('X2','cplex') = X2.L;
report('X3','cplex') = X3.L;
report('Z','cplex') = Z.L;

option LP=minos;

solve q1 using LP maximazing z;


report('X1','MINOS') = X1.L;
report('X2','MINOS') = X2.L;
report('X3','MINOS') = X3.L;
report('Z','MINOS') = Z.L;

option LP=baron;

solve q1 using LP maximazing z;

report('X1','baron') = X1.L;
report('X2','baron') = X2.L;
report('X3','baron') = X3.L;
report('Z','baron') = Z.L;

display report;