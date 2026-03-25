-- scott 유저에게 tigerdb 전체 권한 부여
GRANT ALL PRIVILEGES ON tigerdb.* TO 'scott'@'%';
FLUSH PRIVILEGES;
