$title Spline Fitting
set r /1*200/,
    xy/x,y/;

table l(r,xy)
$ondelim
$include xy_data.csv
$offdelim
;

parameter
         x(r)    x axis of data,
         y(r)    y axis of data;
x(r)=l(r,'x');
y(r)=l(r,'y');

variables        obj     objective function
                 a0,a1,a2,a3
                 f(r)    fitted value;

equations  objdef, fitdef;
objdef..       obj =e= sum(r,sqr(y(r)-f(r)));
fitdef(r)..    f(r) =e= a3*x(r)*x(r)*x(r)+a2*x(r)*x(r)+a1*x(r)+a0;

f.FX('1') = 0;
model q2_1/all/;
solve q2_1 using qcp minimizing OBJ;

variables        obj1    objective1 function
                 f1(r)   fitted value
                 p0,p1,p2,q0,q1,q2;

equations fit1, fit2, svalue, sslope, obj1def;
fit1(r)$(x(r)<=4)..  f1(r) =e= p2*x(r)*x(r)+p1*x(r)+p0;
fit2(r)$(x(r)>4)..   f1(r) =e= q2*x(r)*x(r)+q1*x(r)+q0;
svalue..             16*p2+4*p1+p0 =e= 16*q2+4*q1+q0;
sslope..             8*p2+p1 =e= 8*q2+q1;
obj1def..            obj1 =e= sum(r,sqr(y(r)-f1(r)));

model q2_2/fit1, fit2, svalue, sslope, obj1def/;
solve q2_2 using NLP minimizing obj1;