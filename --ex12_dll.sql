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
            -기본키(key=컬럼)>대표 역할
            -테이블의 행을 구분하기 위한 제약 사항
            -값이 유일하다(unique) + 필수값(not null)
            - 1번+4번 
            -하나의 테이블에 pk는 2개 이상 존재 불가능
            - 반드시 테이블에는 pk가 존재해야 한다( pk가 없는 테이블이 존재가능하지만 안만듦)
            
    3.foreign key
        -
    
    4.unique
        -유일하다. 레코드간에 중복값을 가질 수 없다
        -null을 가질 수 있다. > 식별자가 될 수 없다
        ex>초등학교 학급
            -학생(번호(pk),이름(nn),직책(uq))
            1.홍길동,반장
            2,아무개,null
            3.강아지,부반장
            4.고양이,부반장 >uq error
            
            
    5.check
        -사용자 정의형
        -조건을 직접 정의해서 > 컬럼의 제약 사용으로 적용
        -where 절 조건과 동일
        
    
    
    6.default
    -제약 x 기본값 설정 기능
    -insert/update 작업 시 > 컬럼에 값을 안넣으면 null대신에 미리 설정한 값을 대신 대입해주는 기능
    
    
    
    
    

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
   
   
   
   
   
       
     drop table tblmemo;
    
    select * from tblmemo;
    -- 메모 테이블
create table tblmemo(
--컬럼명 자료형(길이) null 제약사항
        seq number(3) constraint tblmemo_seq_pk primary key, --메모번호,pk라는 제약사항 ex>주민번호 같은 식별자 역할 >> 유일해야 한다>> 항상 모든테이블에 1개가 존재한다. not null이라고 안적혀 있어도 자동으로 not null이다
        name varchar2(30) unique, --작성자 ,선택값
        memo varchar2(1000)not null, --메모내용 nn
        regdate date null --날짜
);

   
    insert into tblmemo(seq,name,memo, regdate)
   values(1,'강아지','멍멍멍',sysdate);
   
    insert into tblmemo(seq,name,memo, regdate)
   values(2,'고양이','멍멍멍',sysdate);
   
       insert into tblmemo(seq,name,memo, regdate)
   values(3,'병아리','왈왈왈',sysdate);
   
   
   
        drop table tblmemo;
    
    select * from tblmemo;
    -- 메모 테이블
create table tblmemo(
--컬럼명 자료형(길이) null 제약사항
        seq number(3) primary key, --메모번호,pk라는 제약사항 ex>주민번호 같은 식별자 역할 >> 유일해야 한다>> 항상 모든테이블에 1개가 존재한다. not null이라고 안적혀 있어도 자동으로 not null이다
        name varchar2(30) null, --작성자 ,선택값
        memo varchar2(1000)not null, --메모내용 nn
        regdate date null, --날짜
        
        --메모의 중요도(1=중요 , 2=보통, 3=안중요)
        --where priority >=1 and priortty?<=3
        --priority number(1) check(priority>=1 and priority <=3)
        priority number(1) constraint tblmemo_priority_ck check(priority between  1 and 3),
        
        --카테고리(할일,공부,약속)
       -- category varchar2(10) check(category='할일' or category ='공부' 
                                     --   or category='약속')
           category varchar2(10) constraint tblmemo_category_ck check(category in('할일','공부','약속'))                             
                                        
);
   
   
    
    insert into tblmemo(seq,name,memo, regdate,priority, category)
   values(1,'강아지','멍멍멍',sysdate,1,'할일');
   
   
      
    insert into tblmemo(seq,name,memo, regdate,priority, category)
   values(2,'고양이','야옹',sysdate,2,'공부');
   
   
      
    insert into tblmemo(seq,name,memo, regdate,priority, category)
   values(3,'병아리','삐약',sysdate,4,'할일');
   --ORA-02290: 체크 제약조건(HR.SYS_C008425)이 위배되었습니 >> 뭐가 잘못됐는지 이름 설정가능
   --ORA-02290: 체크 제약조건(HR.TBLMEMO_PRIORITY_CK)이 위배되었습니다
      
    insert into tblmemo(seq,name,memo, regdate,priority, category)
   values(3,'병아리','삐약',sysdate,2,'여행');
   --02290: 체크 제약조건(HR.SYS_C008426)이 위배되었습니다  >>

       insert into tblmemo(seq,name,memo, regdate,priority, category)
   values(4,'송아지','음매',sysdate,2,'시험');
   
   --ORA-02290: 체크 제약조건(HR.SYS_C008426)
   
   
   ------------default
   
   
        drop table tblmemo;
    
    select * from tblmemo;
   
   
   create table tblmemo(
--컬럼명 자료형(길이) null 제약사항
        seq number(3) primary key, --메모번호,pk
        name varchar2(30) default '익명' , --작성자 ,선택값
        memo varchar2(1000)not null, --메모내용 nn
        regdate date default sysdate --날짜 현재시간 안넣으면 sysdate로 기본값
        
                                    
                                        
);
   
       insert into tblmemo(seq,name,memo, regdate)
   values(1,'강아지','멍멍멍',sysdate);
   
   --명시적 null대입>>사용자의 의지가 담겨있다+의지표현
    insert into tblmemo(seq,name,memo, regdate)
   values(2,null,'멍멍멍',sysdate); --//컬럼은 존재하지만null은존재하는 경우 >>default 동작안함
   
   --암시적 null대입>사용자의 의지가 없다 +권리포기라고 인식
       insert into tblmemo(seq,memo, regdate)
   values(3,'왈왈왈',sysdate);  --컬럼자체가 없는경우 >> null대신 익명  default 동작함
   
       insert into tblmemo(seq,memo)
   values(4,'멍멍멍'); 
   
  -- 1	강아지	멍멍멍	26/01/26
--2		멍멍멍	26/01/26
--3	익명	왈왈왈	26/01/26
--4	익명	멍멍멍	26/01/26

/*

    제약사항을 만드는 방법
    
    1.컬럼 수준에서 만드는 방법
    -컬럼을 선언할 때 제약사항도 같이 선언하는 방식(지금까지의 방식)
    -가독성 향상 >어떤컬럼에 어떤 제약 사항이 있는지 직관적으로 인식 가능
    
    2.테이블 수준에서 만드는 방법
    -컬럼 선언과 제약사항 선언을 분리하는 방식
    
    - 가독성이 향상> 테이블 크기가 커질수록 코드관리 용이
    
    3.외부에서 만드는 방법










*/

      -- 2.테이블 수준에서 만드는 방법
    --컬럼 선언과 제약사항 선언을 분리하는 방식
    
    -- 가독성이 향상> 테이블 크기가 커질수록 코드관리 용이
    
      create table tblmemo(
--컬럼명 자료형(길이) null 제약사항
        seq number(3) , 
        name varchar2(30)  , 
        memo varchar2(1000)not null, 
        regdate date , 
        
        constraint tblmemo_seq_pk primary key(seq) ,
        constraint tblmemo_name_uq unique(name),
           constraint tblmemo_memo_ck check (length(memo)>=10)
                                    
                                        
);
   