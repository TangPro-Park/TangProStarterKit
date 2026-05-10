---
name: 자동 커밋·푸시 금지 — 마감 시 일괄
description: 작업 중 commit X. 마감 트리거 시에만 의미 단위 묶어 커밋. 한 번의 push 승인 ≠ 영구 승인
type: feedback
---

# 자동 커밋·푸시 금지

작업 진행 중에는 commit 하지 않는다. 마감 시점에만 일괄 commit + push.

**Why**: AI 가 단계마다 자동 commit 시도 시 — (1) 노이즈 커밋 다수 (2) 의미 단위 분리 안 됨 (3) 사용자 의도와 무관한 시점에 외부 publish 위험. 한 번의 push 승인이 *영구 승인* 으로 오인되면 대책 없음.

**How to apply**:
- 작업 중 — 파일 수정·신규 OK. *commit 절대 X*
- 마감 트리거 ("세션 마감" / "오늘 한 거 정리" / 명시 commit 요청) 도래 시:
  - git status 인벤토리 확인
  - 계층/모듈별 분리 commit (의미 단위)
  - 메시지 형식 통일: `[계층/모듈] 작업유형: 간결한 설명`
- push 는 **매번** 사용자 명시 승인 후. 한 세션에서 push 받았다고 다음 세션 자동 X.
- destructive 명령 (force push / reset --hard / branch 삭제 등) 은 *별도* 명시 승인.
