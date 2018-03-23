$stitle Read Data for Stigler's Diet Problem

set     n       Nutrients /
        "Calories (1000)",
        "Protein (g)",
        "Calcium (g)",
        "Iron (mg)",
        "Vitamin A (1000 IU)",
        "Thiamine (mg)",
        "Riboflavin (mg)",
        "Niacin (mg)",
        "Ascorbic Acid (mg)"/;

set     f       Foods /
        "Wheat Flour (Enriched)",
        "Macaroni",
        "Wheat Cereal (Enriched)",
        "Corn Flakes",
        "Corn Meal",
        "Hominy Grits",
        "Rice",
        "Rolled Oats",
        "White Bread (Enriched)",
        "Whole Wheat Bread",
        "Rye Bread",
        "Pound Cake",
        "Soda Crackers",
        "Milk",
        "Evaporated Milk (can)",
        "Butter",
        "Oleomargarine",
        "Eggs",
        "Cheese (Cheddar)",
        "Cream",
        "Peanut Butter",
        "Mayonnaise",
        "Crisco",
        "Lard",
        "Sirloin Steak",
        "Round Steak",
        "Rib Roast",
        "Chuck Roast",
        "Plate",
        "Liver (Beef)",
        "Leg of Lamb",
        "Lamb Chops (Rib)",
        "Pork Chops",
        "Pork Loin Roast",
        "Bacon",
        "Ham, smoked",
        "Salt Pork",
        "Roasting Chicken",
        "Veal Cutlets",
        "Salmon, Pink (can)",
        "Apples",
        "Bananas",
        "Lemons",
        "Oranges",
        "Green Beans",
        "Cabbage",
        "Carrots",
        "Celery",
        "Lettuce",
        "Onions",
        "Potatoes",
        "Spinach",
        "Sweet Potatoes",
        "Peaches (can)",
        "Pears (can)",
        "Pineapple (can)",
        "Asparagus (can)",
        "Green Beans (can)",
        "Pork and Beans (can)",
        "Corn (can)",
        "Peas (can)",
        "Tomatoes (can)",
        "Tomato Soup (can)",
        "Peaches, Dried",
        "Prunes, Dried",
        "Raisins, Dried",
        "Peas, Dried",
        "Lima Beans, Dried",
        "Navy Beans, Dried",
        "Coffee",
        "Tea",
        "Cocoa",
        "Chocolate",
        "Sugar",
        "Corn Syrup",
        "Molasses",
        "Strawberry Preserves" /;

set     rows    Rows of data /
        set.f
        "MINIMUM REQUIRED" /;

table   data(rows,n)    Input data
$ondelim
$include stigler.csv
$offdelim
;

parameter       a(f,n)  Food contents,
                r(n)    Requirements;

r(n) = data('MINIMUM REQUIRED',n);
a(f(rows),n) = data(rows,n);

set     diet /  REF     Unrestricted diet,
                  GF      Gluton-free diet,
                  V       Vegan
                VGF     Vegan and gluten-free/
        reportitems     / cost, set.f   /;
parameter       report(reportitems,diet) Summary report ($ per year);
set     seq /cost/;
*$include stiglerdata
variable        V(f)    Expenditure on food f (per day),
                COST    Total cost (per year);

nonnegative variable V;
equations costdef, requirement;
costdef..               COST =e= 365*sum(f,V(f));
requirement(n)..        sum(f, a(f,n)*V(f)) =g= r(n);
model stigler /all/;
solve stigler using lp minimizing cost;
parameter       results(*,*)    Model results;
$set scn ref
results('Cost','%scn%') = COST.L;
results(f,'%scn%') = 365*V.L(f);
set gluton(f)   Foods containing gluton /
        'Wheat Flour (Enriched)', 'Macaroni', 'Wheat Cereal (Enriched)',
        'White Bread (Enriched)', 'Whole Wheat Bread', 'Rye Bread',
        'Pound Cake', 'Soda Crackers' /;


V.UP(f) = inf$(not gluton(f));
solve stigler using lp minimizing cost;
$set scn GF
results('Cost','%scn%') = COST.L;
results(f,'%scn%') = 365*V.L(f);
set nonvegan(f) Non-vegan foods /
        'Milk', 'Evaporated Milk (can)', 'Butter', 'Oleomargarine', 'Eggs',
        'Cheese (Cheddar)', 'Cream', 'Mayonnaise', 'Lard', 'Sirloin Steak',
        'Round Steak', 'Rib Roast', 'Chuck Roast', 'Plate', 'Liver (Beef)',
        'Leg of Lamb', 'Lamb Chops (Rib)', 'Pork Chops', 'Pork Loin Roast',
        'Bacon', 'Ham, smoked', 'Salt Pork', 'Roasting Chicken',
        'Veal Cutlets', 'Salmon, Pink (can)' /;
V.UP(f) = inf$(not nonvegan(f));
solve stigler using lp minimizing cost;
$set    scn V

results('Cost','%scn%') = COST.L;
results(f,'%scn%') = 365*V.L(f);
V.UP(f) = inf$(not (gluton(f) or nonvegan(f)));
solve stigler using lp minimizing cost;
$set    scn VGF
results('Cost','%scn%') = COST.L;
results(f,'%scn%') = 365*V.L(f);
option results:1:1:1;
display results;

