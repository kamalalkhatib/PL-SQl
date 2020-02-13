We need to avoid hard coding for the fowwlowing reasons:
1- avoid repeating our code.
2- avoid making same changes in different places.
in this PL/SQL function i will show how to avoid hard coding in the follwing topics:
1- Data type defining in pl/sql 
2- SQL statemnets
3- Constant values and business rules 

function f_hr_calc(p_st_dt date,p_ed_dt date,p_emp_id employee.emp_id%type,p_pos_id position.pos_id%type)
return number
       is
1- Data type:
	(1)							     (2)
-- Hard coding							Not Hard Coding
v_em_w_hr number(5,2);					v_em_w_hr emp_wk_hr.day_hr%type;	

if we define coulmns in PL/SQL like the hard coding way then if we change the data type in the base table later, we need to go everywhere
 and redefine this variable to be comptible with the new changes. But if we define the variable   
 the same way as not hard coding, then we don't need to make any changes in our pl/sql code.
begin
2- SQL statements inside PL/SQL:
	(1)							    (2)
-- Hard Coding							Not Hard Coding
select sum(day_hr) into v_em_w_hr			v_em_w_hr:=sal_select_sts_pkg.emp_sum_hrs(p_emp_id,p_st_dt,p_ed_dt);
from emp_wk_hr
where from_hr>=to_date(p_st_dt)
and to_hr<=to_date(p_ed_dt)
and  emp_id=p_emp_id;

If we write an SQL statement inside our executable code that's considered hard coding, because if we make any change on the base table
we need to go everywhere and modify all the relevant SQL statements. Also we repeat writing the same SQL statement in different places.
-- To avoid doing that I created a package that contains the required sql statements then when we change the base table or the sql statemnet
-- we need to make changes in one place, inside the sub-program.

3- Constant values and business rules:
	(1)								(2)
-- Hard Coding							   Not Hard Coding
if v_em_w_hr>40 then					v_basic_hrs:=default_values_pkg.v_basic_hrs;--get the basic hours
v_ov_tm_sal:=(v_em_w_hr-40)*(v_pos_sal_hr*1.5);		-- getting emp salary
							v_emp_sal:=default_values_pke.sal_calc_equation(v_em_w_hr,v_pos_sal_hr);	
v_tot_tm_sal:=(40*v_pos_sal_hr)+v_ov_tm_sal;
else
v_tot_tm_sal:=(v_em_w_hr*v_pos_sal_hr);
end if;
return v_tot_tm_sal; 
end;  
To avoid hard coding and repeating the code, I created a package constains all constant values and business rules, 
so if we need to change anything we just change this package instead of making changes everywhere. 
