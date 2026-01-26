--ex20_join.sql

/*
        관계형 데이터베이스 시스템이 지양하는 것들
        
        1.테이블에 기본키가 없는 상태 >>없으면 데이터를 수정 삭제하는 과정에서 구분하지 못해서 곤란 pk가 있으면 번호로 구별가능
        
        2.null이 많은 상태의 테이블 >d이유: 공간 낭비+ sql  작업 불편
        
        3.하나의 속성값이 원자값이 아닌 상태 > 더 이상 쪼개지지 않는 값을 넣어야 한다. ex>운동,독서,코딩 




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
            