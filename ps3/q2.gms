$ title building a stadium

free variable T completion time,
              T1 REDUCTION TIME;

set activity /
A        Installing the construction site,
B        Terracing,
C        Constructing the foundations,
D        Access roads and other networks,
E        Erecting the basement,
F        Main floor,
G        Dividing up the changing rooms,
H        Electrifying the terraces,
I        Constructing the roof,
J        Lighting of the stadium,
K        Installing the terraces,
L        Sealing the roof,
M        Finishing the changing rooms,
N        Constructing the ticket office,
O        Secondary access roads,
P        Means of signalling,
Q        Lawn and sport accessories,
R        Handing over the building /;

alias (activity,i,j);

parameter duration(activity) 'in days' /
A 2, B 16, C 9, D 8, E 10, F 6, G 2, H 2, I 9, J 5, K 3,
L 2, M 1 , N 7, O 4, P 3,  Q 9, R 1/;

set prec(i,j) 'Precedence order' /
A.B, B.(C,D), C.E, (D,E).F, D.G, F.H, (D,F).I, D.J, F.K,
I.L, G.M, B.N, (D,N).O, (H,K,N).P, L.Q, Q.R/;

parameter maxr(activity) 'max reduction' /
A 0, B 3, C 1, D 2, E 2, F 1, G 1, H 0, I 2, J 1, K 1,
L 0, M 0 , N 2, O 2, P 1,  Q 3, R 0/;

parameter rec(activity) 'reduction cost' /
A 0, B 30, C 26, D 12, E 17, F 15, G 8, H 0, I 42, J 21,
K 18, L 0, M 0, N 22, O 12, P 6, Q 16, R 0/;

nonnegative variables
s(i)         starting time of activity i
reducedtime(i);

variable
z            cost of all reduction;

equations
ctime(i) Completion time,  ptime(i,j) Sequence,
rtime1(i) Reduction time,   prof   profit,
ptime1(i,j)    ;

ctime(i)..         T =g= S(i) + duration(i);
ptime(prec(i,j)).. S(i) + duration(i)=L= S(j);
rtime1(i)..         T1 =g= S(i) + duration(i)-maxr(i);
ptime1(prec(i,j))..  S(i) + duration(i)-reducedtime(i)=l= s(j);
prof..             z =e= 30*(64-T1) - sum(i, reducedtime(i)*rec(i));
reducedtime.up(i)=maxr(i);
*EQUATIONS ctime(i) Completion time, ptime(i,j) Sequence;
*ctime(i).. T =g= S(i) + duration(i);
*ptime(prec(i,j)).. S(i) + duration(i) =L= S(j);

model q3_a
/ctime, ptime/;

solve q3_a using lp minimizing T;

display T.L;

model q3_c
/rtime1,ptime1,prof/;

solve  q3_c using lp maximizing z;

display T1.L,z.L;


set R /0*22/;
parameter report1;
parameter tra(R)/0        0
1        1
2        2
3        3
4        4
5        5
6        6
7        7
8        8
9        9
10        10
11        11
12        12
13        13
14        14
15        15
16        16
17        17
18        18
19        19
20        20
21        21
22        22
/;
parameter redu/1 1/;

variable redcost;

equations
         obj3
         ctime3(i)
         tc
         ptime3(i,j);
ctime3(i)..   T =g= S(i) + duration(i)-maxr(i);
tc..          T=e=64-redu("1");
ptime3(prec(i,j)).. S(i) + duration(i)-maxr(i) =L= S(j);
obj3..    redcost=e=sum(activity,maxr(activity)*rec(activity));

model q2_b/obj3,ctime3,tc,ptime3/;
loop (r,
redu("1")=tra(r);

solve q2_b using LP minimizing redcost;
report1(r,"cost")=redcost.l;



)
;
display report1





