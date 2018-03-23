$ title Electricity grid with storage
set       t      time of a day
                 /1am*12am,
                  1pm*12pm/;

nonnegative variables
          a(t)      electricity in battery;

variable  z      ,
         c(t)     change of electricity in battery;

nonnegative variables       x(t)     hourly purchase electricity below 50MWh,
                y(t)     hourly purchase electricity beyond 50MWh;





parameter dem(t)

                   /1am 43, 2am 40, 3am 36, 4am 36, 5am 35, 6am 38,
                    7am 41, 8am 46, 9am 49, 10am 48, 11am 47, 12am 47,
                    1pm 48, 2pm 46, 3pm 45, 4pm 47, 5pm 50, 6pm 63,
                    7pm 75, 8pm 75, 9pm 72, 10pm 66, 11pm 57, 12pm 50 /;


equations
cons1(t),
cons2(t),
cons3(t),
cons4(t),
obj
aup(t);

cons1(t)..     x(t)=L= 50;
cons2(t)..     x(t)+y(t)=L= 65;
cons3(t)..     x(t)+y(t)=e=dem(t)+c(t);
cons4(t)..     a(t)=e=a(t-1)*0.99+c(t);
obj..          152400-sum(t,x(t)*100+y(t)*400) =E=z;

aup(t)..         a(t)=l=30;
y.up(t)=15;

model q4/
         cons1,
         cons2,

         cons3,
         cons4,
         obj,
         aup/;

solve q4 using LP maximizing z;
           display z.L

model q4_b/
         cons1,
         cons2,
         cons3,
         cons4,
         obj/;
solve q4_b using LP maximizing z;
display z.L;


