# Propagation Queue — 미전파 패턴 처리 대기

> universal 패턴 박제 시 본 큐에 등록 → sync 트리거 시 starter kit / downstream 에 적용.
> 처리 완료 시 `SYNC_LOG.md` 로 이동 + 본 큐에서 제거.

---

## 처리 대기

| 일자 | 패턴 | 분류 | 출처 (devlog/SPEC) | starter | downstream |
|---|---|---|---|---|---|

> 분류 라벨: 🌍 universal · 🔧 domain-conditional · 🧩 project-specific · 📌 stable · 🧪 experimental

---

## 처리 액션 (큐 비우는 방법)

### A. Starter Kit 동기 (사용자 트리거)

1. 큐의 🌍📌 패턴 식별
2. Sanitize (도메인 단어 제거 — SPEC_propagation §sanitize)
3. starter kit repo 에 PR 또는 직접 적용
4. `SYNC_LOG.md` 로 이동
5. starter kit 버전 bump (v0.X → v0.X+1)

### B. Downstream Backport (사용자 트리거)

1. `DOWNSTREAM.md` 의 활성 프로젝트 1곳 식별
2. 큐의 🌍 + 🔧(필요 시) 패턴 패키지화
3. 다운스트림 프로젝트 로컬 또는 별도 세션에서 적용
4. `SYNC_LOG.md` 행 추가 + 큐에서 제거

---

## 변경 이력

- 2026-MM-DD: 초안 v0 — Pattern Propagation 시스템 양식 (TangProStarterKit v0.3 도입)
