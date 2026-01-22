--ex03_operator.sql

/*
    연산자 operator
    
    1. 산술 연산자
    - +,-,*,/
    -%(없음) >> 대신 함수로 제공(mod라는 메서드)
    
    2.문자열 연산자(concat)
    - +(x)
    -||(O) 문자열 더하기 연산자
    
    
    3.비교 연산자
    - >,>=.<=.<
    - =(==),<>(!=)
    - 논리값 반환 >  boolean 없음 > 표현 불가능
    -컬럼 리스트에서는 사용 불가
    - 조건절에서는 사용가능
    
    
    4.논리 연산자
    -and(&&) ,or(||),not(!)
    -컬럼리스트에서 사용불가
    -조건절에서 사용

    5.대입 연산자
    - =
    - 컬럼 =값
    - update 문
    - 복합 대입 연산자(+=,-=..) 없음
    
    6.3항 연산자
    -없음
    -제어문 없음
    
    7.증감 연산자
    - 없음
    
    8.sql 연산자
        -자바 > instanceof
        -sql >in ,between,like ,is 등...
    








*** 모든 연산자는 피연산자로 null을 가질 수 없다.

10+0 과 10 + null 은 다르다 10+null은 연산불가능



*/

select 
population,
area,
population +10,
population - 10,
population *10,
population /10,
 population + area
from tblcountry;

select 
    name,
    capital,
   -- name+capital
   name||capital,
   name || ' : ' || capital
from tblcountry;

select
   area>100
from tblcountry;

select *
from tblcountry
where area>100;


select *
from tblcountry
where name='대한민국';


select *
from tblcountry
where continent ='AS' and (area >100);

/*
테이블/컬럼 >별칭
컬럼 별칭
//테이블의 이름을 바꾸는게 아니라 결과셋의 컬럼명을 바꾼다
-결과셋의 컬럼명들을 올바르게 유지하고 싶을 때 사용
바꾸는 이유
1.컬럼명이 중복될 때
2.컬럼의 가공했을때


테이블 별칭
    -결과셋과는 무관
    -sql작성 시 편리함을 제공


*/
select
    name,  
    capital
from tblcountry;

select
tblmen.name as men_name,
tblwomen. name as women_name;

select* from tblmen inner join tblwomen on tblmen.name =tblwomen.couple;


select
    name,
    length(name) as 국가명글자수,  //띄어쓰기 하거나 select를 as로 쓰고 싶으면 " "안에
    area * 2 +10 as 면적연산결과,
    population + area as 기타
from tblcountry;


select name,capital from tblcountry;

select c.name, c.capital  --2
from hr.tblcountry c;   --1

