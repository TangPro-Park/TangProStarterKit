# Docker Stack Presets

이 디렉토리는 부트스트랩 시 즉시 적용 가능한 Docker 환경 프리셋들을 담고 있습니다.

## 프리셋 선택 매트릭스

| 프리셋 이름 | 용도 | 베이스 이미지 | DB / 보조 |
|---|---|---|---|
| (미지정) | 문서/로컬 스크립트 위주 | 없음 | 없음 |
| `python-ai-stack` | AI 에이전트, RAG 파이프라인 | Python 3.11 + ffmpeg | Neo4j (옵션) |
| `python-fastapi-pg` | 일반 백엔드 API (예정) | Python 3.11 | Postgres 16 + Redis 7 |
| `python-minimal` | 가벼운 파이썬 스크립트 (예정) | Python 3.11 slim | 없음 |
| `node-fastify-pg` | Node.js 기반 API (예정) | Node 20 | Postgres 16 |

## 적용 방법

**A. 부트스트랩 시 자동 적용 (권장)**
```bash
./bootstrap.sh "프로젝트명" "도메인" "미션" --stack python-ai-stack
```

**B. 수동 적용 (이미 부트스트랩 된 경우)**
```bash
cp -r tier2/docker_stacks/python-ai-stack/. .
```
