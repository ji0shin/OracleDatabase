SELECT TO_NUMBER('1') FROM DUAL ; -- 문자형('1')을 숫자형(1) 로 형변환해 출력

SELECT TO_CHAR(1) FROM DUAL ; --숫자형(1)을 문자형('1') 로 형변환해 출력

SELECT TO_CHAR(SYSDATE , 'YYYYMMDD') FROM DUAL ; 

SELECT TO_DATE('20230101' , 'YYYY/MM/DD') FROM DUAL ; 

SELECT TO_DATE('20230101141212' , 'YYYY/MM/DD HH24:MI:SS') FROM DUAL; 
/*
3번 문제는 날짜형(SYSDATE) 을 문자형으로 변경합니다. (포맷의미는 꼭 외웁시다!)
4번 문제는 문자형('2023010114')을 날짜형 (2023/01/01 14:00:00) 으로 변경합니다.
5번 문제는 문자형('20230101141212')을 날짜형(2023/01/01 14:12:12) 으로 변경합니다. 
*/

SELECT 직원ID
     , 입사일시
     , TO_CHAR(입사일시, 'YYYY') AS 입사연도
  FROM 직원 ; 
  
-- 포맷 쓸 때 ' ' 안에 작성 주의

SELECT 이름 + 1000 FROM 직원 ; -- 에러발생

SELECT LOWER('ABCDE123@@') AS LOWER사용
 FROM DUAL ;
