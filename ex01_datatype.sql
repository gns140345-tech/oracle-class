--SQL >> 스크립트 파일

--한줄 주석
--ex01 datatype

/*
    관계형 데이터베이스
    - 변수(x) ,제어문 x >Sql은 프로그래밍 언어가 아니다
    -db와 대화를 목적으로 하는 언어> 대화형 언어
    -sql 자료형 > 테이블을 선언할 때 사용 >컬럼에 적용 


    여러줄 주석


    ansi sql 자료형
    1.숫자형
        -정수/실수
        a.number
            -(유효자리)38자리까지 표현
            -1234567890.....
            -1~22byte
            -1x10^-130~9.999x10^125
            -number :정수 or 실수
            -number(precision):전체 자릿수 , 정수형
            -number(precision,scale):소수 이하 자릿수 >정수형 ,실수형
            
    2.문자형
        
        /*
        DDL
        create table 테이블명(
        컬럼선언,
        컬럼선언,
        컬럼선언,
        컬럼= 컬럼명 자료형
        ):
        2.문자형 > 지금은 그냥 varchar2만 일단
    -문자+문자열
    -char vs nchar > n이 의미하는 것은?
    -char vs varchar >> var의 의미는?
    
    
    
    
    
    a.char
        -고정 자리수 문자열 >> 공간(컬럼)의 크기가 불변
        -char(n) : 최대 n자리 문자열 , n(바이트)
            -최소 크기 :1바이트
            -최대 크기 :2000바이트
        -데이터 삽입 후 > 남은 공간을 공백으로=SPACE로 무조건 채워서 반드시 10자리로 만들어버린다
        - 데이터가 고정문자열인경우 EX>전화번호 우편번호 ,이름 같이 자릿 수가 정해져 있는경우에 CHAR를 사용
        -하지만 속도가 빠름
    
    b. nchar
        - n은 national의 약자 > 오라클이 utf-8 인코딩과 상관없이 무조건 해당 컬럼을  utf-16으로 동작
        -nchar(n): 최대 n자리 문자열,n(바이트가 아닌 문자수,글자수)
                -최소크기는 1문자
                -최대크기는 1000문자까지
    
    
    
    
    c.varchar2
        -가변 자릿수 문자열 >>공간(컬럼)의 크기가 가변
        -varchar(2) :최대 n자리 문자열, n바이트
         -최소크기 :1 바
         -최대크기 4000
        - 데이터 삽입 후 >남은 공간을 버린다. (TRIM) >>필요없으면 버린다
        - 가변 문자열인 애들> 데이터마다 길이가 제각각인 것들 EX>주소, 자기소개글 >
        - 남은 공간을 계산해야 해서 속도가 느림
    
    
    
    
    
    d.nvarchar2
        -n의 의미:    :최대 n자리 문자열, n바이트
         -최소크기 :1글자
         -최대크기 2000굴자

    
    e. clob ,nclob
    large object=대용량 텍스트를 지원할때
    -참조형










*/
        

        
        drop table tbltype;
        --수업 식별자 패턴: db object >헝가리언 표기법 사용
    create table tbltype(
   -- num number 
   --num number(3)--3자리 >>-999~+999
   num number(4,2) --4자리+ 소수 이하 2자리까지 >>4자리=정수 2자리+소수이하 2자리 다 합쳐서 4자리 =-99.99~+99.99
    );
    select * from tabs; --tables. 내가 가지고 있는 테이블 목록
    
    --데이터 추가하기
    
    --insert into 테이블명(컬럼명) values (값);
    --insert into 테이블명(컬럼명a, 컬럼명 b) values (값a,값 b);
    insert into tbltype(num) values(100); -->정수형리터럴
    
    select * from tbltype; --테이블의 모든 데이터를 가져와라
     insert into tbltype(num) values (100);
    insert into tbltype(num) values (3.14); --실수형
    insert into tbltype(num) values (1234567890123456789012345678901234567812345678901234567890);
    insert into tbltype(num) values (3.54);
        insert into tbltype(num) values (-999);
            insert into tbltype(num) values (999);
                insert into tbltype(num) values (999.39);
                  insert into tbltype(num) values (99.99);
                    insert into tbltype(num) values (-99.99);
    select * from tbltype;
    
    /*
    3.날짜/시간형 > 거의  date만 사용
    a.date
            -년 월 일 시 분 초 저장가능
            
    
    
    
    
    
    b.timestamp
                -년월일시분초 +밀리초+나노초까지
                -타임존
    
    
    
    
    c.interval
        -시간
        -틱값
    
    4.이진 데이터형
        - 비 텍스트 데이터
        -이미지,영상,음악,프로그램 실행 파일, 압축파일 등
        a.blob binary large object
        -잘사용 안함
        ex>게시판에 첨부파일> db에 첨부파일의 이름을저장(문자열) , 텍스만 저장

    결론
    1.숫자는 number
    2.문자열은 varchar
    3.날자는 date만 공부
*/





/*










*/

create table tbltype(

--txt char(10)
--txt varchar2(10)
--txt1 char(10),
--txt2 varchar2(10)
--txt nchar(10)
regdate date
);

drop table tbltype


insert into tbltype (txt) values  ('ABC');

insert into tbltype (txt) values ('ABC');
insert into tbltype (txt) values ('ABCDEFGHJ');
insert into tbltype (txt) values ('ABCDEFGHiJi');
insert into tbltype (txt) values ('홍길동');
insert into tbltype (txt) values ('홍길동님');
insert into tbltype (txt) values ('홍길동님안녕하세요..');

insert into tbltype(txt1,txt2) values('ABCDE' , 'ABCDE');

insert into tbltype (regdate) values ('2026-01-22'); --날짜 리터럴
select *from tbltype; --테이블의 모든 데이터를 가져와라
--"ABCDE     " //CHAR
--"ABCDE"     //VARCHAR2



select *from tabs;