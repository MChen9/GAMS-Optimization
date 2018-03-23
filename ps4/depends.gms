*display warming;
*$exit
*$title depend

*DISPLAY warming;

variables        OBJ2    Objective2;
equations        objdef2;

objdef2..        OBJ2 =E= SUM(d,DEV(d)*DEV(d));

model L2/tdef,devub,devlb,objdef2/;
solve L2 USING nlp MINIMIZING OBJ2;
parameter       warming         Rate of warming (degrees F per century);
warming = X1.L*365.25*100;
display warming;

parameter       report         Rate of warming (degrees F per century);

*       Enter results for the L2 model:

$set mdl L2
report("%mdl%","warming") = X1.L*365.25*100;
report("%mdl%","season") = sqrt(sqr(X2.L)+sqr(X3.L));
report("%mdl%","solar")  = sqrt(sqr(X4.L)+sqr(X5.L));
report("%mdl%","X0") = X0.L;
report("%mdl%","X1") = X1.L;
report("%mdl%","X2") = X2.L;
report("%mdl%","X3") = X3.L;
report("%mdl%","X4") = X4.L;
report("%mdl%","X5") = X5.L;

display report;

variables        OBJ4    Objective4;
equation         objdef4;

objdef4..        OBJ4 =E= SUM(d,power(DEV(D),4));
model L4/tdef,devub,devlb,objdef4/;
solve L4 USING nlp Minimizing OBJ4;

parameter       warming         Rate of warming (degrees F per century);
warming = X1.L*365.25*100;
display warming;

parameter       report         Rate of warming (degrees F per century);

*       Enter results for the L4 model:

$set mdl L4
report("%mdl%","warming") = X1.L*365.25*100;
report("%mdl%","season") = sqrt(sqr(X2.L)+sqr(X3.L));
report("%mdl%","solar")  = sqrt(sqr(X4.L)+sqr(X5.L));
report("%mdl%","X0") = X0.L;
report("%mdl%","X1") = X1.L;
report("%mdl%","X2") = X2.L;
report("%mdl%","X3") = X3.L;
report("%mdl%","X4") = X4.L;
report("%mdl%","X5") = X5.L;

display report;

variables        OBJLinf Objectivelinf;
equation         objeflinf;

objeflinf(D)..   OBJLinf =G= DEV(D);
model Linf/tdef,devlb,devub,objeflinf/;
solve Linf Using lp Minimizing OBJLinf;

parameter       warming         Rate of warming (degrees F per century);
warming = X1.L*365.25*100;
display warming;

parameter       report         Rate of warming (degrees F per century);

*       Enter results for the Linf model:

$set mdl Linf
report("%mdl%","warming") = X1.L*365.25*100;
report("%mdl%","season") = sqrt(sqr(X2.L)+sqr(X3.L));
report("%mdl%","solar")  = sqrt(sqr(X4.L)+sqr(X5.L));
report("%mdl%","X0") = X0.L;
report("%mdl%","X1") = X1.L;
report("%mdl%","X2") = X2.L;
report("%mdl%","X3") = X3.L;
report("%mdl%","X4") = X4.L;
report("%mdl%","X5") = X5.L;

display report;
