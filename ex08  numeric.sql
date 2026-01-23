--ex08_numeric_function.sql

/*
    숫자함수
    
    자바
    -math.random()
    -math.xxx
    
    round()
    -반올림함수
    -number round(컬럼명):정수반환
      -number round(컬럼명,소수이하자릿수): 정수/실수 반환


*/

select name,3.14 from tblinsa; //모든값에 대해 3.14

desc dual;
select * from dual; --시스템 테이블 >>1행 1열짜리 테이블**

select 3.14 from tblinsa; >>50행이라 50개 돌려줌
select 3.14 from dual; >>  1행1열이라 한개만

--dual = 특정 테이블 테이터와 무관+ 어떤 계산된 값을 만들거나 테스트용으로 테이블이 필요할 때 사용하는 테이블

select round( 3.14) from dual;

select 
    round(3.14), 
    round(3.54),
    round(3.4567,1), --3.5
     round(3.4567,2), --3.46
      round(3.4567,3), --3.457
       round(3.4567,4), ----3.4567
        round(3.4567,5),
         round(3.4567,0)    
from dual;


select
   round(avg(basicpay)) --1556526.666666666666666677
from tblinsa;

/*
floor()
        -절삭 함수 > 소수 이하를 무조건 버린다.
        -무조건 내림함수라고 부름
        -자신과 인접한 가장 가까운 최저 점수를 반환
        - number floor(컬럼명) : 정수 반환
  */      
  
  select 
    floor(3.45),--3
    floor(3.55)--3, 반올림이 돼도 무조건 버림
  from dual;
  
  
  /*
  ceil()
  -무조건 올림함수
  - number ceil(컬럼명): 정수반환
  -자신과 인접한 가장 가까운 최대 정수를 바환
  -number ceil(컬럼) 
  
  
  */
  select
    ceil(3.46),--4
    ceil(3.55)--4
from dual;
  
  select
    floor(3.999999999), --3
    ceil(3.0000000000001)--4
    from dual;
    
    
    /*
     mod()
        -나머지 함수
        -number mod(피제수,제수)
        ex> 10 %3
        ex>mod(10,3)
    
    */
    select 
    
    10/3,
    floor(10/3) as 몫,
    mod(10,3) as 나머지
    from dual;
    
    select
        abs(10) ,abs(-10),
        power(2,2) ,power(2,3), power(2,4), //제곱함수
        sqrt(4),sqrt(9), sqrt(16) --제곱근함수
        from dual;