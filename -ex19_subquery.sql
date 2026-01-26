--ex19_subquery.sql

/*

    sql
    
    1.main query=쿼리
        -하나의 문장안에 하나의 select(insert,update,delete)문으로 되어 있는 쿼리
        
    2.sub query,서브 쿼리
        -하나의 문장안에 또 다른 문장이 들어있는 쿼리
        -메인쿼리       <-서브쿼리 가 삽입
        -select        <-또 다른 select삽입
        -insert         <-select
        -update         <-select
        -delete         <-select
        



*/

    --tblcountry. 인구수가 가장 많은 나라의 이름? 중국
     select max(population) from tblcountry;
     select name from tblcountry where population =120660;
     
      --select name from tblcountry where population = max(population);  --where절에 집계 x
       select name 
       from tblcountry  --메인쿼리
       where population =(select max(population) from tblcountry);--서브쿼리  ,집계함수가 온것이 아니라 select 문장 전체가 온것이다. >>값을 반환
       
       --tblcomedian .몸무게가 가장 많이 나가는 사람의 정보?
       select max(weight) from tblcomedian;
       select *from tblcomedian where weight =129;
       
        select *from tblcomedian where weight =(select max(weight) from tblcomedian);
     
     --tblinsa  평균 급여보다 더 많이 받는 직원들?
     select * from tblinsa
        where basicpay >= (select avg(basicpay) from tblinsa);
        
        /*
        - 서브 쿼리 삽입 위치
        1.조건절> 비교 값으로 사용
            a.반환값이 1행 1열>단일값을 반환 >>상수 취급 > 값 1개  젤 많이
            b. 반환값이 n행 1열 >>다중값 반환>열거형비교 >in연산자  가끔
            c. 반환값이 1행 n열>>다중값 반환 >>그룹비교 >>n:n비교   가끔
            d.반환값이 n행 n열 >>다중값을 반환 >>b+c >>in 연산자 +n:n비교 (잘안씀)
        
        
        
        */
        select * from tblwomen
            where couple =(select name from tblmen where age=31 and height =183);
            
              select * from tblwomen
            where couple =(select name from tblmen where age=22);
            --ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다. where절은 한개의 값만 받아야되는데 값이 2개
            아무개 
            양세형
            
                 select * from tblwomen
            where couple in('아무개', '양세형');
            
                 select * from tblwomen
            where couple in(select name from tblmen where age=22);    --반환값이  n행 1열 >> in연산자
            
            select * from tblmen;
            
            
    --tblinsa. '홍길동'과 같은 지역에 사는 사람 + 같은 부서
    select * from tblinsa
        where city =길동이가 사는지역;
        
        select * from tblinsa
            where city=(select city from tblinsa where name='홍길동')
            and buseo=(select buseo from tblinsa where name='홍길동');
            --너무길다
            --반환값이 1행  n열 
            select *from tblinsa
            where (city,buseo) =(select city,buseo from tblinsa where name='홍길동');  --순서가 맞아야함 동시에 비교
            
            -------------------------------
            --급여가 260만원 이상 받는 직원과 같은 부서 + 사는곳이 같은 지역의 직원?
            select * from tblinsa
                where(city,buseo) in (select city, buseo from tblinsa where basicpay>=2600000);
                
                /*
                  - 서브 쿼리 삽입 위치
                  1.조건절> 비교 값으로 사용
                  2.컬럼 리스트> 컬럼값으로 사용
                        -반드시 결과값이 1행 1열이어햐 한다. >> 이런 쿼리를 스칼라쿼리라고 부른다(=원자값을 반환한다)
                        a.정적 서브쿼리 >> 모든 행에 동일한 값을 반환 >>사람에 바뀌어도 변하지 않는값 1556527
                        b.상관(연관) 서브 쿼리 >>메인쿼리의 일부값을 활용해 서브쿼리에 사용
                                            >> 메인쿼리와 연관된값을 반환
                */
                select 
                    name,buseo, basicpay,
                    (select round(avg(basicpay)) from tblinsa)--=1556527  4번쨰 컬럼으로 사용
                from tblinsa;
                
                 select 
                    name,buseo, basicpay,
                    (select jikwi from tblinsa) --ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다. >>레코드가 60개 ,물리적으로 단일값 나올때만 가능
                from tblinsa;
                
                
                select
                    name,buseo,basicpay,
                    (select round(avg(basicpay))from tblinsa where buseo= a.buseo)
                from tblinsa a;
                
                
                
                     - 서브 쿼리 삽입 위치
                  1.조건절> 비교 값으로 사용
                  2.컬럼 리스트> 컬럼값으로 사용
                  3.from절에 사용
                    -서브쿼리의 결과셋을 또 하나의 테이블이라고 생각하고 메인 쿼리가 실행
                    -익명 테이블 역할 or임시 테이블 역할
                    -인라인 뷰(inline view)와 문법이 겹침
                  
                  select num, name, jikwi from tblinsa where buseo='기획부'; >>이테이블 A라고 가정
                  
                  select * from A; = select * from(select num, name, jikwi from tblinsa where buseo='기획부');
                  