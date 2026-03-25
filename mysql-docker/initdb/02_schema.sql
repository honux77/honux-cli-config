USE tigerdb;

-- 부서 테이블
CREATE TABLE dept (
    deptno  INT          NOT NULL PRIMARY KEY,
    dname   VARCHAR(14),
    loc     VARCHAR(13)
);

-- 사원 테이블
CREATE TABLE emp (
    empno    INT          NOT NULL PRIMARY KEY,
    ename    VARCHAR(10),
    job      VARCHAR(9),
    mgr      INT,
    hiredate DATE,
    sal      DECIMAL(7,2),
    comm     DECIMAL(7,2),
    deptno   INT,
    FOREIGN KEY (deptno) REFERENCES dept(deptno)
);

-- 샘플 데이터
INSERT INTO dept VALUES
    (10, 'ACCOUNTING', 'NEW YORK'),
    (20, 'RESEARCH',   'DALLAS'),
    (30, 'SALES',      'CHICAGO'),
    (40, 'OPERATIONS', 'BOSTON');

INSERT INTO emp VALUES
    (7369, 'SMITH',  'CLERK',     7902, '1980-12-17',  800.00, NULL, 20),
    (7499, 'ALLEN',  'SALESMAN',  7698, '1981-02-20', 1600.00,  300.00, 30),
    (7521, 'WARD',   'SALESMAN',  7698, '1981-02-22', 1250.00,  500.00, 30),
    (7566, 'JONES',  'MANAGER',   7839, '1981-04-02', 2975.00, NULL, 20),
    (7654, 'MARTIN', 'SALESMAN',  7698, '1981-09-28', 1250.00, 1400.00, 30),
    (7698, 'BLAKE',  'MANAGER',   7839, '1981-05-01', 2850.00, NULL, 30),
    (7782, 'CLARK',  'MANAGER',   7839, '1981-06-09', 2450.00, NULL, 10),
    (7839, 'KING',   'PRESIDENT', NULL, '1981-11-17', 5000.00, NULL, 10),
    (7844, 'TURNER', 'SALESMAN',  7698, '1981-09-08', 1500.00,    0.00, 30),
    (7900, 'JAMES',  'CLERK',     7698, '1981-12-03',  950.00, NULL, 30),
    (7902, 'FORD',   'ANALYST',   7566, '1981-12-03', 3000.00, NULL, 20),
    (7934, 'MILLER', 'CLERK',     7782, '1982-01-23', 1300.00, NULL, 10);
