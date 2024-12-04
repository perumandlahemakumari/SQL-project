--find the total no of employees for each job title
/*select
	count(BusinessEntityID) totalemployees,
	jobtitle
from HumanResources.Employee
group by jobtitle
order by totalemployees desc

select * from HumanResources.Department*/

--find total no of departmentid for each groupname in asc order provide details deptid
/*select 
	DepartmentId,
	count(departmentid) over(partition by groupname order by departmentid) totalgroupnames,
	name,
	groupname
from HumanResources.Department*/
 
 --join dept and dept history 
/*select
*
from HumanResources.Department as d
left join HumanResources.EmployeeDepartmentHistory as dh
on d.DepartmentID = dh.DepartmentID*/

/*select * from HumanResources.Employee*/

--total businessentityid per jobtitle
/*select
	businessentityid,
	organizationnode,
	jobtitle,
	count(businessentityid) over(partition by jobtitle) empperjobtitle
from HumanResources.Employee
order by empperjobtitle desc*/

--truncate modified date 
/*select
	businessentityid,
	jobtitle,
	birthdate,
	gender,
	datename(weekday,modifieddate) weekday,
	datepart(year,modifieddate) modifiedyear,
	datepart(year,BirthDate) as birthyear,
	EOMONTH(modifieddate) EndDateoOfMonth
from HumanResources.Employee*/

--find age of employees lessthan thirty and gender male, status single
/*select
	businessentityid,
	jobtitle,
	birthdate,
	gender,
	maritalstatus,
	datediff(year,birthdate,getdate()) age
from HumanResources.Employee
where gender = 'M' and MaritalStatus = 's'*/

--employee who taken more sickhours and provide jobtitle, businessid, gender
/*lect
	jobtitle,
	businessentityid,
	gender,
	sickleavehours
from HumanResources.Employee*/

--details about all departments where group name is sales & market
/*select * 
from hr.dept
where groupname = 'sales and marketing'*/

--count total no of names for each groupname and give details  of deptid  #windows func (count) 
/*select 
	DepartmentID,
	name,
	GroupName,
	count(name) over(partition by groupname order by departmentid) totalnames,
	count(name) over(partition by groupname) totalnamespergrpname
from hr.Dept*/

--to check duplicate rows
/*/select
	departmentid,
	count(*) over(partition by departmentid)
from hr.Dept*/

--value func lead,lag,firstvalue,lastvalue from hr.dept
/*select 
	*,
	lead(departmentid,2) over(partition by groupname order by modifieddate) lead,
	lag(departmentid,2) over(partition by groupname order by modifieddate) lag,
	first_value(departmentid) over(partition by groupname order by modifieddate) firstvalue,
	LAST_VALUE(departmentid) over(partition by groupname order by modifieddate) firstvalue
from hr.Dept*/

-- union dept and depthistory table by asc order of modified date
/*select
	departmentid,
	modifieddate
from hr.Dept
union
select
	departmentid,
	modifieddate
from hr.EmployeeDeptHistory
order by modifieddate*/
/*select
	departmentid,
	modifieddate
from hr.Dept
union all
select
	departmentid,
	modifieddate
from hr.EmployeeDeptHistory
order by modifieddate*/
/*select
	departmentid,
	modifieddate
from hr.Dept
except
select
	departmentid,
	modifieddate
from hr.EmployeeDeptHistory
order by modifieddate*/
/*select
	departmentid,
	modifieddate
from hr.Dept
intersect
select
	departmentid,
	modifieddate
from hr.EmployeeDeptHistory
order by modifieddate*/

--case when func
/*select
	*,
	case
		when GroupName='manufacturing' then 'eng'
		else groupname
	end grpnamenew
from hr.Dept*/
 
 --date & time func
 /*/select 
	DepartmentID,
	ModifiedDate,
	getdate() today,
	day(modifieddate) daynm,
	month(modifieddate) monthnm,
	year(modifieddate) yearnm,
	datepart(year,modifieddate) year_dp,
	datename(month,modifieddate) month_dp,
	datename(WEEKDAY,modifieddate) weekday_dnm,
	datename(DAY,modifieddate) day_dnm,
	datetrunc(MONTH,modifieddate) month_tr,
	EOMONTH(modifieddate) endofmonth
 from hr.Dept*/
/*select
	DepartmentID,
	ModifiedDate,
	format(ModifiedDate,'dd-MM-yyyy') modified_date,
	format(ModifiedDate,'yy') yy,
	format(ModifiedDate,'MMMM') Month_name,
	format(ModifiedDate,'dddd') day_name,
	convert(date,ModifiedDate) as datetimetodate,
	convert(varchar,ModifiedDate,32) as [date to varchar usa],
	convert(varchar,ModifiedDate,34) as [date to varchar eu]
	--cast('30-04-2008' as datetime)
from hr.Dept*/

/*select
	*,
	dateadd(month,6,ModifiedDate) as sixmonthsafter
from hr.Dept*/
/*select
	*,
	dateadd(month,6,ModifiedDate) as sixmonthsafter
from hr.Dept
where groupname='Quality Assurance'*/
/*select 
	*,
	datediff(year,ModifiedDate,getdate()) YearDiffUntilToday
from hr.Dept*/
/*select *
from
	(select
	groupname
	from hr.dept
	where name = 'production')t*/

/*with cte_total_businessid as
(
select
	*,
	count(DepartmentID) as totalid
from hr.Dept
group by groupname
)
select
d.departmentid,
d.name,
d.groupname,
ctb.totalid
from hr.Dept as d
left join cte_total_businessid as ctb
on d.DepartmentID = ctb.DepartmentID*/

--create view
/*
if object_id(hr_dept_view,'v') is not null
	drop view hr_dept_view
go
create view HR.hr_dept_view as
(
	select 
		*,
		count(departmentid) over(partition by groupname order by modifieddate) totaldepts
	from hr.Dept
)
select * from HR.hr_dept_view*/

/*select
	datetrunc(day,modifieddate) modified_date,
	departmentid,
	name,
	groupname
into hr_dept
from hr.Dept
select * from hr_dept*/
/*select 
*
into #temp_hr_dept
from hr.Dept;
select * from #temp_hr_dept;*/

/*create clustered index idx_dept_id on hr.dept(departmentid)
create index idx_name on hr.dept(name,groupname)*/

/*---aggregate func on hr.employee table
select * from hr.Employee
select count(OrganizationNode) num_of_orgn_nodes from hr.Employee 
select sum(VacationHours) totalvacationhours from hr.Employee 
select min(VacationHours) min_vacationhours from hr.Employee
select max(VacationHours) max_vacationhours from hr.Employee
select avg(SickLeaveHours) avg_SickLeaveHours from hr.Employee*/
 
---different techniques to fetch the table(top,limit,fetch first,row num)
/*select top 3 * from hr.Employee;
select top 50 percent * from hr.Employee;
select top 3 * from hr.Employee where gender = 'M';
select top 3 * from hr.Employee where gender = 'F' order by BusinessEntityID desc;
select top 3 * from hr.Employee order by BusinessEntityID desc;*/

--window function
---aggregate values
----total num of employees for each businessentityid in increasing order---------
/*select top 20
	*,
	count(*) over(partition by jobtitle order by businessentityid asc) totalemp
from hr.Employee*/

--find total vacationhours for all businessentityid,total vacationhours for each jobrole, and provide details businessentityid,jobtitle,gender,loginid,salaryflag
/*select
	businessentityid,
	jobtitle,
	gender,
	loginid,
	SalariedFlag,
	sum(vacationhours) over() total_vac_hrs,
	sum(vacationhours) over(partition by jobtitle) total_vac_hrs1
from hr.employee;
select
	businessentityid,
	jobtitle,
	gender,
	loginid,
	SalariedFlag,
	avg(vacationhours) over() avg_vac_hrs,
	avg(vacationhours) over(partition by jobtitle) avg_vac_hrs1
from hr.employee;
select
	businessentityid,
	jobtitle,
	gender,
	loginid,
	SalariedFlag,
	min(SickLeaveHours) over(partition by jobtitle order by salariedflag rows between current row and 2 following) min_sick_hrs,
	max(SickLeaveHours) over(partition by jobtitle) max_sick_hrs_per_jobtitle
from hr.employee
select * from hr.employee*/

---window func on rank
--select * from hr.Employee
/*select
	businessentityid,
	loginid,
	jobtitle,
	vacationhours,
	sickleavehours,
	row_number() over(partition by jobtitle order by vacationhours desc) vacation_ranks
from hr.Employee
select
	businessentityid,
	loginid,
	jobtitle,
	vacationhours,
	sickleavehours,
	rank() over(order by vacationhours desc) vacation_ranks
from hr.Employee
select
	businessentityid,
	loginid,
	jobtitle,
	vacationhours,
	sickleavehours,
	dense_rank() over(partition by jobtitle order by vacationhours desc) vacation_ranks
from hr.Employee*/

--rank employee with less vacationhours for each jobtitle
/*select 
	*
from(
select
	businessentityid,
	loginid,
	jobtitle,
	vacationhours,
	sickleavehours,
	row_number() over(partition by jobtitle order by vacationhours) rankbyvacation
from hr.Employee
)t where rankbyvacation = 1*/

--to find duplicates
/*select * 
from(
	select
	businessentityid,
	loginid,
	jobtitle,
	vacationhours,
	sickleavehours,
	row_number() over(partition by  businessentityid order by vacationhours) rn
from hr.Employee
)t where rn < 1*/

/*select * 
from(
	select
	businessentityid,
	loginid,
	jobtitle,
	vacationhours,
	sickleavehours,
	ntile(3) over(partition by jobtitle order by vacationhours) n_tile
from hr.Employee
)t*/

/*select *,
case
	when buckets=1 then 'high'
	when buckets=2 then 'medium'
	else buckets=3 then 'low'
end segments
from(
select
	businessentityid,
	loginid,
	jobtitle,
	vacationhours,
	sickleavehours,
	ntile(3) over(partition by jobtitle order by vacationhours desc) buckets
from hr.Employee
)t*/

/*select *,
concat(cume_dists*100,'%') dist_rankperc
from(
	select
		businessentityid,
		loginid,
		jobtitle,
		vacationhours,
		sickleavehours,
		cume_dist() over(partition by jobtitle order by vacationhours) cume_dists
	from hr.employee
	)t
where cume_dists < 0.4
select *,
concat(rank_perc*100,'%') rankperc
from(
	select
		businessentityid,
		loginid,
		jobtitle,
		vacationhours,
		sickleavehours,
		percent_rank() over(partition by jobtitle order by vacationhours) rank_perc
	from hr.employee
	)t
where rank_perc < 0.4*/

---window func on value func
/*select 
	businessentityid,
	loginid,
	jobtitle,
	vacationhours,
	sickleavehours,
	birthdate,
	lead(vacationhours) over(order by birthdate) lead_vac_hours,
	lag(vacationhours) over(order by birthdate) lag_vac_hours,
	last_value(businessentityid) over(order by birthdate) lastvalue,
	first_value(businessentityid) over(order by birthdate) firstvalue
from hr.employee*/
--select * from hr.employee
/*select
	businessentityid,
	loginid,
	jobtitle,
	vacationhours,
	sickleavehours,
	birthdate,
	first_value(vacationhours) over(order by birthdate desc) first_vac_hours,
	last_value(vacationhours) over(order by birthdate desc) last_vac_hours,
	first_value(vacationhours) over(order by birthdate desc) - VacationHours as vacationhours_diff
from hr.Employee*/

---sql set operators * unions
/*select
	businessentityid,
	modifieddate
from hr.Employee
union
select
	businessentityid,
	modifieddate
from hr.EmployeePayHistory*/
/*select
	businessentityid,
	modifieddate
from hr.Employee
union all
select
	businessentityid,
	modifieddate
from hr.EmployeePayHistory*/
/*select
	businessentityid,
	modifieddate
from hr.Employee
intersect
select
	businessentityid,
	modifieddate
from hr.EmployeePayHistory*/
/*select
	businessentityid,
	modifieddate
from hr.Employee
except
select
	businessentityid,
	modifieddate
from hr.EmployeePayHistory*/
--select * from hr.Employee

--handling nulls----
/*select top 10 
	*,
	case
		when organizationlevel is null then 0
		else organizationlevel
	end 'organizationlevel_clean',
	avg(case
			when organizationlevel is null then 0
			else organizationlevel
		end 'organizationlevel_clean') over() avg_orgn_level,
	avg(organizationlevel) over() avg_orgn_level2
from hr.Employee*/
/*select
	*,
	coalesce(organizationlevel,0) orgn_level2,
	avg(organizationlevel) over() orgn_level3,
	avg(coalesce(organizationlevel,0 )) over() orgn_level3
from hr.Employee*/
/*select
	*,
	coalesce(organizationlevel,0) + 1 increased_orgn_level
from hr.Employee*/
/*select
*,
coalesce(organizationlevel,999999)
from hr.Employee
order by coalesce(organizationlevel,999999)*/

/*select * from hr.employee where organizationlevel is null
select * from hr.employee where organizationlevel is not null*/
/*select 
	*, 
	isdate(birthdate) datecheck
from hr.Employee*/
--select * from hr.Employee
---FIND THE EMPLOYEE WHO HAS VACATIONHOURS MORE THAN AVG(VACATIONHOURS) OF ALL EMPLOYEESDETAILS
/*SELECT * 
FROM (
    SELECT 
        businessentityid, 
        vacationhours, 
        AVG(vacationhours) OVER() AS avghours 
    FROM hr.Employee
) t
WHERE vacationhours <= avghours;
SELECT 
    *, 
    RANK() OVER(ORDER BY sickleavehours) AS rank,
	MIN(sickleavehours) OVER() AS minsickhours
FROM hr.Employee;*/


----CREATE A CTE----
/*WITH cte_total_rate AS (
    SELECT
        businessentityid,
        SUM(rate) AS totalrate
    FROM
        hr.employeepayhistory
    GROUP BY
        businessentityid
)
SELECT
    e.businessentityid,
    e.jobtitle,
    e.hiredate,
    e.organizationlevel,
    ctr.totalrate
FROM
    hr.employee e
LEFT JOIN
    cte_total_rate ctr ON e.businessentityid = ctr.businessentityid*/

/*WITH cte_rate_summary AS (
	SELECT
		SUM(rate) AS totalrate,
		DATETRUNC(month, modifieddate) AS date,
		businessentityid,
		payfrequency
	FROM hr.EmployeePayHistory
	GROUP BY businessentityid, payfrequency, DATETRUNC(month, modifieddate)
)
SELECT
	SUM(payfrequency) AS totalpay_frequency,
	SUM(totalrate) AS totalrate -- Summing totalrate across records in the final output
FROM cte_rate_summary;*/

---QUERIES ON DEPT HISTORY---
--select * from hr.EmployeeDeptHistory
/*select
	*,
	count(businessentityid) over(partition by departmentid order by startdate) total_emp_dept,
	count(businessentityid) over() totalemployees
from hr.EmployeeDeptHistory*/

--find emp whose shiftid = 2 and startdate should be in first quarter of year
/*select *
from hr.EmployeeDeptHistory
where shiftid = 2 and month(startdate) <= 3
order by StartDate*/
 
 --FIND NO OF YERAS EMPLOYEES ARE WORKED UNTIL END DATE IF ENDDATE NULL MEANS CONSIDER UNTILL TODAY
/*select
	*,
	datediff(year,startdate,enddate2) num_of_years_worked
from(
 select
	startdate,
	enddate,
	datetrunc(day,coalesce(enddate,getdate())) enddate2
from hr.EmployeeDeptHistory
)t*/

----FIND EMPLOYEES WHO LEFT THE COMPANY i.e, NOT WORKING IN COMPANY----
/*select *
from(
select *
from hr.EmployeeDeptHistory
where EndDate is not null)t */

---FIND EMPLOYEES WHO WORKED MORE THAN 15 YEARS IN COMPANY---
/*select
	*
from(
select
	*,
	datediff(year, startdate, datetrunc(day, coalesce(enddate, getdate()))) as num_of_years_worked
from hr.EmployeeDeptHistory)t
where num_of_years_worked > 15*/
 
 ---REPLACE NULL VALUES WITH TODAY DAY IN ENDDATE---
/*select
	*,
	datetrunc(day,coalesce(enddate,getdate())) as enddate2
from hr.EmployeeDeptHistory*/
--select * from hr.EmployeePayHistory;
---FIND MONTHLY SALARY OF EMPLOYEES IF RATE GIVEN IS PER DAY RATE AND PAYFERQUENCY IS HOW MANY TIMES THEY GET PAYED IN A DAY
/*select
    *,
    case 
        when payfrequency = 2 then rate * 2 * 30
        when payfrequency = 1 then rate * 1 * 30
        else 0
    end as monthly_salary
from hr.EmployeePayHistory;*/
 --FIND MONTHLY SALARY IS GREATER THAN 3500 OF EMPLOYEES AND ORDER BY MODIFIEDDATE
/*SELECT *
FROM (
    SELECT
        BusinessEntityID,
        PayFrequency,
        ModifiedDate,
        RateChangeDate, -- Include this if it is relevant to the grouping
        CASE 
            WHEN payfrequency = 2 THEN rate * 2 * 30
            WHEN payfrequency = 1 THEN rate * 1 * 30
            ELSE 0
        END AS monthly_salary
    FROM hr.EmployeePayHistory
) t
WHERE monthly_salary > 3500
ORDER BY ModifiedDate;*/

---JOIN EmployeeDeptHistory WITH shift TABLE AND GIVE COUNT OF EMPLOYEE DETAILS FOR EACH SHIFT TIME
/*select 
	*,
	count(BusinessEntityID) over(partition by starttime,endtime) total_emp_per_shift
from(
SELECT 
    edh.BusinessEntityID,
    edh.DepartmentID,
    edh.ShiftID AS EmployeeShiftID, -- Alias to avoid duplicate
    edh.StartDate,
    edh.EndDate,
    h.ShiftID AS ShiftShiftID,       -- Alias to avoid duplicate
    h.Name,
    h.StartTime,
    h.EndTime
FROM hr.EmployeeDeptHistory edh
LEFT JOIN hr.Shift h ON edh.ShiftID = h.ShiftID
) t*/

























