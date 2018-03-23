$title Retail Profits

sets     m/jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec/
         d/dm,em/
         i/joe,ed,harriet,mabel/
         w/wi,ai/;


table de(m,d)   demand
                 dm      em
         jan     10      1
         feb     10      1
         mar     10      1
         apr     20      1
         may     30      1
         jun     20      1
         jul     20      1
         aug     20      1
         sep     40      1
         oct     100     1
         nov     120     0.5
         dec     200     0.25;

table wa(i,w)    wage
                 wi      ai
         joe     0.341   0.270
         ed      0.170   0.155
         harriet 0.136   0.117
         mabel   0.102   0.083;


nonnegative variables    dmp(m)    reference demand,
                         pr(m)     monthly price,
                         c         monthly wage costs
                         h(i,m)    working hours,
                         s(m)      monthly sales;

variable
          p         annual profits;



equations        demandcurve,wagecosts,sales,salesupb,profit,cons1,cons2,cons3,cons4,cons5;
demandcurve(m)..    dmp(m) =e= de(m,'dm')*(1-de(m,'em')*(pr(m)-1));
wagecosts(m)..      c(m) =e= sum(i,wa(i,'wi')*h(i,m));
sales(m)..          s(m) =e= dmp(m);
salesupb(m)..       s(m) =l= sum(i,wa(i,'ai')*h(i,m));
profit..            p =e= sum(m,s(m)*pr(m)-c(m));
cons1(i,m)..        h(i,m) =l= 100;
cons2(i,m)..        h(i,m) =l= 720;
cons3(m+1)..        sum(i,h(i,m+1)) =g= sum(i,h(i,m))*0.8;
cons4..             sum(i,h(i,'jan')) =g= sum(i,h(i,'dec'))*0.8;
cons5(m+1)..        pr(m+1) =l= pr(m)*1.5;



model q2_1/demandcurve,wagecosts,sales,salesupb,profit,cons1/;
solve q2_1 using nlp maximizing p;

parameter profit1;
profit1 = p.l;

display profit1;

model q2_2/demandcurve,wagecosts,sales,salesupb,profit,cons2/;
solve q2_2 using nlp maximazing p;

parameter premium;
premium = p.l - profit1;

display premium;

model q2_3/demandcurve,wagecosts,sales,salesupb,profit,cons1,cons3,cons4/;
solve q2_3 using nlp maximazing p;

model q2_4/demandcurve,wagecosts,sales,salesupb,profit,cons1,cons5/;
solve q2_4 using nlp maximazing p;




