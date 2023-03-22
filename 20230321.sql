SELECT '1' + 1 FROM DUAL ;
-- '1' �� ���ڷ� ��ȯ ����

SELECT ����ID, �μ�ID, DECODE(�μ�ID, 'D001', 'OK', 'NO')
  FROM ���� ;

SELECT COALESCE(5, NULL, NULL, 1, NULL)
  FROM DUAL;
  
SELECT ����ID
     , �н�����
     , NVL(����, 20)
  FROM ���� ;
  
SELECT ����ID
     , ����
     , ����
     , DECODE(����, '��', '�����Դϴ�', '�����Դϴ�') AS ����Ȯ��
  FROM ���� ; 
  
-- WHERE�� 

SELECT * 
  FROM ����
 WHERE NOT �̸� = '������' ;
 
SELECT *
  FROM ����
 WHERE �̸� != '������' ; -- �ǹ������� != ��� (<>�� ����� �� ����)
 
SELECT ����ID
     , �����ڵ�
     , ����ó
  FROM ��������ó
 WHERE �����ڵ� != '�޴���' ;
 
SELECT ����ID
     , �̸�
     , ����
     , ����
  FROM ����
 WHERE ���� >= 50 ;

-- NULL ����

SELECT *
  FROM ����
 WHERE ���� = NULL ; -- ���̰� NULL�� �����͸� ���� �� �̷��� ��� �Ұ�
                    -- NULL�� �������� ���, �� ������ �Ұ����ϱ� ����
 
SELECT *
  FROM ����
 WHERE ���� IS NULL ; 
 
SELECT * 
  FROM ����
 WHERE ���� IS NOT NULL ;
 
SELECT *
  FROM ����
 WHERE ���� IS NOT NULL ;
 
SELECT *
  FROM ����
 WHERE �Ի��Ͻ� IS NULL ;

-- SQL ������ IN / BETWEEN / LIKE

SELECT *
  FROM ����
 WHERE ����ID NOT IN ( 'A0001' , 'A0003' , 'A0005', NULL ) ; 
 -- NOT IN �ڿ� NULL ���� ����� �ȵ�. �Ʒ��� �Ȱ��� �����ϱ� ����
 
SELECT *
  FROM ����
 WHERE ����ID != 'A0001'
   AND ����ID != 'A0003'
   AND ����ID != 'A0005'
   AND ����ID != NULL ;
   
SELECT *
  FROM ����
 WHERE ���� >= 20
   AND ���� < 30 ; 
   
SELECT * 
  FROM ����
 WHERE ���� BETWEEN 20 AND 29 ;
 
 -- ���ǻ��� 3����
 -- 1. ��� �ڷ��� ���� : ��¥��, ������, ������ ��� �� �� ���� 
 SELECT *
   FROM ����
 WHERE �Ի��Ͻ� BETWEEN SYSDATE - 365 AND SYSDATE ;
 
  SELECT *
   FROM ����
 WHERE ����ID BETWEEN 'A0001' AND 'A0003' ;
 
 -- 2. OR �� �ƴ� : BETWEEN __ AND __
 -- 3. ~ �̻�, ~ ���ϸ� �ǹ��� (�ʰ�, �̸� X)
 -- 4. ù��° ������ �ι�° ���� ���ų� Ŀ�߾�
 SELECT * 
  FROM ����
 WHERE ���� BETWEEN 20 AND 18 ; -- ��¾ȵ�
 
 -- LIKE
 SELECT * FROM ���� WHERE �̸� LIKE '��%' ;
 
 SELECT * FROM ���� WHERE �̸� LIKE '%��%' ;
 
 SELECT * FROM ���� WHERE �н����� LIKE '%123' ;
 
 -- %�� 0�� �̻� ���� ��Ī, _�� 1�� ���� ��Ī
 
 SELECT * FROM ���� WHERE �̸� LIKE '__��' ;
 
 SELECT * FROM �μ� WHERE �μ��� LIKE '__��' ;
 
 -- WHERE�� ����ȯ �Լ� ����ϱ�
 
SELECT * FROM ���� WHERE TO_CHAR(�Ի��Ͻ�, 'YYYY') = '2015' ;

SELECT * FROM ���� 
 WHERE �Ի��Ͻ� > TO_DATE('20150101')
   AND �Ի��Ͻ� < TO_DATE('20160101');
   
-- ����
   
SELECT ����ID
     , �̸�
     , ����
  FROM ���� 
 WHERE �̸� LIKE '%ö%' ;
 
SELECT *
  FROM ����
 WHERE TO_CHAR(�Ի��Ͻ�, 'YYYY') = '2015' 
    OR �Ի��Ͻ� IS NULL ; 
 
SELECT *
  FROM ���� 
 WHERE TO_CHAR(�Ի��Ͻ�, 'YYYY') >= '2017' ;
 
SELECT *
  FROM ����
 WHERE �Ի��Ͻ� BETWEEN TO_DATE('20170101', 'YYYYMMDD HH24MISS') AND SYSDATE ;
 
SELECT * 
  FROM ����
 WHERE �Ի��Ͻ� >= TO_DATE('20170101', 'YYYYMMDD HH24MISS') ; 

SELECT ����ID
     , ����
     , �Ի��Ͻ�
  FROM ����
 WHERE ���� BETWEEN 7000 AND 9000 ;
 
SELECT *
  FROM �����ּ�
 WHERE �ּ� LIKE '����%' ; 
  
-- FROM

SELECT SERVICE.����.����ID
  FROM SERVICE.����
 WHERE SERVICE.����.����ID = 'A0005' ;
 
SELECT ����ID
  FROM ����
 WHERE ����ID = 'A0005' ;
 
SELECT *
  FROM ����, ��������ó ;
  
SELECT ����.����ID
     , A.�̸�
     , A.����
     , A.����
     , B.����ID
     , B.����ó
  FROM ���� A, ��������ó B -- FROM���� ��Ī�� �� ���� AS�� ������� ����. 
 WHERE A.����ID = ��������ó.����ID ;
 
SELECT A.����ID
     , A.�̸�
     , A.����
     , B.����ó
  FROM ���� A
     , ��������ó B
 WHERE A.����ID = B.����ID
   AND A.����ID = 'A0006'
   AND B.�����ڵ� = '�޴���' ;