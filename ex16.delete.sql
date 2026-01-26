--ex16.delete.sql


 /*
    delete
    -원하는 행을 삭제하는 명령어
    -컬럼삭제x
    
    delete [from] 테이블명 [where절]
    
 
 
 
 */
 commit;
 rollback;
 
 select *from tblcountry;
 
 delete from tblcountry where name ='중국';
 
  
 delete from tblcountry where continent ='AS';
 
delete from tblcountry; 


--dml
--select일부
--insert 전부
--update,delete전부