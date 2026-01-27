--ex14_insert.sql



/*


    dml >>select ,insert,update,delete
    
    insert문  ㅠ
    
        -테이블에 데이터를 추가하는 명령어
        
        insert into 테이블명(컬럼리스트) values (값리스트);
        
        












*/
       drop table tblmemo;
    
    select * from tblmemo;
   
   
   create table tblmemo(
--컬럼명 자료형(길이) null 제약사항
        seq number(3) primary key, 
        name varchar2(30) default '익명' , 
        memo varchar2(1000), 
        regdate date default sysdate not null
        
                                    
                                        
);
create sequence seqmemo;

--1.표준
--원본테이블에 정의된 컬럼순서대로 컬럼리스트와 값리스트를 작성
insert into tblmemo(seq, name,memo,regdate)
    values(seqmemo.nextval,'홍길동','메모입니다',sysdate);
    
--2.컬럼리스트의 순서는 원본테이블과 무관하다.
--컬럼리스트의 순서와 값리스트의 순서는 일치해야한다.
insert into tblmemo(regdate,seq, name,memo)
    values(sysdate,seqmemo.nextval,'홍길동','메모입니다');
    
    
    --3.
    insert into tblmemo(seq, memo,regdate)  --SQL 오류: ORA-00913: 값의 수가 너무 많습니다
    values(seqmemo.nextval,'홍길동','메모입니다',sysdate);
    
    
    --4
    insert into tblmemo(seq, name,memo,regdate)  --SQL 오류: ORA-00947: 값의 수가 충분하지 않습니다
    values(seqmemo.nextval,'메모입니다',sysdate);

--5.null컬럼 조작하는 방법>null 허용
--null 상수 사용하는 방법
    insert into tblmemo(seq, name,memo,regdate)
    values(seqmemo.nextval,'홍길동',null,sysdate);
    
    --5.b컬럼 생략
    insert into tblmemo(seq, name,regdate)
    values(seqmemo.nextval,'홍길동',sysdate);
    
    select * from tblmemo;
    
   --6.default 조작
   --6.a 컬럼생략하는방법 >> null 대입(암시적) >default 호출
   insert into tblmemo(seq,memo,regdate)
    values(seqmemo.nextval,'메모입니다',sysdate);
    
  -- 6.b null 상수 >>default동작안함
   insert into tblmemo(seq, name,memo,regdate)
    values(seqmemo.nextval,null,'메모입니다',sysdate);
    
    --6.상수
    insert into tblmemo(seq, name,memo,regdate)
    values(seqmemo.nextval,default,'메모입니다',sysdate);
    
    
    ------------------------------------------------------------------
    --7.단축표현
    --7,a컬럼리스트를 생략할 수 있다
    insert into tblmemo
    values(seqmemo.nextval,'홍길동','메모입니다',sysdate);
    
    --7.b컬럼리스트의 순서를 바꿀 수 없다  >>순서를 외우고 있어야함
      insert into tblmemo -- 이때 컬럼리스트의 순서는 원본테이블의 순서대로 적혀있다
    values(sysdate, seqmemo.nextval,'홍길동','메모입니다');
    --ORA-00932: 일관성 없는 데이터 유형: NUMBER이(가) 필요하지만 DATE임
    
    
    --7.c null컬럼 생략 불가능
        insert into tblmemo values(seqmemo.nextval,'메모입니다',sysdate);
            insert into tblmemo values(seqmemo.nextval,null,'홍길동','메모입니다',sysdate);
            
   -- 7.d default 컬럼생략불가능
       
          insert into tblmemo values(seqmemo.nextval,'메모입니다',sysdate);
            insert into tblmemo values(seqmemo.nextval,default,'홍길동','메모입니다',sysdate);
    
    --8
    -- tblmemo 테이블 > 복사하면서 새테이블을 생성(tblmemocopy)
    
       create table tblmemocopy(
--컬럼명 자료형(길이) null 제약사항
        seq number(3) primary key, 
        name varchar2(30) default '익명' , 
        memo varchar2(1000), 
        regdate date default sysdate not null                                        
);
insert into tblmemocopy select * from tblmemo; --sub query


9.
--tblmemo테이블 >복사>새테이블생성(tblmemocopy)
--데이터 복사 ,컬럼도 복사하지만 제약사항은 복사가 안된다 ***
--더미 데이터용> 임시용 or 테스트용
create table tblmemocopy;

as
select*from tblmemo;

select*from tblmemo;
select*from tblmemocopy

insert into tblmemocopy values(3, '하하하','메모',sysdate);

drop table tblmemocopy;

select*from tblmemocopy;

    --9
    -- tblmemo 테이블 > 복사하면서 새테이블을 생성(tblmemocopy)
    
   