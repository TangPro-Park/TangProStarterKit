# Python AI Stack 프리셋

이 스택은 **AI 에이전트, RAG(지식 검색) 파이프라인, 비디오 데이터 처리** 등을 위한 환경입니다. 
Project Oracle 에서 검증된 패턴을 기반으로 만들어졌습니다.

## 1. 언제 사용하나요?
- `ffmpeg`, `yt-dlp` 등 멀티미디어 처리가 필요한 파이썬 봇/에이전트
- `neo4j` 지식 그래프를 활용하는 RAG 시스템
- `claude CLI` 와 연동되는 무거운 백엔드

## 2. 시작 명령

```bash
# (1) 환경변수
cp .env.example .env
# .env 안의 키값 채우기

# (2) 빌드 + 가동
docker compose up --build -d

# (3) 기동 확인
docker compose ps      
docker compose logs -f <SERVICE_NAME>    # 헬스체크 통과 대기
```

## 3. 일상 운영 (가장 자주 쓰는 명령)

```bash
# 상태 & 로그
docker compose ps
docker compose logs -f <SERVICE_NAME>

# 재시작 (코드 변경은 .:/app 마운트 덕에 재시작 불필요!)
docker compose restart <SERVICE_NAME>               # 환경변수 변경 시
docker compose down && docker compose up -d     # 컴포즈 자체 재구성

# Python 스크립트 실행 (모든 실행은 이 형식)
docker exec <CONTAINER_NAME> python scripts/my_script.py
```

## 4. 흔한 함정 (반드시 읽을 것)

1. **Permission denied (호스트에서 삭제 불가)**
   컨테이너가 root(uid 0)로 동작하므로 컨테이너가 만든 파일은 호스트에서 일반 권한으로 지울 수 없습니다.
   *해결:* `docker exec <CONTAINER_NAME> bash -c 'chown -R 1000:1000 /app/data'`

2. **UNC 경로 에러 (Windows Bash)**
   Windows 환경의 Bash tool 은 `\\wsl.localhost\ubuntu\...` 같은 UNC 경로를 사용합니다.
   명령어가 깨질 수 있으므로 `docker exec` 등은 반드시 `bash -c '...'` 로 감싸 내부 경로를 기준으로 하세요.

3. **Rebuild 시점**
   * 코드(`*.py`, `*.md`) 변경 시: 마운트로 즉시 반영되므로 `--build` 불필요.
   * `requirements.txt`, `Dockerfile` 변경 시: `--build` 필요.

## 5. 컨벤션 안내 (중요)

이 프리셋은 다음 두 가지를 가정하고 작성되었습니다:
- 앱의 메인 진입점이 `app/main.py`에 존재함 (Dockerfile의 `CMD` 참고)
- `/health` 엔드포인트가 존재함 (docker-compose의 `healthcheck` 참고)

만약 본인 프로젝트의 구조와 다르다면 `Dockerfile`의 CMD와 `docker-compose.yml`의 healthcheck를 반드시 수정하세요.

## 6. <플레이스홀더> 설정 안내

사용자 프로젝트마다 `docker-compose.yml` 에서 다음 항목을 직접 채워야 합니다:
- `<SERVICE_NAME>`: 서비스명 (예: `ai-api`)
- `<CONTAINER_NAME>`: 컨테이너명 (예: `my_project_api`)
- `<DB_CONTAINER_NAME>`: DB 컨테이너명 (예: `my_project_neo4j`)
- 볼륨 마운트 주석 해제 시 `<사용자>`, `<계정명>`, `<옵시디언경로>` 를 본인 PC 환경에 맞게 입력.
