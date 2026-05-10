# 개발 세션 마감 루틴 (Dev Session Close v2)

> 개발 세션 종료 시 *기록·동기화·푸시·전파 큐* 를 빠뜨리지 않게 하는 7단계 체크리스트.
> 사용자 트리거: "세션 마감" / "마감 루틴" / "오늘 한 거 정리하고 푸시" / "오늘 개발한 거 데브로그·기획서·로드맵 반영 + 깃 푸시"

---

## 7 단계 체크리스트

### [1] 진행 중 백그라운드 작업 완료 대기

먼저 백그라운드 fetch / digest / batch 가 끝났는지 확인. 미완 상태로 마감하면 다음 세션에 이중 작업 위험.

→ 끝나야 git status 가 안정된 변경 셋 반영.

### [2] 데브로그 작성 + CHANGELOG 인덱스 갱신

**파일명**: `docs/devlog/YYYY-MM-DD_session{N}_<slug>.md` (영문 snake_case)

**본문 구조** (예시):
```markdown
# YYYY-MM-DD (오전/오후) — 한줄 요약 제목

## 달성한 목표
**SPEC_NNN: <기능명>**
- 핵심 변경 (모듈 + 줄 수 가늠)

## 발견 / 정정 (선택)
- 실측 → 정책 변경한 것

## 다음 세션
- 우선순위 1
```

**CHANGELOG 인덱스 갱신**: `docs/CHANGELOG.md` 최상단 해당 날짜 섹션에 1줄:
```markdown
## YYYY-MM-DD
- [세션 제목](devlog/YYYY-MM-DD_session{N}_{slug}.md)
```

원칙:
- *코드 변경*만 쓰지 않음 — *왜* + *다음 액션*
- 길이 제한 X — 의미 있는 만큼
- **CHANGELOG 본문에 직접 박제 금지** (인덱스 전용)

### [3] SPEC 진행 동기화

영향받은 SPEC 파일:
| 상태 | 액션 |
|---|---|
| Done | `Status: Done` + Milestones 모두 ✅ |
| In Progress | 현재까지 완료 milestones 만 ✅ |
| Draft → 시작됨 | `Status: In Progress` 로 변경 |
| 기각·보류 | `Status: On Hold` + 재개 트리거 박제 |
| 새 결정 (정책 변경) | 본문에 박제 (날짜 + 이유) |

### [4] ROADMAP + PROJECT_STATUS 자동 갱신

```bash
# SPEC milestones 진행률
python scripts/spec_progress.py --roadmap

# 자산 카운트 (도메인별 트랜스크립트·digest·페르소나 등)
python scripts/project_status.py --write
```

→ 자동 재생성 (직접 편집 금지):
- `docs/ROADMAP.md` — SPEC 진행
- `docs/PROJECT_STATUS.md` — 자산 수치

서사·구조는 `docs/PROJECT_MAP.md` (수동) 에 별도. 도메인·파이프라인 추가 시 갱신.

### [5] git 정리

```bash
git status --short          # 변경 인벤토리
```

원칙:
- **secrets, audit log 등 .gitignore 확인**
- **계층/모듈별 분리 커밋** — 의미 단위
- 메시지 형식: `[계층/모듈] 작업유형: 간결한 설명`

### [6] git push (★ 사용자 명시 승인 필요)

push 는 destructive 가능 → 자동 push 절대 X. 매번 명시 OK.

```bash
git push origin <branch>
```

### [7] Propagation 큐 등록 (★ universal 패턴 박제 시)

본 세션에서 박제한 패턴 중 *🌍 universal* 이 있는가?

→ 있으면 `docs/propagation/QUEUE.md` 표에 1줄 추가:
```
| YYYY-MM-DD | <패턴 이름> | 🌍📌 또는 🌍🧪 | <출처 devlog 파일명> | 대기 | 대기 |
```

→ `docs/propagation/INVENTORY.md` 의 해당 카테고리 표도 갱신.

→ 다음 sync 사이클 (사용자가 *"스타터킷 동기화"* 또는 *"<프로젝트>에 backport"* 트리거) 에 일괄 처리.

---

## ★ 트러블슈팅 — git push 가 hang 걸릴 때

### 증상
- `git push` 실행 후 *출력 없이 hang*

### 원인
WSL git 의 `credential.helper` 가 비어있음 → 비대화형 환경에서 prompt 영원히 멈춤.

```bash
git config --global --get credential.helper   # 결과 비어있으면 원인 확정
```

### 해결책 (1회 셋업)

```bash
# Windows GCM 위치 확인
ls "/mnt/c/Program Files/Git/mingw64/bin/git-credential-manager.exe"

# WSL git 에 매핑
git config --global credential.helper "/mnt/c/Program Files/Git/mingw64/bin/git-credential-manager.exe"

# 첫 push — browser 인증 prompt
git push origin master
```

### 또는 — credential store + Personal Access Token

```bash
git config --global credential.helper store

# 토큰 박제 (사용자 본인 터미널 — 채팅창 노출 X)
read -sp "Token: " T && \
  echo "https://USERNAME:${T}@github.com" > ~/.git-credentials && \
  chmod 600 ~/.git-credentials && \
  unset T
```

---

## 원칙

- **데브로그·SPEC·ROADMAP·git·propagation** 5개가 동기화되면 1세션 마감
- **다음 세션 사용자가 git pull 만 해도 어디서 이어갈지 보임** — 이게 데브로그의 진짜 목적
- **'완료'의 정의**: 코드 머지가 아니라 *데브로그까지 반영된 상태*
