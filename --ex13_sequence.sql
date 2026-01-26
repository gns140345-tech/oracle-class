--ex13_sequence.sql

/*

    시퀀스 , sequence
    -db object (테이블, 제약사항, 시퀀스 등...)
    -db object> 생성 /수정/삭제하는 모든 과정 >>ddl(create ,drop, alter)
    
    -일련 번호를 생성하는 객체(***)
    -오라클 전용
    -주로 식별자를 만드는데 사용
    
    시퀀스 객체 생성하기
        -create sequence 시퀀스명;
        
        시퀀스 객체 삭제하기
        -drop sequence 시퀀스명;
        
        시퀀스 객체 사용하기
        -시퀀스명 .nextval
        -시권스명.currval
    




*/
        create sequence seqNum;
        drop sequence seqNum;
        select seqNum.nextVal from dual;
        
         create sequence seqNo;
         
     select seqNo.nextVal from dual;
     
     select name,seqNum .nextVal from tblinsa;
     

  
   
       insert into tblmemo(seq,name,memo, regdate)
   values(seqNum.nextVal,'강아지','멍멍멍',sysdate);
   
   select * from tblmemo;
   
   select seqNum.currVal from dual;
   
   
   --쇼핑몰>상품번호> abc001, bdf55334
   select 'ABC' ||seqNum.nextVal from dual;--abc21
   
      select 'ABC' || lpad(seqNum.nextVal,3,'0') from dual;--abc024
      
      
      
      
      /*
      시퀀스 객체 생성하기
      -create sequence 시퀀스명;(모두 다 생략가능)
      
      -create sequence  시퀀스명  
                            increment by n --증감치
                            start with n --시작값
                            maxvalue n   --최댓값(증감치가 양수일때)
                            minvalue n      --최솟값(증감치가 음수일때
                            cycle       (순환구조를 만듦
                            cache n;        (임시저장(성능 관련)
      
      
      
      
      
      */
      
      drop sequence seqtest;
      
      create sequence seqtest
                       -- increment by -5
                       -- start with 10
                      -- maxvalue 10
                      -- cycle
                       cache 20
                        ;
     
     
     select seqtest.nextval from dual;
     
     create sequence seqtest start with 16;
     ;
     
     
     --services.msc >>oracleserviceXE>중지