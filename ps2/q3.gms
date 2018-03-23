$ title Museum Site Planing

nonnegative variables x0     x-axis of center of museum,
                      y0     y-axis of center of museum,
                      r      radius of building;
variable
                      z;

equations cons1,
          cons2,
          cons3,
          cons4,
          cons5,
          obj;

cons1..   500-y0=g= 50;
cons2..   abs(2/3*x0+y0-700)/sqrt(13/9)-r=g=50;
cons3..   abs(3*x0-y0-1500)/sqrt(10)-r=g= 50;
cons4..   x0-r=g= 50;
cons5..   y0-r=g= 50;
obj..     r=e=z;


model q3/
         cons1,
         cons2,
         cons3,
         cons4,
         cons5,
         obj/;

solve q3 using DNLP maximazing  z ;

display z.L, x0.L, y0.L;
