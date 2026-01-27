--EX22_UNION.SQL

/*
        테이블
        -합집합(union
        -차집합(minus
        -교집합(intersect




*/

select * from tblmen;
select * from tblwomen;

select * from tblmen m inner join tblwomen w on m.name =w.couple;


select * from tblmen --a
union
select * from tblwomen;  --b

select  * from tblinsa --컬럼 10개
union
select * from tbltodo --컬럼 4개
--ORA-01789: 질의 블록은 부정확한 수의 결과 열을 가지고 있습니다.



select  name,ibsadate  from tblinsa --컬럼 10개
union
select title, adddate from tbltodo; --컬럼 4개 --강제로 컬럼 수를 맞출수는 있음


--쇼핑몰 >> 구매이력
--전체기간x >> 전체기간 제공한다면 >> union
--3개월,6개월
--2026년,2025년,2024년
select * from 구매 2026;-10
select * from 구매 2025;--1백
select * from 구매 2024;--1백




select * from 구매 2026-10
union
select * from 구매 2025--1백
union
select * from 구매 2024;--1백



-- 회사 > 게시판 >부서별 전용 게시판
select * from 영업부게시판;
select * from 총무부게시판;
select * from 개발부게시판;

--사장님 >> 모든 게시판을 한번에 볼수?
select * from 영업부게시판
union
select * from 총무부게시판
union
select * from 개발부게시판;


--야구 선수  > 공격수, 수비수
select * from  공격수;
select * from 수비수;

select 공통된컬럼 from 공격수
union
select 공통된컬럼 from 수비수;

--동물  >> 애완동물
create table tblaaa(
    name varchar2(30) not null,
    color varchar2(30) not null
    );
    --동물 >> 야생동물
    create table tblbbb(
    name varchar2(30) not null,
    color varchar2(30) not null
    );
    
    insert into tblaaa values('강아지', '검정');
     insert into tblaaa values('고양이', '노랑');
      insert into tblaaa values('토끼 ', '갈색');
       insert into tblaaa values('거북이 ', '녹색');
       insert into tblaaa values('강아지 ', '회색');
       
       
            insert into tblbbb values('강아지', '검정');
             insert into tblbbb values('고양이', '노랑');
              insert into tblbbb values('호랑이 ', '주황');
               insert into tblbbb values('사자 ', '회색');
                insert into tblbbb values('고양이 ', '삼색');
                
                select * from tblaaa;
                select * from tblbbb;
                
                --union >수학의집합 >>중복이 제거됨
                select * from tblaaa --5개
                union
                select * from tblbbb;--5개
강아지 	검정
고양이 	노랑
토끼 	갈색
거북이 	녹색    >>교집합은제거
강아지 	회색
고양이	노랑
호랑이 	주황
사자 	회색
고양이 	삼색

                select * from tblaaa --5개
                union all
                select * from tblbbb;--5개
  >> 중복된것까지 다 보여줌
  
  
  
  --차집합(minus)
  select * from tblaaa
  minus
  select * from tblbbb;


 select * from tblbbb
  minus
  select * from tblaaa;
  
  
  --교집합
  select * from tblaaa
  intersect
  select * from tblbbb;
  
  
  
