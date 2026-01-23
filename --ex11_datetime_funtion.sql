--ex11_datetime_funtion.sql


/*
    날짜시간 함수
    
    sysdate
    -시스템의 기각을 반환
    -date sysdate

*/
select sysdate from dual;


/*
    날짜 연산
    1.시각 -시각 =시간
    2.시각 +시간= 시각
    3.시각-시간= 시각


*/
-- 1.시각 -시각 =시간( 일 수로 정해짐) >> 아래로 시 분 초는 구할수있지만, 단위를 올려서 월이랑 년으로는 못 구함
--현재 시간 - 입사일= 근무시간
select
    name, to_char(ibsadate, 'yyyy-mm-dd')AS 입사일,
    round(SYSDATE -ibsadate) as 근무일수,  --날짜
    round((SYSDATE -ibsadate)*24) as 근무시수,
        round((SYSDATE -ibsadate)*24*60) as 근무분수,
         round((SYSDATE -ibsadate)*24*60*60) as 근무초수,
          round((SYSDATE -ibsadate)/30.4) as 근무개월수, --사용금지
           round((SYSDATE -ibsadate)/365) as 근무년수  --사용금지
from tblinsa;

--홍길동	2008=10=11	6313.652418981481481481481481481481481481(6313일째) >>round로 반올림


select 
    title ,adddate, completedate,
    round((completedate-adddate)*24) as  "실행하기 까지 걸린시간"
from tbltodo
--ORDER BY 4 ASC;
--ORDER BY  "실행하기 까지 걸린시간" ASC;
ORDER BY  round((completedate-adddate)*24) ASC;


--2.시각 +시간(일)= 시각
--3.시각 -시각(일) =시각
 select
    sysdate,
    sysdate +100 as "100일 후",
    sysdate -100 as "100일 전",
    to_char(sysdate +(3/24),'hh24:mi:ss') as "3시간 뒤",
    to_char(sysdate -(30/60/24),'hh24:mi:ss') as "30분전 "
from dual;


  /*
   날짜 연산(월,년)
   -시각- 시각= 시간(월)
   - number months_between(date,date)
  */
  
  select
    name,
    round(sysdate-ibsadate) as 근무일수,
    round(months_between(sysdate,ibsadate)) as 근무개월수,
     round(months_between(sysdate,ibsadate)/12) as 근무년수
  from tblinsa;
  
  
  /*
    add_months()
        -시각 +시간(월) =시각
        -시각-시간(월) =시각
  
  
  */
  
  select
    sysdate,
    sysdate+3,
    add_months(sysdate,3), --26.04
    add_months(sysdate,-2),
    add_months(sysdate,3*12)
    from dual;
    
    /*
        시각-시각=시간 원하는 단위
        1.일, 시,분,초 >>연산자(-)
        2.월 년을 원하면 >> months_between()
        
        시각+시간 //시각 -시간 =시각
        1.일.시,분,초를 원하면 연산자(+,-)
        2.월년을 원하면 >>add_months()
    */
    
    
    
    
    --null 함수 >> null value
    -- 1.nvl >값이 있으면 그값을 사용하고 ,없으면 대체값을 사용한다.
    -- 2.nvl2 >> 값이 있으면 앞의 값을 돌려주고 없으면 뒤의 값을 돌려준다
    select
        name,population,
        case
                when population is not null then population
                when population is null then 0
         end ,
         nvl(population,0),
          nvl2(population,'인구기재됨','인구기재안됨')  --원본 돌려주고 싶으면 1에 population 넣으면됨
    from tblcountry;
    
    
    
    