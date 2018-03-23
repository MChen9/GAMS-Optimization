set      ch      Chemical elements
                 / C     "Carbon",
                  Cu     "Copper",
                  Mn     "Manganese"/,
         a       Material alloys
                 / i1*i3    "Iron alloys",
                   c1*c2    "Copper alloys",
                   al1*al2  "Alluminum alloys" /,
         lim     Limit
                 /min
                  max/ ;

variables        Z       Objective value;

nonnegative
variables        X(a)    Tons of materials used,
                 S       Produced steel;

table   cha(ch,lim)     Characteristics of Steel
                        min     max
                 C       2       3
                 Cu      0.4     0.6
                 Mn      1.2     1.65;

table   mat(a,ch)        Material
                               C   Cu     Mn
                         i1   2.5  0      1.3
                         i2   3    0      0.8
                         i3   0    0.3    0
                         c1   0    90     0
                         c2   0    96     4
                         al1  0    0.4    1.2
                         al2  0    0.6    0 ;

parameter             Avai(a)/
                        i1     400
                        i2     300
                        i3     600
                        c1     500
                        c2     200
                       al1     300
                       al2     250 /
                      Cost(a)/
                        i1     200
                        i2     250
                        i3     150
                        c1     220
                        c2     240
                       al1     200
                       al2     165/ ;

equations  con1(ch),con2(ch),con3(a),con4,obj;

con1(ch).. sum(a,X(a)*mat(a,ch))/500=l=cha(ch,'max');
con2(ch).. sum(a,X(a)*mat(a,ch))/500=g=cha(ch,'min');
con3(a).. X(a)=l=Avai(a);
con4.. sum(a,X(a))=e=500;
obj..  sum(a,X(a)*Cost(a))=e=z;

MODEL q4/
con1,
con2,
con3,
con4,
obj/ ;

option LP=Cplex;


solve q4 using LP minimizing z;


