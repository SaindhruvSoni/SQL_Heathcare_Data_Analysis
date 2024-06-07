
Q1--Give a unique numeric identity to every patient

alter table healthcare add id int identity(1,1)

Q2--Find the average age of the patients diaganosed with Cancer

select Medical_Condition,avg(age) as average_age 
from healthcare 
group by Medical_Condition

Q3--Find out the blood-group with most patients

select Blood_Type,count(medical_condition) as counts
from healthcare
group by Blood_Type
order by counts desc

Q4--select the Name and the medical condition of the patient who paid the biggest sum of bill

select name,round(Billing_Amount,2)as Amount
from healthcare 
where Billing_Amount=(select max(Billing_Amount) from healthcare)

Q5--select the most used insaurance company

select Insurance_Provider,count(id) as Counts
from healthcare
group by Insurance_Provider
order by counts desc

Q6--Select the percentage of Males and Females diaganosed with medical condition(Obesity)

with cte1 as (
select count(Medical_Condition) as total 
from healthcare where Medical_Condition='obesity'
),
cte2 as (
select gender,medical_condition,count(Medical_Condition) as patients
from healthcare
where Medical_Condition='obesity' 
group by Medical_Condition,Gender
)
select Gender,Medical_Condition,(patients*100.0/cte1.total) as percnt from cte2,cte1

Q7--Find the most common blood type among the patients in the hospital ranked in the descending order

select Blood_Type,count(blood_type) as Blood_Type_Count
from healthcare
group by Blood_Type
order by Blood_Type_Count desc

Q8--Find the percentage of patients in all type of medical conditions, order the results in desc order 

with cte1 as(
select distinct Medical_Condition,count(name) as no_of_patients
from healthcare
group by Medical_Condition),
cte2 as(select sum(no_of_patients) as total from cte1)
select medical_condition,(no_of_patients*100.0/total) as patient_percentage from cte1,cte2
order by patient_percentage desc

Q9--Find the most common health condition among the patients above the age of 55

select Medical_Condition,count(Medical_Condition) as patient_count
from healthcare 
where age>55
group by Medical_Condition
order by patient_count desc

Q10--Find the percentage of all blood group types, order in desc 

select Blood_Type,count(Blood_Type) as Blood_Count
from healthcare
group by Blood_Type
order by Blood_Count desc

Q11--Find the most common blood group among the male and female patients

with cte1 as
(select Gender,Blood_Type,count(Blood_Type) as counts
from healthcare
group by Gender,Blood_Type),
cte2 as
(select *,rank() over(order by counts desc) as ranking
from cte1)
select top 2 gender,Blood_Type,counts 
from cte2
order by counts desc

Q12--Find the most preferred hospital by patients 

select Hospital,count(id) as patients_count
from healthcare
group by Hospital
order by patients_count desc

Q13--Find out the average billing amount for every medical condition 
--Round up the value to 2 decimal places also arrange it in descending order

select Medical_Condition,round(avg(Billing_Amount),2) as avg_bill
from healthcare
group by Medical_Condition
order by avg_bill desc

Q14--Find out the top 2 insaurance provider who cleared the most billing amount
--Arrange them in a descending order also round up value to 2 decimal places

select Insurance_Provider,round(sum(Billing_Amount),2) as Dispersed_Amount
from healthcare
group by Insurance_Provider
order by Dispersed_Amount desc

Q15--Find out the most prescribed medicines to the patients diaganosed with cancer

with cte1 as
(select Medical_Condition,Medication,rank() over(order by medication) as counts_of_prescription
from healthcare
group by Medical_Condition,Medication)
select distinct Medical_Condition,Medication,counts_of_prescription from cte1 
where counts_of_prescription=(select max(counts_of_prescription) from cte1)

