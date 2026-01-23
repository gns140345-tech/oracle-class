--ex12_dll.sql


/*
    수업진도
    
    1.초반 dml(ex01~ex11)
    2.ddl >테이블(구조)
    3.후반 dml
    -------------------------ansi -sql
    4.데이터설계(모델링)8******
    5.간단한 프로젝트(팀 프로젝트):1일
            ----------------------
            6.pl/sql
            ---------------------
            7.db 프로젝트(팀 프로젝트):1주
            
            
            
            
        테이블 생성하기> 테이블 구조(테이블 스키마,schema)설계 > 컬럼을 정의하기
          >컬럼의 이름을 정하고 자료형을 정하고 길이를 정함, 제약사항도 정의
          
          
          create table 테이블명(
          컬럼 선언,
          컬럼명 자료형(길이) null 제약사항
          );

    제약사항 , constraint***********************************************************
    -데이터 베이스의 무결성을 보장하기 위한 장치
    데이터베이스의 무결성이란?
    >>데이터들을 올바른 값으로 유지하기 위한 성질
        -해당 컬럼에 들어갈 데이터에 대한 조건***
        1.조건을 만족하면 저장하고
        2.만족하지 못하면 에러를낸다
        
    1.not null
            -애가 정의된 해당 컬럼은 반드시 값을 가져야한다. 
            -만약 컬럼에 값이 없으면 not null제약사항을 위반했기 때문에 에러가 발생
            -필수값(required_
            
    2.primary key
            -기본키
            -테이블의 행을 구분하기 위한 제약 사항
            -값이 유일하다(unique) + 필수값(not null)
            - 1번+4번 
    3.foreign key
    4.unique
    5.check
    6.default

*/
-- 메모 테이블
create table tblmemo(
--컬럼명 자료형(길이) null 제약사항
        seq number(3)null, -- 이컬럼은 값을 안 넣어도 됩니다(optional) s넣고싶으면 넣고 안넣고 싶으면 넣지마
        name varchar2(30) null,
        memo varchar2(1000) null,
        regdate date null
);


 
 insert into tblmemo(seq,name,memo, regdate)
   values(1,'홍길동','메모입니다','2026-01-23');
    insert into tblmemo(seq,name,memo, regdate)
    
   values(2,'아무개','테스트입니다',
   to_date('2026-01-23 17:07:54','yyyy-mm-dd hh24:mi:ss'));
   
    insert into tblmemo(seq,name,memo, regdate)
   values(3,'강아지','멍멍멍',sysdate);
   
    insert into tblmemo(seq,name,memo, regdate)
   values(4,'고양이','메모',null);
   
       insert into tblmemo(seq,name,memo, regdate)
   values(5,'병아리',null,null);
   
       insert into tblmemo(seq,name,memo, regdate)
   values(6,null,null,null);
   
       insert into tblmemo(seq,name,memo, regdate)
   values(null,null,null,null);

    
    drop table tblmemo;
    
    
    -- 메모 테이블
create table tblmemo(
--컬럼명 자료형(길이) null 제약사항
        seq number(3) not null, --메모번호는 n`n 필수값
        name varchar2(30) null, --작성자 ,선택값
        memo varchar2(1000)not null, --메모내용 nn
        regdate date null --날짜
);
       insert into tblmemo(seq,name,memo, regdate)
   values(1,'강아지','멍멍멍',sysdate);
   
       insert into tblmemo(seq,name,memo, regdate)
   values(2,'고양이',null,sysdate); --ORA-01400: NULL을 ("HR"."TBLMEMO"."MEMO") 안에 삽입할 수 없습니다 >>not null 이라는 제약사항이 있기때문에
   
   
   
       insert into tblmemo(seq,name,memo, regdate)
   values(2,'고양이','',sysdate);  --빈문자열도 null로 취급 ,아무것도 안넣고 생략해도 null, 보통 null은 그냥생략
   

    
    
    
     drop table tblmemo;
    
    
    -- 메모 테이블
create table tblmemo(
--컬럼명 자료형(길이) null 제약사항
        seq number(3) primary key, --메모번호,pk라는 제약사항 ex>주민번호 같은 식별자 역할 >> 유일해야 한다>> 항상 모든테이블에 1개가 존재한다. not null이라고 안적혀 있어도 자동으로 not null이다
        name varchar2(30) null, --작성자 ,선택값
        memo varchar2(1000)not null, --메모내용 nn
        regdate date null --날짜
);

   
   
    select * from tblmemo;
    
 insert into tblmemo(seq,name,memo, regdate)
   values(1,'강아지','멍멍멍',sysdate);
   
    insert into tblmemo(seq,name,memo, regdate)
   values(2,'고양이','멍멍멍',sysdate);
   
    insert into tblmemo(seq,name,memo, regdate)
   values(3,'강아지','왈왈왈',sysdate);
   
    insert into tblmemo(seq,name,memo, regdate)
   values(3,'홍길동','멍멍멍',sysdate); --ORA-00001: 무결성 제약 조건(HR.SYS_C008420)에 위배됩니다. 에러번호 1번
   
       insert into tblmemo(seq,name,memo, regdate)
   values(null,'홍길동','멍멍멍',sysdate);  -- 사람을 유일하게 구분하려고 붙는게 주민번호인데 가지지 않는 것은 안된다 . 반드시 값을 가져야 한다  .