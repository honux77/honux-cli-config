# MySQL 8.4 Docker 개발환경

## 설정 정보

| 항목 | 값 |
|------|-----|
| MySQL 버전 | 8.4 |
| root 비밀번호 | db1004 |
| 사용자 | scott / tiger |
| 데이터베이스 | tigerdb |
| 포트 | 3306 |

---

## 시작 / 종료

```bash
# 시작 (백그라운드)
docker compose up -d

# 로그 확인
docker compose logs -f

# 종료 (데이터 보존)
docker compose down

# 완전 초기화 (데이터 삭제 후 재시작)
docker compose down -v && docker compose up -d
```

> **주의:** `down -v` 는 볼륨을 삭제합니다. 기존 데이터가 모두 사라집니다.

---

## 접속

### 터미널에서 직접 접속

```bash
# root 접속
docker exec -it mysql84 mysql -u root -pdb1004

# scott 접속
docker exec -it mysql84 mysql -u scott -ptiger tigerdb
```

### 외부 클라이언트 (DBeaver, TablePlus 등)

| 항목 | 값 |
|------|-----|
| Host | 127.0.0.1 |
| Port | 3306 |
| User | scott |
| Password | tiger |
| Database | tigerdb |

---

## 샘플 테이블

초기화 시 `tigerdb`에 두 개의 테이블과 샘플 데이터가 생성됩니다.

```sql
-- 부서 목록 조회
SELECT * FROM dept;

-- 사원 목록 조회
SELECT * FROM emp;

-- 부서별 평균 급여
SELECT d.dname, AVG(e.sal) AS avg_sal
FROM emp e JOIN dept d ON e.deptno = d.deptno
GROUP BY d.dname;
```

---

## 초기화 SQL 추가

`initdb/` 폴더에 `.sql` 파일을 추가하면 컨테이너 **최초 실행 시** 파일명 순서대로 자동 실행됩니다.

```
initdb/
├── 01_grant.sql    # scott 권한 부여
├── 02_schema.sql   # 테이블 및 샘플 데이터
└── 03_mydata.sql   # 추가할 SQL 파일
```

> **주의:** 볼륨이 이미 존재하면 initdb는 실행되지 않습니다. 재실행하려면 `down -v` 후 다시 시작하세요.
