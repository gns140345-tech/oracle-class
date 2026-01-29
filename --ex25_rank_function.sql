--ex25_rank_function.sql



/*
        순위함수 3가지
        -rownum을 기반으로 만들어진 함수
        
        1.rank() over(order by 컬럼명 desc|asc)
        -동일값=동일순위
        -누적이 돼서 다음 순위값
        2.dense_rank over(order by 컬럼명 desc|asc)
        -동일값=동일순위
        -누적안되고 바로 연속적인값
        3.row_number() over(order by 컬럼명 desc|asc)
            -무조건 다른순위
            -rownum을 직접사용했을때와 동일

*/

--tblinsa .급여순으로 가져오시오  +순위 표시

select a.*,rownum
from(select name, buseo,basicpay from tblinsa order by basicpay desc)a;

select
    name,buseo,basicpay,
    rank() over(order by basicpay desc) as rnum
from tblinsa;
--rownum은 값이 같아도 동일 순위를 따지지 않지만 rank는 동일값이면 같은 순위로

이미경	자재부	2520000	5
김인수	영업부	2500000	6
지재환	기획부	2450000	7
이상헌	개발부	2350000	8
최석규	홍보부	2350000	8


        
        2.dense_rank over(order by 컬럼명 desc|asc)
        
        
        select
    name,buseo,basicpay,
    dense_rank() over(order by basicpay desc) as rnum
from tblinsa;
지재환	기획부	2450000	7
이상헌	개발부	2350000	8
최석규	홍보부	2350000	8
김영길	총무부	2340000	9
정정해	총무부	2304000	10
박문수	인사부	2300000	11
문길수	자재부	2300000	11
이기자	개발부	2265000	12



    select
    name,buseo,basicpay,
    row_number() over(
    order by basicpay desc) as rnum
    from tblinsa;
    
    --5위
            
        select
    name,buseo,basicpay,
    rank() over(order by basicpay desc) as rnum
    from tblinsa
        whererank() over (order by basicpay desc)=1;
    --불가
    
    select * from
   ( select
    name,buseo,basicpay,
    rank() over(order by basicpay desc) as rnum
from tblinsa)
where rnum=5;



------------------------------------------------------
--순위함수 + partition by ==group by역할

    select --등수가 직위 그룹별로
        name,buseo,jikwi basicpay,
        rank() over(partition by  buseo,jikwi order by basicpay desc) as rnum
    from tblinsa; 
    
이상헌	개발부	과장	1
이기자	개발부	과장	2
이기상	개발부	대리	1
장인철	개발부	대리	2
이순애	개발부	부장	1
이미성	개발부	사원	1
황진이	개발부	사원	2
정영희	개발부	사원	3
채정희	개발부	사원	4
엄용수	개발부	사원	5
김신애	개발부	사원	6
임수봉	개발부	사원	7