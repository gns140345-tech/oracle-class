




/*
        view
        -db object > 객체> 오라클에 저장
        -create/drop> ddl로 조작
        -가상 테이블 ,뷰 테이블이라고도 부름
        -테이블과 유사한 행동을 한다
        -select를 실행한 결과를 복사한 테이블(x)
        -복사가 아닌 sql(select)문을 저장한 객체
        
        create [or replace]생략가능 view 뷰이름  --머리
        as  -->연결부 하는일 없음(as또는 is)
        select문; --몸통

        뷰를 사용하는 이유
        1.자주 쓰는 쿼리를 저장하는 용도
        2.복잡하고 긴 쿼리를 저장하는 용도
        3. 저장하는 객체라서 같은 데이터베이스를 공유하는 사용자끼리 뷰 공유가능 >재사용/협업
        4.권한을 통제  > 보안
                -신입사원> 직원들 연락처로 문자 메세지 발송
                    - TBLINSA
                    -vwinsa
*/
        create or replace view vwinsa
        as
        select * from tblinsa;  --계정에 따른 테이블 접근 권한 유/무
        
        create table tbltel
        as
        select num,name,tel jikwi from tblinsa where buseo='기획부';
        
   
        
        
        
        select * from vwinsa; --테이블은 아님  
   -- == select * from(select *from tblinsa);  --from절에 들어가는  데이터를 저장하는것이 아니라 실시간으로 마지막에 동기화
        
        create or replace view vwtel
        as
        select num,name,tel jikwi from tblinsa;
        
        select * from vwtel;
        
        --특정레코드  >>pk
        --011 2356 4528
        update tblinsa set tel ='010-1111-2222' where num=1001;
        
        select * from tblinsa where num=1001; --'010-1111-2222
        select * from tbltel where num =1001;--011 2356 4528 안바뀜
         select * from vwtel where num =1001; --010-1111-2222 >> 바뀜
        
        
         create or replace view vwinsa
        as
        select num,name,jikwi from tblinsa where buseo='기획부';  --view는 drop하지 않고 replace로 그냥 바로됨 >>덮어쓰기
        
        select * from vwinsa;
        
        
        
        --비디오 대여점 사장님 >> 날마다 업무
        -- 어던 회원이 어떤 비디오를 빌려갔고 언제 반납예정일이고 연체일,연체료
        create or replace view vwcheck
        as
        select
        m.name as 회원명,
        v.name as 비디오,
        r.rentdate as 대여일,
        r.retdate as 반납일,
        g.period as 대여기간,
        r.rentdate + g.period as 반납예정일,
        case
            when r.retdate is not null then r.retdate -r.rentdate -g.period
            when r.retdate is  null then round(sysdate - r.rentdate -g.period)
        end as 연체일,
        
        g.price as 대여료,
        
          case
            when r.retdate is not null then r.retdate -r.rentdate -g.period
            when r.retdate is  null then round(sysdate - r.rentdate -g.period)
        end * g.price *0.1 as 연체료
        
        from tblmember m
                inner join tblrent  r
                on m.seq= r.member
                    inner join tblvideo v
                        on v.seq =r.video
                            inner join tblgenre g
                                on g.seq=v.genre;
                                
                                
유관순	털미네이터	07/02/03		2	07/02/05	6932	1500	1039800
이율곡	털미네이터	07/02/04	07/02/08	2	07/02/06	2	1500	300
김유신	어쭈구리	   07/02/10		 1	07/02/11	6926	1000	692600
강감찬	어쭈구리	     07/02/02	07/02/03	1	07/02/03	0	1000	0
김유신	영구와 땡칠이	07/01/01		3	07/01/04	6964	1000	696400
신숙주	뽀뽀할까요	07/02/05		1	07/02/06	6931	2000	1386200






select * from vwcheck;


--뷰 사용 시 주의점
--1.select할때 실행>>>결론 뷰는 읽기 전용테이블이다
--2/.insert 에 뷰 실행 됨   하지만 2~3,4 다 절대사용금지  >>결론 뷰는 읽기 전용테이블이다 >>table로 하면됨
--3.update 
--4. delete  > 다 잘됨
        create or replace view vwtodo
        as
        select *from tbltodo;
        
        select * from vwtodo;
      --  insert into vwtodo values(=select *from tbltod)(21,'뷰 만들기',sysdate,null);
         insert into vwtodo values(21,'뷰 만들기',sysdate,null);
        update vwtodo set completedate = sysdate where seq =21;
        delete from vwtodo where seq=21;
        
        --단순뷰(테이블이1개)는 >crud가능
        --복합뷰(테이블2개이상) >curd가 불가능 > r 가능
        --vwtodo vwcheck는 R만하자!!!
        
