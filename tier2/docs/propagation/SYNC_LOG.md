# Propagation Sync Log

> 큐의 패턴이 starter kit / downstream 으로 적용된 기록.
> 형식: 일자 / 패턴 / 대상 / 결과.

---

## 2026-05-30 — Oracle QUEUE → 키트 v0.4 동기 (1차)

> Oracle `docs/propagation/QUEUE.md` 의 🌍 패턴 22건 처리. SPEC_039 §6 sanitize 적용.
> 처리 분류: 신규작성 3 / 이미반영 9 / orchestration위임 2 / 보류 5 / (domain-conditional·experimental 보류 포함).

### 신규 작성 (키트에 추가)

| 일자 | 패턴 | 대상 | 결과 |
|---|---|---|---|
| 2026-05-30 | FastAPI 운영 화면 인프라 (routers·schemas·services) | starter v0.4 — `tier2/docs/runbook/operational_ui.md` §1 | ✓ 추출 + sanitize |
| 2026-05-30 | Activity Stream emit() (HTTP POST + WS pub/sub) | starter v0.4 — `operational_ui.md` §2 | ✓ 추출 + sanitize |
| 2026-05-30 | React UMD → 실 API wire (live/mock 폴백) | starter v0.4 — `operational_ui.md` §3 | ✓ 추출 + sanitize |
| 2026-05-30 | viewport meta 함정 (반응형 무력화 1줄) | starter v0.4 — `operational_ui.md` §0·§4 | ✓ 추출 + sanitize |
| 2026-05-30 | PROJECT_DIRECTIVE 나선형 자기진화 | starter v0.4 — `tier1/docs/conventions/spiral-self-evolution.md` | ✓ 추출 + sanitize (도메인어 제거) |
| 2026-05-30 | WSL Interop + 클립보드 페어링 환경 셋업 | starter v0.4 — `tier2/docs/runbook/wsl_environment.md` | ✓ 추출 (🧪 등급, WSL 사용 시만) |

### 이미 반영됨 (v0.3 — 중복 생성 X)

| 일자 | 패턴 | 대상 | 결과 |
|---|---|---|---|
| 2026-05-08 | Devlog + CHANGELOG 인덱스 컨벤션 | `tier2/docs/runbook/dev_session_close.md` [2] | 이미 반영 (v0.3) |
| 2026-05-08 | dev_session_close 루틴 v2 | `dev_session_close.md` | 이미 반영 (v0.3) |
| 2026-05-08 | SPEC_039 본 SPEC 자체 | `tier2/docs/propagation/` 4파일 전체 | 이미 반영 (v0.3) |
| 2026-05-08 | dev_session_close [7] propagation 큐 단계 | `dev_session_close.md` [7] | 이미 반영 (v0.3) |
| 2026-05-08 | ORDERS 트리거 — 스타터킷 동기화 / backport | `tier1/docs/ORDERS.md` ops | 이미 반영 (v0.3) |
| 2026-05-05 | ORDERS 어휘집 시스템 | `tier1/docs/ORDERS.md` + `GLOSSARY.md` | 이미 반영 (v0.3) |
| 2026-05-05 | PROJECT_MAP / STATUS 분담 | `dev_session_close.md` [4] | 이미 반영 (v0.3) |
| 2026-05-02 | Tech review INDEX 시스템 | (v0.3 반영 — 본 작업자 영역 외) | 이미 반영 (v0.3) |
| 2026-05-08 | 아키텍처 보존 룰 | `tier1/docs/conventions/architecture-preservation.md` | 이미 반영 (v0.3, P-005) |

### orchestration 모듈 위임 (tier3 — 본 작업자 미관여)

| 일자 | 패턴 | 대상 | 결과 |
|---|---|---|---|
| 2026-05-20 | Agent Teams 워크플로 (TeamCreate + Agent team_name+name + SendMessage + TeamDelete) | tier3 orchestration 모듈 | tier3/docs/orchestration/ 로 반영 (다른 작업자) |
| 2026-05-20 | dev_session_close 서브에이전트 위임 패턴 (일꾼화) | tier3 orchestration 모듈 | tier3/docs/orchestration/ 로 반영 (다른 작업자) |

### 보류 (domain-conditional · experimental · 영역 외)

| 일자 | 패턴 | 분류 | 결과 |
|---|---|---|---|
| 2026-05-08 | Code review 의뢰서 양식 | 🌍🧪 | 보류 — 검증 필요 (Oracle 큐도 보류) |
| 2026-05-08 | Notion + Telegram 외부 공유 | 🔧📌 | 보류 — 옵션 모듈, 외부 발신 필요 시만 |
| 2026-05-08 | Design brief 양식 | 🔧🧪 | 보류 — 시각 자산 필요 시 |
| 2026-05-08 | 인라인 룰 grammar prepend (Vision 호출) | 🌍🧪 | 보류 — 도메인 의존성 큼 |
| 2026-05-20 | Tech review 박제 패턴 (결정 라벨 ✅채택/⏸대기/❌스킵) | 🌍📌 | 보류 — Tech review INDEX(v0.3 반영)에 종속, research conventions 홈 신설은 본 작업 범위 외 |

---

## 향후 기록 형식

```
| 2026-MM-DD | <패턴 이름> | starter v0.X+1 | ✓ 추출 + sanitize 완료 |
| 2026-MM-DD | <패턴 이름> | <다운스트림 프로젝트> | ✓ backport 패치 적용 |
```

---

## 변경 이력

- 2026-MM-DD: 초안 v0 — Pattern Propagation 시스템 양식 (TangProStarterKit v0.3 도입)
- 2026-05-30: 1차 sync — Oracle QUEUE 22건 처리 (신규 3 문서 / 이미반영 9 / orchestration 위임 2 / 보류 5). 키트 v0.4
