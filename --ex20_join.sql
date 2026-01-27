--ex20_join.sql

/*
        관계형 데이터베이스 시스템이 지양하는 것들 >>테이블을 잘못 만들면 발생
        
        1.테이블에 기본키가 없는 상태 >>없으면 데이터를 수정 삭제하는 과정에서 구분하지 못해서 곤란 pk가 있으면 번호로 구별가능
        
        2.null이 많은 상태의 테이블 >d이유: 공간 낭비+ sql  작업 불편
        
        3.하나의 속성값이 원자값이 아닌 상태 > 더 이상 쪼개지지 않는 값을 넣어야 한다. ex>운동,독서,코딩 

        4.데이터가 중복되는 상태를 싫어함 > 데이터 관리 불편(일관성 저하)


*/

---------------------------111
    create table tblnote(
        --seq number primary key
        name varchar2(30) not null, --작성자
        content varchar2(1000) not null,    --내용
        regdate date default sysdate not null
        );
        
        insert into tblnote values('홍길동','자바 정리', default);
         insert into tblnote values('아무개','오라클 정리', default);
          insert into tblnote values('강아지','네트워크 정리', default);
           insert into tblnote values('고양이','자바 정리', default);
            insert into tblnote values('홍길동','알고리즘 정리', default);
           insert into tblnote values('홍길동','자바 정리', default);
           
          select * from tblnote;
          
          update tblnote set content='자바 수업 정리' where content ='자바 정리';    
          update tblnote set content='자바 수업 정리' where name ='홍길동';
           update tblnote set content='자바 수업 정리' 
           where content='자바 정리' and  name ='홍길동';
           
           ---------------------------------------------------------------
           
           
           drop table tbluser;
        create table tbluser(
            id varchar2(30) primary key,
            name varchar2(30) not null,
            hobby1 varchar2(50),
            hobby2 varchar2(50),
            hobby3 varchar2(50) --차라리 컬럼 3개
        );
        --회원이 만명 가입
        --딱 1명이 취미가 100개이고
        나머지 9999명은 취미가 0~2개 >>너무 많은 null 발생/데이터 낭비
        --테이블 설계 잘못
        
        insert into tbluser values('hong','홍길동','독서',null,null);
          insert into tbluser values('dog','강아지','null',null,null);
            insert into tbluser values('cat','고양이','운동','독서','코딩');
            insert into tbluser values('test','테스트','런닝','메뉴얼독서',null);
            
             select * from tbluser ;
            select * from tbluser where hobby1='독서' or hobby2='독서' or hobby3='독서';
            
            select * from tbluser where hobby like '%독서%'; -- 원자값이 아니면 찾기 번거로움
            
            update tbluser  set hobby='책읽기' where hobby='독서';
            --'독서'>>'책읽기'
            --'매뉴얼독서'는 그대로
            
            
            
            ---쇼핑몰 >판매테이블
    create table tblshop(
        seq number primary key, --판매번호
        id varchar2(30) not null, --고객아이다
        name varchar2(30) not null, --고객명
        tel varchar2(15) not null,    --연락처
        item varchar2(50) not null,--상품명
        qty number not null,    --수량
        regdate date default sysdate not null
    );
    
    insert into tblshop 
    values(1,'hong','홍길동', '010-1234-5678','마우스',1,default);
    
        insert into tblshop 
    values(2,'test','테스트' ,'010-5555-6666','키보드',1,default);
    
        insert into tblshop 
    values(3,'honh','홍길동', '010-1234-5678','태블릿',1,default);
    
    
    
    
    --직원정보
    --직원(번호pk)_,직원명, 급여,거주지, 담당프로젝트)
    create table tblstaff(
    seq number primary key, --직원번호
    name varchar2(30) not null,--직원명
    salary number not null, --급여
    address varchar2(300) not null,--거주지
    project varchar2(300) not null  --담당프로젝트
    );
    
        insert into tblstaff values(1,'홍길동', 300,'서울시','홍콩 수출');
          insert into tblstaff values(2,'아무개', 250,'인천시','tv 광고');
            insert into tblstaff values(3,'하하하', 350,'의정부시','매출 분석');
            
            select * from tblstaff
    --홍길동에게 담당 프로젝트를 1개 추가 >>'고객 관리'  >>홍콩수출과 고객관리 >>다중값>관리 힘듦
    
    1	홍길동	300	서울시	홍콩 수출,고객관리
    2	아무개	250	인천시	tv 광고
    3	하하하	350	의정부시	매출 분석
    4.  홍길동 ~
    
    --잘못만든 테이블
    
    drop table tblstaff;
    
    
        create table tblstaff(  --부모테이블
    seq number primary key, --직원번호
    name varchar2(30) not null,--직원명
    salary number not null, --급여
    address varchar2(300) not null--거주지
    --project varchar2(300)  --담당프로젝트  >>프로젝트가 여러개 들어가는 문제 >> 뺀다
    
    );
    
    --테이블을 하나 더 만듦
    create table tblproject(        --자식테이블
        seq number primary key,             --프로젝트 번호(pk)
        project varchar2(300) not null,      --프로젝트명 >> 누구 담당인지 알수 없음 >>뒤에 담당직원의 번호를 집어넣기 ,아름은 동명이인때매 x
        staff_seq number not null           --담당직원번호 not null이 없으면 >> 아직 담당직원이 배치 안되었을수도 있다  --부모테이블의 직원번호를 참조해서 자식 테이블이라 한다
    );
  
    
    
    
            insert into tblstaff values(1,'홍길동', 300,'서울시');
            insert into tblstaff values(2,'아무개', 250,'인천시');
            insert into tblstaff values(3,'하하하', 350,'의정부시');
            
   
    
            
               insert into tblproject values(1,'홍콩 수출',1);
               insert into tblproject values(2,'tv광고',2);
              insert into tblproject values(3,'매출 분석', 3);
              insert into tblproject values(4,'tv 광고', 2);
              insert into tblproject values(5,'대리점 분양', 2);
            
            select * from tblstaff;
                 
           drop table tblproject;
 
    --tv 광고 담당자 호출
    --2 tv광고 2  >>직원의 번호를 알아냄 >>직원이름을 알아보자
    select * from tblproject where project ='tv광고';
    select * from tblstaff where seq= 2;
    --== 서브쿼리
     select * from tblstaff 
     where seq =(select staff_seq from tblproject where project ='tv광고');
     
     --a. 신입 사원 입사 >> 신규 프로젝트 배정
     --a.1 신입 사원 추가
     insert into tblstaff values(4,'호호호',220,'성남시');
     
     --a.2 신규 프로젝트 배정
     insert into tblproject values(6,'자재 매입',4);
     
      select * from tblstaff 
     where seq =(select staff_seq from tblproject where project ='자재 매입');
    
    --a.3 신규 프로젝트 추가
    insert into tblproject values(7, '고객 유치',5);  
    --ORA-02291: 무결성 제약조건(HR.SYS_C008487)이 위배되었습니다- 부모 키가 없습니다 >>foreign key참조 이후 안들어감 >>부모키의 primary키가 없다
    
    select * from tblproject;
    
     select * from tblstaff 
     where seq =(select staff_seq from tblproject where project ='고객 유치');  -- 아무것도 안나옴
     --존재하지 않은 직원 5번
     
     
     
     
     
     
     
     
     --b '홍길동'퇴사
     --b.1 '홍길동' 삭제
    -- delete from tblstaff where name ='홍길동'; --신중( 동명이인)
     delete from tblstaff where seq =1; --유일한 식별자로 검색 pk
     -ORA-02292: 무결성 제약조건(HR.SYS_C008487)이 위배되었습니다- 자식 레코드가 발견되었습니다 >> 자기번호를 참조하는 레코드가 존재
    select *from tblstaff;
    
       select * from tblstaff 
     where seq =(select staff_seq from tblproject where project ='홍콩 수출');  --홍길동 퇴사
    
      insert into tblstaff values(1,'홍길동', 300,'서울시');
      
      --b.2 '홍길동' 삭제 전 >> 업무 인수 인계(위임)
        select * from tblproject;
        
        update tblproject set staff_seq =2 where staff_seq =1; -- 1번이 2번에게 위임
        
        --b.3 홍길동 퇴사
         delete from tblstaff where seq =1;
      
      
        select * from tblstaff 
     where seq =(select staff_seq from tblproject where project ='홍콩 수출');
      
      
      drop table tblstaff;
      select * from tblprojectl
      
          create table tblproject(  
      seq number primary key, --v프로젝트
     project varchar2(30) not null,
        --담당직원번호
    staff_seq number not null references tblstaff(seq)
  
    );
      --테이블 생성순서
      --1.부모테이블 먼저 >2. 자식 테이블
      
      
      --테이블 삭제 순서
      --1.자식테이블 부터 >>2.부모테이블
      
      ----------------------------------------------------------------------
      
      
        create table tblshop( --판매정보   --자식테이블
        seq number primary key, --판매번호
        item varchar2(50) not null,--상품명
        qty number not null,    --수량
        regdate date default sysdate not null
        id varchar2(30) not null references tbluser(id) --구매 고객(fk) --참조키는 항상 부모테이블의 pk와 관계
        );        
                
         create table tbluser(       --고객정보 --부모
         
        id varchar2(30) primary key, --고객아이디 >> 중복허용할거면 seq number
        name varchar2(30) not null, --고객명
        tel varchar2(15) not null    --연락처  >> 번호 변경 수정하는 과정에서 이전번호를 다른 사람이 쓸 수 있어서 primary key불가
    );
    --부모 자식 테이블 구분법 >> 누가 먼저 생겨야 할지? 직원이 있어야 프로젝트가 시작되는거처럼// 회원가입 있어야 판매가 가능
      
      
      
      -- 2개
-- 고객 테이블
create table tblCustomer (
    seq number primary key,         --고객번호(PK)
    name varchar2(30) not null,     --고객명
    tel varchar2(15) not null,      --연락처
    address varchar2(100) not null  --주소
);

-- 판매내역 테이블
create table tblSales (
    seq number primary key,                             --판매번호(PK)
    item varchar2(50) not null,                         --제품명
    qty number not null,                                --수량
    regdate date default sysdate not null,              --판매날짜
    cseq number not null references tblCustomer(seq)    --고객번호(FK)
);




-- 4개(비디오 대여방)

-- 장르
create table tblGenre (
    seq number primary key,     --장르번호(PK)
    name varchar2(30) not null, --장르명
    price number not null,      --대여가격
    period number not null      --대여기간(일)
);

-- 비디오
create table tblVideo (
    seq number primary key,                         --비디오번호(PK)
    name varchar2(100) not null,                    --제목
    qty number not null,                            --수량
    company varchar2(50) null,                      --제작사
    director varchar2(50) null,                     --감독
    major varchar2(50) null,                        --주연배우
    genre number not null references tblGenre(seq)  -- 장르번호(FK)
);

-- 회원 테이블
create table tblMember (
    seq number primary key,     --회원번호(PK)
    name varchar2(30) not null, --회원명
    grade number(1) not null,   --회원등급(1,2,3)
    byear number(4) not null,   --생년
    tel varchar2(15) not null,  --연락처
    address varchar2(300) null, --주소
    money number not null       --예치금
);

-- 대여
create table tblRent (
    seq number primary key,                             --대여번호(PK)
    member number not null references tblMember(seq),   --회원번호(FK)
    video number not null references tblVideo(seq),     --비디오번호(FK)
    rentdate date default sysdate not null,             --대여시각
    retdate date null,                                  --반납시각
    remart varchar2(500) null                           --비고
);

create sequence genreSeq;
create sequence videoSeq;
create sequence memberSeq;
create sequence rentSeq;
      
      
      /*  
        조인, join -테이블을 여러개 사용할때
        (서로 관계를 맺고) 2개(1개) 이상의 테이블을 대상으로 select >1개의 결과셋
        -테이블을 여러개로 합치는 기술
        
        조인의 종류(ansi)
        1.크로스조인 ,cross join
        2.내부조인, inner join
        3.외부조인, outer join
            5.전체 외부 조인 , full outer join
        4.셀프조인, self join
        
      
      db이론
       -관계 대수 > 연산(자)
       -테이블 자체를 피연산자로 하는 연산
       -테이블 +테이블  =union
       -테이블 - 테이블 =minus
       -테이블 * 테이블 =join
      
      
        1.크로스조인 ,cross join(모든 조인의 기본동작, 모든 조인안에 들어가 있음)
        -카티션 곱, 데카르트 곱
        -a 테이블 x b 테이블 = 1개의 결과 테이블이 나옴
        -쓸모 없다  > 가치가 있는 행과 가치가 없는 행이 뒤섞여 있다.
        -유효성과 관계 없는 양이 많은 데이터가 필요할 때 >> 대량의 더미 데이터용으로 사용
      
      */
      select * from tblcustomer; --고객 3명
      select * from tblsales;  --판매 9건
      
      
        1	전화기	1	26/01/27	1                   1	홍길동	010-1234-5678	서울시  1	전화기	1	26/01/27	1  
        2	다이어리	3	26/01/27	2                   1	홍길동	010-1234-5678	서울시   2	다이어리	3	26/01/27	2
        3	노트	10	26/01/27	2                       1	홍길동	010-1234-5678	서울시   3	노트	10	26/01/27	2  
        4	볼펜	20	26/01/27	3                           ......
        5	지우개	15	26/01/27	3
        6	마우스	5	26/01/27	1                                             3x9
        7	키보드	2	26/01/27	3
        8	모니터	1	26/01/27	2
        9	선풍기	2	26/01/27	1
      
      
       1	홍길동	010-1234-5678	서울시 
        2	아무게	010-3333-4444	인천시
        3	하하하	010-5555-6666	부산시
      
      select * from tblcustomer cross join tblsales; --ansi 전용
      select * from tblcustomer ,tblsales; -- oracle전용
      --결론 쓸데가 없다
      
1	홍길동	010-1234-5678	서울시	1	전화기	1	26/01/27	1(foreign key) >>1번만 쓸모있는 데이터 ,길동이가 사간 물건과 일치해야
1	홍길동	010-1234-5678	서울시	2	다이어리	3	26/01/27	2
1	홍길동	010-1234-5678	서울시	3	노트	10	26/01/27	2
1	홍길동	010-1234-5678	서울시	4	볼펜	20	26/01/27	3
1	홍길동	010-1234-5678	서울시	5	지우개	15	26/01/27	3
1	홍길동	010-1234-5678	서울시	6	마우스	5	26/01/27	1
1	홍길동	010-1234-5678	서울시	7	키보드	2	26/01/27	3
1	홍길동	010-1234-5678	서울시	8	모니터	1	26/01/27	2
1	홍길동	010-1234-5678	서울시	9	선풍기	2	26/01/27	1
2	아무게	010-3333-4444	인천시	1	전화기	1	26/01/27	1
2	아무게	010-3333-4444	인천시	2	다이어리	3	26/01/27	2(2번만)
2	아무게	010-3333-4444	인천시	3	노트	10	26/01/27	2
2	아무게	010-3333-4444	인천시	4	볼펜	20	26/01/27	3
2	아무게	010-3333-4444	인천시	5	지우개	15	26/01/27	3
2	아무게	010-3333-4444	인천시	6	마우스	5	26/01/27	1
2	아무게	010-3333-4444	인천시	7	키보드	2	26/01/27	3
2	아무게	010-3333-4444	인천시	8	모니터	1	26/01/27	2
2	아무게	010-3333-4444	인천시	9	선풍기	2	26/01/27	1
3	하하하	010-5555-6666	부산시	1	전화기	1	26/01/27	1
3	하하하	010-5555-6666	부산시	2	다이어리	3	26/01/27	2
3	하하하	010-5555-6666	부산시	3	노트	10	26/01/27	2
3	하하하	010-5555-6666	부산시	4	볼펜	20	26/01/27	3
3	하하하	010-5555-6666	부산시	5	지우개	15	26/01/27	3
3	하하하	010-5555-6666	부산시	6	마우스	5	26/01/27	1
3	하하하	010-5555-6666	부산시	7	키보드	2	26/01/27	3
3	하하하	010-5555-6666	부산시	8	모니터	1	26/01/27	2
3	하하하	010-5555-6666	부산시	9	선풍기	2	26/01/27	1
      
      
      
      /*
        2.내부(단순)조인 ,inner join
         -크로스 조인에서 유효한 레코드만 추출한 조인( 쓸데없는 값 버림)
         
         -select 컬럼리스트 from 테이블a cross join 테이블 b;
         -select 컬럼리스트 from 테이블a inner join 테이블 b on(조건=where절) 테이블a.pk=테이블b.fk;
         
         
      
      
      
      
      
      */
      -- 두테이블에서 쓸모있는 값만 모아둔것
      select * from tblcustomer 
      inner join tblsales 
      on tblcustomer.seq = tblsales.cseq;
      
      --oracle 버전
        select * from tblcustomer , tblsales 
       where tblcustomer.seq = tblsales.cseq;
      
1	홍길동	010-1234-5678	서울시	1	전화기	1	26/01/27	1
2	아무게	010-3333-4444	인천시	2	다이어리	3	26/01/27	2
2	아무게	010-3333-4444	인천시	3	노트	10	26/01/27	2
3	하하하	010-5555-6666	부산시	4	볼펜	20	26/01/27	3
3	하하하	010-5555-6666	부산시	5	지우개	15	26/01/27	3
1	홍길동	010-1234-5678	서울시	6	마우스	5	26/01/27	1
3	하하하	010-5555-6666	부산시	7	키보드	2	26/01/27	3
2	아무게	010-3333-4444	인천시	8	모니터	1	26/01/27	2
1	홍길동	010-1234-5678	서울시	9	선풍기	2	26/01/27	1

------------------------------------------------------------

      select 
     c.seq as 회원번호,
      c.name as 회원명,
      s.seq as 판매번호,  -- 결과값에는 seq_1이라 뜨지만 사실 seq 그래서 회원번호와 판매번호가 충돌 >> 앞에 테이블 이름을 붙여서 구분해준다. 근데 테이블명이 너무길다 alias c ,s붙임
         s.item as 상품명
      from tblcustomer c
      inner join tblsales s
      on c.seq = s.cseq;
      
      
      
      --고객 테이블과 판매 테이블
      -- 어떤 고객(c.name)이 어떤 물건(S.ITEM)을 몇 개를(S.QTY) 사갔습니까?
      
      
     --방법1
      SELECT 
      c.name,
      s.item,
      s.qty
      FROM tblcustomer c
      inner join tblsales s
        on c.seq=s.cseq;
        
       --방법2 
        select
        item,
        qty,
        cseq,
        (select name from tblcustomer where seq=tblsales.cseq)  ---상관서브쿼리
        from tblsales; --자식테이블을 메인 쿼리로
      
      ---------------------------
      --비디오(자식) + 장르(부모테이블0 자식테이블이나 부모테이블이나 누가 먼저오든 상관은 없다.
      
        select
        * 
        from tblgenre g
            inner join tblvideo v
                on g.seq= v.genre;  --어떤 장르안에 어떤 비디오가 있는지
                
                --비디오(c)와 장르(p) //비디오(p) + 대여(c) 
                
                --대여+ 비디오 +장르 =대여 x 비디오 x 장르
                
                
       select
        * 
        from tblgenre g               --장르
            inner join tblvideo v      --x비디오
                on g.seq= v.genre
                    inner join tblrent r  --x대여
                        on v.seq= r.video;   --렌트가 비디오 
                        
 1	액션	1500	2	3	털미네이터	3	파라마운트	James	John	1	3	3	3	07/02/03		
1	액션	1500	2	3	털미네이터	3	파라마운트	James	John	1	4	4	3	07/02/04	07/02/08	
2	에로	1000	1	2	어쭈구리	5	에로 프로덕션	김감독	박에로	2	2	2	2	07/02/02	07/02/03	
2	에로	1000	1	2	어쭈구리	5	에로 프로덕션	김감독	박에로	2	6	1	2	07/02/10		
3	어린이	1000	3	1	영구와 땡칠이	5	영구필름	심영래	땡칠이	3	1	1	1	07/01/01		
5	멜로	2000	1	5	뽀뽀할까요	6	뽀뽀사	박감독	최지후	5	5	5	5	07/02/05		  

--07-01-01에 빌련간 사람의 회원 정보를 알고 싶다  >>회원 테이블도 조인

               --회원ㅔ+ 대여c=비디오(c)와 장르(p) //비디오(p) + 대여(c) 
                                                                                --회원  --대여  --- 비디오 ---장르
                --회원(p) + 대여c= 대여c+ 비디오p +장르 =대여 x 비디오 x 장르                 
      
       select
        * 
        from tblgenre g               --장르
            inner join tblvideo v      --x비디오
                on g.seq= v.genre
                    inner join tblrent r  --x대여
                        on v.seq= r.video   --렌트가 비디오 
                            inner join tblmember m
                                on m.seq= r.member;
      
      
      
      /*
        3.외부조인,outer join
         -내부 조인의 반댓말이 아님
         -내부 조인결과를 그대로 가지고 + @ 
         -내부 조인의 확장 개념
         
        -select
            컬럼리스트
     
       from 테이블a     (left or right를 반드시 선택) outer inner join 테이블 b   >> 방향  left이면 from a table쪽 right이면 from b 쪽을?
                on(조건=where절) 테이블a.pk=테이블b.fk;
      
      
      
      */
      
      select * from tblcustomer;    --3명
      select* from tblsales;            --9건
      
      
      insert into tblcustomer values(4,'강아지','010-1234-5678', '서울시');
            insert into tblcustomer values(5,'고양이','010-1234-5678', '서울시');
      
      
      --내부 조인
      --물건을 한번이라도 구매한 이력이 있는 고객의 정보와 구매내역을 가져오시오
      
      --외부조인
       --모든(구매이력이 있든 없든) 고객의 정보를 가져와라
       --구매이력이 있다면 구매내역도 같이 가져오시오
       -- 방향 > 부모 테이블을 가르킨다.
       
    select * from tblcustomer c
        inner join tblsales s
            on c.seq =s.cseq;
      
      1	홍길동	010-1234-5678	서울시	1	전화기	1	26/01/27	1
2	아무게	010-3333-4444	인천시	2	다이어리	3	26/01/27	2
2	아무게	010-3333-4444	인천시	3	노트	10	26/01/27	2
3	하하하	010-5555-6666	부산시	4	볼펜	20	26/01/27	3
3	하하하	010-5555-6666	부산시	5	지우개	15	26/01/27	3
1	홍길동	010-1234-5678	서울시	6	마우스	5	26/01/27	1
3	하하하	010-5555-6666	부산시	7	키보드	2	26/01/27	3
2	아무게	010-3333-4444	인천시	8	모니터	1	26/01/27	2
1	홍길동	010-1234-5678	서울시	9	선풍기	2	26/01/27	1
      
      --강아지와 고양이가 없는 이유는 구매한 이력이 없어서
      
      
      --외부 조인 --기본 inner조인 + @(left=tblcustomer >> 구매이력이 없는 애들까지 >> 강아지 고양이
     
      --
        select * from tblcustomer c
        left outer join tblsales s  
            on c.seq= s.cseq;  --강아지 고양이가 존재
      
 1	홍길동	010-1234-5678	서울시	1	전화기	1	26/01/27	1
2	아무게	010-3333-4444	인천시	2	다이어리	3	26/01/27	2
2	아무게	010-3333-4444	인천시	3	노트	10	26/01/27	2
3	하하하	010-5555-6666	부산시	4	볼펜	20	26/01/27	3
3	하하하	010-5555-6666	부산시	5	지우개	15	26/01/27	3
1	홍길동	010-1234-5678	서울시	6	마우스	5	26/01/27	1
3	하하하	010-5555-6666	부산시	7	키보드	2	26/01/27	3
2	아무게	010-3333-4444	인천시	8	모니터	1	26/01/27	2
1	홍길동	010-1234-5678	서울시	9	선풍기	2	26/01/27	1
4	강아지	010-1234-5678	서울시					
5	고양이	010-1234-5678	서울시			null		
      
      
      
        select * from tblcustomer c
        right outer join tblsales s
            on c.seq= s.cseq;
      -- inner + right(tblsales) >>이미 inner조인이랑 같음 >> 더 가져올것이 없다
      
      1	홍길동	010-1234-5678	서울시	1	전화기	1	26/01/27	1
1	홍길동	010-1234-5678	서울시	6	마우스	5	26/01/27	1
1	홍길동	010-1234-5678	서울시	9	선풍기	2	26/01/27	1
2	아무게	010-3333-4444	인천시	2	다이어리	3	26/01/27	2
2	아무게	010-3333-4444	인천시	3	노트	10	26/01/27	2
2	아무게	010-3333-4444	인천시	8	모니터	1	26/01/27	2
3	하하하	010-5555-6666	부산시	4	볼펜	20	26/01/27	3
3	하하하	010-5555-6666	부산시	5	지우개	15	26/01/27	3
3	하하하	010-5555-6666	부산시	7	키보드	2	26/01/27	3
      
      
      
       select * from tblstaff;  --4명(3명 담당 0, 1명 - 담담 x)
       select * from tblproject;--6건
      
      
      
      --내부조인
      -- 프로젝트를 1개 이상 담당하고 있는 직원정보와 프로젝트의 정보를가져오시오
      
         select * from tblstaff s
         inner join  tblproject p
            on s.seq=p.staff_seq;
         ;
      --외부 조인
      --담당 프로젝트 유무와 상관없이 모든 직원 정보 가져와라 + 담담 프로젝트정보
      
      
           select * from tblstaff s
       left  outer join  tblproject p
            on s.seq=p.staff_seq;
         ;
2	아무개	250	인천시	1	홍콩 수출	2
2	아무개	250	인천시	2	tv광고	2
3	하하하	350	의정부시	3	매출 분석	3
2	아무개	250	인천시	4	tv 광고	2
2	아무개	250	인천시	5	대리점 분양	2
1	홍길동	300	서울시			
		
        
        
        /*
        내부 조인인데 + 셀프조인인 것과
        외부 조인인데 + 셀프조인인 것이 있다.
        
        4.셀프 조인
            - 1개의 테이블을 사용하는 조인
            - 테이블이 자기 스스로와 관계를 맺고있는 경우에만 사용
            
        
        
        */
      
      --직원 테이블
      --hr.employees >>자기참조
      create table tblself(
            
            seq number primary key,-- 직원번호 (pk)
            name varchar2(30) not null,  --직원명
            department varchar2(50) not null, --부서명
            boss number  null references tblself(seq)              --상사의 직원번호(fk)-- 자기가 자기를 참조( 사장이 상사가 없어서 null)
      );
      
      insert into tblself values(1 , '홍사장', '사장실',null);
     insert into tblself values(2 , '김부장', '영업부',1);
      insert into tblself values( 3, '박과장', '영업부',2);
     insert into tblself values( 4, '최대리', '영업부',4);
     insert into tblself values( 5, '정사원', '영업부',4);
     insert into tblself values( 6, '이부장', '개발부',1);
     insert into tblself values( 7, '하과장', '개발부',6);
     insert into tblself values(8, '신과장', '개발부',6);
     insert into tblself values( 9, '황대리', '개발부',7);
       insert into tblself values(10 , '허사원', '개발부',9); 
       
       --직원 명단을 가져오시오 . 단, 상사의 이름까지
       --1. join
       --2. sub query
       --3.계층형 쿼리      로 가져올수 있다
       select * from tblself;
       
       --1. join
       
    --직원들 중 직속 상사가 있는 직웜난 가져오시오.   
       select
       S2.NAME AS 직원명,
       s2.department as 부서명,
       s1.name as 상사명
       from tblself s1   -- 상사 테이블이다라고 생각
            inner join tblself s2 -- 부하직원테이블
        on s1.seq= s2.boss ;
        

      
   상사명                      직원명
1	홍사장	사장실		2	김부장	영업부	1
2	김부장	영업부	1	3	박과장	영업부	2
4	최대리	영업부	4	4	최대리	영업부	4
4	최대리	영업부	4	5	정사원	영업부	4
1	홍사장	사장실		6	이부장	개발부	1
6	이부장	개발부	1	7	하과장	개발부	6
6	이부장	개발부	1	8	신과장	개발부	6
7	하과장	개발부	6	9	황대리	개발부	7
9	황대리	개발부	7	10	허사원	개발부	9
      
      
      
김부장	영업부	홍사장
박과장	영업부	김부장
최대리	영업부	최대리
정사원	영업부	최대리
이부장	개발부	홍사장
하과장	개발부	이부장
신과장	개발부	이부장
황대리	개발부	하과장
허사원	개발부	황대리
      -- 사장 제외
      
      
              --모든 직원(+상사 정보) 가져오시오( 상사가 없는 사장까지) -- outer right
      
         select
       S2.NAME AS 직원명,
       s2.department as 부서명,
       s1.name as 상사명
       from tblself s1   
        right  outer join tblself s2 
        on s1.seq= s2.boss ;
      
      
김부장	영업부	홍사장
이부장	개발부	홍사장
박과장	영업부	김부장
최대리	영업부	최대리
정사원	영업부	최대리
하과장	개발부	이부장
신과장	개발부	이부장
황대리	개발부	하과장
허사원	개발부	황대리
홍사장	사장실	
      
      
      -----------------------
      --서브쿼리로
      select
            name as 직원명,
            department as 부서명,
            boss,
            (select name from tblself where seq=a.boss)
      from tblself a; --직원(자식) 테이블
      
      
      
      --------------------------------------
      5. full outer join
      
      /*
        5.전체 외부 조인
        -서로 참조하고 있는 관계에서 사용
        -table a >참조>table b
        -table b>참조> table a
      
      
      
      
      */
      select *from tblmen;
      select * from tblwomen;
   men                  women   
홍길동	25	180	70	장도연
아무개	22	175		이세영
하하하	27		80	
무명씨	21	177	72	
유재석	29			김숙
박명수	30	170		김지민
정준하	31	183		신보라
정형돈	28		92	
양세형	22	166	55	김민경
조세호	24	165	58	오나미


--커플인 남/녀를 가져오시오  --서로 참조라 부모 자식 구분x
select
    m.name as 남자,
    w.name as 여자
from tblmen m
        inner join tblwomen w
            on m.name =w.couple;
      
      
-- 커플 + 남자 솔로들...
      
      
      select
    m.name as 남자,
    w.name as 여자
    from tblmen m
       left outer join tblwomen w
            on m.name =w.couple;
      
      
      - 커플 + 여자 솔로들...
      
      
      select
    m.name as 남자,
    w.name as 여자
    from tblmen m
       right outer join tblwomen w
            on m.name =w.couple;
            
        박나래
홍길동	장도연
박명수	김지민
유재석	김숙
조세호	오나미
양세형	김민경
	    홍현희
정준하	신보라
아무개	이세영
        신봉선
      
      
      - 커플 + 남자 여자 솔로들...
      
      
      select
    m.name as 남자,
    w.name as 여자
    from tblmen m
       full outer join tblwomen w
            on m.name =w.couple;
      
      	박나래
홍길동	장도연
박명수	김지민
유재석	김숙
조세호	오나미
양세형	김민경
	    홍현희
정준하	신보라
아무개	이세영
	    신봉선
정형돈	
무명씨	
하하하	
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      item as 상품명
      from tblcustomer 
      inner join tblsales 
      on tblcustomer.seq = tblsales.cseq;


      
      
      
      
      
      