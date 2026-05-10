---
name: 데이터 삭제·재구축 무허가 금지
description: --rebuild/--force/drop/cleanup 등은 사용자 명시 승인 후에만. 절차 위반 = 신뢰 손상
type: feedback
---

# 데이터 삭제·재구축 무허가 금지

다음 명령·옵션은 사용자 명시 승인 후에만 실행:
- `--rebuild` / `--force` / `--reset` 등 destructive 옵션
- `DROP TABLE` / `TRUNCATE` / DB 인덱스 삭제
- 디렉토리 `rm -rf` / `git clean -fdx` / `git reset --hard`
- 캐시·메타파일 일괄 삭제 (다음 처리 비용 큼)
- 외부 시스템의 컬렉션·스키마 변경

**Why**: AI 가 *깨끗한 상태* 만들기 위해 자기 판단으로 reset 시도 시 — 사용자가 의도하지 않은 *진행 중 작업·실험·검증 산출* 까지 휩쓸려 사라짐. 비가역.

**How to apply**:
- destructive 의심 명령 직전에 *사용자에게 정확한 영향 보고* + 명시 OK 대기
- "재가동 시 깨끗한 상태가 좋을 것" 이라는 AI 의 *추정* 으로 진행 X
- 트러블 발생 시 *원인 진단 우선*. *우회 수단으로 reset 사용 금지*
- 사용자가 한 번 OK 줘도 *그 명령에 대해서만*. 유사 명령은 *다시* 명시.
