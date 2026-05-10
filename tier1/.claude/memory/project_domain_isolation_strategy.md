---
name: 도메인 독립 발전 전략
description: 다도메인 프로젝트 — 각자 독립 발전. 통합은 ontology+RAG 성숙 후. 형식만 통일, 데이터 분리
type: project
---

# 도메인 독립 발전 전략

여러 도메인을 다루는 프로젝트는 *각자 독립 ontology·그래프·페르소나·파이프라인* 으로 발전. 도메인 간 통합 그래프 *지금은 X*.

**Why**: 도메인 간 *교차 데이터* 부족 시 통합 강요는 *형식적 통합* 이지 *의미적 통합* 아님. 도메인별 깊이 채운 후, 명확한 결합 가치 (페르소나 교차 발언·다중 도메인 동시 질의·도메인 교차 토론 등) 발생 시 결합.

**How to apply**:
- 4-추상 메타 ontology (또는 유사 표현 모델) 의 *형식만* 동일 — Persona/Utterance/Assertion/Subject 같은 추상 모델 한 곳 박제
- *데이터·그래프·SPEC 은 도메인별 분리* — `data/processing/{도메인}` / 그래프 namespace / 도메인별 SPEC
- adapter (`adapters/{domainA}.py`, `adapters/{domainB}.py`) 도 도메인별 별도 파일. 한 함수에 통합 X
- UI 화면도 도메인별 별도 (Console / Library / Search 등)
- *결합 트리거* 도래 전엔 4 도메인 각자 *깊이* 발전 — 통합 폭주 X
- 사용자가 "통합해" 명시할 때만 통합 SPEC 신설 (Council Engine 등)
