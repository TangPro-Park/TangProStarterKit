# Architecture Preservation — 대전제·아키텍처 보호

> AI 협업 프로젝트의 *전형적 함정* 회피 컨벤션.
>
> **원칙**: 프로젝트의 *정체성 자산* 은 사용자 명시 결정의 영역. AI 는 패턴 매칭·시각화 욕구·미래 호환성 가정으로 임의 변경 금지. ROI 0 추상화는 SPEC 박제 후 On Hold — 폐기보다 보존.
>
> 출처: Tang-Pro Starter Kit Pattern P-005 (project_oracle 운영에서 추출).

---

## 1. 적용 상황 (왜 필요한가)

AI 협업 시 흔히 발생하는 drift:

- AI 가 *패턴 매칭* 으로 기존 구조에 새것을 끼워넣음 (사용자 동의 없이)
- 시각화·UI 개선 욕구가 *데이터 모델 변경* 으로 번짐
- "미래 호환성" / "표준 컨벤션" 이라는 모호한 사유로 의미 없는 추상화 도입
- 도입 후 *제거 비용 > 도입 비용* (관성으로 굳음)
- 사용자가 의도하지 않은 architecture drift 누적 → 프로젝트 정체성 흐려짐

본 컨벤션은 위 함정의 *체계적 회피*.

---

## 2. 룰 A — 대전제·아키텍처 임의 변경 금지

다음 자산은 **사용자 명시 결정 없이 변경 X**:

- 핵심 layer / 모듈 골격 (예: 도메인 별 5-layer 구조)
- 통합 모델 / 카테고리 데이터 모델 (LAYER_MAP 류)
- PROJECT_DIRECTIVE 의 핵심 다이어그램
- CLAUDE.md 의 계층 지도·디렉토리 지도
- *어떤 자산이든 "프로젝트 정체성" 의 일부로 사용자가 명시 박제한 것*

### 필수 절차

| 상황 | 조치 |
|---|---|
| 신규 SPEC 이 기존 골격에 안 맞음 | *"어디에 넣을지" 사용자에게 묻기*. 골격 자체 변경 X |
| 시각화·UI 욕구로 데이터 모델 변경 충동 | **시각화는 시각화로 해결** — 모델 그대로 |
| 대전제 변경이 진짜 필요해 보임 | 즉시 *사용자 컨펌 게이트* 진입 |

### 위반 시 정정

깔끔한 원복 — 수동 Edit 으로 *되돌리기* 시도 X (누락 위험):

```bash
git checkout <pre-change-commit> -- <files>
```

그 다음 *재발 방지 메모리 룰* 박제 (`feedback_no_unilateral_arch_change.md`).

---

## 3. 룰 B — ROI 0 추상화 On Hold

외부 자산 (마켓플레이스 컴포넌트·표준 인터페이스 등) SPEC 작성 시 **GO 사유 검증 4 질문**:

| # | 질문 | 통과 기준 |
|---|---|---|
| Q1 | 마켓플레이스·외부 공개 계획? | 명시된 시점 있음 |
| Q2 | 의존 SPEC 곧 진입? | 시기 미정 X — 명확한 phase 가시 |
| Q3 | 현재 도구·형식으로 *불편* 한 게 있나? | 구체 pain point 있음 (가설 X) |
| Q4 | 도입 직후 *즉시 효용* ? | 0 이 아님 — 즉시 사용 가능 |

### 미통과 시

| 처리 | 절차 |
|---|---|
| Status 변경 | `Draft` → `On Hold` |
| 재개 트리거 명시 | 예: "marketplace 공개 결정 시 / Managed Agents 진입 시" |
| SPEC 박제 보존 | **폐기 X** — 재발견·재평가 가능 자료로 |

### 절대 GO 사유 부족

다음 두 사유로는 *항상 On Hold*:

- "미래 호환성" 만 (구체 진입 시점·소비자 미정)
- "표준 컨벤션" 만 (현재 *불편함* 미증명)

→ 이 사유들만 가지고는 *추상화 도입 = 매몰 비용*.

---

## 4. 메모리 룰 (Claude Code AI)

본 컨벤션은 `~/.claude/projects/.../memory/` 의 두 룰로 *세션 자동 로드*:

| 파일 | 내용 |
|---|---|
| `feedback_no_unilateral_arch_change.md` | 룰 A — 대전제 임의 변경 금지 |
| `feedback_no_premature_abstraction.md` | 룰 B — ROI 0 추상화 On Hold |

두 룰 entry 가 `MEMORY.md` 인덱스에 등재되어 매 세션 시 AI 가 인지.

---

## 5. SPEC 템플릿 연동

`docs/specs/_TEMPLATE.md` 의 *Status* 필드:

- `Draft` — 작성 중
- `In Progress` — 사용자 컨펌 후 구현 중
- `Done` — Test Plan + Success Criteria 통과
- **`On Hold`** — ROI 0 으로 보류 (위 §3 절차)
- `Abandoned` — 명시 폐기

`On Hold` 의 경우 SPEC 본문에 **재개 트리거** 명시 필수.

---

## 6. CLAUDE.md 연동

CLAUDE.md 의 *AI 작업 룰* 섹션에 본 컨벤션 인라인 명시 — AI 가 매 작업 시 *즉시 참조*.

예시 (`CLAUDE.md` §X):

> **대전제·아키텍처 보호** — 핵심 layer 골격·데이터 모델·다이어그램은 사용자 명시 결정 없이 변경 X. 신규 SPEC 이 골격에 안 맞으면 "어디에 넣을지" 묻기. 자세한 절차: `docs/conventions/architecture-preservation.md`.

---

## 7. 참조

- 원천: project_oracle disciple/cases/2026-Q2-007_architecture-preservation-rules.md
- 패턴: Tang-Pro Starter Kit Pattern P-005
- 형제 컨벤션:
  - `docs/conventions/ORDERS-GLOSSARY.md` (P-003) — 동사·명사 어휘집 분리
  - `docs/runbook/dev_session_close.md` (P-004) — 개발 세션 마감 v2
