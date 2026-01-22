--ex05_column.sql

--컬럼 리스트에서 할 수 있는 행동들
--select 컬럼리스트
-- 컬럼명
select name , jikwi ,buseo from tblinsa;

--연산
select name || '님' , sudang * 2 from tblinsa;

--상수
select
    name, 100
 from tblinsa;
 
 select
    100          
 from tblinsa;
 
 
 --함수 
select name ,length(name) from tblcountry;

/*  
    java stream >list.stream().distinct().foreach()
       = distinct
       -컬럼리스트에서 사용
       -레코드의 중복값 제거
       -distinct 컬럼명 >x
       -distinct 컬럼리스트 > o




*/
-- tblcountry . 어떤대륙들이있어요?  >>개인으로 질문했는지 그룹으로 질문했는지
select * from tblcountry;-- 개인?
select distinct continent from tblcountry;--


--tblinsa 어떤 부서가 있어여?


select distinct buseo from tblinsa;
select distinct jikwi from tblinsa;
select distinct city from tblinsa;
select distinct name from tblinsa;  --60명 

select distinct buseo, name from tblinsa; --(buseo,name) 전체에 영향을 줌 buseo$name 

select distinct buseo , jikwi from tblinsa;

/*
        sql >제어문 없음
        case문  하나있음
        -대부분의 절에서 사용가능 where ,select 등..
        -조건문 역할 >> 컬럼값을 조작하는데 쓰임
        - 자바로 치면 다중 if문 or switch case 문 역할
        
    언어
    1.C계열 언어 >컴파일언어
    2.BASIC 계열 >인터프리터 > 스크립트
   3.() 말고 CASE END
   4. 조건만족시  then 값 반환
   5.조건불만족시 null반환***
*/
select
 last || first as name,
 gender,
 case 
 --WHEN 조건 THEN 값  -- 다중 if문과 비슷
 WHEN GENDER='m' THEN '남자'
 when gender='f' then '여자' 
 END as gendername,
 case gender  --switch문과 비슷
    when 'm' then '남자'
    when 'f' then '여자'
 end as gendername2
from tblcomedian;

select
    name, continent,
    case
     when continent ='as' then '아시아'
     when continent ='eu' then '유럽'
     when continent='af' then '아프리카'
    -- else '기타'
     else continent
    end as continentname
from tblcountry;

select
    last ||  fist as name, weight,
    case
        when weight >90 then '과체중'
        when weight > 50 then '정상체중'
        else '저제충'
    end state,
    case
        when weigh >=50 and weight <=90 then '정상체중'
        else '주의체중'
     end state2,
     case
        when weight between 50 and 90 then '정상체중'
        else '주의체중'
    end state3
from tblcomedian;


--사원과 대리를 현장직으로 분류
--과장과 부장은 관리직으로 분류해서 출력
select 
    name,jikwi,
    case
        when jikwi ='사원' or jikwi = '대리' then '현장직'
        when jikwi ='과장'or jikwi= '부장'then '관리직'
    end,
    case
        when jikwi in('사원', '대리') then '현장직'
        when jikwi in('과장','부장') then '관리직'
        end
from tblinsa;

select  
    name, ssn,
    case
        when ssn like '%-1%' then '남자직원'
           when ssn like '%-2%' then '여자직원'
    end
from tblinsa;

select
        title,
        CASE
            when completedate is not null then '완료'
            when completedate is null then '미완료'
        end
 
from tbltodo;





