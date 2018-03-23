$title Voltage Smooting

set      t       time /1*200/;


Parameter a(t)/
$ondelim
$include voltages.csv
$offdelim
/;

parameter lambda;
parameter report;
variables
         z       smooth
         dis     distance between fitted value and observed value
         f(t)    fitted value provided by model
         OBJ     Objective function: sum of squares;


equations objdef, edef, vardef;
vardef..       z   =e= sum(t,sqr(f(t) - f(t-1)));
objdef..       OBJ =e= lambda*z+(1-lambda)*dis;
edef..         dis =e= sum(t, sqr(f(t)-a(t)));

model q1 /all/;

set      tof /1*11/;

loop(tof,
lambda=(tof.val-1)/10;
solve q1 using nlp minimizing OBJ;
report(tof,t)=f.l(t)+eps;
)

execute_unload
'p1.gdx',report;
display report;