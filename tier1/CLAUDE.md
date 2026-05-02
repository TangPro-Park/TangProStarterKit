# CLAUDE.md — <프로젝트명> AI 협업 지시서

> 이 문서는 **Claude Code 등 AI 에이전트 전용 운영 지시서**다.
> 프로젝트 비전·아키텍처는 [`PROJECT_DIRECTIVE.md`](PROJECT_DIRECTIVE.md) 헌법 참조.
> 본 문서는 **코드를 쓰는 순간 즉시 필요한 규칙**만.

---

## 1. 현재 단계 (반드시 먼저 읽을 것)

**프로젝트는 <단계 — 예: PoC> 단계입니다.** 엔터프라이즈 인프라(서킷브레이커·Eval 파이프라인 등)는 Phase 3+ 에 도입 예정이며 **현재는 적용하지 않습니다.**

🧭 **맥락 빠른 파악**: [`docs/context/AGENT_CONTEXT_GUIDE.md`](docs/context/AGENT_CONTEXT_GUIDE.md) — Tier 2 도입 후 매 세션 진입 시 이 파일부터.

진행 상황 단일 출처: [`docs/specs/SPEC_000_<프로젝트명>_main.md`](docs/specs/) (SPEC_000 작성 후).

---

## 2. 개발 워크플로우 (필수)

기능 요청이 들어오면 **구현 전** 아래 순서.

```
① 요청 접수
② docs/specs/_TEMPLATE.md 복사 → docs/specs/SPEC_NNN_<주제>.md (Status: Draft)
③ Context Anchor + Risks + Impact Analysis 채우기 (구현 전 사고 강제)
④ 사용자 컨펌 대기 — 컨펌 없이 구현 금지
⑤ 컨펌 후 구현 (Status: In Progress)
⑥ Test Plan + Success Criteria 모두 통과 → Status: Done + 커밋
```

**"완료(Done)" 의 정의**: 머지된 상태가 아니라 **Test Plan + Success Criteria 가 모두 통과한 상태**.

---

## 3. 디렉토리 지도

```
프로젝트루트/
├── PROJECT_DIRECTIVE.md       # 헌법
├── CLAUDE.md                  # 본 문서
├── README.md                  # 외부 독자용 진입점
├── docs/
│   ├── specs/                 # SPEC 본체
│   ├── devlog/                # 일자별 결정 일기
│   └── (Tier 2: ROADMAP / CHANGELOG / context / runbook / conventions)
└── (소스 디렉토리 — 본인이 작성)
```

**규칙**: 모듈 간 직접 의존 금지 — 공유 인터페이스 경유. 페이로드는 타입 정의된 모델로.

---

## 4. 코딩 기본기

- (언어·런타임 명시 — 예: Python 3.11+ / Node 20+)
- 타입 힌트 / 정적 타입 필수
- 주석·docstring·커밋 메시지는 **<언어 — 예: 한국어>**
- 설정값은 `.env` / 설정 모듈. 하드코딩 금지
- 프롬프트는 코드 인라인 금지 → `.md` 파일로 (AI 프로젝트 한정)

---

## 5. 파괴적 명령 차단 (예외 없음)

**어떤 이유로도 자동 실행 금지.** 필요하면 사용자에게 보고하고 승인 대기.

| 분류 | 금지 |
|---|---|
| 파일 파괴 | `rm -rf`, `Remove-Item -Recurse -Force` |
| Git 파괴 | `git reset --hard`, `git push --force`, `git clean -fdx` |
| 권한 우회 | `--dangerously-skip-permissions` |
| 큐·배치 | 동시 큐 가동 / 자동 재시작 / 사용자 명시 범위 외 작업 추가 |

파일 삭제·패키지 설치·git 조작·외부 API 호출은 실행 전 보고. `.env` 키 값은 로그·프롬프트·출력에 노출 금지.

---

## 6. 큐·배치 운영 5계명 (반복 작업 안전 룰)

> 한 번에 둘 이상의 큐를 절대 돌리지 않는다.

1. **단일 큐 원칙** — 동시 큐 X
2. **명시 승인 원칙** — 큐 시작은 사용자 명시 승인 후
3. **명시 범위 한정** — 사용자가 지시한 범위 외 작업을 임의 추가 X
4. **자동 재시작 금지** — fail 시 재시작 정책은 사용자가 정한다
5. **idempotent 우선** — 모든 단계 산출물 존재 시 자동 스킵

---

## 7. 커밋 메시지

```
[모듈/계층] 작업 유형: 간결한 설명
```

예시:
```
[core] feat: 인증 미들웨어 추가
[docs] update: SPEC_003 Phase 상태 갱신
```

---

## 8. 실행 환경 — <환경 명시>

(예: Docker 단일 환경, WSL Ubuntu, venv 등 본인 프로젝트에 맞게)

```bash
# 컨테이너 / venv 활성화 명령
# 자주 쓰는 실행 명령 5~10개
```

---

## 9. 참조 문서

- [`PROJECT_DIRECTIVE.md`](PROJECT_DIRECTIVE.md) — 헌법
- [`docs/specs/_TEMPLATE.md`](docs/specs/_TEMPLATE.md) — SPEC 템플릿
- [`docs/devlog/_TEMPLATE.md`](docs/devlog/_TEMPLATE.md) — devlog 템플릿
- (Tier 2 이상) `docs/runbook/` — 운영 절차서

---

## 10. Phase 3+ 에서 부활할 유예 규칙 (현재 미적용)

- (예: 외부 API 중앙 통제 / Eval 파이프라인 / 동시성 강제 / 분산 트레이싱)
- 필요해지면 PROJECT_DIRECTIVE 의 해당 섹션 참고해 본 문서로 승격.

---

> "Right-sized rules for the right phase."
