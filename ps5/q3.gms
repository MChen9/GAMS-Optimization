$title  Frighter Navigation Data

set     t       Time points      /1*72/
        ka(t)    Way points times /20,50,60/
        kb(t)                    /21,51,61/;
set xy /x,y/;
table xwA(ka,xy) Waypoints xy
                x       y
        20      4       3
        50      7       -1
        60      1       1;

table xwB(kb,xy)
   x y
21 4 3
51 7 -1
61 1 1;

parameter
           l/0.001/,
           d/0.01/;

parameter loc(t,xy) ;
loc(t,xy)=0;
variables OBJ Objective function,
X(t,xy) Location,
V(t,xy) Velocity,
U(t,xy) Acceleration;

equations  objdef, xdef, vdef, xc;
objdef..        obj =e= sum((t,xy),sqr(u(t,xy)))-sum(t,l*log(sum(xy,sqr(X(t,xy)-loc(t,xy)))+d));
xdef(t+1,xy)..  X(t+1,xy) =e= X(t,xy) + V(t,xy);
vdef(t+1,xy)..  V(t+1,xy) =e= V(t,xy) + U(t,xy);
xc(xy)..        X('72',xy)=e=X('1',xy);

model q3 /all/;
parameter sA,sB ;
set itr/1*10/;
l=0;

loop(itr,
X.FX("1",xy) = 1;
X.FX(ka,xy) = xwA(ka,xy);
solve q3 using NLP minimizing OBJ;
l=0.001;
loc(t,xy) = X.L(t,xy);
sA(t,xy)=x.L(t,xy);
x.up(t,xy)=+inf;
x.lo(t,xy)=-inf;
X.FX("2",xy) = 1;  X.FX(kb,xy) = xwB(kb,xy);
solve q3 using NLP minimizing OBJ;
loc(t,xy) = X.L(t,xy);
sB(t,xy)=x.L(t,xy);
x.up(t,xy)=+inf;
x.lo(t,xy)=-inf;
);
display sa,sb;