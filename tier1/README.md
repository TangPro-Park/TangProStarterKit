# <프로젝트명>

> **<한 줄 미션>**

도메인: <도메인>
시작일: <시작일>

---

## 빠른 시작

```bash
# (clone)
git clone <repo-url> <프로젝트명>
cd <프로젝트명>

# (setup — 본인 환경에 맞게 수정)
# 예: python -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt

# (run)
# 예: python -m <프로젝트명>
```

## 문서 지도

| 문서 | 역할 |
|---|---|
| [`PROJECT_DIRECTIVE.md`](PROJECT_DIRECTIVE.md) | 프로젝트 헌법 — 비전·절대 원칙·금기 |
| [`CLAUDE.md`](CLAUDE.md) | AI 협업 운영 지시서 |
| [`docs/specs/`](docs/specs/) | 모듈·기능별 SPEC |
| [`docs/devlog/`](docs/devlog/) | 일자별 결정 일기 |

## 기여 / 협업

본 프로젝트는 **탱프로 개발방법론** 을 따릅니다. 자세한 내용은 [`docs/methodology/`](docs/methodology/) (Tier 3 진입 후 추가).

핵심 룰:
- 30분+ 작업이면 SPEC 먼저 작성
- 작업한 날엔 devlog 1줄이라도
- 실패가 일반화 가능하면 즉시 룰북·메모리에 등록
