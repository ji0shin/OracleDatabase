-- QUIZ_TABLE 생성

CREATE TABLE QUIZ_TABLE (
   Q_ID       NUMBER(3, 0) NOT NULL ,
   Q_CONTENT  VARCHAR2(200) NOT NULL ,
   Q_ANSWER   VARCHAR2(100) ,
   REG_DATE   DATE DEFAULT SYSDATE
) ;

INSERT INTO QUIZ_TABLE (
       Q_ID
     , Q_CONTENT
     , Q_ANSWER
     , REG_DATE
) VALUES (
       1
     , '쥐는 영어로 무엇일까요?'
     , 'mouse'
     , SYSDATE
) ;

INSERT INTO QUIZ_TABLE (
       Q_ID
     , Q_CONTENT
     , Q_ANSWER
     , REG_DATE
) VALUES (
       2
     , '달력은 영어로 무엇일까요?'
     , 'calendar'
     , SYSDATE
) ;

INSERT INTO QUIZ_TABLE (
       Q_ID
     , Q_CONTENT
     , Q_ANSWER
     , REG_DATE
) VALUES (
       3
     , '종이는 영어로 무엇일까요?'
     , 'paper'
     , SYSDATE
) ;

INSERT INTO QUIZ_TABLE (
       Q_ID
     , Q_CONTENT
     , Q_ANSWER
     , REG_DATE
) VALUES (
       3
     , '쥐는 영어로 무엇일까요?'
     , 'mouse'
     , SYSDATE
) ;

SELECT * FROM QUIZ_TABLE ;

ALTER TABLE QUIZ_TABLE ADD CONSTRAINT PK_QUIZ_TABLE PRIMARY KEY(Q_ID) ;

-- 실습 
--1. 3개의 테이블 생성
CREATE TABLE 회원정보 (
   회원ID    VARCHAR2(10) NOT NULL ,
   이름      VARCHAR2(20) NOT NULL ,
   가입일자   DATE , 
   나이      NUMBER DEFAULT 0 
   성별      VARCHAR2(5) CONSTRAINT 성별_CHECK CHECK(성별 in ('남', '여')) 
) ;

CREATE TABLE 회원연락처 (
   회원ID   VARCHAR2(10) NOT NULL ,
   구분코드  VARCHAR2(10) NOT NULL ,
   연락처    VARCHAR2(15) NOT NULL  
) ;

CREATE TABLE 회원주소 (
   회원ID    VARCHAR2(10) NOT NULL ,
   도로명주소 VARCHAR2(200) NOT NULL
) ;

--2. PK 제약조건 추가

ALTER TABLE 회원정보 ADD CONSTRAINT PK_회원정보 PRIMARY KEY(회원ID) ;
ALTER TABLE 회원연락처 ADD CONSTRAINT PK_회원연락처 PRIMARY KEY(회원ID, 구분코드) ;
ALTER TABLE 회원주소 ADD CONSTRAINT PK_회원주소 PRIMARY KEY(회원ID) ;

-- UK 제약조건 추가
ALTER TABLE 회원정보 ADD CONSTRAINT UK_회원정보 UNIQUE (주민등록번호) ;


--3. FK 제약조건 설정

ALTER TABLE 회원연락처 ADD CONSTRAINT FK_회원연락처 
FOREIGN KEY (회원ID) REFERENCES 회원정보(회원ID) ;

ALTER TABLE 회원주소 ADD CONSTRAINT FK_회원주소 
FOREIGN KEY (회원ID) REFERENCES 회원정보(회원ID) ;

-- ALTER

ALTER TABLE 직원 ADD (생년월일 VARCHAR2(8)) ;

ALTER TABLE 직원 DROP COLUMN 생년월일 ; 

ALTER TABLE 직원 MODIFY (패스워드 VARCHAR2(300)) ;

ALTER TABLE 직원 RENAME COLUMN 패스워드 TO 비밀번호 ;

SELECT * FROM 직원 ;

