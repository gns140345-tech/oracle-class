--ex24_pseudo.sql



/*


    의사 컬럼,pseudo column
    -  실제 컬럼은 아닌데 컬럼처럼 행동하는 객체
    
    
    rownum
    -행번호
    -테이블 내의 레코드의 행번호를 가져오는 역할
    -오라클 전용
    








*/
select 
name,buseo,--일반 컬럼(속성) >레코드에 따라 서로 다른 값을 가진다(개인데이터)
100,--상수도 온다 > 모든 레코드가 동일한 값을 가진다
length(name), --가공된 값(컬럼) 
rownum -- 의사컬럼(컬럼이 아닌데 컬럼 자리에옴)
from tblinsa;

select name, buseo, rownum from tblinsa where rownum=1;
select name, buseo, rownum from tblinsa where rownum<=5;  --1~4가 포함돼서 가능

select name, buseo, rownum from tblinsa where rownum=5;  -- 첫번째 rownum=1 > 탈락 > 아예 데이터에서 빠짐 >> rownum2가 1번으로 재할당 > 계속 재할당>> 결국 끝까지 가서 다 탈락==rownum은 고정값이 아니다.
select name, buseo, rownum from tblinsa where rownum>=5 and rownum<=10; --1~4포함 x

--*** 1.where 절에 의해서 결과셋에 변화가 발생할 때마다 rownum이 다시 계산된다
--***2.rownum이 언제 만들어지느냐? >from절이 실행할때!! 생성된다
--서브쿼리 +rownum
--급여가 ㄱ장많은 5명을 가져오시오
select
name, basicpay, rownum --2.가져오기
from tblinsa --1.현재 테이블의 상태 + rownum 행번호를 할당
;

select
name, basicpay, rownum --2.가져오기
from tblinsa --1.현재 테이블의 상태 + rownum 행번호를 할당
order by basicpay desc; --3.basicpay 따라 재배치 >rownum도 basicpay 순서따라 뒤죽박죽

select name,basicpay, rnum ,rownum
from(select
name, basicpay, rownum as rnum
from tblinsa 
order by basicpay desc); 
--rnum은 필요없는 순자  >> from이 하나 더 있어서 rownum이 다시 생성

select name,basicpay, rownum
from(select
name, basicpay
from tblinsa 
order by basicpay desc)where rownum<=5;

--그래서 rnum은 날려도됨

--결론
--1. 원하는 정렬을 한다
--2.1을 인라인(서브쿼리)로 사용해서 메인 쿼리를 작성한다
--3.메인 쿼리의 rownum을 사용한다.


top10
허경운	2650000
홍길동	2610000
이순애	2550000                 
김종서	2540000
이미경	2520000
김인수	2500000
지재환	2450000
이상헌	2350000
최석규	2350000
김영길	2340000

rownum<=5
홍길동	2610000
이순애	2550000
김정훈	1954200
한석봉	1420000
이순신	1320000

order by 없을때
홍길동	2610000	1
이순신	1320000	2
이순애	2550000	3
김정훈	1954200	4
한석봉	1420000	5

--하지만 아직 =5는 출ㄺ안됨
select name,basicpay, rownum ,rnum
from (select name,basicpay, rownum as rnum
from(select name, basicpay
from tblinsa 
order by basicpay desc)) where rnum =5;
--rnum은 가장 바깥쪽 from절에 의한 영향을 안받음 >> 고정값 가능
--rownum은 가장 바깥쪽 where에 의해 계속 값을 재할당 >고정불가 >>불필요한 값


select name,basicpay, rnum
from (select name,basicpay, rownum as rnum
from(select name, basicpay
from tblinsa 
order by basicpay desc)) where rnum >=5 and rnum <=10;

이미경	2520000	5
김인수	2500000	6
지재환	2450000	7
이상헌	2350000	8
최석규	2350000	9
김영길	2340000	10

--페이징 + 수당정렬 수당이 많은 사람순으로 > 10명씩 보여주기

select * from tblinsa order by sudang desc;


select i.*,rownum from tblinsa i order by sudang desc;


select a.*,rownum  from
(select * from tblinsa order by sudang desc)a
where rownum between 1 and 10;  --1이포함돼서 가능

select * from
(select a.*,rownum as rnum from
(select * from tblinsa order by sudang desc)a)
where rnum between 11 and 20;

select * from
(select a.*,rownum as rnum from
(select * from tblinsa order by sudang desc)a)
where rnum between 21 and 30;

.....
--아예 처음부터 뷰로  수당이 순서대로정렬되어 있는 테이블을 만든다
create or replace view vwsudang
as
select a.*,rownum as rnum from
(select * from tblinsa order by sudang desc)a;

select * from vwsudang where rnum=5;

/*
    순서 (순위)와 관련된 작업
    
    --오라클 전용 문법
    
    1.rownum
        
    
    2. 순위함수 >rownum을 편한게 + 추가된 기능을 제공
    
    3.offset fetch >>12c 버전 이후 도입



*/