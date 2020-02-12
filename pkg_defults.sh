-- This package shows how we can define values for constants 
-- then we can use them in different equations   
create or replace package default_values_pkg
                 as
                 function basic_hrs_fun return number;
         function over_time_sal return number;
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
                 end default_values_pkg;
