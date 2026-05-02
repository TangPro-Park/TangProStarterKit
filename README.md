# Tang-Pro Starter Kit

> AI 협업 시대 1~3인 개발자를 위한 문서·메모리·자동화 통합 방법론 스타터 키트.
>
> 각 문서가 자기 자리에서 자기 역할만 한다 — 헌법·SPEC·devlog·ROADMAP·CHANGELOG·BACKLOG 6원소 분리. 실패는 즉시 룰북·메모리로 박제. AI 메모리는 보조이고 본체는 git 마크다운.

---

## ⚡ 5초 사용법

1. 우상단 **"Use this template"** → 새 repo 생성
2. clone 후:
   ```bash
   bash bootstrap.sh "MyProject" "투자자문" "한 줄 미션" --stack python-ai-stack
   ```
3. 부트스트랩 끝나면 [`AI_KICKOFF_PROMPT.md`](AI_KICKOFF_PROMPT.md) 의 프롬프트를 AI 에게 던지면 첫 SPEC Draft 까지 자동 진행.

`--stack` 생략하면 Docker 파일 없이 부트스트랩 (가장 가벼움).

---

## 더 알고 싶다면

| 문서 | 답하는 질문 |
|---|---|
| [METHODOLOGY.md](METHODOLOGY.md) | 왜 이런 방법론인가? (본문 — 7원리·6원소·14 Part) |
| [BOOTSTRAP.md](BOOTSTRAP.md) | 단계별 절차 + 막히면? (FAQ 포함) |
| [tier2/docker_stacks/README.md](tier2/docker_stacks/README.md) | 어떤 Docker 스택 프리셋이 있나? |

---

## 라이선스

MIT — 자유 사용. [LICENSE](LICENSE) 참조.
