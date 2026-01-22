--ex02_select.sql
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

[ ]은 생략가능하다

그래서 이 2줄만 필수
SELECT column_list --원하는 컬럼을 지정해서 해당 컬럼만 가져와라 ex> 국영수 성적에서 국어만 가져오기
from table_name   --데이터 소스.어떤 테이블로부터 데이터를 가져와라


각 절의 순서******************************************

각 절들은 순서가 정해져있다.
2.select
1.from
>> 테이블을 먼저 지정하고 거기서 컬럼을 가져와라








*/
select txt from tbltype;

select txt
from tbltype;

select regdate--2
  from tbltype; --1
  
  
  --hr >샘플데이터 제공
  select *from tabs; --tabs=table 이런 테이블을 시스템 테이블이라함
  
  
  --EMPLOYEES 구조?
  DESC EMPLOYEES; --구조를 모를 때 DESCRIBE  >> 구조도를 보여줌
  
  select *  --*= 모든 컬럼이라는 뜻= 다 가져와라
  from employees;
  
  select last_name ,first_Name, phone_number  //내가 보고싶은 컬럼만
  from employees;
  
  select *from tblCountry;
  
  select *from tblcomedian;
  
  select *from tbldiary;
  
  select *from tblInsa;
  
  select * from tblmen;

  select * from tblwomen;
  select * from tbltodo;

select * from tblhousekeeping;















select *   --*(모든컬럼)
from tblcountry;


select name   --단일컬럼)
from tblcountry;


select name,capital   --다중 컬럼 >> 컬럼 순서는 마음대로
from tblcountry;



select name,name   --같은 컬럼을 여러번 가져오기 가능(쓸일은 없음)
from tblcountry;

select name,length(name)   --name의 길이
from tblcountry;


--select문 질의 > 결과를 반환 > 그결과는 항상 테이블 형태 > 원본이 테이블이라 결과값도 테이블
--결과 테이블이라고도 부름 ,결과 셋이라고도 부름result set

--에러
select * from tblcountr; //ORA-00942: 테이블 또는 뷰가 존재하지 않습니다 

select nam from tblcountry;//ORA-00904: "NAM": 부적합한 식별자=컬럼명이 틀린것