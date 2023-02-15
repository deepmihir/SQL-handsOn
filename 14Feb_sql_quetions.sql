use [sample]


-- quetion -1
ALTER function fn_give_highest_salary1(@n int)
returns INT
as
BEGIN
    declare @value int
    SET @value = (select top 1 salary
    from (select top (@n) salary from tbl_emp_salary ORDER by salary desc) as h
    ORDER by salary asc)
    return @value
end


-- select 
-- from tbl_emp_salary
-- offset @n-1 ROWS
-- fetch next @n rows ONLY


SELECT dbo.fn_give_highest_salary1(2)



-- quetion -2
use [sample]
select * from tbl_rank_score
select id, score, DENSE_RANK () OVER (ORDER BY score desc) AS Rank_no from tbl_rank_score


-- quetion -3
-- select number,COUNT(number) as [Number count] from tbl_num
-- GROUP by number
-- HAVING COUNT(number)>=3

ALTER view vW_Consicutive_num
AS
use [sample]
SELECT number as val, LAG(number) over(ORDER by id) as before_val,LEAD(number) OVER(ORDER by id) after_val
FROM tbl_num

select * from tbl_num

select val from vW_Consicutive_num
where val= before_val and val = after_val



-- quetion -4
--self join
select em1.name
from tbl_emp_manager em1
JOIN tbl_emp_manager em2
on em1.id = em2.ManagerId
where em1.salary > em2.salary 



-- quetion -5
select email from tbl_emp_mail
GROUP by email
having COUNT(*) >1
select distinct email from tbl_emp_mail 