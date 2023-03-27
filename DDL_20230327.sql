COMMENT ON TABLE QUIZ_TABLE IS '���� ������ �� ���̺�' ;
COMMENT ON COLUMN QUIZ_TABLE.Q_ID IS '����ID' ;

-- 1. DELETE 
DELETE FROM ����ǥ ; -- ������ ��� ���ư�
-- �ѹ��� ����

-- 2. TRUNCATE
TRUNCATE TABLE ����ǥ ; -- �ڿ� WHERE�� ���� ���� 
-- �ѹ��� �Ұ���

-- 3. DROP
DROP TABLE ����ǥ ; 
-- �ѹ��� �Ұ���

SELECT * FROM ����ǥ ;

ROLLBACK;

CREATE SEQUENCE ����ID_SEQ
       INCREMENT BY 1  -- ������ ��������
       START WITH 1    -- ������ ��������
       MINVALUE 1      -- �ּ� ����� ������ ���� 1 
       MAXVALUE 9999 ; -- �ִ� ����� ������ ���� 9999
       
SELECT ����ID_SEQ.NEXTVAL FROM DUAL ;

INSERT INTO ���� (
����ID
, ��й�ȣ
, �̸�
, ����
, ����
, �Ի��Ͻ�
, �ֹε�Ϲ�ȣ
, ����
, �μ�ID
) VALUES ( 
'A' || LPAD( ����ID_SEQ.NEXTVAL , 4 , '0' ) 
, '��й�ȣ123' 
, '������'
, '��'
, 30
, SYSDATE 
, '930711-2441223' 
, 5000 
, 'D006' 
);

SELECT LPAD( ����ID_SEQ.NEXTVAL, 4, '0') FROM DUAL;

DROP SEQUENCE ����ID_SEQ;

-- �並 �̿��Ͽ� ���� ����ϴ� ������ ���� ������ �� ����
CREATE VIEW �μ����ְ���_VIEW AS -- AS �ڿ� ���� ����ϴ� ���� �ۼ�
SELECT �μ�ID
     , MAX(����) AS �μ����ְ���
  FROM ����
 GROUP BY �μ�ID 
 ORDER BY �μ�ID ;
 
SELECT * FROM �μ����ְ���_VIEW ;

-- �������� : ���� �ȿ� ������ �ۼ��ϴ� ���
-- �������� ��� �� �ϳ��� �ζ��κ�
-- FROM ���� ������ �ۼ��� ������ ���̺�ó�� ����ϴ� ���
SELECT A.�̸�
     , A.����
     , B.�μ����ְ���
  FROM ���� A
     , (
     SELECT �μ�ID
          , MAX(����) AS �μ����ְ���
       FROM ����
      GROUP BY �μ�ID 
      ORDER BY �μ�ID
     ) B
 WHERE A.�μ�ID = B.�μ�ID
   AND A.���� = B.�μ����ְ��� ;
   
CREATE VIEW ����_�ΰ��������� AS
SELECT ����ID
     , �̸�
     , �μ�ID
 FROM ���� ;
 
SELECT * FROM ����_�ΰ��������� ;

-- ����ID�� A0005�� ����� ������ 1000���� �λ��Ѵ�.
UPDATE ����
   SET ���� = ���� + 1000
 WHERE ����ID = 'A0005' ;
 
SELECT ����ID, �̸�, ���� FROM ���� ;

COMMIT ;

UPDATE ���� 
   SET ���� = 9999
 WHERE ����ID = 'A0003' ; 
 
ROLLBACK;