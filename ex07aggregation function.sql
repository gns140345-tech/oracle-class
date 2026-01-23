--ex07    aggregation function
/*
        클래스내에 선언된 함수를 메서드라고 한다.
        자바의 메서드는 
        모든 기능이 객체안에 구현 > 데이터(변수) ,행동(메서드
        -s1.getTotal() //개인행동
        -student.getxxx ///단체행동
        
        sql의 메서드x >>함수 o
            -sql은 소속된 주체가 없다
            - 함수 자체로 존재한다.
            
        함수 , function
        1.내장 함수 , built in function
        2.사용자 정의 함수 ,user function(내가만든함수)> 
        
        집계함수 aggregation function
        -java stream > count,sum, avg, max,min
        
        1.count()
        2.sum()
        3.avg()
        4.max()
        5.min()
        
        1.count()
        -결과 테이블의 레코드 수를 반환
        -number count(컬럼명) //null을 예상하고 레코드수
        number count* >>(특정 컬럼에 null유무와 상관없이 모든 레코드의 수)
        -null값은 제외한다 **********************
*/
select
*
from tblcountry;

select count(*) from tblcountry; --14 (특정 컬럼에 null유무와 상관없이 모든 레코드의 수)
select count(name) from tblcountry; --14
select count(capital) from tblcountry; --14
select count(population) from tblcountry;--13   

select capital from tblcountry;

--연락처가 있는 직원의 수는?>
select count(*) from tblinsa;
select count(tel) from tblinsa; 
-- 연락처가 없는 직원은? >>불가
select count(*) from tblinsa where tel is not null; --57
--연락처가 없는 직원의 수?
select count(*) from tblinsa where tel is  null;--3
select count(*) -count(tel) from tblinsa;
--어떤 부서들이 있나요? >부서가 총 몇개인가?
select distinct buseo from tblinsa;--60
--중복값이 사라진 부서의 갯수
select count(distinct buseo) from tblinsa;--7

--tblcomedian 남자수 여자수
select * from tblcomedian;
select count( *) from tblcomedian where gender='m';
select count( *) from tblcomedian where gender='f';


--**자주쓰는 패턴
--남자 수와 여자수를 1개의 테이블로 가져오시오
select //
  count(case 
       when gender='m' then '남자'
    end) as 남자수 ,
 count ( case
         when gender='f' then '여자'
        end)as 여자수
from tblcomedian;


--tblinsa 기획부 몇명? 총무부 몇명? 개발부 몇명? >> 1개의 테이블로 알고 싶다
select * from tblinsa where buseo ='기획부';--7
select * from tblinsa where buseo ='총무부';
select * from tblinsa where buseo ='개발부';

--1번의 테이블로

select
    count(case
        when buseo='기획부' then 1
    end)as 기획부,
    count(case
        when buseo='총무부' then 1
    end) as 총무부,
   count(case
        when buseo='개발부' then 1
    end) as 개발부,
    count(
        case
            when buseo not in('기획부','총무부','개발부') then 1
        end
    )as 나머지
from tblinsa;

--null을 값을 활용하여 구하는게 핵심

/*
    2.sum()
    -해당 컬럼의 합을 구한다.
    -number sum(컬럼명)
    -숫자형 컬럼에만 적용
    

*/
select sum(population), sum(area) from tblcountry; //null값은 포함 x
select sum(name)from tblcountry; -- 숫자형만 가능이라 에러
select sum(ibsadate) from tblinsa; --ORA-00932: 일관성 없는 데이터 유형: NUMBER이(가) 필요하지만 DATE임
select sum(*) from tblcountry; -- 의도를 알수없는 합 >>특정 컬럼의 합만을 구할 수 있음 2개이상의 컬럼의 합은 의도를 알 수 없음

select
    sum(basicpay) as 지출급여합,
    sum(sudang) as 지출수당합,
    sum(basicpay) +sum(sudang) as 총지출,
    sum(basicpay+sudang) as 총지출
from tblinsa;
/*
    3.avg()
        -해당 컬럼의 평균값을 반환
            -number avg( 마찬가지로 특정 컬럼명에서만 가능)
            -숫자형 컬럼에만 적용가능
            
*/


--tblinsa ,평균급여?
select sum(basicpay) /60    from tblinsa; ---155~
select sum(basicpay) /count(*)  from tblinsa; -- 퇴사등 변동에 대비
select avg(basicpay) from tblinsa;

--tblinsa 평균 인구수?
select sum(population) /14 from tblcountry; --14475
select sum(population) /count(*) from tblcountry; --14475>>null값인 케냐가 반영
select avg(population) from tblcountry;--15588
select sum(population) /13 from tblcountry; --15588
select sum(population)/ count(population) from tblcountry; 
--그래도 케냐를 반영해서 나누는 경우도 있다

--회사 >성과급 지급 > 출처> 1팀 공로~
--1.균등 지급 >>총지급액/모든 직원수 =sum()/count(*)
--2.차등 지급 >>총지급액/1팀직원수= sum()/count(1팀) =avg

/*
    4.max()
        -최댓값 반환
        -object max(특정 컬럼명)
        
    5.min()
        -최솟값 반환
        -object min(특정 컬럼명)
        //objcet라 표현한이유
    -숫자형,문자형, 날짜형 모두 적용 가능

*/

select max(basicpay),min(basicpay) from tblinsa;
select max(name),min(name) from tblinsa;
select max(ibsadate),min(insadate) from tblinsa;

select
count(*) as 직원수,
sum(basicpay) as 총급여합,
avg(basicpay) as 평균급여,
max(basicpay) as 최고급여,
min(basicpay) as 최저급여
from tblinsa;

-- 집계 함수 사용 시 주의할 점!!
--ORA-00937: 단일 그룹의 그룹 함수가 아닙니다 "not a single-group group function
-->>컬럼 리스트(select절)에서는 절대 집계함수와 그냥 일반컬럼(name)을 동시에 사용할 수 없다.
--요구사항] 직원들의 이름과 총 전체 직원수를 가져오시오
select name , count(*) from tblinsa;

--요구사항]평균 급여보다 더 많이 받는 직원들?

select avg(basicpay) from tblinsa; -155652..........

select * from tblinsa where basicpay>=1556526.66666666666666666666; 
--평균값은 변해서 avg자체를 대입
select * from tblinsa where basicpay>=avg(basicpay); --ORA-00934: 그룹 함수는 허가되지 않습니다
--where절에서는 집계함수를 사용할 수 없다
--where절은 개인에대한 질문 >>하나하나의 한사람의 데이터에 대해서 질문하는데 여러개가 집계되어 있는 집계함수가 나오면 실행할 수 없는 공간

--개인데이터 집합데이터는 절대 함께할수 없다

