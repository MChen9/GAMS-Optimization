set c    Crop type
         / wheat, corn /,
    r    Resource
         / labor, fertilizer /;
variables       Z       Profit level;

nonnegative
variables       X(c)    Planted acres of crop type c;

table   uti(c,r)
                  labor   fertilizer
        wheat       3          2
        corn        2          4;

parameter  res(r)/
         labor           100
         fertilizer      120/
           pro(c)/
         wheat           200
         corn            300/;

equations
con1        owned land,
con2(r)     labor fertilizer using,
obj;

con1..      sum(c,x(c))=l=45;
con2(r)..   sum(c,x(c)*uti(c,r))=l=res(r);
obj..       sum(C,x(c)*pro(c))=e=z;

model q3/
con1,
con2,
obj/;

option LP=Cplex;

solve q3 using LP maximazing z;

parameter report;





