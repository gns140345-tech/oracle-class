--ex23_alter.sql



/*
    dml >데이터 조작
    -데이터 생성:insert
    -데이터 수정 :update
    -데이터 삭제: delete
    
    ddl >객체 조작
    -객체 생성:create
    -객체 수정:alter
    -객체 삭제:drop
    
    
    테이블 수정하기
     -테이블 수정 > 컬럼 수정하겟다 >컬럼명 or 자료형(길이) or 제약사항 등을 수정하는 행위를 말한다
     
     테이블을 수정해야 하는 상황 발생!
     1. 테이블을 삭제 (drop > 테이블 ddl(Create)문을 수정 > 수정된 ddl로 다시 테이블을 생성
            a. 기존 테이블에 데이터가 없는 경우> 아무 문제 없음
            b. 기존 테이블에 데이터가 있는 경우>미리 데이터를 백업 > 테이블을 삭제 > 테이블 ddl을 수정 >수정된 ddl로 다시 테이블 생성 > 백업했던 데이터를 다시 복구
            
            
     2. 삭제하는 대신에 alter 명령어 사용 > 기존 테이블의 구조를 바로 변경
             a. 기존 테이블에 데이터가 없는 경우> 아무 문제 없음
             b. 기존 테이블에 데이터가 있는 경우 > 상황에 따라 비용 차이 발생


*/

drop table tbledit;

create table tbledit(
 seq number,
 name varchar(20)
 
 );
 insert into tbledit values(1,'마우스');
  insert into tbledit values(2,'키보드');
   insert into tbledit values(3,'모니터');
   
 --  case 1.새로운 컬럼을 추가하기
 alter table tbledit(
 add(컬럼 정의)
 );
 
 delete from tbledit;
 
 
  alter table tbledit
 add(price number not null);
 --ORA-01758: 테이블은 필수 열을 추가하기 위해 (NOT NULL) 비어 있어야 합니다
 
   alter table tbledit
 add(price number default 0 not null);
 
 select *from tbledit;
 
 
 
 
 ----------------------
 0-- case2. 기존 컬럼을 삭제하기
 alter table tbledit
    drop column 컬럼명;
 
  alter table tbledit
  
    drop column price;
    
      alter table tbledit
    drop column seq;   --pk삭제 >>절대금지!!
    
    --case 3.컬럼을 수정하기
    
    --case3.1 컬럼의 길이를 수정하기(확장/축소)
     insert into tbledit values(4,'삼성 갤럭시 북6 프로');
     --SQL 오류: ORA-12899: "HR"."TBLEDIT"."NAME" 열에 대한 값이 너무 큼(실제: 28, 최대값: 20)
                     alter table tbledit
                        modify(컬럼정의);
                        
                      alter table tbledit
                      modify(name varchar2(100)); --확장
                      
                       alter table tbledit
                      modify(name varchar2(20)); --축소  -- 최소 27바이트까지
                      --ORA-01441: 일부 값이 너무 커서 열 길이를 줄일 수 없음
                      
                      --상품명 중 가장 이름이 긴 상품명? >컬럼 길이 조절
                      select max(length(name)) from tbledit;
                      --1.
                      select name from tbledit
                       where length(name)=(select max(length(name)) from tbledit);
                       --2.
                       select length(name), name from tbledit order by length(name) desc;
                       
                        select lengthb(name), name from tbledit order by lengthb(name) desc; -- 길이를 바이트로 length byte
                       
    --case3.2 컬럼의 제약사항 수정하기(not null)에 한해서
    alter table tbledit
        modify(컬럼명 자료형(길이) null); -- not null이 null로
    
      alter table tbledit
        modify(컬럼명 자료형(길이) not null);--  null이not null로
        
         alter table tbledit
        modify(name varchar2(100
        )  null);
        
     insert into tbledit values(5,null);
    --case3.3 컬럼의 자료형을 바꾸기
    --ORA-01439: 데이터 유형을 변경할 열은 비어 있어야 합니다
    alter table tbledit
        modify(name number);
        
    update tbleidt set name =null;
     desc tbledit;
    --case3.4 컬럼명 바꾸기
    alter table tbledit
        rename column name to item;
 
 --case4.제약사항 조작( 추가,삭제)
 
 drop table tbledit;

create table tbledit(
 seq number,
 name varchar(20)
 
 );
 alter table tbledit
    add constraint tbledit_seq_pk primary key(seq);
    
     alter table tbledit
    add constraint tbledit_seq_uq unique(name);
    
    alter table tbledit
        drop constraint tbledit_seq_uq;
        
        
    --db처음 설계+구축
    --style1.
    create table tbledit(
 seq number primary key,
 name varchar2(20) unique
 
 );
 
     --style2.
    create table tbledit(
 seq number ,
 name varchar2(20) ,
 
    constraint tbleit_seq_pk primary key(seq)
    constriant tbleidt_name_uq unique(name)
 
 );
 
      --style3.
    create table tbledit(
 seq number ,
 name varchar2(20) ,
); 
   alter table tbledit add constraint tbleit_seq_pk primary key(seq);
    alter table tbledit add constraint  tbleidt_name_uq unique(name);
 

    