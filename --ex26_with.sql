--ex26_with.sql

/*
  각절의 순서
  1.witn<sub query> --인라인뷰에서 잠시 이름을 붙인다(가독성)
  7.select
  2.from
  3.where
  4.group by
  5.having
  6.order by
*/
select * from
  (select name, buseo ,jikwi from tblinsa where city ='서울')seoul;
  ==둘이 같음
  
  with seoul as (select name, buseo ,jikwi from tblinsa where city ='서울');
  select * from seoul;
  
  --tblmen.몸무게(90이하) + tblwomen.몸무게(60초과) > join
  
  --tblmen inner join tblwomen
  
  create or replace view vwmen
  as
  select name, age, couple from tblmen where weight <=90;
  
  create or replace view vwwomen
  as
  select name,age, couple from tblwomen where weight >60;
  
  select * from (select name, age, couple from tblmen where weight <=90) a
    inner join(select name,age, couple from tblwomen where weight >60) b
        on a.couple = b.name;
          
    ==
      select * from vwmen a
    inner join vwwomen b
        on a.couple = b.name;
        
        
        select * from vwmen;
        
        
        with a as(select name, age, couple from tblmen where weight <=90),
           b as (select name,age, couple from tblwomen where weight >60)
           
           
          select * from  a
            inner join b
              on a.couple = b.name;