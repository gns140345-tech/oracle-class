/* ex04 where

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

[ ]은 생략가능하다

그래서 이 2줄만 필수
SELECT column_list --원하는 컬럼을 지정해서 해당 컬럼만 가져와라 ex> 국영수 성적에서 국어만 가져오기
from table_name   --데이터 소스.어떤 테이블로부터 데이터를 가져와라
where search_condition  -- 행의 조건 지정 >원하는 행만 가져와라

각 절의 순서******************************************

각 절들은 순서가 정해져있다.
3.select >>거의 꼴등
1.from  >>from은 거의 1번 ,일단 테이블을 지정해야 실행을하니까
2.where

optimizer > sql 실행하기 전에 결과를 얻기 위해 최적의 sql로 수정

between
    -주로 where절에서 사용 > 조건으로 사용
    -컬러명을 적고 between 최솟값 and 최댓값
    -하는일은 범위비교
    -가독성 향상을 위해서 사용
    -최솟갑 최댓값 모두 포함 > 이상 ~이하

*/
select *from tblinsa where basicpay>=1000000 and basicpay <=1200000;


select *from tblinsa where basicpay between 1100000 and 1320000; //


select *from employees where first_Name <= 'f';  //이름 a~f

select *from employees where first_name >= 'j' and first_name <='l';

select *from employees where first_name between 'j' and 'l';

desc tblinsa;
select * from tblinsa where ibsadate < '2010-01-01';
select * from tblinsa where ibsadate >= '2010-01-01'and ibsadate <= '2010-12-31';
select * from tblinsa where ibsadate between '2010-01-01'and '2010-12-31';

/*
in 연산자
    -where 절에서 사용 > 조건으로 사용
    -열거형 비교
    -컬럼명 in(값, 값, 값..) >>> 컬럼 값이 하나라도 만족하면 실행
    -가독성 향상목적
    

*/
--tblinsa 개발부보고싶다 + 홍보부 + 총무부
select * from tblinsa where buseo ='개발부';
select * from tblinsa where buseo ='개발부' or buseo ='홍보부' or buseo = '총무부';
select * from tblinsa where buseo in('개발부','홍보부','총무부');

--city > 서울+인천이면서 
--jikwi>> 과장+부장이면서
--basicpay >> 250-300

select * from tblinsa
where city in( '서울','인천')
        and jikwi in('과장','부장')
            and basicpay between 2500000 and 3000000;
/*
        like
        -where 절에서 사용 >> 조건으로 사용
        -패턴 비교(정규 표현식 유사 기능)
        -컬럼명 like '패턴 문자열'
        
        패턴 문자열 구성 요소
        1. _ : 임의의 문자 1개(정규표현식 .)
        2. %: 임의의 문자 n개. 0~무한대

*/
---직원명  김 씨 찾기
select * from tblinsa;
select *from tblinsa where name like '김__';
select *from tblinsa where name like '_길_';
select *from tblinsa where name like '__수';

select *from tblinsa where name like '김__';

select * from employees where first_name like 'S_____';//문법은 대소문자 구분하지 않지만 데이터 입력값은 대소문자를 가린다
select *from tblinsa where name like '김%'; //글자수에 상관없이 김 뒤에 뭐가  나오든 상관없음
select *from tblinsa where name like '%수';
select *from tblinsa where name like '%길%';  // %에 0도 포함이라 길만 들어가면 다 찾음
select *from EMPLOYEES where FIRST_name like '%S';
select * from tblinsa where ssn like '______-1______'; //s=남자직원들
select * from tblinsa where ssn like '%-2%';  //여자 직원들


/*
    RDBMS에서의 NULL
        -컬럼값이 비어있는 상태
        -NULL 상수 제공
        -대부분의 언어는 NULL은 연산의 대상이 될 수 없다.

    is null
        -where절에서 사용
        -컬럼명 is null

*/
select *from tblcountry;

--인구수가 미기재 된 나라를 찾아라
select * from tblcountry
    where population = null; //null은 연산의 대상이 아니라 무조건  false 
    
    select * from tblcountry
    where population is null;

--인구수가 기재된 나라들은?
select * from tblcountry
    where not population is null;
    
    select * from tblcountry
    where not population is not null; //이렇게 더 많이씀

select *   ---
from tblcountry     --1
    where continent<>'AS' OR CONTINENT = 'EU'; --2 행>레코드 = 튜플(TUPLE) 
    
    
    -- tblComedian
-- 1. 몸무게(weight)가 60kg 이상이고, 키(height)가 170cm 미만인 사람

-- 2. 몸무게가 70kg 이하인 여자만

-- tblInsa
-- 3. 부서가 '개발부'이고, 급여가 150만원 이상 받은 직원

-- 4. 급여 + 수당을 합한 금액이 200만원이 넘는 직원


SELECT
*
FROM 
 TBLCOMEDIAN   WHERE WEIGHT >=60 AND HEIGHT <170 ;

SELECT
*
FROM TBLCOMEDIAN
WHERE GENDER='W' AND WEIGHT<=70;

select
*
from tblinsa;
    
    select
*
  from tblinsa
  where buseo='개발부'
  and basicpay >=1500000;
  
  
  
  select
        basicpay,
        sudang,
        basicpay+sudang as total
  from tblinsa
     where basicpay+sudang >=2000000;
    
    
    SELECT *
    FROM TBLCOMEDIAN;