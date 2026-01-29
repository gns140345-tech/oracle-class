--ex_27_hierarchical.sql


    /*
       계층형 쿼리, hierarchical query
            -오라클 전용 쿼리
            - 레코드의 관계가 서로간에 상하 수직 구조인 경우에만 사용한다
            -주로 , 자기 참조를 하는 테이블에서 사용
        
    계층형 쿼리
    1.start with 절 + connect by절
    2.계층형 쿼리에서만 사용 가능한 의사컬럼
        a.prior :부모 테이블의 레코드라는 뜻
        b.level
        c.  몇 가지 함수들..
        
    
    */
    select 
        seq as 번호,
        name as 직원명,
        boss as 상사번호,
        prior name as 상사명,
        level,
        connect_by_root name  as 사장,
        connect_by_isleaf,
        
        sys_connect_by_path(name,'>')
        
    from tblself
            start with seq =1
                connect by prior seq= boss  --on s1.seq =s2.boss
                ;
                
                
        select
          lpad('  ',(level-1)*2) ||   name as 직원명
        from tblself
        start with seq =1
            connect by prior seq = boss;
            
            
            
         ---------------------------------------------ansi-sql
         
         
         
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            