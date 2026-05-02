# 탱프로 개발방법론 — 프레임워크 정의서 (Tang-Pro Development Methodology)

> **버전**: v0.2 (2026-05-01)
> **저자**: delfaran
> **사례 베이스**: Project Oracle (다중 페르소나 자율 투자 분석 시스템 / 2025-12 ~ 진행 중)
> **상태**: Living Framework (살아있는 문서 — 매 프로젝트 라운드마다 갱신)

---

## 한 줄 정의

> **탱프로(Tang-Pro)는 AI 협업 시대의 1~3인 개발자가 컨텍스트·결정·시간을 잃지 않고 연속적으로 무거운 시스템을 짓기 위한 문서·메모리·자동화 통합 운영 방법론이다.**

각 문서가 자기 자리에서 자기 역할만 한다. 한 문서에 다 적지 않는다. 흔들릴 때 어디로 돌아갈지 명확하다. AI 메모리는 보조이고 본체는 git에 들어가는 마크다운이다. 운영의 *실패*는 룰북으로 굳어 다음 세션에 자동 적용된다.

---

# Part I — 동기와 사례

## 1. AI 협업 개발에서 반복되는 3가지 손실

### 1.1 세션 간 컨텍스트 손실
- 새 채팅을 열면 AI는 0에서 시작한다. 어디까지 했는지, 왜 그런 선택을 했는지 잊힌다.
- "직전 회차에 분명 결정했던 것"을 또 논쟁한다.

### 1.2 기획-구현 정합성 손실
- 기획서가 코드와 어긋난다. "원래 왜 이렇게 짰지?"를 모른다.
- 기획서가 *살아있는 문서*가 아니라 *제출용 문서*가 되면 죽는다.

### 1.3 결정 이력 손실
- "이거 안 하기로 했었나, 했었나?" — 폐기·우회·보류한 *흔적*이 사라지면 같은 선택지를 다시 검토하게 된다.
- 안 한 것의 *이유*가 한 것의 이유보다 자주 물어진다.

## 2. 1~3인 팀의 추가 함정

| 함정 | 증상 |
|---|---|
| 빅뱅 작업 | 한 SPEC을 5일 만에 끝내려다 3일째 막혀 폐기. 분리 가능한 세부 단위가 없음. |
| 머릿속 환상 | "다 머릿속에 있다" → 일주일 쉬면 사라진다. |
| 가드레일 약화 | 헌법인지 메모인지 헷갈리는 기획서 → 슬그머니 원칙이 깎인다. |
| 병행 누락 | AI가 작업할 수 있는데 사용자 의사결정 대기로 멈춘다. 반대도 마찬가지. |

## 3. 안전·규제 도메인의 추가 요구

의료·금융·법무·보안처럼 *결정의 이유*가 감사 대상인 도메인:
- 폐기된 옵션의 *흔적* 보존이 필수 ("왜 옵션 B 안 갔는가")
- 가드레일 약화는 추적 가능해야 함 (커밋 + 의사결정 로그 이중화)
- Red-team 시나리오는 회귀 테스트로 운영

## 4. 케이스 스터디: Project Oracle

본 방법론은 **Project Oracle**(다중 페르소나 자율 투자 분석 시스템) 5개월 운영에서 발견된 패턴·실패를 추출해 만들었다. 본 문서가 인용하는 모든 패턴은 Oracle 저장소에 *실제로 존재*한다.

| 지표 | 값 (2026-05-01 기준) |
|---|---|
| 누적 SPEC | 23개 (SPEC_000 ~ SPEC_024, 폐기·번호점프 포함) |
| 누적 devlog | 13편 |
| 운영 룰북 (`docs/runbook/`) | 9개 |
| 컨벤션 (`docs/conventions/`) | 1개 (확장 중) |
| AI auto-memory 엔트리 | 11개 (`MEMORY.md` 인덱스) |
| 자동화 스크립트 | `scripts/spec_progress.py` 등 다수 |
| Phase 진행 단계 | Phase 4 (PoC 실현 단계) |

### 4.1 Oracle에서 실제 발생한 실패 → 룰화 사례
1. **시골의사 병렬 큐 사고** (2026-04-XX) — 매억남 큐 돌리는 도중 임의로 시골의사 큐를 병렬 가동 → yt-dlp 트래픽 충돌·시스템 행. **룰화**: `feedback_batch_execution_approval.md` (5계명: 단일 큐, 사용자 승인, 명시 범위 외 작업 금지, 자동 재시작 금지) + `docs/runbook/execution_governance.md`.
2. **SPEC 번호 충돌** — `SPEC_013_essay_ingestion_pipeline.md` 와 `SPEC_013_project_elliott.md` 가 동일 번호로 공존. **룰화**: 한 번 부여된 SPEC 번호는 재사용 금지, 충돌 시 새 번호로 분기.
3. **DuckDB 컬럼 RENAME 의존성** — INDEX 의존 때문에 ALTER 실패 → 백업 후 재생성. **룰화**: `docs/devlog/2026-05-01_chart_data_lakehouse_and_personas.md` 의 "마이그레이션 정리" 섹션, 그리고 SPEC_024 의 Risks 섹션에 사전 기록.
4. **머신레벨 vs 색상레벨 봉 표현** — 사용자 피드백 "디스플레이와 색으로 구분하는건 아닌거같어 머신레벨로" → 표준화. **룰화**: `docs/conventions/candle_reading.md`.
5. **Split 환경 함정** — yt-dlp/ffmpeg 위치를 매 세션 검색하던 시간 낭비. **룰화**: `docs/runbook/split_env_and_paths.md` 의 "0. 검색 금지, 외워라" 섹션.

→ **모든 실패는 한 번만 한다. 두 번째부터는 룰이 막는다.**

---

# Part II — 7대 원리

## 원리 1. 헌법 우선 (Constitution First)
- 메인 기획서가 모든 분쟁의 1차 권위.
- SPEC과 메인이 충돌하면 SPEC을 고친다 (메인은 변경 이력으로만 갱신).
- 가드레일 약화는 *반드시* 메인 기획서 변경 + 버전 bump.

## 원리 2. 역할 분리 (Single Responsibility per Document)
- 6원소(Part III) 각자 자기 자리만 지킨다.
- 기획서에 일자별 진행을 적지 않는다. devlog에 헌법을 다시 쓰지 않는다.
- 정보 중복은 정합성 붕괴의 시작.

## 원리 3. 번호 불변 (Immutable Numbering)
- 한 번 부여된 SPEC 번호는 재사용 안 한다.
- 폐기되어도 번호와 파일은 남기고 `Status: Abandoned` 로 표시.
- Oracle 사례: SPEC_017·018·020 은 폐기·통합되었지만 번호는 비어 있다 (재할당 X).

## 원리 4. 흔적 우선 (Trace First)
- 폐기·우회·보류한 것을 *기록*한다.
- "왜 안 했는가"가 "왜 했는가"보다 자주 물어진다.
- BACKLOG의 ❌ 섹션, devlog의 "결정 보류" 섹션, SPEC의 `Status: Abandoned` 활용.

## 원리 5. 컨텍스트 닻 (Context Anchor)
- 모든 SPEC 상단에 5줄 표 강제: WHY / WHO / RISK / SUCCESS / SCOPE.
- 구현 도중 흔들리면 닻으로 돌아온다.
- (Oracle 표준 템플릿: `docs/specs/_TEMPLATE.md` 참조)

## 원리 6. 병행 가능성 우선 (Parallelism First)
- 사용자 작업·AI 작업이 병행 가능하도록 Phase를 쪼갠다.
- 다운로드·법무 검토·샘플 확보 같은 *대기 시간*에 *AI 작업*이 채워질 수 있어야.
- 의존 그래프를 명시한다.

## 원리 7. 실패 → 룰 즉시 변환 (Fail Fast, Codify Faster)
- 한 번 일어난 사고는 한 번만 일어나도록 즉시 룰북·메모리·CLAUDE.md 에 박는다.
- 룰의 본문은 사례·*Why*·*How to apply* 3종을 명시.
- (Oracle 사례: 시골의사 병렬 큐 사고 → 24시간 안에 거버넌스 룰북 + auto-memory 엔트리 생성.)

---

# Part III — 6원소 + 보조 4원소

## A. 핵심 6원소

| # | 원소 | 역할 | 비유 | 갱신 빈도 | Oracle 위치 |
|---|---|---|---|---|---|
| 1 | **메인 기획서** | 무엇을 만드는가 / 절대 원칙 | 헌법 | 분기 | `PROJECT_DIRECTIVE.md` |
| 2 | **SPEC (서브 기획서)** | 어떻게 만드는가 / 모듈·Phase 분해 | 법률 | SPEC당 수일~수주 | `docs/specs/SPEC_NNN_*.md` |
| 3 | **BACKLOG** | 다음에 무엇을 할 후보 | To-do 풀 | 수시 | `docs/specs/BACKLOG.md` |
| 4 | **ROADMAP** | 지금 어디인가 (한 화면 대시보드) | 거울 | 큰 진척마다 | `docs/ROADMAP.md` |
| 5 | **CHANGELOG** | 세션·Phase 단위로 무엇을 했나 | 족보 | 세션 마감마다 | `docs/CHANGELOG.md` (또는 git log) |
| 6 | **devlog** | 일자별 *왜* 그렇게 했나 | 일기 | 작업한 날마다 | `docs/devlog/YYYY-MM-DD_*.md` |

## B. 보조 4원소 (도메인·규모에 따라 도입)

| # | 원소 | 역할 | Oracle 위치 |
|---|---|---|---|
| 7 | **AI 컨텍스트 헌장** | AI 행동 강제 + 가드레일 자동 로드 | `CLAUDE.md` |
| 8 | **세션 시작 가이드** | 매 세션 진입 시 5분 컨텍스트 회복 경로 | `docs/context/AGENT_CONTEXT_GUIDE.md` |
| 9 | **운영 룰북** | 반복 운영·실패 대응 절차서 | `docs/runbook/*.md` |
| 10 | **컨벤션** | 코드·데이터·문서 표준 | `docs/conventions/*.md` |

→ 6원소가 헌법·법률·일기라면, 보조 4원소는 행정·시행규칙·교범에 가깝다.

## C. AI 메모리 (외부 보조 저장소)

- 본체가 아니라 *캐시*. git에 들어가지 않는다.
- 다음 세션이 docs를 다시 읽기 전에 핵심을 빠르게 회상하기 위해 존재.
- Oracle: `~/.claude/projects/.../memory/` 에 `MEMORY.md` 인덱스 + 개별 파일.
- 메모리에 적힌 사실도 의심하라 — 코드 변경으로 stale 가능. *현재 코드 상태가 진실*.

---

# Part IV — 표준 디렉토리 구조 (3 Tier)

## Tier 1 (Minimal — 1~2주차 신생 프로젝트)

```
프로젝트루트/
├── CLAUDE.md
├── README.md
├── PROJECT_DIRECTIVE.md          # 메인 기획서 (헌법)
└── docs/
    ├── specs/
    │   ├── _TEMPLATE.md
    │   └── SPEC_001_*.md
    └── devlog/
        └── YYYY-MM-DD_*.md
```

## Tier 2 (Standard — 1개월+, SPEC 5개+)

```
+ docs/
    + ROADMAP.md
    + CHANGELOG.md
    + specs/BACKLOG.md
    + context/AGENT_CONTEXT_GUIDE.md
    + runbook/                    # 운영 명령·장애 대응
    + conventions/                # 코드·데이터 표준
```

## Tier 3 (Full — Phase 4+, 실서비스 진입)

```
+ docs/
    + methodology/                # 본 문서 같은 방법론 정의서
    + strategy/                   # 비즈니스·로드맵 전략 문서
    + dev_history/                # 큰 chat log·디버깅 세션 보존
    + code_reviews/               # PR/리뷰 기록
    + archive/                    # 이전 버전·폐기 문서 (삭제 X)
    + audits/                     # 안전·규제 도메인의 감사 흔적
```

**YAGNI**: Tier 1로 시작. 필요해질 때 다음 Tier로 승격. 미리 만들면 빈 디렉토리 부담만 늘어난다.

---

# Part V — 표준 워크플로우 (라이프사이클)

## 5.1 새 세션 시작 (5분 안에 컨텍스트 90% 회복)

```
1. CLAUDE.md  자동 로드 (Claude Code 기본 동작)
2. docs/context/AGENT_CONTEXT_GUIDE.md  → "프로젝트 전체 현황"
3. docs/ROADMAP.md  → "지금 어디?"
4. docs/CHANGELOG.md 최상단 1~2 세션  → "직전에 뭐 했나?"
5. 진행 중 SPEC 본문 → "지금 작업 단위?"
6. 필요 시 관련 devlog → "왜 그렇게 결정?"
```

## 5.2 기능 요청 → SPEC 작성 → 구현 (Oracle 표준 6단계)

```
① 요청 접수
② docs/specs/_TEMPLATE.md 복사 → SPEC_NNN_<주제>.md (Status: Draft)
③ Context Anchor + Risks + Impact Analysis 채우기 (구현 전 사고 강제)
④ 사용자 컨펌 대기 — 컨펌 없이 구현 금지
⑤ 컨펌 후 구현 (Status: In Progress) — Milestones 체크박스로 추적
⑥ Test Plan + Success Criteria 모두 통과 → Status: Done + 커밋
```

**"완료(Done)"의 정의**: 코드가 머지된 상태가 아니다. **Test Plan과 Success Criteria가 모두 통과한 상태**. 실행 안 된 코드는 Done 아님.

## 5.3 작업 중 (실시간 운영)

- 결정사항 발생 → devlog에 1줄 기록 (즉시).
- 가드레일·금기 위반 발견 → 즉시 사용자 확인.
- 외부 라이브러리 추가 → 메인 기획서 절대 원칙과 정합 검증.
- 막혀서 우회 → "왜 우회했는지" devlog 기록.
- 실패가 일반화 가능하면 → 즉시 룰북·메모리에 등록 (원리 7).

## 5.4 세션 마감

- devlog 마감: 다음에 할 일 + 결정 보류 명시.
- CHANGELOG 상단에 세션 항목 추가 (큰 단위만).
- ROADMAP의 Phase 상태 갱신.
- 메모리 갱신 (필요 시 — 보조).
- git commit (작업 결과).

## 5.5 Phase·SPEC 완료

- SPEC Status: `Done`.
- ROADMAP에서 ✅ 표기.
- CHANGELOG에 완료 기록.
- 회고 1단락 (devlog) — "막혔던 곳 / 잘 된 것 / 다음 SPEC에 반영할 것".

## 5.6 큐·배치 운영 (반복 작업의 안전 룰)

> Oracle 시골의사 병렬 큐 사고에서 추출한 5계명. **모든 장기 배치 작업에 적용.**

1. **단일 큐 원칙**: 동시에 두 개 이상의 큐를 절대 돌리지 않는다.
2. **명시 승인 원칙**: 큐 시작은 사용자 명시 승인 후에만.
3. **명시 범위 한정**: 사용자가 지시한 범위 외 작업을 임의 추가 금지 (예: "매억남 짧은거만"이면 정확히 그것만).
4. **자동 재시작 금지**: fail 시 재시작 정책은 사용자가 정한다. AI가 임의로 재가동 X.
5. **idempotent 우선**: 모든 단계는 산출물 존재 시 자동 스킵하도록 설계 (재가동 비용 0).

---

# Part VI — SPEC 작성 규약

## 6.1 파일명
- `SPEC_NNN_<주제슬러그>.md`
- NNN: 3자리 0패딩 (`001` ~ `999`)
- 슬러그: 한국어 또는 영어 (프로젝트 일관성 유지)
- 한 번 부여된 번호는 재사용 X

## 6.2 필수 섹션 (Oracle 검증 템플릿)

```
# SPEC_NNN: <기능명>
> Status: Draft / Approved / In Progress / Done / Abandoned
> 작성일 / 연관 SPEC

## Context Anchor   (5줄 강제: WHY/WHO/RISK/SUCCESS/SCOPE)
## 1. 배경
## 2. 요구사항·핵심 원칙
## 3. 설계·구현 범위
## 4. Risks & Mitigation        (도메인 리스크 명시)
## 5. Impact Analysis           (Changed Resources / Current Consumers / Verification)
## 6. Success Criteria (DoD)    ("끝났다"의 정의 — 측정 가능)
## 7. Test Plan (L1~L5)         (Unit / CLI / E2E / Data Flow / Regression)
## 8. Milestones                (체크박스 진행 추적)
## 9. 변경 이력
```

## 6.3 SPEC Status 머신

```
Draft  ──사용자 컨펌──▶  Approved ──작업 시작──▶  In Progress
                                                       │
                          ┌────────────────────────────┤
                          ▼                            ▼
                       Abandoned                  Test/DoD 통과 → Done
```

- **Abandoned**: 폐기 사유 1단락 + 대체 SPEC 링크 (있으면). 파일·번호 보존.

## 6.4 작성 시 금기

- ❌ "나중에 채움" 빈 섹션 (작성 안 할 거면 섹션 제거 + 사유 1줄)
- ❌ 코드 자체를 SPEC에 길게 붙이기 (소스 링크로 대체)
- ❌ 사용자 결정 없이 임의 `Approved` / `Done` 마킹
- ❌ 폐기 시 파일 삭제 (Status `Abandoned`로 흔적 보존)
- ❌ 번호 충돌 (Oracle SPEC_013 가 두 개 — 한 건 재명명 또는 신규 번호로 분기 권고)

---

# Part VII — devlog 작성 규약

## 7.1 파일명
- `YYYY-MM-DD_<주제슬러그>.md`
- 작업한 날만 생성 (빈 날 파일 X)
- 한 날 두 큰 주제 → 두 파일로 분리 (`_subject_a.md`, `_subject_b.md`)

## 7.2 표준 섹션

```
# YYYY-MM-DD — <주제>
## 1. 한 줄 요약
## 2. 무엇을 했나
## 3. 왜 그렇게 결정했나 (트레이드오프)
## 4. 막힌 부분 + 해결법
## 5. 결정 보류 / 다음에 할 일
## 6. 관련 커밋·SPEC·메모리
```

## 7.3 작성 시 금기
- ❌ 시크릿·실 직원 이름·실 사번 등 민감정보 평문 기록 (가명·마스킹)
- ❌ "커밋했음"만 적기 — *이유* 적어라
- ❌ 다른 날 일기를 끼워 넣기 (별도 파일로)
- ❌ 잡담·곁가지를 무한 누적 (요점만 — 잡담은 메모리도 X)

---

# Part VIII — AI 메모리 시스템 (보조 캐시)

## 8.1 메모리 4분류

| 종류 | 무엇 | 예시 |
|---|---|---|
| **user** | 사용자 역할·전문성·선호 | "사용자는 Go 10년 경력, React 처음" |
| **feedback** | 명시적 가이드·교훈 (실패+성공) | "큐는 단일 운영. 5계명 적용" |
| **project** | 외부에서 유추 안 되는 진행 사실 | "법무팀이 5/15 까지 토큰 정책 제출 요청" |
| **reference** | 외부 시스템 위치 포인터 | "버그는 Linear INGEST 프로젝트" |

## 8.2 메모리 작성 패턴 (feedback·project)

```
---
name: <짧은 이름>
description: <한 줄 — 다음 세션이 관련성 판단할 때 사용>
type: feedback | project | user | reference
---

<본문>

**Why:** <이유 / 사례>
**How to apply:** <어떤 상황에서 어떻게 적용>
```

## 8.3 메모리 운영 룰
- 본체는 docs/, 메모리는 캐시. 둘이 충돌하면 docs/ 가 정답.
- 메모리는 *시점 관찰*이라 stale 가능 → 행동 전 코드 상태 검증.
- `MEMORY.md` 인덱스는 200줄 이내 (잘리면 의미 X).
- 코드에서 derive 가능한 사실은 메모리에 적지 않는다 (디렉토리 구조·import 경로 등).

## 8.4 메모리 ↔ 룰북 ↔ CLAUDE.md 위계

```
메모리 (개인 캐시)  ──일반화──▶  CLAUDE.md (프로젝트 강제)
            │                          │
            └─실패 사례 누적─▶  docs/runbook/*.md (절차서)
            └─결정 패턴화───▶  docs/conventions/*.md (표준)
```

→ 메모리에 같은 종류 항목이 3건+ 누적되면 **승격 검토**: runbook 또는 CLAUDE.md 로 옮겨 모든 협업자가 자동으로 받게.

---

# Part IX — 거버넌스 패턴: 실패 → 룰 변환

## 9.1 변환 라이프사이클

```
실패 발생
   │
   ▼
사용자 즉시 피드백 ("XX 하지 마")
   │
   ▼
24시간 안에:
   ① devlog에 사례 기록 (사고 보고서)
   ② auto-memory 엔트리 생성 (feedback 타입)
   ③ runbook/conventions 신규 또는 갱신
   ④ 필요 시 CLAUDE.md 헌법 조항 추가
   │
   ▼
다음 세션부터 자동 적용
```

## 9.2 Oracle 검증 사례

### 사례 A. 시골의사 병렬 큐 사고
- **사고**: 매억남 큐 도중 임의 시골의사 큐 병렬 가동 → 시스템 행
- **변환물**:
  - `docs/runbook/execution_governance.md` (5계명 + 모듈-자원 매트릭스)
  - `memory/feedback_batch_execution_approval.md` (다음 세션 자동 로드)
- **효과**: 이후 모든 큐 작업이 단일·승인·범위한정 룰 자동 적용.

### 사례 B. 봉 차트 표현 표준
- **요청**: "디스플레이·색으로 구분 X, 머신레벨로"
- **변환물**:
  - `docs/conventions/candle_reading.md` (9 섹션 머신레벨 표준)
  - `app/shared/schemas/candle.py` (CandleSpec — 색·한글 라벨 없는 비율 기반)
  - SPEC_024 의 Risks 섹션 사전 기록
- **효과**: 후속 모든 룰·인디케이터·백테스트가 색 의존 없는 정량 룰로.

### 사례 C. Split 환경 함정
- **반복 발생**: yt-dlp/ffmpeg 위치를 매 세션 `which`/`find` 로 검색 → 시간 낭비
- **변환물**:
  - `docs/runbook/split_env_and_paths.md` 의 **0번 섹션** ("검색 금지, 외워라")
  - 진단 체크리스트 0번 항목 ("FileNotFoundError 가 yt-dlp 류면 prefix env")
  - `memory/feedback_split_env_claude_ffmpeg.md` 갱신
- **효과**: 다음 세션 진입 시 검색 단계 자동 스킵.

---

# Part X — 안전·규제 도메인 통합

본 프로젝트(투자 자문) 또는 의료·법무·보안처럼 *결정의 이유*가 감사 대상인 도메인:

## 10.1 추가 강제

1. **헌법 = 메인 기획서 = 가드레일 1차 출처** (모든 SPEC이 헌법 위반 여부 사전 검증)
2. **SPEC의 Risks & Mitigation 에 법적·규제 리스크 명시 강제**
3. **외부 호출(API·DB·결제·매매) 추가 시 헌법 절대 원칙 위반 여부 사용자 확인 필수**
4. **devlog 에 가드레일 우회 시도·해결 기록**
5. **Red-team 시나리오는 별도 SPEC** (정기 회귀 테스트)
6. **감사 로그**: 모든 자동 결정·매매·외부 데이터 적재는 jsonl 로그 (Oracle: `data/trading_logs/{YYYY-MM-DD}.jsonl`)

## 10.2 권장 디렉토리

```
docs/
├── audits/                         # 감사 흔적 (분기 감사 보고서)
├── compliance/                     # 규제 매핑 (법조문 ↔ 코드)
└── red_team/                       # 적대 시나리오·리그레션
```

---

# Part XI — 자동화 키트 (Tooling Inventory)

## 11.1 권장 자동화 (Tier 2 이상)

| 스크립트 | 역할 | Oracle 구현 |
|---|---|---|
| `spec_progress.py` | 모든 SPEC milestones 스캔 → 진행률 표 + ROADMAP 자동 갱신 | ✅ |
| `devlog_today.sh` | 오늘 날짜·주제로 devlog 새 파일 만들고 템플릿 채우기 | (예정) |
| `memory_index.py` | `~/.claude/projects/*/memory/MEMORY.md` 자동 정렬·중복 검사 | (예정) |
| `spec_lint.py` | SPEC 필수 섹션 누락 검출 (Context Anchor·Risks·DoD 빈칸) | (예정) |
| `roadmap_render.py` | ROADMAP을 한 화면 SVG/이미지로 렌더 (PR 첨부용) | (예정) |

## 11.2 Hook (CI 통합)

```
pre-commit:
  - SPEC 필수 섹션 누락이면 거부
  - devlog 가 비어있으면 경고 (오늘 작업했는데 일기 없으면)
  - 메모리 인덱스 길이가 200줄 초과하면 경고

pre-push:
  - SPEC `Done` 마킹된 것 중 Test Plan 결과 누락이면 거부
```

---

# Part XII — Oracle 사례 인덱스 (참조용)

> 본 방법론을 채택하려는 이가 *실제 동작하는 예시*를 봐야 할 때 다음 위치 참고.

| 분류 | Oracle 실제 파일 |
|---|---|
| 헌법 | `PROJECT_DIRECTIVE.md` |
| AI 컨텍스트 헌장 | `CLAUDE.md` |
| 세션 진입 가이드 | `docs/context/AGENT_CONTEXT_GUIDE.md` |
| SPEC 템플릿 | `docs/specs/_TEMPLATE.md` |
| 메인 SPEC | `docs/specs/SPEC_000_project_oracle_main.md` |
| Phase 분해 SPEC 예시 | `docs/specs/SPEC_024_chart_data_lakehouse.md` |
| 폐기 SPEC 예시 | `docs/specs/SPEC_017_*.md` (번호 점프 보존 사례) |
| 운영 룰북 — 거버넌스 | `docs/runbook/execution_governance.md` |
| 운영 룰북 — 환경 함정 | `docs/runbook/split_env_and_paths.md` |
| 컨벤션 — 데이터 표준 | `docs/conventions/candle_reading.md` |
| devlog 모범 | `docs/devlog/2026-05-01_chart_data_lakehouse_and_personas.md` |
| 자동화 — 진행률 | `scripts/spec_progress.py` |
| 메모리 인덱스 | `~/.claude/projects/.../memory/MEMORY.md` |

---

# Part XIII — 채택 가이드 (도입 단계)

## 13.1 Day 1 (1시간 안)
1. `CLAUDE.md` 1쪽 작성 (가드레일 5줄 + 코드 스타일 5줄 + 금기 5줄).
2. `PROJECT_DIRECTIVE.md` 한 페이지 — 무엇을·왜.
3. `docs/specs/_TEMPLATE.md` 본 문서 부록 A 복사.
4. 첫 SPEC_001 작성 (Draft).

## 13.2 Week 1
- 첫 SPEC `Done` 까지 한 사이클 완주.
- 첫 devlog 작성.
- `docs/specs/BACKLOG.md` 시작 (다음 후보 3~5개).

## 13.3 Month 1
- ROADMAP.md 도입 (Phase 1개 이상 살아 움직일 때).
- 첫 실패 → 첫 룰북·첫 메모리 엔트리.
- SPEC 5개 누적 시 `BACKLOG` 우선순위 정리.

## 13.4 Month 3+
- `docs/conventions/` 도입 (코드·데이터 표준이 굳을 때).
- `docs/methodology/` 도입 (본 문서 같은 방법론을 *그 프로젝트에 맞게* 작성).
- 자동화 스크립트 1~2개 (spec_progress + devlog_today).
- 메모리 항목 10개 넘으면 카테고리 분리 검토.

## 13.5 Month 6+ (Tier 3 진입 신호)
- SPEC 20개+, Phase 3+ 진입.
- audits·red_team 디렉토리 도입 (안전 도메인).
- CI hook 활성화 (spec_lint, roadmap_render).
- 외부 협업자(2명+) 발생 시 README 의 "온보딩" 섹션 작성.

---

# Part XIV — 안티패턴 (이렇게 하면 무너진다)

| # | 안티패턴 | 증상 | 대응 |
|---|---|---|---|
| A1 | **모든 결정을 문서화** | 작성 오버헤드 폭증, 본인이 안 본다 | "비가역적·논쟁 가능성 있는" 결정만 |
| A2 | **기획서가 곧 SPEC** | 기획서에 일자별 진척 누적 → 헌법 권위 상실 | 6원소 분리 강제 |
| A3 | **SPEC 번호 재사용** | 폐기 흔적 사라짐, 미래에 같은 논쟁 반복 | 원리 3 (번호 불변) |
| A4 | **devlog 없이 빠른 머지** | 결정 이력 휘발 → 3주 뒤 "왜 이렇게 짰지" | 작업한 날은 1줄이라도 |
| A5 | **CLAUDE.md 절대 안 갱신** | 가드레일이 코드와 어긋남 → AI가 위반 못 알아챔 | Phase 마감마다 갱신 검토 |
| A6 | **메모리 = 본체** | git에 안 들어가서 다른 도구·다른 사람에게 안 보임 | 본체는 docs/, 메모리는 캐시 |
| A7 | **병렬 큐 임의 가동** | 트래픽·자원 충돌 → 시스템 행 | 5계명 (Part V.5.6) |
| A8 | **SPEC 없이 코드** | "잠깐 만들어보자" 가 영구 코드 됨 | 30분+ 작업이면 SPEC 강제 |
| A9 | **자동화 미루기** | spec_progress 같은 거 매번 손으로 → 결국 안 함 | Month 1 끝나기 전에 1개 도입 |
| A10 | **ROADMAP·CHANGELOG 통합** | 정보 중복 → 둘 다 stale | 시간축 분리 (ROADMAP=현재, CHANGELOG=과거, BACKLOG=미래) |

---

# 부록 A — 표준 템플릿 모음

## A.1 SPEC 템플릿

(Oracle `docs/specs/_TEMPLATE.md` 사용. 별도 복사본 유지하지 않고 원본 참조 권장.)

## A.2 devlog 템플릿

```markdown
# YYYY-MM-DD — <주제>

## 1. 한 줄 요약


## 2. 무엇을 했나


## 3. 왜 그렇게 결정했나 (트레이드오프)


## 4. 막힌 부분 + 해결법


## 5. 결정 보류 / 다음에 할 일

- [ ]

## 6. 관련 커밋·SPEC·메모리

- 커밋:
- SPEC:
- 메모리:
```

## A.3 CLAUDE.md 스켈레톤

```markdown
# CLAUDE.md — <프로젝트명> AI 협업 지시서

## 1. 프로젝트 단계
(현재 Phase + 미적용 Phase 3+ 규칙 명시)

## 2. 워크플로우
(SPEC 6단계 — Part V.5.2)

## 3. 계층 지도 / 디렉토리

## 4. 코딩 기본기 (5~10줄)

## 5. 파괴적 명령 차단

## 6. 커밋 메시지 형식

## 7. 실행 환경

## 8. 참조 문서

## 9. Phase 3+ 에서 부활할 유예 규칙
```

## A.4 메모리 엔트리 (feedback)

```markdown
---
name: <짧은 이름>
description: <한 줄 — 관련성 판단용>
type: feedback
---

<본문>

**Why:** <이유 / 사례>
**How to apply:** <상황 + 행동>
```

## A.5 ROADMAP 한 화면 양식

```markdown
# ROADMAP

## 현재 Phase: Phase N — <주제>
- 진행률: ##%
- 마감 목표: YYYY-MM-DD

## Active SPECs
| SPEC | Status | 진행 |
|---|---|---|
| 023 matgnam_auto_trader | In Progress | 60% |
| 024 chart_data_lakehouse | In Progress | 90% |

## Done This Phase
| SPEC | 완료일 |
|---|---|
| 022 binance_ohlcv_anchor | 2026-04-XX |

## Next (BACKLOG 인용)
1. SPEC_025 ...
2. SPEC_026 ...
```

---

# 부록 B — 자주 묻는 질문 (FAQ)

**Q1. SPEC을 너무 자주 만들면 관리 부담 아닌가?**
A. 30분+ 작업이면 SPEC. 5분 짜리 typo 수정이면 SPEC X. 기준은 "결정이 들어가는가". 결정이 들어가면 SPEC, 단순 수행이면 SPEC X.

**Q2. devlog와 git commit 메시지 중복 아닌가?**
A. commit 메시지는 *무엇*. devlog는 *왜* + 트레이드오프 + 결정 보류. 영역이 다르다. 다만 작은 작업은 commit 메시지로 충분, 큰 결정만 devlog.

**Q3. ROADMAP·CHANGELOG·BACKLOG 셋 다 운영하면 무겁지 않은가?**
A. 시간축 분리 원칙(Part III.A)을 지키면 셋 다 가벼워진다. 정보 *중복*이 무거움의 원인. ROADMAP은 현재만, CHANGELOG는 과거 요약만, BACKLOG는 미래만.

**Q4. AI 메모리를 본체로 쓰면 안 되나?**
A. 안 된다. (1) git 추적 X — 협업·롤백 불가. (2) 다른 AI 도구는 안 읽음. (3) stale 가능. 본체는 항상 docs/.

**Q5. 헌법(메인 기획서) 변경은 얼마나 자주?**
A. 분기 단위 권장. 그 사이엔 SPEC·devlog·룰북에 추가하고, 분기 끝에 "헌법으로 승격할 항목" 검토.

**Q6. SPEC 번호가 점프되면(예: 17·18·20 폐기) 보기 흉하지 않나?**
A. 점프가 *흔적*이다. 점프 자체가 학습 자산. 메우면 안 된다.

**Q7. Phase 1~3에는 본 방법론 풀세트가 과한가?**
A. Tier 1 (Part IV)로 시작. Tier 2 → Tier 3 는 자연스럽게 승격. 1주차에 풀세트 만들면 모두 stale 될 가능성 큼.

**Q8. 1인 개발이면 SPEC 컨펌은 누가?**
A. 본인이 *시간차로* 컨펌. SPEC을 Draft 로 쓰고 다음 날 다시 본 다음 Approved 로 넘긴다. 머리가 식은 다음 검토하는 게 핵심.

---

# 변경 이력

| 일자 | 버전 | 변경 |
|---|---|---|
| 2026-05-01 | v0.1 | 초안. 6원소·7원리·디렉토리·워크플로우 초안. |
| 2026-05-01 | v0.2 | 프레임워크급 재구성. Project Oracle 5개월 운영 사례 5건 검증. 보조 4원소(CLAUDE.md·context·runbook·conventions) 정식 편입. 안티패턴 10개·자동화 키트·채택 4단계·FAQ 8문항·표준 템플릿 5종 추가. |

---

> **본 방법론도 살아있는 문서다.**
>
> 새 프로젝트에서 발견되는 패턴·실패는 즉시 반영한다. 메이저 변경 시 버전 bump.
>
> 본 문서가 *그 자체로* 본 방법론의 적용 사례 — Part XII Oracle 인덱스가 본문의 모든 주장을 실제 파일로 뒷받침한다.
