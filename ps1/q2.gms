variables        Z       Objective value,
                 z1,z2,z3,z4     variables;

equations
con1 Constraint 1,
con2 Constraint 2,
con3 Constraint 3,
objdef Objective definition;

con1.. -z1+ 6*z2- z3+ z4=G= 3;
con2..      7*z2    + z4=E= 5;
con3..            z3+ z4=L= 2;
objdef..   3*z1-   z2        =E= z;

z2.UP=5;
z2.LO=-1;
z3.UP=5;
z3.LO=-1;
z4.UP=2;
z4.LO=-2;


model q2 /
con1,
con2,
con3
objdef/ ;

option LP=Cplex;

Solve q2 using LP maximizing z;

parameter report;

report('Z','orig') = Z.L;
report('Z1','orig') = Z1.L;
report('Z2','orig') = Z2.L;
report('Z3','orig') = Z3.L;
report('Z4','orig') = Z4.L;



variables
                 o;

nonnegative variables
                 a,a1,b,b1,c,c1,s1,s2,w,v;


equations
cons1,
cons2,
cons3,
cons4,
cons5,
cons6,
obj;

cons1..   -s1+ s2+ 6*a- b+ c- w =e= 10;
cons2..   7*a+ c =e= 14;
cons3..   b+ c+ v =e= 5;
cons4..   a+ a1 =e= 6;
cons5..   b+ b1 =e= 6;
cons6..   c+ c1 =e= 4;
obj..    -3*s1 +3*s2 +a -1 =e= o;

model q2_2/
cons1,cons2,cons3,cons4,cons5,cons6,obj/;

option LP=Cplex;

solve q2_2 using LP minimizing o;

report('Z','equal') = -o.L ;
report('Z1','equal') = s1.L-s2.L ;
report('Z2','equal') = a.L-1 ;
report('Z3','equal') = b.L-1;
report('Z4','equal') = c.L-2;

display report;
















