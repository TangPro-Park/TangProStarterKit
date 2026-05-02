# Docker 셋업·운영 가이드라인 (템플릿)

> 본 파일은 **스타터 키트 템플릿**. 신규 프로젝트가 Docker 단일/다중 컨테이너 환경을 쓸 때 복사·수정해 사용.
> 채워야 할 곳에 `<...>` 플레이스홀더 표시.

---

## 0. 🚨 영구 사실 (검색 금지, 외워라)

```
컨테이너 = N개 (<주컨테이너명> / <보조컨테이너명> ...)
주 컨테이너 = <주컨테이너명>  (<역할 — 예: FastAPI + Python 3.11 + 의존 도구>)
네트워크 = <bridge / host / custom>
PYTHONPATH 또는 NODE_PATH = <컨테이너 안 경로>
시크릿 환경변수 = <.env 파일에서 로드>
컨테이너 cwd = <예: /app>
```

호스트 ↔ 컨테이너 핵심 마운트:

| 호스트 경로 | 컨테이너 경로 | 의미 |
|---|---|---|
| `.` | `/app` | 라이브 코드 (rebuild 없이 즉시 반영) |
| `<DB 데이터 경로>` | `<컨테이너 DB 경로>` | DB 영구 저장 |
| `<공유 디렉토리>` | `<컨테이너 매핑>` | (예: 외부 도구·Vault·자료 공유) |

**중요**: 컨테이너 내부에서 만든 파일은 호스트에서 root 소유로 보일 수 있음 (uid 매핑 없을 시). §5 권한 함정 참조.

---

## 1. 최초 셋업 (Day 0)

```bash
# (1) 환경변수
cp .env.example .env
# .env 안에 시크릿 채움 (절대 git 에 커밋 X — .gitignore 확인)

# (2) 빌드 + 가동
docker compose up --build -d

# (3) 기동 확인
docker compose ps      # 모든 서비스 Up (healthy) 여야 정상
docker compose logs -f <주서비스명>

# (4) 초기 권한 정리 (한 번만 — 나중 사고 방지)
docker exec <주컨테이너명> bash -c 'chown -R 1000:1000 /app/data <기타>'
```

---

## 2. 일상 운영 (가장 자주 쓰는 명령)

```bash
# 상태
docker ps
docker compose ps

# 로그
docker compose logs -f <서비스>
docker compose logs --tail=50 <서비스>

# 재시작 (코드만 변경했으면 .:/app 마운트 덕에 재시작 불필요)
docker compose restart <서비스>           # 환경변수 변경 시
docker compose down && docker compose up -d  # 컴포즈 재구성

# 인터랙티브
docker exec -it <주컨테이너명> bash
docker exec -it <주컨테이너명> <쉘 또는 REPL>

# 스크립트 실행
docker exec <주컨테이너명> <명령>
docker exec -w /app <주컨테이너명> <명령>
```

**규칙**: 코드만 수정 → 마운트로 즉시 반영, 재시작 불필요.
`requirements.txt` / `package.json` / `Dockerfile` 변경 → rebuild (`docker compose up --build -d`).

---

## 3. Volume 마운트 의미

### 3.1 라이브 코드 (`.:/app` 또는 유사)
- 호스트 코드 수정 → 컨테이너 안 즉시 반영
- 결과 파일이 컨테이너 안에서 만들어지면 호스트 측 owner 가 root 일 수 있음 → §5

### 3.2 데이터 영속 볼륨
- DB·캐시 등 재기동 후에도 보존돼야 하는 것
- 깡그리 초기화 필요 시 호스트에서 디렉토리 삭제 (위험 — 사용자 확인 필수)

### 3.3 외부 도구·인증 마운트 (필요 시)
- 호스트의 CLI 바이너리·OAuth 토큰을 read-only 로 컨테이너에 부착
- (예: claude CLI, gcloud SDK, AWS credentials)
- read-only 권장 — 컨테이너가 호스트 인증 정보를 변경하지 못하게

---

## 4. Rebuild 시점

| 변경 | rebuild 필요? |
|---|---|
| 소스 코드 | ❌ (마운트로 즉시 반영) |
| 의존성 (`requirements.txt` / `package.json`) | ✅ |
| `Dockerfile` | ✅ |
| `docker-compose.yml` 의 environment·volumes | ❌ but `down && up -d` 필요 |
| `.env` | restart 만 (`docker compose restart <서비스>`) |

```bash
docker compose up --build -d
docker compose build --no-cache && docker compose up -d   # 캐시 무시
```

---

## 5. 권한 함정 (Permission denied)

### 증상
```bash
$ rm -f data/<파일>
rm: cannot remove '...': Permission denied
```
컨테이너가 root 로 동작 → 컨테이너가 만든 파일이 호스트에서 root 소유 → 일반 사용자가 못 지움.

### 응급처치
```bash
docker exec <주컨테이너명> bash -c 'chown -R 1000:1000 /app/data'
```

### 예방
- 새 디렉토리는 호스트(WSL/Linux)에서 mkdir → uid 1000 으로 생성
- 또는 컨테이너에서 만들고 즉시 chown
- 정기 점검: 주요 작업 후 ls -la 로 owner 확인

### Bash tool / Windows UNC 경로 함정 (Windows 사용 시)
```bash
# ❌ 깨짐 — UNC 경로 그대로 전달
docker exec <주컨테이너명> chown -R 1000:1000 /app/data

# ✅ 안전 — bash -c '...' 으로 감싸 컨테이너 내부 경로 사용
docker exec <주컨테이너명> bash -c 'chown -R 1000:1000 /app/data'
```

---

## 6. 장애 대응

### 6.1 `Input/output error` 또는 `docker not found`
**증상**: `docker ps` 자체가 안 됨.
**의미**: Docker Desktop · WSL VM · 데몬 자체 문제.

**복구**:
1. Docker Desktop Quit → 재실행 (가장 흔한 해결)
2. 안 되면 (Windows): `wsl --shutdown` 후 30초 대기 → WSL 재진입
3. 그래도 안 되면 Docker Desktop 재설치 검토

**자동 실행 금지** — 다른 WSL 작업 같이 종료됨. 사용자 확인 필수.

### 6.2 컨테이너 unhealthy
```bash
docker compose ps
docker compose logs --tail=100 <서비스>
# 흔한 원인: .env 누락 / 포트 충돌 / 의존 서비스(DB) 가 늦게 뜸
```

### 6.3 컨테이너 무한 재시작
```bash
docker compose logs --tail=200 <서비스> 2>&1 | grep -Ei "Error|Traceback|Exception"
```

### 6.4 디스크 가득
```bash
docker system df                # 사용량
docker system prune             # 미사용 정리 (안전)
docker system prune -a --volumes  # 볼륨까지 (위험 — 사용자 확인 필수)
```

---

## 7. 백업·정리

### 7.1 백업 대상 (재생성 불가 또는 비용↑)
- DB 영속 볼륨
- 외부 호출 결과 캐시 (LLM·API 비용 발생분)
- 사용자 업로드·매매 로그
- 영구 보존 원칙 데이터 (예: 다운로드한 영상)

### 7.2 정리 가능 (안전)
- 로그 파일 (오래된 것)
- 임시 작업물 (재생성 가능)
- Docker 미사용 이미지 (`docker image prune`)

### 7.3 정리 절대 금지 (사용자 명시 승인 없이)
- `.env` / 시크릿
- LLM·API 비용 발생분 결과물
- 사용자 데이터·매매 로그

---

## 8. 진단 체크리스트

0. **`docker not found` / `Input/output error`** → §6.1 (Docker Desktop 재시작)
1. `docker ps` — 컨테이너 살아있나?
2. `docker compose ps` — healthy 인가? (start_period 지났는데도 unhealthy 면 §6.2)
3. `docker compose logs --tail=50 <서비스>` — 직접 에러
4. `docker exec <컨테이너> env | grep <시크릿키>` — env 로딩됐나?
5. Permission denied? → §5
6. 디스크? → §6.4

---

## 9. 변경 이력

| 일자 | 변경 |
|---|---|
| YYYY-MM-DD | 초안. |
