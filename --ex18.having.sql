--ex18.having.sql

/*
 having search_condition >> 조건을 지정
 
 from에 대한 조건 은 where >>개인에대한 조건 지정 >>원하는 행만 가져와라
 
 group에 대한 조건은 having >>그룹조건 지정  >>조건 만족시 원하는 그룹만 가져와라

 
  각절의 순서
  5.select
  1.from
  2.where
  3.group by
  4.having
  6.order by
  having 절
  -그룹에 대한 조건

*/
--1
select              --3.그렇게 나누어진 그룹별 통계값을 구한다.
    buseo,
    count(*),
    round(avg(basicpay))
from tblinsa                --1.60명의데이터를 가져온다.
    group by buseo;         --2. 60명을 대상으로 부서별 그룹을 나눈다
    
    --2
    select              --4.그렇게 나누어진 그룹별 통계값을 구한다.
    buseo,
    count(*),
    round(avg(basicpay))
from tblinsa                --1.60명의데이터를 가져온다.
    where basicpay>=1500000 --2. 60명 중 급여가 150만원 이상인 사람만 가져온다
    group by buseo;         --3. 대략 30명 대상으로 부서별 그룹을 나눈다.
    
기획부	5	2174000
개발부	4	2303750
영업부	8	2164275
홍보부	3	1967000
인사부	2	2200000
총무부	3	2431333
자재부	2	2410000
    
    
    
   --3 
    select              --4.그렇게 나누어진 그룹별 통계값을 구한다.
    buseo,
    count(*),
    round(avg(basicpay))
from tblinsa                --1.60명의데이터를 가져온다.
    group by buseo        --2. 60명을 대상으로 부서별 그룹을 나눈다
    having avg(basicpay)>=1500000;      --3.그룹별 평균 급여가 150만원 이상인 그룹만 통과 
    
기획부	7	1855714
총무부	7	1714857
영업부	16	1601513
인사부	4	1533000


--각 부서별(group by) 과장과 부장을 합한 인원수(where)가 3명이 넘는(having) 부서들은 어디??
select
    buseo,
    count(*)
    from tblinsa
    where jikwi in('과장','부장')
    group by buseo
        having count(*)>=3;

        
