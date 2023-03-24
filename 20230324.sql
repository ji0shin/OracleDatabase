-- QUIZ_TABLE ����

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
     , '��� ����� �����ϱ��?'
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
     , '�޷��� ����� �����ϱ��?'
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
     , '���̴� ����� �����ϱ��?'
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
     , '��� ����� �����ϱ��?'
     , 'mouse'
     , SYSDATE
) ;

SELECT * FROM QUIZ_TABLE ;

ALTER TABLE QUIZ_TABLE ADD CONSTRAINT PK_QUIZ_TABLE PRIMARY KEY(Q_ID) ;

-- �ǽ� 
--1. 3���� ���̺� ����
CREATE TABLE ȸ������ (
   ȸ��ID    VARCHAR2(10) NOT NULL ,
   �̸�      VARCHAR2(20) NOT NULL ,
   ��������   DATE , 
   ����      NUMBER DEFAULT 0 
   ����      VARCHAR2(5) CONSTRAINT ����_CHECK CHECK(���� in ('��', '��')) 
) ;

CREATE TABLE ȸ������ó (
   ȸ��ID   VARCHAR2(10) NOT NULL ,
   �����ڵ�  VARCHAR2(10) NOT NULL ,
   ����ó    VARCHAR2(15) NOT NULL  
) ;

CREATE TABLE ȸ���ּ� (
   ȸ��ID    VARCHAR2(10) NOT NULL ,
   ���θ��ּ� VARCHAR2(200) NOT NULL
) ;

--2. PK �������� �߰�

ALTER TABLE ȸ������ ADD CONSTRAINT PK_ȸ������ PRIMARY KEY(ȸ��ID) ;
ALTER TABLE ȸ������ó ADD CONSTRAINT PK_ȸ������ó PRIMARY KEY(ȸ��ID, �����ڵ�) ;
ALTER TABLE ȸ���ּ� ADD CONSTRAINT PK_ȸ���ּ� PRIMARY KEY(ȸ��ID) ;

-- UK �������� �߰�
ALTER TABLE ȸ������ ADD CONSTRAINT UK_ȸ������ UNIQUE (�ֹε�Ϲ�ȣ) ;


--3. FK �������� ����

ALTER TABLE ȸ������ó ADD CONSTRAINT FK_ȸ������ó 
FOREIGN KEY (ȸ��ID) REFERENCES ȸ������(ȸ��ID) ;

ALTER TABLE ȸ���ּ� ADD CONSTRAINT FK_ȸ���ּ� 
FOREIGN KEY (ȸ��ID) REFERENCES ȸ������(ȸ��ID) ;

-- ALTER

ALTER TABLE ���� ADD (������� VARCHAR2(8)) ;

ALTER TABLE ���� DROP COLUMN ������� ; 

ALTER TABLE ���� MODIFY (�н����� VARCHAR2(300)) ;

ALTER TABLE ���� RENAME COLUMN �н����� TO ��й�ȣ ;

SELECT * FROM ���� ;

