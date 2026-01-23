--ex10_casting_function

/*
    형변환 함수
    1.varchar2 to_char(숫자형): 숫자를 문자로 바꿈*
    2.varchar2 to_char(날짜형: 날짜를 문자로 바꿈 *****8
    3.number to_number(문자형: 문자를 숫자로 바꿈*
    4.date ti_date(문자형 :문자를 날짜로 바꿈****

       1.varchar2 to_char(숫자형 [,형식문자열])
       
       형식 문자열 구성 요소
       a. 9:숫자 1개를 문자 1개로 바꾸는 역할. 빈자리는 공백으로 채운다. >%5d
       b.0:숫자 1개를 문자 1개로 바꾸는 역할. 빈자리는 0으로 채운다. >%05d  >> 남는자리는 0
       c.$ : 그냥 달러 기호,통화기호
       d.L: 통화 기호(지역 설정에 맞게끔 자동으로 들어감)
       E. . :소수점
       F. ,: 자릿수마다 ,


        자바
        -엄격한 문법을 준수하는 언어
        
        sql
        -유연한 문법을 제공하는 언어
        - 자료형에 대한 판정에 대해 유연함 > 형변환이 자동으로 많이 발생
        basicpay가 숫자인데도 length(basicpay)가능
*/
select 
basicpay,  --우측정렬
to_char(basicpay)--좌측정렬  숫자>문자
from tblinsa;

select
    weight,--64
    to_char(weight), --'64'
 '@' ||   to_char(weight,'99999') || '@', --> 64라는 숫자를 5자리 문자열로 바구겠다 , 숫자 9가 아니라 문자로 바꾸는 역할을 함, 사실 6자리 앞에 +- 1자리 +5자리
  '@' || trim(  to_char(weight,'00000')) || '@',
   '@' ||   to_char(-weight,'99999') || '@',
    '@' ||   to_char(-weight,'00000') || '@',
     '@' ||   to_char(123456789,'00000') || '@' --@######@ >>에러 난 것 
 from tblcomedian;
 
 select
    100,
    to_char(100,'$999'), --$100
    --to_char(100,'999달러') 
      to_char(100,'999') ||'달러',
        to_char(100,'L999')
    from dual;
    
    select
        3.14,
        to_char(3.14,'999') ,--999는 정수
          to_char(3.14,'9.99'), --3.14
            to_char(3.14,'99.9'),--3.1 
              to_char(3.15,'99.9'), ---3.2
                to_char(1234567,'9,999,999')  --
                
    from dual;
    
    
    /*
    2.varchar2 to_char(날짜형 [,형식 문자열])  >>날자를 문자열로 돌려줌
        
        형식 문자열 구성 요소
        a.yyyy
        b.yy
        c.month
        d.mon
        e.mm
        f.day
        g.dy
        h.add
        i.dd
        j.d
        k.hh
        l.hh24
        m.mi
        n.ss
        0.am(pm)
    
    */
    
    --sysdate: 함수  >>현재 날짜를 돌려줌 >localdate.now()
    select sysdate from dual; 
    select to_char(sysdate,'yyyy') from dual ; --'2026' >4자리 년도
    select to_char(sysdate,'yy') from dual ;  --26 >>2자리 년도
    select to_char(sysdate,'month') from dual ;--1월>월(풀네이몌 january
    select to_char(sysdate,'mon') from dual ;-- >>1월 >월(약어) jan
    select to_char(sysdate,'mm') from dual ; --01>월(2자리)
    select to_char(sysdate,'day') from dual ; --금요일 >요일(풀네임)
    select to_char(sysdate,'dy') from dual ;--금>>요일
    select to_char(sysdate,'d') from dual ; --6> 요일(이번주들어서 며칠인지)
    select to_char(sysdate,'ddd') from dual ; --023>일(올해들어서 며칠째냐)
    select to_char(sysdate,'dd') from dual ;--23 >일(이번달 들어서 며칠_
    select to_char(sysdate,'hh') from dual ; --02(12시간표기법
    select to_char(sysdate,'hh24') from dual ;--14(24시간표기법
    select to_char(sysdate,'mi') from dual ;--46분
    select to_char(sysdate,'ss') from dual ;--19초
    select to_char(sysdate,'am') from dual ;--오후
    select to_char(sysdate,'pm') from dual ;
    
    select  
    sysdate,
    to_char(sysdate,'yyyy-mm-dd'),
    to_char(sysdate,'hh24:mi:ss'),   -- 26/01/23	2026-01-23	14:50:04	2026-01-23 14:50:04	금요일 오후 02:50:04
    to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'),
    to_char(sysdate, 'day am hh:mi:ss')
    from dual;
    
    
    -- 평일 입사 vs 휴일 입사
    select
        name,ibsadate,
        to_char(ibsadate,'yyyy-mm-dd') as 입사일,
          to_char(ibsadate,'day') as 요일,
          case
                when to_char(ibsadate,'d') in('7','1') then '휴일입사'
                else '평일 입사'
            end
    from tblinsa;
    
    --요일별 입사한 인원수를 1개의 테이블로 가져와라
    select
      count( decode( to_char(ibsadate,'d'),'1',1))as 일,
      count( decode( to_char(ibsadate,'d'),'2',1)) as 월
    from tblinsa;
    
    --3.number to_number(문자형)
    select
        '123'*2,
        to_number('123') * 2
        from dual;
        
            --4.date to_date(문자형 :문자를 날짜로 바꿈****
            
        select 
        *
        from tblinsa
     --   where ibsadate>='2010-01-01'; --날짜 리터럴 없음  ,문자형을 날짜로 바꿔준것임
         where ibsadate>=to_date('2010-01-01'); --시분초 >> 자정 >>00:00:00
         
        select name, to_char(ibsadate,'yyyy-mm-dd hh24:mi:ss') from tblinsa;
        
        select
         '2026-01-23', -- 2016-01-23
         to_date('2026-01-23'),--	16/01/23
           to_date('2026-01-23 12:30:40','yyyy-mm-dd hh24:mi:ss'), --26/01/23 -- 년월일 이후는 내가 직접 알려줘야함?? 시분초는 무조건 알려줘여됨
           to_date('2026.01.23','yyyy.mm.dd'),
           to_date('20260123','yyyymmdd'),
            to_date('2026.01.23'),  -- 이정도는 자동
           to_date('20260123')
         from dual;
        
        
        
        --tblinsa. 2010-01-01~2010-12-31 사이에 입사한 직원
        select * from tblinsa
            where ibsadate >='2010-01-01'
             and ibsadate <='2010-12-31';  --00:00:00 자동이라 실제로는 1230까지라 
             
               select * from tblinsa
            where ibsadate >=to_date('2010-01-01 00:00:00','yyyy-mm-dd hh24:mi:ss')
             and ibsadate <=to_date('2010-12-31 23:59:59','yyyy-mm-dd hh24:mi:ss');
             
         select * from tblinsa
            where to_char(ibsadate,'yyyy')='2010';
             
             