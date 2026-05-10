# Memory Index (Claude Code 자동 로드)

> 본 디렉토리는 Claude Code 가 *매 세션 자동 로드* 하는 사용자 메모리.
> 파일을 본인 환경의 `~/.claude/projects/<encoded-path>/memory/` 로 *복사 1회* 하면 즉시 활성.
>
> 형식 표준 — 각 메모리 파일은:
> ```yaml
> ---
> name: <한 줄 제목>
> description: <검색 키워드용 1줄>
> type: feedback | project
> ---
> # 본문 + Why (사고 사례) + How to apply
> ```

---

## 운영 룰 (8건 + 2건 = 10건)

- [자동 커밋·푸시 금지](feedback_no_auto_commit_push.md) — 작업 중 commit X. 마감 트리거 시에만 일괄. push 매번 명시 승인
- [데이터 삭제·재구축 무허가 금지](feedback_no_destructive_without_approval.md) — `--rebuild`/`--force`/drop/cleanup 등 사용자 명시 승인 후만
- [백그라운드 큐 실행 승인 룰](feedback_batch_execution_approval.md) — 큐 시작·동시성·범위·재시도 4조건 모두 사용자 명시
- [사용자 오더 매칭 우선](feedback_orders_first.md) — 오더 형태 메시지는 ORDERS.md *먼저* 매칭. 컨텍스트 서치 X
- [작업·세션 모델 매칭](feedback_session_model_match.md) — 단순 정돈=Haiku / 표준=Sonnet / 본질 설계=Opus
- [런북 먼저](feedback_runbook_first.md) — 트러블 시 `docs/runbook/` 먼저. 시도-실패 반복 금지
- [스크립트 출력 본문 paste](feedback_paste_bash_output.md) — 도구 결과 verbatim paste. 요약·재가공 금지
- [도메인 독립 발전 전략](project_domain_isolation_strategy.md) — 다도메인 프로젝트 — 통합 강요 X. 형식만 통일
- [대전제·아키텍처 임의 변경 금지](feedback_no_unilateral_arch_change.md) — 핵심 layer 골격 등 사용자 명시 결정 영역
- [ROI 0 추상화 도입 금지](feedback_no_premature_abstraction.md) — 즉시 효용 없으면 SPEC On Hold 박제 후 보류

---

## 사용 가이드

### 새 룰 추가

1. 사용자 정정·시행착오에서 *재발 방지* 가치 발견 시 *즉시* 메모리 파일 작성
2. 본문에 **Why** (사고 사례) + **How to apply** (구체 절차) 박제
3. 본 인덱스 (MEMORY.md) 에 1줄 entry 추가
4. Git commit (메모리는 사용자별이라 commit 시 path encoding 주의)

### 룰 폐기

오래된 룰이 더 이상 유효하지 않으면 — 파일 삭제하지 말고 *frontmatter 에 `deprecated: true`* + 본문에 *왜 폐기됐는지* 박제. 미래 참고 가치 보존.

### 짝 메모리 (cross-reference)

룰끼리 연관이 있으면 본문에 `[ruleX](ruleX.md)` 링크 — 미래 AI 가 함께 적용 가능.
