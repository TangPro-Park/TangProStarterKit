# docs/specs/ — SPEC 본체 인덱스

> 모든 모듈·기능별 SPEC 이 여기. 한 번 부여된 번호는 재사용 X.

---

## 작성 규칙

1. `_TEMPLATE.md` 복사 → `SPEC_NNN_<주제>.md` 생성
2. NNN 은 3자리 0패딩. 한 번 부여된 번호 재사용 X
3. 폐기 시 파일 보존, `Status: Abandoned` 마킹 + 폐기 사유 1단락
4. Context Anchor 5줄은 *구현 시작 전* 채운다 — 이게 "사고 강제 장치"
5. 사용자 컨펌 없이 `Approved` / `Done` 마킹 X

## SPEC Status 머신

```
Draft  ──사용자 컨펌──▶  Approved ──구현 시작──▶  In Progress
                                                       │
                          ┌────────────────────────────┤
                          ▼                            ▼
                       Abandoned                  Test/DoD 통과 → Done
```

---

## SPEC 인덱스 (자동 갱신 권장)

| # | 주제 | Status | 진척 | 마지막 변경 |
|---|---|---|---|---|
| 000 | (메인) | Draft | — | <시작일> |
| 001 | | | | |

> Tier 2 진입 시 `scripts/spec_progress.py` 같은 자동 인덱스 생성 도구 도입.

---

## 후보·폐기 풀

→ [`BACKLOG.md`](BACKLOG.md)

---

## 템플릿

→ [`_TEMPLATE.md`](_TEMPLATE.md)
