# 부트스트랩 상세 절차

> 5초 사용법(README)으로 안 풀리는 케이스·세부 옵션·FAQ.

---

## A. 사전 준비 (변수 셋팅)

```bash
NEW=/path/to/new_project          # 새 프로젝트 루트
KIT=/path/to/tangpro-starter-kit  # 본 키트 위치 (Use this template 후 clone 한 곳)
PROJECT_NAME="MyProject"          # 프로젝트 이름 (영문 권장)
DOMAIN="투자자문"                  # 도메인 (자유 — 안전 도메인이면 Tier 3 도 미리 검토)
MISSION="1인용 자동화"             # 한 줄 미션
TODAY=$(date +%Y-%m-%d)
```

---

## B. Step 1 — 부트스트랩 스크립트 실행 (권장)

```bash
cd $NEW
bash bootstrap.sh "$PROJECT_NAME" "$DOMAIN" "$MISSION" [--stack <스택이름>]
```

`--stack` 옵션 (선택):
- `python-ai-stack` — AI 에이전트·RAG·비디오 처리 (Project Oracle 검증 패턴)
- 생략 시 Docker 파일 없이 부트스트랩 (가장 가벼움)

부트스트랩 후 트리:
```
$NEW/
├── CLAUDE.md
├── PROJECT_DIRECTIVE.md
├── README.md
├── NEXT_STEPS.md                  # 부트스트랩이 자동 생성
└── docs/
    ├── specs/
    │   ├── README.md
    │   ├── _TEMPLATE.md
    │   └── BACKLOG.md
    └── devlog/
        ├── README.md
        └── _TEMPLATE.md
```

`--stack` 적용 시 `Dockerfile` / `docker-compose.yml` / `requirements.txt` / `.env.example` 도 추가됨.

---

## C. Step 2 — 본인이 채울 핵심 5칸

치환만으로 끝 아님. 다음 5칸은 *반드시 직접* 채워야 첫 SPEC 을 시작할 수 있음.

### C-1. `PROJECT_DIRECTIVE.md`
- 한 줄 미션
- 절대 원칙 5줄 (예: "외부 자금 운용 금지", "PII 평문 저장 금지")
- 금기 5줄 (예: "git push --force 자동 실행 금지", "API 키 코드 인라인 금지")

### C-2. `CLAUDE.md`
- "현재 단계" — 현재 Phase, Phase 3+ 유예 규칙 명시
- "코딩 기본기" — 타입힌트·언어·주석 정책
- "실행 환경" — Docker / WSL / venv 등 어디서 돌리는지

### C-3. `README.md`
- 외부 독자용 한 단락 (이 프로젝트가 무엇인지)
- 빠른 시작 명령 (clone → setup → run)

### C-4. `docs/specs/SPEC_001_<주제>.md`
- `_TEMPLATE.md` 복사
- Context Anchor 5줄 (WHY/WHO/RISK/SUCCESS/SCOPE) 만이라도 우선 작성
- Status: `Draft`

### C-5. `docs/devlog/$TODAY_bootstrap.md`
- 오늘 부트스트랩한 사실 1단락
- 결정 보류 (있으면) 1줄
- 다음에 할 일

→ 또는 `AI_KICKOFF_PROMPT.md` 의 프롬프트로 AI 에게 위 5칸 초안 자동 작성 시킬 수 있음.

---

## D. Step 3 — git 초기화 + 첫 커밋

bootstrap.sh 가 git init 을 안 함 (Use this template 으로 받은 경우 이미 git repo).
clone 한 새 repo 그대로 작업하면 됨:

```bash
git add .
git commit -m "[init] 탱프로 Tier 1 부트스트랩 ($DOMAIN)"
```

---

## E. Step 4 — 첫 SPEC 사이클 (Day 1 클로징)

```
요청 (본인이 본인에게)
  ↓
SPEC_001 Draft 작성  → Context Anchor 5줄 + 1차 설계
  ↓
24시간 머리 식힌 후 본인 검토 → Approved
  ↓
구현 진입  →  Status: In Progress
  ↓
Test Plan / Success Criteria 통과  →  Status: Done + commit
```

→ 이 사이클을 *한 번 끝내면* 탱프로가 몸에 붙는다.

---

## F. Tier 2 승격 시점 신호

다음 중 2개 이상 발생하면 Tier 2 도입 검토:
- [ ] SPEC 5개 이상 누적
- [ ] 한 화면에 진척이 안 보여서 본인이 헷갈림
- [ ] 같은 명령을 매번 다시 찾고 있음 (→ runbook)
- [ ] 코드·데이터 표준이 흔들려서 PR 마다 재논의 (→ conventions)

본 키트 repo 에서 tier2/docs/ 하위를 가져가면 됨 (수동 복사 또는 cherry-pick).

---

## G. Tier 3 승격 시점 신호

- [ ] 외부 사용자 / 베타 진입
- [ ] 안전·규제 도메인 (의료·금융·법무) — 감사 흔적 필요
- [ ] 외부 협업자 2명+
- [ ] Phase 3 진입

본 키트 repo 의 `tier3/docs/` + `METHODOLOGY.md` 를 새 프로젝트 `docs/methodology/` 에 복사.

---

## H. 자주 막히는 곳 (FAQ)

**Q1. `sed -i` 가 macOS 에서 다르게 동작.**
A. macOS BSD sed: `sed -i '' 's/A/B/g' file` (빈 backup 인자 필요). Linux/WSL/Git Bash GNU sed: `sed -i 's/A/B/g' file`. macOS 라면 `brew install gnu-sed` 후 `gsed` 사용 또는 bootstrap.sh 직접 수정.

**Q2. 한국어 파일명이 git 에서 깨진다.**
A. `git config --global core.quotepath false` 설정. `.gitattributes` 에 `* text=auto` 권장.

**Q3. CLAUDE.md 가 너무 짧으면 AI가 가이드를 안 따름.**
A. Day 1 에는 짧아도 OK. SPEC 누적되면서 살을 붙인다. 단 *금기 항목* 은 Day 1 부터 명확히.

**Q4. PROJECT_DIRECTIVE 와 README 차이?**
A. PROJECT_DIRECTIVE = 헌법(내부용·결정 권위). README = 외부 독자용 진입점. 한쪽만 쓰면 둘 다 약해진다.

**Q5. 기존 프로젝트에 키트를 끼얹고 싶은데 충돌이 무서움.**
A. 절대 통째 덮어쓰기 X. 다음 절차:
```bash
# 1. 안전한 것만 단순 복사 (충돌 가능성 0)
cp $KIT/tier1/docs/specs/_TEMPLATE.md  $EXISTING/docs/specs/
cp $KIT/tier1/docs/devlog/_TEMPLATE.md $EXISTING/docs/devlog/

# 2. 충돌 가능 파일은 diff 후 부분 병합 — 기존 내용 보존 우선
diff $EXISTING/CLAUDE.md $KIT/tier1/CLAUDE.md
diff $EXISTING/README.md $KIT/tier1/README.md
diff $EXISTING/PROJECT_DIRECTIVE.md $KIT/tier1/PROJECT_DIRECTIVE.md
```
`bootstrap.sh` 자체는 *빈 디렉토리 전제*로 설계됨 — 기존 프로젝트엔 직접 실행 X.

**Q6. 키트 자체가 업데이트되면 어떻게 받나?**
A. Use this template 로 받은 새 repo 는 키트 repo 와 git 이력이 *분리* 됨 (이게 의도). 따라서 자동 업데이트 X. 키트 v0.3 등 신버전 도입 시 다음 중 선택:
1. **선택적 cherry-pick** — 신버전 키트 repo 를 별도 clone, 변경된 파일만 본인 프로젝트에 수동 복사
2. **upstream remote 추가** (고급):
   ```bash
   git remote add upstream https://github.com/TangPro-Park/TangProStarterKit.git
   git fetch upstream
   git diff main upstream/main -- tier1/  # 무엇이 바뀌었나 확인
   git checkout upstream/main -- <특정파일>  # 원하는 것만 가져오기
   ```
3. 메이저 변경 시엔 새 프로젝트로 마이그레이션 — 키트는 *프로젝트 시작 시점의 시드* 라 메이저 갱신을 매 프로젝트에 강제하지 않는 게 원칙.
