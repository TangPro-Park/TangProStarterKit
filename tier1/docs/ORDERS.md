# 사용자 오더 어휘집 (Orders Vocabulary)

> 한 마디 오더 → AI 가 컨텍스트 서치 없이 진입점만 읽고 즉시 수행.
>
> - **이 문서**: 동사 (트리거 → 액션)
> - **[`GLOSSARY.md`](GLOSSARY.md)**: 명사 (호칭 → 정의 — 화면·계층·외부채널)
> - 트리거에 명사가 등장하면 GLOSSARY 매칭 후 본 문서의 동사로 액션

---

## 사용 룰 (AI 측)

1. **사용자 메시지가 오면 본 문서를 *먼저* 확인** — 컨텍스트 서치보다 앞서 매칭
2. 트리거 어구 정확 일치 또는 명확한 의미 매칭 → **진입점 1곳만** 읽고 액션 (광범위 Glob/Grep 금지)
3. **모호하면 사용자 확인** — 추측 액션 금지
4. 매칭 안 되면 정상 추론 fallback
5. 새 오더 패턴 자주 등장하면 *능동 등록 제안*

---

## 카테고리 (예시 — 프로젝트별 조정)

| 카테고리 | 정의 |
|---|---|
| **data** | 도메인 컨텐츠 처리 (수집·정제·변환·적재) |
| **research** | 외부 자료 검토 → 보고서 |
| **knowledge** | 지식 엔지니어링 (도메인 모델·온톨로지·메커니즘) |
| **platform** | SPEC 신설·수정·아키텍처 설계 |
| **ui** | 화면 띄우기·외부 노출 ([GLOSSARY §1](GLOSSARY.md) 명사) |
| **ops** | 세션 마감·갱신·푸시 등 운영 루틴 |

---

## 정착 오더 (Stable)

> 형식: `\| 트리거 \| 진입점 \| 액션 \| 출력 \|` 표.
> 새 오더가 3회 이상 등장하면 본 표로 승급.

### data
| 트리거 | 진입점 | 액션 | 출력 |
|---|---|---|---|
| (예시: "<도메인> 처리 상태") | (예: `_pipeline.md`) | (예: `python scripts/dashboard.py`) | (예: 도메인×카테고리 표) |

### research
| 트리거 | 진입점 | 액션 | 출력 |
|---|---|---|---|

### knowledge
| 트리거 | 진입점 | 액션 | 출력 |
|---|---|---|---|

### platform
| 트리거 | 진입점 | 액션 | 출력 |
|---|---|---|---|
| "SPEC 만들어" / "{기능} SPEC" | `docs/specs/_TEMPLATE.md` + CLAUDE.md §2 | SPEC_NNN 신설 (Status: Draft) → Context Anchor + Risks + Impact + Success + Test Plan + Milestones → 컨펌 대기 | `docs/specs/SPEC_NNN_*.md` |

### ui
| 트리거 | 진입점 | 액션 | 출력 |
|---|---|---|---|

### ops
| 트리거 | 진입점 | 액션 | 출력 |
|---|---|---|---|
| "세션 마감" / "마감 루틴" | `docs/runbook/dev_session_close.md` | 7단계 루틴: 백그라운드 → devlog → SPEC 동기 → ROADMAP+STATUS auto → git → push → propagation | devlog·ROADMAP·STATUS 갱신 + 커밋 |
| "스타터킷 동기화" / "스타터킷 sync" | `docs/propagation/QUEUE.md` | 큐의 🌍 패턴 → sanitize → starter kit repo 적용 → SYNC_LOG 기록 | starter kit 버전 bump |
| "{프로젝트}에 backport" | `docs/propagation/DOWNSTREAM.md` | 활성 다운스트림 1곳 식별 → 미적용 패턴 패키지화 | backport 패치 + SYNC_LOG 행 |

---

## 미정착 (Observing)

> 1~2회 등장. 3회 이상 + 사용자 컨펌 시 정착 승급.

- (없음)

---

## 변경 이력

- 2026-MM-DD: 초안 v0 — Project Oracle 의 ORDERS 시스템 양식 (TangProStarterKit v0.3 도입)
