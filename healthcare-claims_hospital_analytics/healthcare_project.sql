#Healthcare Claims & Hospital Analytics using MySQL

create database if not exists healthcare_db;
use healthcare_db;

drop table if exists healthcare_data;

create table healthcare_data(
name varchar(120),
age int,
gender varchar(20),
blood_type varchar(10),
medical_condition varchar(100),
date_of_admission varchar(20),
doctor varchar(120),
hospital varchar(220),
insurance_provider varchar(100),
billing_amount decimal(12,2),
room_number int,
admission_type varchar(50),
discharge_date varchar(20),
medication varchar(100),
test_results varchar(50)
);

set global local_infile = 1;
show variables like 'local_infile';


alter table healthcare_data
modify billing_amount decimal(15,5);

truncate table healthcare_data;

load data local infile 'C:/Users/Tanupriya/OneDrive/Desktop/Imarticus- Data Science/Projects/sagility projects/sql project/data/healthcare_dataset/healthcare_dataset.csv'
into table healthcare_data
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

#Cleaning
#Adding date conversions
update healthcare_data
set date_of_admission = str_to_date(date_of_admission,'%d-%m-%Y'),
discharge_date = str_to_date(discharge_date,'%d-%m-%Y');

#Cleaning name casing
update healthcare_data set name = concat( upper(left(lower(name),1)),substring(lower(name),2));

#Clean test_results
update healthcare_data set test_results = trim(replace(replace(test_results,'\r',''),'\n',''));

#Other cleanups
update healthcare_data set gender = trim(gender);
update healthcare_data set admission_type = trim(admission_type);
update healthcare_data set insurance_provider = trim(insurance_provider);
update healthcare_data set medical_condition = trim(medical_condition);

update healthcare_data
set date_of_admission = trim(replace(replace(date_of_admission,'\r',''),'\n','')),
    discharge_date   = trim(replace(replace(discharge_date,'\r',''),'\n',''));
    
select count(*) from healthcare_data;

#Basic queries
#1.Total Patients
select count(*) as total_records from healthcare_data;

#2.Gender Distribution
select gender,count(*) as patients from healthcare_data group by gender;

#3.Most Common Medical Conditions
select medical_condition,count(*) as cnt from healthcare_data group by medical_condition order by cnt desc;

#4.Average Billing by Insurance Provider
select insurance_provider,round(avg(billing_amount),2) avg_bill from healthcare_data group by insurance_provider order by avg_bill desc;

#5.Highest Billing Patients
select name,billing_amount from healthcare_data order by billing_amount desc limit 10;

#6.Admission Type Split
select admission_type,count(*) cnt from healthcare_data group by admission_type;

#7.Average Age by Condition
select medical_condition,round(avg(age),1) avg_age from healthcare_data group by medical_condition;

#8.Hospitals with Most Patients
select hospital,count(*) cnt from healthcare_data group by hospital order by cnt desc limit 10;

#9.Abnormal Test Result %
select round(sum(case when trim(lower(test_results))='abnormal' then 1 else 0 end)*100.0/count(*),2) as abnormal_pct from healthcare_data;

#10.Average Billing by Admission Type
select admission_type, round(avg(billing_amount),2) from healthcare_data group by admission_type;

    
#Advanced queries:
#11. Total Revenue by Insurance Provider
select insurance_provider,round(sum(billing_amount),2) total_revenue from healthcare_data group by insurance_provider order by total_revenue desc;

#12. Monthly Admissions Trend
select month(str_to_date(date_of_admission,'%Y-%m-%d')) as month_no,count(*) as admissions from healthcare_data group by month_no order by month_no;

#13. Average Stay Days
select round(avg(datediff(str_to_date(discharge_date,'%Y-%m-%d'),str_to_date(date_of_admission,'%Y-%m-%d'))),2) as avg_stay_days from healthcare_data;

#14. Avg Stay by Admission Type
select admission_type,round(avg(datediff(str_to_date(discharge_date,'%Y-%m-%d'),str_to_date(date_of_admission,'%Y-%m-%d'))),2) as avg_days from healthcare_data
group by admission_type;

#15. Top 10 Expensive Hospitals
select hospital,round(avg(billing_amount),2) avg_bill from healthcare_data group by hospital order by avg_bill desc limit 10;

#16. Condition-wise Revenue
select medical_condition, round(sum(billing_amount),2) revenue from healthcare_data group by medical_condition order by revenue desc;

#17. Patients Above Avg Billing
select name,billing_amount from healthcare_data where billing_amount >(select avg(billing_amount) from healthcare_data);

#18. Top Billing Patient per Condition
select * from(select medical_condition,name,billing_amount,dense_rank() over(partition by medical_condition order by billing_amount desc) rn
from healthcare_data)t where rn=1;

#19. Insurance Provider Market Share
select insurance_provider,round(count(*)*100.0/(select count(*) from healthcare_data),2) pct_share from healthcare_data group by insurance_provider;

#20. Abnormal Results by Condition
select medical_condition, sum(case when trim(lower(test_results))='abnormal' then 1 else 0 end) abnormal_cases from healthcare_data group by medical_condition
order by abnormal_cases desc;

#21.Running Monthly Admissions
select month(date_of_admission) m,count(*) admissions,sum(count(*)) over(order by month(date_of_admission)) running_total from healthcare_data group by m;

#22.Top 3 Insurance by Revenue
select * from(select insurance_provider,sum(billing_amount) revenue,dense_rank() over(order by sum(billing_amount) desc) rn from healthcare_data group by 
insurance_provider)t where rn<=3;