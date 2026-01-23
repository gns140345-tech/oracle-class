-- ex09_string_function

/*
    문자열 함수
        
        대소문자 변환
        -upper(),lower(),inticap()
        -varchar2 upper(컬럼명)
         -varchar2 lower(컬럼명)
          -varchar2 initcap(컬럼명)
*/
select
 'aBcDeF',
 upper('aBcDeF'),
 lower('aBcDeF'),
 initcap('aBcDeF') --대소문자 정리
 from dual;
 
 --이름(first name)에  an에 포함된 직원들을 찾아라 (대소문자와 상관없이 an이들어간)
 
 select
    first_name
from employees
where first_name like '%an%' //소문자 an만 찾음
             or first_name like '%AN%'
            or first_name like '%An%',
            or first_name like '%aN%';
 where lower(fist_name) like '%an%'
 
 
 
 
 
 
 
 
 /*
    문자열 추출함수
    -substr()
    -varchar2 substr(컬럼명,시작위치, 가져올 문자 개수) // 오버로딩 구조와 같음
     -varchar2 substr(컬럼명,시작위치)
    
 */ //3전까지가 아니라 가져올 개수
 select
    name,
    substr(name,1,3) ,            
    substr(name,2),
    substr(name,-1)  --// 끝에서 한문자
 from tblcountry;
 /*
    -1990년대 >1,2
    -2000년대>3,4
    -
 */
 
 
 select
  name,ssn,
  substr(ssn,1,2) as 생년,
  substr(ssn,3,2) as 생월,
  substr(ssn,5,2) as 생일,
  substr(ssn,8,1) as  성별
  from tblinsa;
  
  --tblinsa >60명 > 김,이 박, 정 최 > 각각 몇명?
  select * from tblinsa where substr(name,1,1)='김'; --12
    select * from tblinsa where substr(name,1,1)='이';
      select * from tblinsa where substr(name,1,1)='박';
        select * from tblinsa where substr(name,1,1)='정';
          select * from tblinsa where substr(name,1,1)='최';
          
select
        count(case when substr(name,1,1) ='김'then 1 end) as 김,
       count(case when substr(name,1,1) ='이'then 1 end)as 이,
       count( case when substr(name,1,1) ='박'then 1 end)as 박,
        count(case when substr(name,1,1) ='최'then 1 end)as 정,
        count(case when substr(name,1,1) ='정'then 1 end)as 최,
        count(
            case
                when substr(name,1,1) not in ('김', '이','박','정','최') then 1
                end
                ) as 나머지
from tblinsa;


/*
문자열길이
    -number length(컬럼명)
    
*/
select name, length(name) from tblcountry;

--함수들이 여러 절에서 사용되는 모습
--1. 컬럼 리스트에서 사용
select name,length(name) from tblcountry;

--2.조건절에서 사용
select name, length(name) from tblcountry
    where length(name)=2;
    
--3. 정렬 order by에서 사용
select name,length(name) from tblcountry
order by length(name) asc;

/*
    문자열 검색
    index
    = instr()
    -역할은 검색어의'위치'를 반환
    -number instr(컬럼명,검색어)
    -number instr(컬럼명,검색어,시작위치)
    -number instr(컬럼명,검색어,시작위치, -1) //= lastindexOF() 검색이 반대로
    -못찾으면? 0을 반환
    
*/
select
    '안녕하세요.홍길동님',
    instr( '안녕하세요. 홍길동님','홍길동') as r1,
    instr( '안녕하세요. 홍길동님','아무개') as r2,
    instr( '안녕하세요. 홍길동님 홍길동님','홍길동',11) as r4,  --두번째 길동이찾을때
    instr( '안녕하세요. 홍길동님 홍길동님','홍길동') as r3,
        instr( '안녕하세요. 홍길동님 홍길동님','홍길동',-1) as r6
from dual;



/*
    패딩
    -lpad(), rpad()
    -leftpadding, right padding >>왼쪽 오른쪽 여백
    -varchar2 lpad(컬럼명, 개수,문자)
      -varchar2 rpad(컬럼명, 개수,문자)

*/
select
    'a',
    lpad('a',5), --    a >>%5s 데이터가 공간을 다 채우지 못하면 나머지는 공백으로 채워라
    rpad('a',5),   -- a    >>%-5s 오른쪽이 공백
    lpad('a',5,'b'), --bbbba >> 나머지 공간을 b로 채운다
    lpad('1',5,'0') --00001
from dual

/*
    공백제거
        -trim() , ltrim(),rtrim()
        -varchar2 trim(컬럼)
        -varchar2 ltrim(컬럼)
        -varchar2 rtrim(컬럼)
*/
select
    trim('     하나     둘     셋'),
     ltrim('     하나     둘     셋'),
      rtrim('     하나     둘     셋')
    from dual;
        
  /*
    문자열치환
        -replace()
        -varchar2 replace(컬럼명, 찾을문자열, 바꿀문자열)
    
        -regexp_replace(컬럼명, 정규표현식, 바꿀문자열)
  */      
select
    replace('홍길동','홍','김'),
    replace('홍길동','최','김'),
    replace('홍길홍','홍','김')
from dual;

select
    name,
    regexp_replace(name,'김[가-힣]{2}','김00'),
    regexp_replace(name,'([가-힣])[가-힣]{2}','\1oo'),
    regexp_replace(tel,'(\d{3})-(\d{4})-(\d{4})','\1-1234-\3')
from tblinsa;


--string[] split() >없음
/*
    문자열 치환함수
    -decode()
    -replace()와 유사
    -varchar2 decode(컬럼명,찾을문자열,바꿀문자열)
     -varchar2 decode(컬럼명,찾을문자열,바꿀문자열,찾을문자열,바꿀문자열) >> replace와 다르게 최소 1번은 찾아서 바꿔야되고 무제한으로 추가가능
     


*/
    select
        gender,
        case
            when gender ='m' then '남자'
            when gender='f'  then '여자'
        end as g1,
           replace( replace(gender, 'm','남자'),'f','여자') as g2, 
           decode(gender,'m','남자','f','여자') as g3
    from tblcomedian;
    
    select
    decode(continent, 'AS','아시아','EU','유럽','AF','아프리카')
    from tblcountry;
    
    
  --TBLcomedian.남자수?여자수?
  select 
        count(case
        when gender='m' then 1
        end) as m1,
          count(case
        when gender='f' then 1
        end) as f1,
        
        count(decode(gender,'m',1)) as m2,
        count(decode(gender,'f',1))as f2
  from tblcomedian;
   
   --100만원 이하 받는사람 몇명? 100~200 몇명? 200이상 몇명? 
    select
       --basicpay
       count(case
            when basicpay between 0 and 1000000 then 1
        end),
        count(case
            when basicpay between 1000001 and 2000000 then 1
        end ) ,
        count(case
            when basicpay >2000000 then 1
        end )   
    from tblinsa;