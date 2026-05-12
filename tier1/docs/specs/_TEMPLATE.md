# SPEC_NNN: <기능명>

> **Status**: Draft   <!-- Draft / In Progress / Done / On Hold / Abandoned -->
> **작성일**: YYYY-MM-DD
> **연관**: (선행/관련 SPEC 링크)

<!--
Status 안내:
- Draft       — 작성 중 (사용자 컨펌 전)
- In Progress — 사용자 컨펌 후 구현 중
- Done        — Test Plan + Success Criteria 통과
- On Hold     — 현재 ROI 0 으로 보류. *재개 트리거* 필수 명시 (아래 §0 참조)
- Abandoned   — 명시 폐기 (사유 기록)
-->

---

## 0. Status: On Hold 처리 (해당 시만)

> ROI 0 추상화 도입 검토 결과 `On Hold` 라면 본 섹션 채울 것. 폐기보다 보존 — 재발견·재평가 가능.

**GO 사유 검증 4 질문 결과**:

| # | 질문 | 답 |
|---|---|---|
| Q1 | 마켓플레이스·외부 공개 계획? | (시점 없으면 ❌) |
| Q2 | 의존 SPEC 곧 진입? | (시기 미정이면 ❌) |
| Q3 | 현재 도구·형식의 구체 pain point? | (가설이면 ❌) |
| Q4 | 도입 직후 *즉시 효용* 0 이 아닌가? | (0 이면 ❌) |

**재개 트리거** (검증 통과 시 Status 변경 조건):
- (예: "marketplace 공개 결정 시" / "의존 SPEC_XXX 진입 시" / "사용자가 pain point 명시 시")

자세한 절차: [`docs/conventions/architecture-preservation.md`](../conventions/architecture-preservation.md)

---

## Context Anchor

> 이 SPEC 의 전략 의도를 5줄로 박는다. 구현 도중 컨텍스트가 흔들릴 때 돌아오는 닻.

| Key | Value |
|---|---|
| **WHY**     | (해결하려는 핵심 문제 — 한 줄) |
| **WHO**     | (누가 이 결과물을 소비/사용하는가) |
| **RISK**    | (가장 큰 리스크 1줄. 해결 못 하면 SPEC 자체가 흔들리는 것) |
| **SUCCESS** | (측정 가능한 성공 기준 — "X가 Y하면 끝") |
| **SCOPE**   | (이번 SPEC 의 In/Out 또는 Phase 분해) |

---

## 1. 배경

(이 기능이 왜 필요한가. 무엇이 부족해서 만드는가. 5~15줄.)

---

## 2. 요구사항 / 핵심 원칙

| # | 요구사항 | 우선순위 |
|---|---|---|
| R1 | | High/Med/Low |
| R2 | | |

---

## 3. 설계 / 구현 범위

(다이어그램·인터페이스·데이터 모델·핵심 알고리즘 — 코드 자체 붙여넣기보다는 *결정 사항* 기록.)

### 3.1 ...

---

## 4. Risks & Mitigation

> 시작 전 리스크 인벤토리. 도메인 리스크(법적·규제·보안) 명시.

| # | 리스크 | 영향 | 완화 |
|---|---|---|---|
| K1 | | | |
| K2 | | | |

---

## 5. Impact Analysis

> 변경되는 리소스 + 기존 소비자 전수조사. 예상치 못한 깨짐 방지.

### 5.1 Changed Resources
- 신규: (파일 / 모듈 / 테이블)
- 수정: (스키마 변경 / 인터페이스 변경)
- 삭제: (사유 명시)

### 5.2 Current Consumers
- (이 변경에 영향 받는 기존 코드·서비스·외부 사용자)

### 5.3 Verification
- (어떤 테스트로 깨지지 않음을 확인할 것인가)

---

## 6. Success Criteria (Definition of Done)

> "끝났다" 의 정의 — 측정 가능한 항목만.

- [ ] 기능 X 가 입력 Y 에 대해 Z 결과를 낸다
- [ ] 성능: P95 < 500ms (해당 시)
- [ ] (도메인 안전 기준 — 안전 도메인 한정)

---

## 7. Test Plan

### L1 — Unit
| ID | 대상 | 시나리오 |
|---|---|---|
| L1-01 | | |

### L2 — Integration
| ID | 시나리오 |
|---|---|
| L2-01 | |

### L3 — E2E
| ID | 시나리오 | 기대 결과 |
|---|---|---|
| L3-01 | | |

(L4·L5 는 데이터 흐름·회귀 — 프로젝트 성숙 시 추가)

---

## 8. Milestones

> 체크박스로 진행 추적. ROADMAP 자동 생성 단위.

### Phase A — <소제목>
- [ ] A1.
- [ ] A2.

### Phase B — <소제목>
- [ ] B1.

---

## 9. 변경 이력

| 일자 | 버전 | 변경 |
|---|---|---|
| YYYY-MM-DD | v0.1 | 초안. |
