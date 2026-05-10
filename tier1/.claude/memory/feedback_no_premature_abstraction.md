---
name: ROI 0 추상화 도입 금지
description: 외부 자산·컨벤션이 좋아 보여도 *지금 효용 없으면* On Hold. SPEC 박제 후 트리거 시 재개
type: feedback
---

# ROI 0 추상화 도입 금지

외부 자산·컨벤션 도입 결정 시 다음 4 질문 통과 못하면 **Status: On Hold** 박제 후 보류:

| 질문 | 통과 기준 |
|---|---|
| 마켓플레이스·외부 공개 계획? | 명시된 시점 있음 |
| 의존 SPEC (예: Managed Agents) 곧 진입? | 시기 미정 X |
| 현재 도구·형식으로 *불편* 한 게 있나? | 구체 pain point 있음 |
| 도입 직후 즉시 효용? | 0 이 아님 |

**Why**: AI 는 *외부 좋은 것* 보면 *우리도 도입* 하려는 경향. 그러나 ROI 0 추상화는 *이중 관리* 부담 + *제거 비용* 이 도입 비용보다 큼. "미래 호환성" / "표준 컨벤션" 만으론 GO 사유 부족.

**How to apply**:
- 외부 자산 검토 후 SPEC 작성 시 *§Context Anchor 의 SUCCESS 항목* 에 *지금 즉시 얻는 가치* 명시. 미래 호환성·표준 컨벤션은 GO 사유로 부족
- ROI 0 인 경우 SPEC Draft → On Hold 로 박제 (Status 갱신, *재개 트리거* 명시). 폐기 X — 재발견·재평가 가능
- 사용자가 "굳이 필요할까?" 의문 표명 시 *내 권고 GO 라도* 즉시 *솔직 평가* (지금 ROI · 트리거 시점 · 대안) 제시. SPEC 강행 금지
- 메모리 룰 [feedback_no_unilateral_arch_change](feedback_no_unilateral_arch_change.md) 와 짝 — 둘 다 "변경의 정당화 책임은 도입자에게" 원칙
