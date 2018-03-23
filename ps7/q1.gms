$title board game 22

set h/0*12/
    i/1*13/;

parameter peg(i)/1 1, 2 2, 3 3, 4 4, 5 5, 6 6, 7 7, 8 8, 9 9, 10 10, 11 11, 12 12,13 13 /;




binary variables        x(h,i);

variable         z;

set      s       solution/1*1000/;
set      cs(s);
cs(s)=no;
parameter zstar(s,h,i);
zstar(s,h,i)=0;



equations
trian1,trian2,trian3,trian4,trian5,trian6, cons1,cons2,objdef,cut;
trian1..         sum(i,x('1',i)*peg(i))+sum(i,x('3',i)*peg(i))+sum(i,x('4',i)*peg(i))=e= 22;
trian2..         sum(i,x('2',i)*peg(i))+sum(i,x('3',i)*peg(i))+sum(i,x('6',i)*peg(i))=e= 22;
trian3..         sum(i,x('6',i)*peg(i))+sum(i,x('8',i)*peg(i))+sum(i,x('9',i)*peg(i))=e= 22;
trian4..         sum(i,x('4',i)*peg(i))+sum(i,x('5',i)*peg(i))+sum(i,x('7',i)*peg(i))=e= 22;
trian5..         sum(i,x('7',i)*peg(i))+sum(i,x('10',i)*peg(i))+sum(i,x('11',i)*peg(i))=e= 22;
trian6..         sum(i,x('10',i)*peg(i))+sum(i,x('12',i)*peg(i))+sum(i,x('9',i)*peg(i))=e= 22;
cons1(h)..       sum(i,x(h,i))=e= 1;
cons2(i)..       sum(h,x(h,i))=e= 1;
objdef..         sum((h,i),x(h,i))=e= z;
cut(cs)..        sum((h,i)$zstar(cs,h,i), x(h,i)) =L= sum((h,i)$zstar(cs,h,i),1) - 1;



model q1_a /all/;

parameter count(i);
count(i)=0;
*h.fx('1','1')=1;
scalar run /1/
loop(s$run,
         solve q1_a using MIP minimizing z;
         cs(s)=yes;
         zstar(cs(s),h,i)=x.l(h,i);
         if  ((q1_a.modelstat eq 10),run=0);
         count(i)$x.l('0',i)=count(i)$x.l('0',i)+1;
);
count(i)$x.l('0',i)=count(i)$x.l('0',i)-1;
options count:0:0:1;
display count;



