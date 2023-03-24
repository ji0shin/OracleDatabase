/***************************************************************
다음 문항은 이전에 배웠던 내용을 복습하기 위한 문제입니다.
PDF를 참고하면서 천천히 문항을 풀어보세요. 
범위 : FROM 처음부터 끝까지 
****************************************************************/ 

/* 
1. 성적표 와 수강생정보 테이블을 학생ID 를 기준으로 조인하려고 합니다. 
   이때 "="조건으로 INNER 조인을 해서 S0001 , S0002 , S0003 의 데이터만 출력하세요.
   (오라클 조인 방식, ANSI 조인 방식 아무거나 상관 없음) 
   
   [ 성적표    => 학생ID , 과목 , 성적 컬럼을 가져오세요 ] 
   [ 수강생정보 => 학생이름 , 소속반 컬럼을 가져오세요 ] 
   
[출력결과] 
학생ID  과목    성적  학생이름  소속반 
S0001	국어     90	 김현철	  A
S0001	수학     85	 김현철	  A
S0001	영어    100 	 김현철	  A
S0002	국어    100	 문현중	  A
S0002	수학	   100	 문현중	  A
S0002	영어	    20	 문현중	  A
S0003	국어	   100	 강문치	  B
S0003	수학	   100	 강문치	  B
S0003	영어	    20	 강문치	  B 
*/     

-- 오라클 조인 방식
SELECT A.학생ID
     , A.과목
     , A.성적
     , B.학생이름
     , B.소속반
  FROM 성적표 A
     , 수강생정보 B
 WHERE A.학생ID = B.학생ID
   AND A.학생ID IN ('S0001' , 'S0002', 'S0003'); 

-- ANSI 조인 방식
SELECT A.학생ID
     , A.과목
     , A.성적
     , B.학생이름
     , B.소속반
  FROM 성적표 A INNER JOIN 수강생정보 B
    ON A.학생ID = B.학생ID
   WHERE A.학생ID IN ('S0001' , 'S0002', 'S0003'); 

/* 
2. 성적표와 수강생정보 테이블을 조인을 하되, 성적이 정해지지않은(NULL) 데이터만 보이도록 해주세요.
   (오라클 조인 방식, ANSI 조인 방식 아무거나 상관 없음) 
   
   [ 성적표    => 과목 , 성적 출력 ] 
   [ 수강생정보 => 학생이름 , 소속반 출력 ] 

[출력결과] 
과목  성적   학생이름  소속반 
영어  NULL	물고기	  C
수학	 NULL	물고기	  C
국어	 NULL	물고기	  C
*/ 

-- 오라클 조인 방식
SELECT A.과목
     , A.성적
     , B.학생이름
     , B.소속반
  FROM 성적표 A
     , 수강생정보 B
 WHERE A.학생ID = B.학생ID
   AND 성적 IS NULL ; 

-- ANSI 조인 방식
SELECT A.과목
     , A.성적
     , B.학생이름
     , B.소속반
  FROM 성적표 A INNER JOIN 수강생정보 B
    ON A.학생ID = B.학생ID
 WHERE 성적 IS NULL ;

/* 
3.  직원중에 주소를 입력하지 않는 대상의 정보만 출력해주세요. (오라클 방식으로 풀이하시오)  
    직원 => [ 직원id , 이름 ] 컬럼을 출력 
    (힌트 : 직원주소 테이블과 조인 , IS NULL 조건 활용) 
    (단, 출력 순서는 고려하지 않습니다 ) 

[출력결과] 
직원ID   이름 
A0011	신입
A0003	이현정
A0002	강홍수
A0005	문현철
A0004	김선미
A0001	김철수
*/ 

SELECT A.직원ID
     , A.이름
  FROM 직원 A
     , 직원주소 B
 WHERE A.직원ID = B.직원ID (+)
   AND B.주소 IS NULL ;


/*
4. 위 3번 문항을 ANSI 문법으로 바꿔주세요 
*/ 

SELECT A.직원ID
     , A.이름
  FROM 직원 A LEFT OUTER JOIN 직원주소 B 
    ON A.직원ID = B.직원ID
 WHERE B.주소 IS NULL ;

SELECT *, 직원ID
  FROM 직원 ;  -- 오류 발생

SELECT 직원.*, 직원.직원ID
  FROM 직원 ;  -- 출력 가능

/* 
5. 직원 테이블과 직원연락처 테이블을 [직원ID] 로 조인하여 아래와 같은 결과를 출력하세요. 
   (오라클 조인 방식, ANSI 조인 방식 아무거나 상관 없음) 

[출력결과] 
직원ID    이름    연봉       휴대폰  (<- 이 컬럼은 AS로 이름을 바꾼것입니다. 원래는 연락처 컬럼) 
A0001	김철수	2800	010-1231-1234
A0002	강홍수	3000	010-2544-6342
A0003	이현정	2600	010-7766-5231
A0004	김선미	4500	010-4433-5522
A0005	문현철	5000	010-9988-7273
A0006	송대주	7500	010-8373-5511
A0007	메이슨	6200	010-2323-1133
A0008	송진아	7500	010-8877-0087
*/

-- 오라클 조인 방식

SELECT A.직원ID
     , A.이름
     , A.연봉
     , B.연락처 AS 휴대폰
  FROM 직원 A
     , 직원연락처 B
 WHERE A.직원ID = B.직원ID 
   AND B.구분코드 = '휴대폰' ;
   
-- ANSI 조인 방식

SELECT A.직원ID
     , A.이름
     , A.연봉
     , B.연락처 AS 휴대폰
  FROM 직원 A INNER JOIN 직원연락처 B
    ON A.직원ID = B.직원ID 
 WHERE B.구분코드 = '휴대폰' ;

/*
6. 아래 쿼리를 ANSI 문법으로 변경하세요. 
SELECT A.직원ID , A.이름 , A.나이 , A.연봉 , B.연락처
  FROM 직원 A
     , 직원연락처 B 
 WHERE A.직원ID = B.직원ID(+)
   AND A.직원ID IN ('A0005' , 'A0006' , 'A0007' ) ; 
*/ 

SELECT A.직원ID, A.이름, A.나이, A.연봉, B.연락처
  FROM 직원 A LEFT OUTER JOIN 직원연락처 B 
    ON A.직원ID = B.직원ID
   AND A.직원ID IN ('A0005', 'A0006', 'A0007') ;

----------------------------------------------


--1번 답 
SELECT A.학생ID
     , A.과목 
     , A.성적
     , B.학생이름
     , B.소속반 
  FROM 성적표 A 
     , 수강생정보 B 
 WHERE A.학생ID = B.학생ID 
   AND A.학생ID IN ( 'S0001' , 'S0002' , 'S0003'); 

--혹은 
SELECT A.학생ID
     , A.과목 
     , A.성적
     , B.학생이름
     , B.소속반 
  FROM 성적표 A INNER JOIN 수강생정보 B ON (A.학생ID = B.학생ID) 
 WHERE A.학생ID IN ('S0001' , 'S0002' , 'S0003' ) ;


   
   
--2번 답 
SELECT A.과목 , A.성적 , B.학생이름 , B.소속반 
  FROM 성적표 A , 수강생정보 B 
 WHERE A.학생ID = B.학생ID 
   AND A.성적 IS NULL ; 
--혹은
SELECT A.과목 , A.성적 , B.학생이름 , B.소속반 
  FROM 성적표 A INNER JOIN 수강생정보 B ON (A.학생ID = B.학생ID) 
 WHERE A.성적 IS NULL  ; 




--3번 답 
SELECT A.직원ID , A.이름 
  FROM 직원 A , 직원주소 B 
 WHERE A.직원ID = B.직원ID(+)
   AND B.주소 IS NULL;


--4번 답 ) 
SELECT A.직원ID , A.이름
  FROM 직원 A LEFT OUTER JOIN 직원주소 B 
    ON (A.직원ID = B.직원ID)
 WHERE B.주소 IS NULL;
 
 
 
 
-- 5번 답 
SELECT A.직원ID , A.이름 , A.연봉 , B.연락처 AS 휴대폰
  FROM 직원 A  
     , 직원연락처 B 
 WHERE A.직원ID = B.직원ID 
   AND B.구분코드 = '휴대폰';
--혹은
SELECT A.직원ID , A.이름 , A.연봉 , B.연락처 AS 휴대폰
  FROM 직원 A INNER JOIN 직원연락처 B ON (A.직원ID = B.직원ID)
 WHERE B.구분코드 = '휴대폰'; 
 



--6번 답 
SELECT A.직원ID , A.이름 , A.나이 , A.연봉 , B.연락처
  FROM 직원 A LEFT OUTER JOIN 직원연락처 B 
    ON ( A.직원ID = B.직원ID ) 
 WHERE A.직원ID IN ('A0005' , 'A0006' , 'A0007' ) ; 