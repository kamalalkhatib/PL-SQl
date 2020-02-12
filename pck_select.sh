create or replace package sal_select_sts_pkg
    as
    function pos_sum_ded_fun(p_empid employee.emp_id%type)return number;
    function emp_ded_period_fun (p_empid employee.emp_id%type,p_st_dt date,p_ed_dt date)return number;
    function pos_sum_all_fun(p_empid employee.emp_id%type)return number;
    function emp_all_period_fun(p_empid employee.emp_id%type,p_st_dt date,p_ed_dt date)return number;
function emp_sum_hrs(p_emp_id employee.emp_id%type,p_st_dt date,p_ed_dt date)return number;
function pos_sal(p_emp_id employee.emp_id%type)return number;
   end;
 
   create or replace package body sal_select_sts_pkg
    as
    function pos_sum_ded_fun(p_empid employee.emp_id%type)return number
    is
    v_pos_ded_sum pos_ded.amount%type;
    begin
    if p_empid is null then
    raise_application_error(-20001,'null p_empid is not allowed');
    end if;
   select nvl(sum(amount),0) into v_pos_ded_sum from POS_DED
                         where
                         pos_id=(select pos_id from emp_pos where emp_id=p_empid and end_date is null);
   return v_pos_ded_sum;
   exception when others then
   error_vals_pkg.err_pos_ded_pro(p_empid,v_pos_ded_sum,sysdate);
   raise;
   end;
   function emp_ded_period_fun (p_empid employee.emp_id%type,p_st_dt date,p_ed_dt date)return number
   is
   v_em_ded_sum emp_ded.amount%type;
   begin
   select sum(amount) into v_em_ded_sum from emp_ded where
                         (ded_date>= p_st_dt and ded_date <=p_ed_dt)
                          and emp_id=p_empid;
                 return v_em_ded_sum;
   exception when others then
   error_vals_pkg.err_emp_ded_pro(p_empid,v_em_ded_sum,p_st_dt,p_ed_dt);
   raise;
   end;
   function pos_sum_all_fun(p_empid employee.emp_id%type)return number
   is
   v_pos_all_sum pos_all.amount%type;
   begin
   if p_empid is null then
   raise_application_error(-20001,'null p_empid is not allowed');
   end if;
   select nvl(sum(amount),0) into v_pos_all_sum from POS_all
                         where
                         pos_id=(select pos_id from emp_pos where emp_id=p_empid and end_date is null);
   return v_pos_all_sum;
   exception when others then
   error_vals_pkg.err_pos_ded_pro(p_empid,v_pos_all_sum,sysdate);
   raise;
   end;
   function emp_all_period_fun (p_empid employee.emp_id%type,p_st_dt date,p_ed_dt date)return number
   is
   v_em_all_sum emp_all.amount%type;
   begin
   select sum(amount) into v_em_all_sum from emp_all where
                         (all_date>= p_st_dt and all_date <=p_ed_dt)
                          and emp_id=p_empid;
                 return v_em_all_sum;
   exception when others then
   error_vals_pkg.err_emp_ded_pro(p_empid,v_em_all_sum,p_st_dt,p_ed_dt);
   raise;
   end;
   function emp_sum_hrs(p_emp_id employee.emp_id%type,p_st_dt date,p_ed_dt date)return number
   is
              v_em_w_hr emp_wk_hr.day_hr%type;-- emp work hours/week
            begin
           select sum(day_hr) into v_em_w_hr
               from emp_wk_hr
                   where from_hr>=to_date(p_st_dt)
                   and to_hr<=to_date(p_ed_dt)
                   and  emp_id=p_emp_id;
    return v_em_w_hr;
    end;
   function pos_sal(p_emp_id employee.emp_id%type)return number
   is
   v_pos_sal_hr position.pos_sal_hr%type;
   begin
           select pos_sal_hr into v_pos_sal_hr
           from position
                   where pos_id=(select pos_id from emp_pos where emp_id=p_emp_id and end_date is null);
   return v_pos_sal_hr;
   end;
  end sal_select_sts_pkg;
