SELECT * FROM ����ǥ ;

SELECT �л�ID
     , COUNT(*)  -- *�� NULL�� ������ ���� ����
     , COUNT(����)
  FROM ����ǥ
 GROUP BY �л�ID ;
 
-- ���� ���̺� �����Ͱ� �����?

SELECT COUNT(*)
  FROM ���� ;

SELECT COUNT(*)
  FROM ����
 GROUP BY ();  -- �׷���̸� �Ⱦ��� �ڵ����� �̷��� ����� 
               -- �������̺� ��ü�� �ϳ��� �׷����� ��
               
SELECT MAX(����)
  FROM ���� ;  -- ���� ���̺��� �ϳ��� �׷����� �� ���� ������ ������ 
  
--

SELECT MAX(�Ի��Ͻ�) FROM ���� ;
SELECT MIN(����ID) FROM ���� ; 

--

SELECT �л�ID, ROUND(AVG(����), 1)
  FROM ����ǥ
 GROUP BY �л�ID ;
 
-- �ǽ����� 
--1. ����ǥ ���̺��� �л����� ������� ��� (�Ҽ��� 1�ڸ� ������)

SELECT �л�ID
     , ROUND(AVG(����), 1) AS ��ռ���
  FROM ����ǥ
 GROUP BY �л�ID ; 
 
--2. ���� ���̺��� ��� ���� �� �ְ� ������ ���� ���� ���

SELECT MAX(����) AS �ְ���
     , MIN(����) AS ��������
  FROM ���� ;
  
SELECT ����ID
     , MAX(����) AS �ְ���
     , MIN(����) AS ��������
  FROM ���� 
  GROUP BY ();
  
SELECT ����ID
     , MAX(����) AS �ְ���
     , MIN(����) AS ��������
  FROM ���� 
  GROUP BY ����ID;
  
--3. ���������� ���̺��� �� �Ҽӵ� �� ���� �� ���� �ִ��� ���

SELECT �Ҽӹ�
     , COUNT(*) AS �ݺ��ο���
  FROM ����������
 GROUP BY �Ҽӹ� ;
 
--4. ����ǥ ���̺��� �л����� ����� ���� ������ ����� ��� 
-- (������ ������ ������ ����)

SELECT �л�ID
     , AVG(����) AS �������������
  FROM ����ǥ
 WHERE ���� IN ('����', '����') 
GROUP BY �л�ID ; -- WHERE ���� ó�� �� GROUP BY ����

--5. ���� ���̺��� �μ����� ������ �հ� ���

SELECT �μ�ID
     , SUM(����) AS �μ��������հ�
  FROM ���� 
 GROUP BY �μ�ID ;
 
--6. ���� ���̺�� ���� ����ó ���̺��� �̿��Ͽ� �������� ����ó ������ �� �� �ִ��� ���
-- ���� ���̺��� �������� A0001 ~ A0011�� ��� ������ �����ֵ�,
-- ����ó�� ���� ��� 0������ ��� (���ν� ����Ŭ ��� ���� Ȱ��)

SELECT A.����ID
     , COUNT(B.����ó) AS ����ó����
  FROM ���� A
     , ��������ó B
 WHERE A.����ID = B.����ID (+)
 GROUP BY A.����ID ;  
 
-- HAVING

SELECT �л�ID, ROUND(AVG(����), 1) AS ��ռ���
  FROM ����ǥ
WHERE AVG(����) <= 75
 GROUP BY �л�ID
  ;
    
-- �ǽ����� 
--1. ���������� ���̺��� �Ҽӹ� �� �ο����� 3���̻��� Ʃ�ø� ���

SELECT �Ҽӹ�
     , COUNT(*) AS �ο���
  FROM ����������
 GROUP BY �Ҽӹ�
 HAVING COUNT(*) >= 3 ;
 
--2. ���� ���̺��� �μ��� �ְ����� 7500�� Ʃ�ø� ���

SELECT �μ�ID
     , MAX(����) AS �ְ���
  FROM ����
 GROUP BY �μ�ID
 HAVING MAX(����) = 7500 ;
 
--3. ����ǥ ���̺��� �л��� ��ռ����� ���ϵ�, ��հ��� NULL�� �ƴ� ���� ���
SELECT �л�ID
     , ROUND(AVG(����) , 1) AS ��ռ���
  FROM ����ǥ
 GROUP BY �л�ID 
 HAVING AVG(����) IS NOT NULL ; 
 
-- ORDER BY 

SELECT *
  FROM ����
 ORDER BY �̸� DESC ;
 
SELECT *
  FROM ����
 ORDER BY �μ�ID, �̸� DESC ;  
 -- �μ�ID�� �������� �������� �����ϵ� �Ȱ��� �μ��� ������ �̸� �������� �������� ����
 
SELECT ����ID
     , �̸�
     , ���� AS �������ǿ���
     , ���� * 0.1 AS ���ʽ�
  FROM ����
 ORDER BY 3 ;  -- �������ǿ����� �������� �������� ����
 
SELECT ����ID
     , �̸�
     , ���� AS �������ǿ���
     , ���� * 0.1 AS ���ʽ�
  FROM ����
 ORDER BY �������ǿ��� ;
 
-- DML INSERT

INSERT INTO ���� (
       ����ID
     , �н�����
     , �̸�
     , ����
     , ����
     , �Ի��Ͻ�
     , �ֹε�Ϲ�ȣ
     , �μ�ID
) VALUES (
         'A0013'
       , 'pass1234'
       , '������'
       , '��'
       , '30'
       , SYSDATE
       , '930911-1255231'
--       , 'D001'
) ;

SELECT * FROM ���� ;

INSERT INTO ����
VALUES (
'A0014' 
, 'hipasswd'
, '������'
, '��'
, 50
, sysdate
, '740922-2555111'
, 7000
, 'D002'
) ;

COMMIT;

UPDATE ���� 
   SET ���� = 9999 ; -- ���� ���̺��� ��� ������ 9999�� �ٲ�
  
ROLLBACK ; -- ��� �Է��� ������ �ǵ�����

UPDATE ����
   SET ���� = 9999
 WHERE ����ID = 'A0001' ;
 
COMMIT;

SELECT * FROM ���� ;