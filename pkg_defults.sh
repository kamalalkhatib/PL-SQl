-- This package shows how we can define values for constants and equations
-- then we can use them in different places   
create or replace package default_values_pkg
                 as
                 function basic_hrs_fun return number;
	         function over_time_sal return number;
		 function sal_calc_equation(p_em_w_hr number,p_pos_sal_hr number) return number;
                end;
create or replace package body default_values_pkg
                 is
                 v_basic_hrs constant number default 40;
                 v_over_time_sal constant number(6,3) default 1.5;
                 function basic_hrs_fun return number
                         is
                 begin
                        return  v_basic_hrs;
                         end;
                 function over_time_sal return number
                 is
                 begin
                 return v_over_time_sal;
                 end;
		function sal_calc_equation(p_em_w_hr number,p_pos_sal_hr number) return number
		is
		v_ov_tm_sal emp_sal.net_sal%type;--over time sal
	        v_tot_tm_emp_sal.net_sal%type;--total time sal
		begin
            	  if v_em_w_hr>v_basic_hrs then
 	   	    v_ov_tm_sal:=(v_em_w_hr-v_basic_hrs)*(v_pos_sal_hr*v_over_time_sal);
 	   	    v_tot_tm_sal:=(v_basic_hrs*v_pos_sal_hr)+v_ov_tm_sal;
 	   	else
 	   	   v_tot_tm_sal:=(v_em_w_hr*v_pos_sal_hr);
 	   	end if;
 	   	return v_tot_tm_sal;
 	   	end;
                end default_values_pkg;
