SELECT TO_NUMBER('1') FROM DUAL ; -- ������('1')�� ������(1) �� ����ȯ�� ���

SELECT TO_CHAR(1) FROM DUAL ; --������(1)�� ������('1') �� ����ȯ�� ���

SELECT TO_CHAR(SYSDATE , 'YYYYMMDD') FROM DUAL ; 

SELECT TO_DATE('20230101' , 'YYYY/MM/DD') FROM DUAL ; 

SELECT TO_DATE('20230101141212' , 'YYYY/MM/DD HH24:MI:SS') FROM DUAL; 
/*
3�� ������ ��¥��(SYSDATE) �� ���������� �����մϴ�. (�����ǹ̴� �� �ܿ�ô�!)
4�� ������ ������('2023010114')�� ��¥�� (2023/01/01 14:00:00) ���� �����մϴ�.
5�� ������ ������('20230101141212')�� ��¥��(2023/01/01 14:12:12) ���� �����մϴ�. 
*/

SELECT ����ID
     , �Ի��Ͻ�
     , TO_CHAR(�Ի��Ͻ�, 'YYYY') AS �Ի翬��
  FROM ���� ; 
  
-- ���� �� �� ' ' �ȿ� �ۼ� ����

SELECT �̸� + 1000 FROM ���� ; -- �����߻�

SELECT LOWER('ABCDE123@@') AS LOWER���
 FROM DUAL ;
