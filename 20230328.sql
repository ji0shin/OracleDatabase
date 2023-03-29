-- ROWNUM
SELECT *
  FROM (
        SELECT ROWNUM AS RN  -- ROWNUM�� �̹� ǥ�� �ִ� ���� ��ó��(�ζ��κ�)
            , ����ID
            , �̸�
            , ����
            , �μ�ID
         FROM ����
    )
 WHERE RN = 2;  -- ROWNUM = 2�� ��� �̱�
 
-- TOP-N
SELECT *
  FROM (
        SELECT *
          FROM ����
         WHERE ���� IS NOT NULL
         ORDER BY ���� DESC  -- ������ �̸��� ���̺�� ����
         )
 WHERE ROWNUM <= 5 ; -- �ۿ��� ROWNUM ���
 
-- TOP-N �ǽ�
--1. ���� �߿� ������ ���� ���� 3���� ��� ���� ���
SELECT *
  FROM (
        SELECT *
          FROM ����
         WHERE ���� IS NOT NULL 
         ORDER BY ����
         )
 WHERE ROWNUM <= 3 ;

--2. ���� �߿� ���� �ֱٿ� �Ի��� 3���� ��� ���� ��� (�Ի��Ͻ� NULL ����)
SELECT *
  FROM (
        SELECT *
          FROM ���� 
         WHERE �Ի��Ͻ� IS NOT NULL
         ORDER BY �Ի��Ͻ� DESC
         )
 WHERE ROWNUM <= 3 ;
 
CREATE TABLE �Խ��� ( 
�Խ��ǹ�ȣ NUMBER(9) PRIMARY KEY , 
�ۼ��� VARCHAR2(50) NOT NULL , 
�Խù����� VARCHAR2(4000) NOT NULL , 
�ۼ��Ͻ� DATE NOT NULL 
) ;
INSERT INTO �Խ���
SELECT LEVEL -- �Խ��ǹ�ȣ
, '���̵�' || MOD(LEVEL , 10000) -- �ۼ���
, '���̵�' || 
MOD(LEVEL , 10000) || 
'���� �ۼ��Ͻ� �Խù��Դϴ�. �� �Խù��� �Խ��� ��ȣ�� ' 
|| LEVEL 
|| '�Դϴ�' -- �Խù�����
, TO_DATE('20000101') + LEVEL --2022�� 1��1�Ϻ��� �Ϸ羿 �Խù��� �ԷµǴ� ��
FROM DUAL
CONNECT BY LEVEL <=1000000; --100������ ������ �Է�
COMMIT;

SELECT * FROM �Խ��� ;
  -- �� ���� 100������ �����͸� �������� ����
  -- ó���� 50���� �����ְ�, �巡�׸� �ϸ� 50���� �߰��� ������

-- ���� �ֱٿ� �Խõ� �Խù� 20���� �̾� ��� �÷� ���� ���
SELECT *
  FROM (
        SELECT *
          FROM �Խ���
         ORDER BY �ۼ��Ͻ� DESC
         )
 WHERE ROWNUM <= 20 ;
 
-- ���� 40������ �̴´�. 
-- �� �߿��� 21��°���� �̴´�. 
SELECT *
  FROM (
        SELECT ROWNUM AS RN, A.*
          FROM (
                SELECT *
                  FROM �Խ���
                 ORDER BY �ۼ��Ͻ� DESC
                 ) A
         WHERE ROWNUM <= 40
         )
 WHERE RN >= 21 ;
 
-- ����¡ ��� ����
SELECT *
  FROM (
        SELECT ROWNUM AS RN, A.*
          FROM (
                SELECT *
                  FROM �Խ���
                 ORDER BY �ۼ��Ͻ� DESC
                 ) A
         WHERE ROWNUM <= 20 * N  -- N�� ������ ������, 20�� �� �������� ������ �Խñ� ��
         )
 WHERE RN >= 20*(N -1) + 1 ;
 
-- �Խ��� ���̺��� ���� �ֱٿ� �ۼ��� �Խù��� �������� 31~60��° �����͸� ���̵��� ������ �ۼ�
SELECT *
  FROM (
        SELECT ROWNUM AS RN
             , A.*
          FROM (
                SELECT * 
                  FROM �Խ���
                 ORDER BY �ۼ��Ͻ� DESC
                 ) A
         WHERE ROWNUM <= 60
         )
 WHERE RN >= 31 ;
 
--AS ���� ���� -> �÷��� ���̺���� ��ҹ��� ���� X
SELECT ����ID AS hello
  FROM ���� ;
  
-- "" �ȿ� ���ڿ��� ������ �״�� ����
SELECT ����ID AS "hello"
     , ���� AS " 1 2 3 4 "
 FROM ���� ;
 
ALTER TABLE ���� MODIFY (�μ�ID NULL) ;
UPDATE ���� SET �μ�ID = NULL WHERE ����ID = 'A0005' ;
COMMIT;

SELECT A.����ID
     , A.����
     , A.�μ�ID
     , (
        SELECT �μ���, �μ�ID
          FROM �μ�
         WHERE �μ�ID = B.�μ�ID ) AS �μ��� -- A.�μ�ID�� NULL�̸� �� �Ұ��� ->  �̶��� NULL�� ���
  FROM ���� A
 WHERE ����ID BETWEEN 'A0001' AND 'A0006' ; -- ����ID ���̺��� WHERE�ش��ϴ� ������ �� ��ŭ SELECT ����
 
-- �������� ��� ��������
SELECT A.����ID
     , A.����
     , A.�μ�ID
     , B.�μ���
  FROM ���� A
     , �μ� B
 WHERE A.�μ�ID = B.�μ�ID (+)  -- �������� ���� ���� ���̺��� WHERE���� �ش��ϴ� ������ ��� ���������Ƿ� 
                               -- �ƿ��� �������� ���� ���̺��� �������� ��� Ʃ�� ��� 
   AND A.����ID BETWEEN 'A0001' AND 'A0006' ;

SELECT A.����ID
     , A.����
     , A.�μ�ID
     , B.�μ���
  FROM ���� A LEFT OUTER JOIN �μ� B
    ON (A.�μ�ID = B.�μ�ID)
 WHERE A.����ID BETWEEN 'A0001' AND 'A0006' ;
 
-- ��Į�� �������� ���� 
--1. ���� ���̺��� ���� A0001���� A0006������ ����ID, ����, �μ�ID�� ����ϰ�
-- �μ�ID�� ���� �μ��� �Բ� ��� 
SELECT ����ID
     , ����
     , �μ�ID
     , (
         SELECT �μ���
           FROM �μ�
          WHERE �μ�ID = ����.�μ�ID
          ) AS �μ���
  FROM ����
 WHERE ����ID BETWEEN 'A0001' AND 'A0006' ;
 
-- ���ι��
SELECT A.����ID
     , A.����
     , A.�μ�ID
     , B.�μ���
  FROM ���� A
     , �μ� B
 WHERE A.�μ�ID = B.�μ�ID (+)
   AND A.����ID BETWEEN 'A0001' AND 'A0006' ;
 
--2. ���� ���̺��� ���� A0006���� A0010������ ����ID, �̸�, �ֹε�Ϲ�ȣ�� ���
-- �޴�����ȣ�� �Բ� ���
SELECT ����ID
     , �̸�
     , �ֹε�Ϲ�ȣ
     , (
         SELECT ����ó
           FROM ��������ó
          WHERE �����ڵ� = '�޴���'
            AND ����ID = ����.����ID
        ) AS �޴�����ȣ
  FROM ����
 WHERE ����ID BETWEEN 'A0006' AND 'A0010' ;
 
-- ���ι��
SELECT A.����ID 
     , A.�̸�
     , A.�ֹε�Ϲ�ȣ
     , B.����ó
  FROM ���� A
     , ��������ó B
 WHERE A.����ID = B.����ID (+)
   AND A.����ID BETWEEN 'A0006' AND 'A0010'
   AND B.�����ڵ� (+) = '�޴���'; 


--3. 2�� ������ ������ �״�� ����ϵ� ��Į�󼭺������� �ѹ� �� ����Ͽ� 
-- A0006~A0010 ������ ������ ���� ���ּҵ� �Բ� ���
SELECT ����ID
     , �̸�
     , �ֹε�Ϲ�ȣ
     , (
         SELECT ����ó
           FROM ��������ó
          WHERE �����ڵ� = '�޴���'
            AND ����ID = ����.����ID
        ) AS �޴�����ȣ
     , (
         SELECT �ּ�
           FROM �����ּ�
          WHERE ����ID = ����.����ID
            AND �����ڵ� = '��'
        ) AS ���ּ�
  FROM ����
 WHERE ����ID BETWEEN 'A0006' AND 'A0010' ;
 
 -- ���� 
SELECT A.����ID
     , A.�̸�
     , A.�ֹε�Ϲ�ȣ 
     , B.����ó AS �޴�����ȣ
     , C.�ּ� AS ���ּ�
  FROM ���� A
     , ��������ó B
     , �����ּ� C
 WHERE A.����ID = B.����ID (+)
   AND A.����ID = C.����ID (+)
   AND A.����ID BETWEEN 'A0006' AND 'A0010'
   AND B.�����ڵ� (+) = '�޴���' -- �����ڵ� NULLL�̸� = �� �Ұ� -> ��¾ȵ�
   AND C.�����ڵ� (+) = '��'; 
   
-- �ζ��κ�
SELECT A.����ID
     , A.�̸�
     , A.����
     , B.�μ����ְ���
  FROM ���� A
     , (
         SELECT �μ�ID, MAX(����) AS �μ����ְ���
           FROM ����
          WHERE �μ�ID IS NOT NULL
          GROUP BY �μ�ID
        ) B
 WHERE A.�μ�ID = B.�μ�ID
   AND A.���� = B.�μ����ְ��� ;
   
-- �ζ��κ� ����
--1. �μ����� ���� ���� ������ ���� �������� ��� ���� ��� (�μ�ID�� NULL�� ���� ����)
SELECT A.����ID
     , A.�̸�
     , A.����
     , B.�μ�����������
  FROM ���� A
     , (
        SELECT MIN(����) AS �μ�����������
          FROM ����
         GROUP BY �μ�ID 
         ) B
 WHERE A.���� = B.�μ�����������
   AND A.�μ�ID IS NOT NULL ;

SELECT A.����ID
     , A.�̸�
     , A.����
     , B.�μ�����������
  FROM ���� A
     ,  (
        SELECT �μ�ID
             , MIN(����) AS �μ�����������
          FROM ����
         WHERE �μ�ID IS NOT NULL
         GROUP BY �μ�ID
        ) B
 WHERE A.���� = B.�μ�����������
;

--2. ���̰� � ���� 3���� ��� ������ ���
SELECT *
  FROM (
        SELECT * 
          FROM ����
         WHERE ���� IS NOT NULL
         ORDER BY ����
         )
 WHERE ROWNUM <= 3 ;
 
-- ��ø ��������
SELECT *
  FROM ����
 WHERE ���� >= ( SELECT AVG(����)
                  FROM ����
                ) ; -- ��ü ������ ��� �������� ũ�ų� ���� ������ ��� ���� ���