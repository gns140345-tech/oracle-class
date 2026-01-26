--ex17_groupby.sql



  /*
  
  group by group_by expression --그룹을 나눈다
  
  각절의 순서
  4.select
  1.from
  2.where
  3.group by
  5.order by
  
  
  group by절
    -특정 기준(컬럼값)으로 레코드들을 그룹을 나눈다.(수단)
    > 각각의 그룹을 대상으로  집계 함수를 실행한다.(목적)
    
  
  
  
  */
  select * from tblinsa;
  
  --직위별 평균 급여가 궁금
  select round(avg(basicpay)) from tblinsa; --1556527
  
  select distinct jikwi from tblinsa;
  
    select round(avg(basicpay)) from tblinsa where jikwi='부장';
    select round(avg(basicpay)) from tblinsa where jikwi='사원';
    select round(avg(basicpay)) from tblinsa where jikwi='대리';
    select round(avg(basicpay)) from tblinsa where jikwi='과장';
    
    select
    jikwi,  
    round(avg(basicpay)) as "직위별 평균 급여",
    count(*) as "직위별인원수",
    sum(basicpay) as "직위별 총지급액",
    max(basicpay) as "직위별 최고 급여",
      min(basicpay) as "직위별 최저 급여"
    from tblinsa
    group by jikwi;  --집계함수만 올수있음
    
    
    select * from tblcomedian;
    
    --남자수? 여자수?(최종)
    select count(*) from tblcomedian where gender ='m';
    --남자수? 여자수?(최종)
    select count(*) from tblcomedian where gender ='f';
    
    --1.
    select
        count(case
            when gender='m' then 1
        end), 
         count(case
            when gender='f' then 1
        end)
        from tblcomedian;
        
        
        
        --2
          select
        count(decode(gender,'m',1)) as m,
        count(decode(gender,'f',1)) as f
      
        from tblcomedian;
        
        --3
        select 
        gender,
        count(*)
        from tblcomedian
        group by gender;
        
        select
        buseo,
        count(*) as "부서별인원수"
        from tblinsa
        group by buseo
        --order by 2 desc ;
        --order by "부서별인원수" asc;
        order by count(*) desc;
        
        
          select
        buseo,
        count(*), 
        --name   --ORA-00979: GROUP BY 표현식이 아닙니다.
        from tblinsa
        group by buseo
        
        
        
        --1차 그룹 > 2차그룹 >3차그룹... 
        select
             jikwi,
             buseo,
            count(*)
        from tblinsa
            group by jikwi,buseo; --1차그룹
            
            
            
            
            
            
            --tblinsa
            --급여별 그룹나누기
            --100만원 미만
            --100만원 이상- 200만원 미만 그룹
            --200만원 이상 그룹
            
            select
            basicpay,
            count(*)
            from tblinsa
                group by basicpay;
            
            select
            
               ( floor(basicpay/1000000)+1)*100 ||'만원이하' as money,
               count(*)
            from tblinsa
            group by floor(basicpay/1000000);
            
            
            --tblinsa. 남자수? 여자수?
            select
                substr(ssn,8,1),
                
                
                count(*)
                from tblinsa
                group by substr(ssn,8,1);
                
                
                --tbltodo
                 select
                 completedate,
                 count(*)
                 from tbltodo
                 group by completedate;
            
                select
                case
                    when completedate is not null then 1
                    else 2
                end,
                count(*)
                from tbltodo
                group by   case
                    when completedate is not null then 1
                    else 2
                    end;
                    
                    --tblinsa , 과장 +부장 몇명이고 사원+대리는몇명인가
                    
        select
        case
            when jikwi in('과장','부장') then 1
            else 2
        end ,
        count(*)
        from tblinsa
        group by case
            when jikwi in('과장','부장') then 1
            else 2
        end ;
        
        
        
            
            
            
            
            
            
            
            
            
            
            
            