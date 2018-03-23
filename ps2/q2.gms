$ title Construction with Constraints


nonnegative variables x1       workers of Project 1 in 1st month,
                      x2       workers of Project 1 in 2nd month,
                      x3       workers of Project 1 in 3rd month,
                      y1       workers of Project 2 in 1st month,
                      y2       workers of Project 2 in 2nd month,
                      y3       workers of Project 2 in 3rd month,
                      y4       workers of Project 2 in 4th month,
                      z1       workers of Project 3 in 1st month,
                      z2       workers of Project 3 in 2nd month;

variable z;

equations cons1,
          cons2,
          cons3,
          cons4,
          cons5,
          cons6,
          cons7,
          cons8,
          obj;

cons1..  x1+x2+x3=e=8;
cons2..  y1+y2=e=10;
cons3..  z1+z2=e=12;
cons4..  x1+y1+z1=l=8;
cons5..  x2+y2+z2=l=8;
cons6..  x3+y3=l=8;
cons7..  y4=l=8;
cons8..  y4=g=8;
obj..    y4=e=z;

 x1.UP=6;
 x2.UP=6;
 x3.UP=6;
 y1.UP=6;
 y2.UP=6;
 y3.UP=6;
 y4.UP=6;
 z1.UP=6;
 z2.UP=6;


model q2/
         cons1,
         cons2,
         cons3,
         cons4,
         cons5,
         cons6,
         cons7,
         cons8,
         obj/;

solve q2 using LP minimizing z;

display   x1.L,x2.L,x3.L,y1.L,y2.L,y3.L,y4.L,z1.L,z2.L;
