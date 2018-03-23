$ title car rental

set i /1*10/
    xy /x,y/
    ;
alias(i,j);

table  data(i,xy)
      x   y
1     0   0
2     20  20
3     18  10
4     30  12
5     35  0
6     33  25
7     5   27
8     5   10
9     11  0
10    2   15

parameter
         r(j) 'required cars'
         /1 10, 2 6, 3 8, 4 11, 5 9, 6 7, 7 15, 8 7, 9 9, 10 12/;

parameter
         p(j) 'cars present'
         /1 8, 2 13, 3 4, 4 8, 5 12, 6 2, 7 14, 8 11, 9 15, 10 7/;

parameter

         dist(i,j)= sqrt(sum(xy,sqr(data(i,xy)-data(i,xy)));
         x(i,j)   transporting cars from each position;


nonnegative variables
C Total Shipping cost;


equations
supply(j),
cost,
cons(i);

cons(i)..   x(i,j)=e= p(j)-r(j);
supply(j).. r(j)=e=p(j)+sum(i,x(i,j));
cost..   c   =e=sum((i,j),0.5*1.3*dist(i,j)*x(i,j));

model q4 /all/;

solve q4 using lp minimizing  c;

display c.L;




