--ex06_order.sql
    /*
        select문

-DML,DQL
-데이터베이스의 특정 테이블로부터 원하는 데이터를 가져오는 명령어
-- 각 절마다 각각의 기능이 있다
[WITH<SUB QUERY>]
SELECT column_list
from_table_name
[where search_condition]
[group by group_by_expression]
[having search_condition]
[order by order_expression [asc|desc]];

    
    
    order by 컬럼명 [asc/desc] :어떻게 레코드를 정렬할 지 표현식을 적어라
    
    각절의 순서
    3 select(order by 없으면 항상마지막
    1.from
    2.where
    4.order by (항상 마지막
    
    order by 절
    -order by 컬럼명
    -order by 컬러명 ASC
       -order by 컬러명 DESC
       -order by 컬럼명,[,컬럼명[ asc|desc]] x N
    */
    
    select * from tblinsa;
    --** 원본 테이블에 저장된 레코드의 순서는 어떤 정렬 상태인지 알 수 없다. >>오라클 맘대로..
    select * from tblinsa order by name asc;
    select * from tblinsa order by name desc;
    select * from tblinsa order by jikwi asc ;---1차 정렬 
     select * from tblinsa order by jikwi asc, buseo desc ;--2차정렬
    select * from tblinsa order by jikwi asc, buseo desc, basicpay asc ;--3차정렬
    
    
    --정렬이 되려면 누가 크고 작은지 비교> 대상: 숫자,문자,날짜 모두 다 가능
    
    select * from tblinsa order by basicpay desc; --숫자형
     select * from tblinsa order by name asc; --문자형
     select * from tblinsa order by ibsadate desc; --날짜형
     
     -- select절의 컬럼 인덱스를 사용해서도 정렬가능
     --첨자가 1부터 시작
     select
     name,buseo,jikwi--2
                               
     from tblinsa --1
     order by 1-3
     asc;
     
     
     --급여순(기본급+상여급)으로
     select * from tblinsa order by basicpay desc;
        select * from tblinsa order by basicpay+sudang desc;
        
        --직위순으로 정렬: 부장(4>과장(3>대리(2>사원
        select * from tblinsa order by jikwi asc;
        
        select 
        name ,jikwi
        from tblinsa;
        
          select 
        name ,jikwi,
        case
            when jikwi ='부장' then 4
            when jikwi ='과장' then 3
            when jikwi ='대리' then 2
            when jikwi ='사원' then 1
            end as jikwiSeq
        from tblinsa
        order by  jikwiSeq desc ;
        
           select 
        name ,jikwi,
        case
          
            end as jikwiSeq
        from tblinsa
        order by  jikwiSeq desc ;
        
        
        --tblinsa. 남자직원 > 여자직원순으로
        select
            name,ssn,buseo
        
           
        from tblinsa
        order by case
        when ssn like '%-1%' then 1
                when ssn like '%-2%' then 2
                end asc;
                
                
                