--ex15_update.sql


/*
  -원하는 행을 찾아서 원하는 컬럼값으로 수정하는 명령어
  
  update 테이블명  set  컬럼명=값  [, 컬럼명= 값] x N [where절]





*/
commit;
rollback;


select * from tblcountry;

--대한민국의 서울 >세종

update tblcountry set capital ='세종';
update tblcountry set capital ='세종' where name ='대한민국';

--전체 세계 인구수 10%증가
update tblcountry set population = population *1.1;

update tblcountry set
        capital ='제주',
        population =5000,
        area=20
            where name ='대한민국';
            
            
            