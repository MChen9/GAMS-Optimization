$ title doodle scheduling

set t time of a day /t1*t13/,
    name / Manuel,Luca,Jule,Michael,Malte,Chris,Spyros,Mirjam,Matt,Florian,
Josep,Joel,Tom,Daniel,Anne/;

table data(name,t) scheduling data
       t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12 t13
Manuel  0  0  1  1  0  0  0  1  1  0   0   0   0
Luca    0  1  1  0  0  0  0  0  1  1   0   0   0
Jule    0  0  0  1  1  0  1  1  0  1   1   1   1
Michael 0  0  0  1  1  1  1  1  1  1   1   1   0
Malte   0  0  0  0  0  0  1  1  1  0   0   0   0
Chris   0  1  1  0  0  0  0  0  1  1   0   0   0
Spyros  0  0  0  1  1  1  1  0  0  0   0   0   0
Mirjam  1  1  0  0  0  0  0  0  0  0   1   1   1
Matt    1  1  1  0  0  0  0  0  0  1   1   0   0
Florian 0  0  0  0  0  0  0  1  1  0   0   0   0
Josep   0  0  0  0  0  0  1  1  1  0   0   0   0
Joel    1  1  0  0  0  1  1  1  1  0   0   1   1
Tom     1  1  1  0  1  1  0  0  0  0   0   1   1
Daniel  0  1  1  1  0  0  0  0  0  0   0   0   0
Anne    1  1  0  0  1  1  0  0  0  0   0   0   0   ;

nonnegative variables
sche(name,t),
time(t);

variable z;

equations
cons1(name), cons2(name), cons3(name),cons4(t),obj;
cons1(name).. sum(t, sche(name,t))=g=0;
cons2(name).. sum(t, sche(name,t))=l=1;
obj.. sum(name,sum(t, sche(name,t))) =e= z;
cons3(name).. sum(t,sche(name,t)*data(name,t))=e= 1;
cons4(t)..    sum(name,sche(name,t))=e= time(t);

time.up(t)=1;
time.up('t7')=3;

model q1/all/;

solve q1 using LP minimizing z;

parameter report;

report(name,t)  =   sche.L(name,t)
display report;






