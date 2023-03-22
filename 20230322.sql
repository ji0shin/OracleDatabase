/* �׽�Ʈ �����͸� �����ô� */ 
CREATE TABLE �� (
����ȣ VARCHAR2(5) PRIMARY KEY , 
���� VARCHAR2(50) NOT NULL 
) ; 
CREATE TABLE ����ȭ��ȣ ( 
����ȣ VARCHAR2(5) ,
��ȭ�����ڵ� VARCHAR2(10) ,
��ȭ��ȣ VARCHAR(15) NOT NULL 
) ; 
ALTER TABLE ����ȭ��ȣ ADD CONSTRAINT PK_����ȭ��ȣ PRIMARY KEY(����ȣ , ��ȭ�����ڵ�) ; 
INSERT INTO �� VALUES ( '0001' , '������' ) ; 
INSERT INTO �� VALUES ( '0002' , '������' ) ; 
INSERT INTO �� VALUES ( '0003' , '������' ) ; 
INSERT INTO ����ȭ��ȣ VALUES ( '0001' , '����ȭ' , '062-111-1111') ; 
INSERT INTO ����ȭ��ȣ VALUES ( '0001' , '�޴���' , '010-1111-1111') ; 
INSERT INTO ����ȭ��ȣ VALUES ( '0002' , '�޴���' , '010-2222-2222') ; 
INSERT INTO ����ȭ��ȣ VALUES ( '0004' , '�޴���' , '010-4444-4444') ; 
COMMIT;

-- īƼ������ : ���̺��� FROM�� 2�� �̻� �Էµ� ����

SELECT * FROM �� ;

-- ����ȣ �÷����� ���� (��������)
SELECT A.����ȣ
     , A.����
     , B.��ȭ��ȣ
  FROM �� A, ����ȭ��ȣ B
 WHERE A.����ȣ = B.����ȣ(+);  -- �� ���̺� ���� ������ Ʃ�õ� ���

SELECT A.����ȣ
     , A.����
     , B.��ȭ��ȣ
  FROM �� A, ����ȭ��ȣ B
 WHERE A.����ȣ (+) = B.����ȣ ;  -- ����ȭ��ȣ ���̺� ���� ������ Ʃ�õ� ���

 
 SELECT *
  FROM �� A, ����ȭ��ȣ B
 WHERE A.����ȣ <= B.����ȣ;  -- �񵿵�����

-- ����ȣ�� 0001�� �� (�Ϲ�����) 
SELECT A.����ȣ
     , A.����
     , B.��ȭ��ȣ
  FROM �� A, ����ȭ��ȣ B
 WHERE A.����ȣ = B.����ȣ
   AND A.����ȣ = '0001' 
   AND B.��ȭ�����ڵ� = '����ȭ' ;

-- �Ȱ��� �̸��� �÷��� ������ �ȵ�. ���� ���� �̸��� ��� �̸��� �����Ͽ� ������
SELECT A.����ȣ, B.����ȣ
  FROM �� A, ����ȭ��ȣ B ;

-- �ǽ�
-- 1.
SELECT C.����ID AS ����_����ID
     , C.����
     , C.����
     , D.����ID AS �ּ�_����ID
     , D.�����ڵ�
     , D.�ּ�
  FROM ���� C, �����ּ� D
 WHERE C.����ID = D.����ID ;

-- 2.
SELECT C.����ID
     , C.����
     , C.����
     , D.����ID
     , D.�����ڵ�
     , D.�ּ�
  FROM ���� C, �����ּ� D
 WHERE C.����ID = D.����ID 
   AND C.����ID = 'A0007' ;

-- 3. �����ּ� ���̺� ���� = ���� ���̺��� ������ -> ���� ���̺� ����
SELECT C.����ID AS ����_����ID
     , C.�̸�
     , C.����
     , D.����ID AS �ּ�_����ID
     , D.�����ڵ�
     , D.�ּ�
  FROM ���� C, �����ּ� D
 WHERE C.����ID = D.����ID (+) ;
 
 SELECT * FROM ���� ;
 SELECT * FROM �����ּ�;
 
-- 4. ���� ���Ǵ� CASE 
SELECT C.����ID
     , C.�̸�
     , C.����
     , D.����ID
     , D.�����ڵ�
     , D.�ּ�
  FROM ���� C, �����ּ� D
 WHERE C.����ID = D.����ID (+)
   AND D.�ּ� IS NULL;
   
-- 5. 
SELECT C.����ID
     , C.�̸�
     , C.����
     , D.�ּ�
     , E.����ó
  FROM ���� C, �����ּ� D, ��������ó E
 WHERE C.����ID = D.����ID
   AND C.����ID = E.����ID; -- �������� �ּ� ���� = ���̺� ���� - 1
   
-- 6.
SELECT A.����ID
     , A.�̸�
     , A.�Ի��Ͻ�
     , B.����ó
  FROM ���� A, ��������ó B
 WHERE A.����ID = B.����ID 
   AND A.����ID IN ( 'A0001', 'A0002', 'A0003')
   AND B.�����ڵ� = '�޴���';
   
-- 7. 
SELECT A.����ID
     , A.�̸�
     , B.�μ�ID
     , B.�μ���
  FROM ���� A, �μ� B
 WHERE A.�μ�ID = B.�μ�ID ;

SELECT * FROM �μ� ;

-- ����Ŭ ���� -> ANSI ����

SELECT *
  FROM �� A, ����ȭ��ȣ B
 WHERE A.����ȣ = B.����ȣ (+) ;

SELECT *
  FROM �� A LEFT OUTER JOIN ����ȭ��ȣ B
    ON (A.����ȣ = B.����ȣ);

-- �ǽ�
-- 1. 
SELECT A.����ID
     , A.�̸�
     , B.�ּ�
  FROM ���� A LEFT OUTER JOIN �����ּ� B
    ON (A.����ID = B.����ID)
 WHERE A.����ID IN ( 'A0005', 'A0008') ;
 
--2. 
SELECT B.����ID
     , B.�̸�
     , A.�ּ�
  FROM �����ּ� A RIGHT OUTER JOIN ���� B
    ON (A.����ID = B.����ID) ;

--3. 
SELECT A.����ID
     , A.�̸�
     , A.����
     , B.����ó
  FROM ���� A INNER JOIN ��������ó B
    ON (A.����ID = B.����ID);
    
-- ���̺� 3�� �����ϴ� ��
-- 2������ ���� ����

SELECT A.����ID
     , A.�̸�
     , B.����ó
     , C.�ּ�
  FROM ���� A
     , ��������ó B
     , �����ּ� C
 WHERE A.����ID = B.����ID
   AND B.����ID = C.����ID ; 

SELECT A.����ID
     , A.�̸�
     , B.����ó
     , C.�ּ�
  FROM ���� A INNER JOIN ��������ó B ON (A.����ID = B.����ID)
              INNER JOIN �����ּ� C ON (B.����ID = C.����ID) ;

-- GROUP BY

DROP TABLE �л��������� ;
���� ����
DROP TABLE ���������� ; 
DROP TABLE ����ǥ ; 
CREATE TABLE ���������� (
�л�ID VARCHAR2(9) PRIMARY KEY , 
�л��̸� VARCHAR2(50) NOT NULL , 
�Ҽӹ� VARCHAR2(5) 
); 
CREATE TABLE ����ǥ ( 
�л�ID VARCHAR2(9) , 
���� VARCHAR2(30) , 
���� NUMBER , 
CONSTRAINT PK_����ǥ PRIMARY KEY(�л�ID , ����) , 
CONSTRAINT FK_����ǥ FOREIGN KEY(�л�ID) REFERENCES ����������(�л�ID) 
) ; 
INSERT INTO ���������� VALUES ('S0001' , '����ö' , 'A') ; 
INSERT INTO ���������� VALUES ('S0002' , '������' , 'A') ; 
INSERT INTO ���������� VALUES ('S0003' , '����ġ' , 'B') ; 
INSERT INTO ���������� VALUES ('S0004' , '�ڳ���' , 'B') ; 
INSERT INTO ���������� VALUES ('S0005' , '���°�' , 'B') ; 
INSERT INTO ���������� VALUES ('S0006' , '�����' , 'C') ; 
INSERT INTO ���������� VALUES ('S0007' , '�ڶ��' , 'C') ; 
INSERT INTO ���������� VALUES ('S0008' , '���ȵ�' , 'C') ; 
INSERT INTO ���������� VALUES ('S0009' , '������' , 'C') ; 
INSERT INTO ����ǥ VALUES('S0001' ,'����' , 90); 
INSERT INTO ����ǥ VALUES('S0001' ,'����' , 85); 
INSERT INTO ����ǥ VALUES('S0001' ,'����' , 100); 
INSERT INTO ����ǥ VALUES('S0002' ,'����' , 100); 
INSERT INTO ����ǥ VALUES('S0002' ,'����' , 100); 
INSERT INTO ����ǥ VALUES('S0002' ,'����' , 20); 
INSERT INTO ����ǥ VALUES('S0003' ,'����' , 100); 
INSERT INTO ����ǥ VALUES('S0003' ,'����' , 100); 
INSERT INTO ����ǥ VALUES('S0003' ,'����' , 20); 
INSERT INTO ����ǥ VALUES('S0004' ,'����' , 85); 
INSERT INTO ����ǥ VALUES('S0004' ,'����' , 40); 
INSERT INTO ����ǥ VALUES('S0004' ,'����' , 60); 
INSERT INTO ����ǥ VALUES('S0005' ,'����' , 100); 
INSERT INTO ����ǥ VALUES('S0005' ,'����' , 100); 
INSERT INTO ����ǥ VALUES('S0005' ,'����' , 100); 
INSERT INTO ����ǥ VALUES ( 'S0006' , '����' , NULL ) ; 
INSERT INTO ����ǥ VALUES ( 'S0006' , '����' , NULL ) ; 
INSERT INTO ����ǥ VALUES ( 'S0006' , '����' , NULL ) ; 
COMMIT; 

SELECT * FROM ���������� ;
SELECT * FROM ����ǥ ;

SELECT �Ҽӹ�, COUNT(*) AS �ݺ��ο���
  FROM ����������
 GROUP BY �Ҽӹ� ;
 
SELECT �Ҽӹ�, �л��̸�
  FROM ����������
 GROUP BY �Ҽӹ� ;
 
SELECT �Ҽӹ�, COUNT(*)
  FROM ����������
 GROUP BY �Ҽӹ� ;
 
SELECT �л�ID, AVG(����)
  FROM ����ǥ
 GROUP BY �л�ID ;

SELECT �л�ID, SUM(����)
  FROM ����ǥ
 GROUP BY �л�ID ;

SELECT �л�ID, MAX(����), MIN(����)
  FROM ����ǥ
 GROUP BY �л�ID ;