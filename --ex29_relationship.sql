--ex29_relationship.sql


/*
        1.기본키
            a.단일키
            b.복합키

        2.관계
        A.비식별 관계
        B.식별



*/
select * from tabs;

drop table tbluser;



--부모가 자식을 바라보는 시점으로써의 표현 > 식별 vs 비식별
--*** 자식 테이블에서  fk가 pk의 역할을 하면 식별관계라고 한다
--*** 자식 테이블에서 fk가 일반 컬럼이면 비식별관계라고 한다.

--식별관계가 만들어지기 위한 조건
--1. 1:1관계
--2. 복합키


--회원테이블과 게시판 테이블의 관계
--단일키(pk)+1:n + 비식별관계

--홍길동(회원)- 홍길동(세부정보)

--회원테이블: 회원 상세 테이블관계
--단일키(pk) + 1:1 + 식별관계

create table tbluser(
    seq number primary key,
    id varchar2(30) not null,
    pw varchar(30) not null,
    name varchar2(30) not null
    
);

--n:n 관계가 발견되면 중간에 테이블을 생성하고
--1:n n:1 관계로 바꾼다

--학생,과목 ,수강 정보 >>복합키

create table tblstudent(
    seq number primary key,
    name varchar2(30)not null
    
);

create table tblsubject(
    seq number primary key,
    name varchar2(100)not null
    
);


--게시판 테이블
create table tblboard(
    seq number primary key,
    subject varchar2(1000)  not null,
    content varchar2(4000) not null,
    regdate date default sysdate not null,
    user_seq number not null references tbluser(seq)
);

--유저 세부정보\
create table tbluserdetails(
tel varchar2(15) not null,
email varchar2(50) not null,
address varchar2(200) not null,

constraint tbluserdetails_seq_pk primary key(seq),
constraint tbluserdetails_seq_fk foreign key(seq) references tbluser(seq)
);



create table tblregistration(
    student_seq number not null,
     subject_seq number not null,
     score number not null,
     
     constraint tblregistration_pk primary key(student_seq, subject_seq),
       constraint tblregistration_fk1 foreign key(student_seq)
                                              references tblstudent(seq),
     constraint tblregistration_fk2 foreign key(student_seq)
                                              references tblsubject(seq)
     );
     
     insert into tblstudent values( 1, '홍길동 ');
      insert into tblstudent values(2 , ' 강아지');
       insert into tblstudent values(3 , '고양이 ');
       
        insert into tblsubject values( 1, '자바 ');
         insert into tblsubject values( 2, '오라클 ');
          insert into tblsubject values(3 , '스프링 ');
          
          insert into tblregistration values(1 ,1 ,0);
            insert into tblregistration values(1 ,2 ,0);
              insert into tblregistration values( 1,2 ,0);
                insert into tblregistration values(2 ,1 ,0);
                  insert into tblregistration values( 2,2 ,0);
                    insert into tblregistration values(3 ,2 ,0);
                      insert into tblregistration values(3 ,3 ,0);
                      
                      select * from tblregistration;
                      
                      
                      --홍길동  + 자바 > 점수?
                      --홍길동  + 어떤 과목을 듣는지
                      --자바를 어떤 학생이 듣는지
                      
                      
                                 
                      --홍길동  + 자바 > 점수?
                      select seq from tblstudent where name ='홍길동'; --1
                       select seq from tblsubject where name ='자바';
                       
                       --조건절
                       select *from tblregistration
                        where student_seq= ( select seq from tblstudent where name ='홍길동')
                        and subject_seq = (select seq from tblsubject where name ='자바');
                        --inner조인으로
                        select * from tblstudent st
                            inner join tblregistration r
                                on st.seq= r.student_seq
                                    inner join tblsubject sj
                                     on sj.seq= r.subject_seq
                                     where st.name='홍길동' and sj.name='자바';
                                     
                                     
            --홍길동 + 어떤 과목을 듣는지?
            
            --1
             select * from tblstudent st
                            inner join tblregistration r
                                on st.seq= r.student_seq
                                    inner join tblsubject sj
                                     on sj.seq= r.subject_seq
                                      where st.name='홍길동';
                                      
                                      
                                      
          --2                            
    select * from tblsubject
            where seq in (select subject_seq from tblregistration
                            where student_seq=(select seq from tblstudnet
                                                    where name='홍길동'));
                                                    
                                                    
    --자바를 어떤 학생이 들었느지
     select * from tblstudent st
                            inner join tblregistration r
                                on st.seq= r.student_seq
                                    inner join tblsubject sj
                                     on sj.seq= r.subject_seq
                                        where sj.name ='자바';
                                        
                                        
                                        
                                        
                                        
                                        
                                        
-- 보충 수업
create table tblextra(
        seq number primary key,
        regdate date,
        student_seq number, -- references tblregistration(student_Seq)
        subject_seq number,-- references tblregistration(subject_Seq)
        
        constraint tblextr_fk foreign key(student_seq ,subject_seq)
            references registration(student_seq, subject_seq)
);
insert into tblextra values(1,sysdate,1,1);
insert into tblextra values(2,sysdate+1,1,2);

--홍길동 > 어떤과목명에 대한 보충수업을 듣는지 알고 싶다.>>4개 다 조인



     select sj.name , e.regdate from tblstudent st
                            inner join tblregistration r
                                on st.seq= r.student_seq
                                    inner join tblsubject sj
                                     on sj.seq= r.subject_seq
                                        inner join tblextra e
                                            on r.student_seq =e.student_seq
                                                and r.subject_seq = e.subject_seq
                                                where st.name='홍길동';