# 🤖 AI 킥오프 프롬프트 (Start Message for AI)

새 프로젝트를 템플릿으로부터 막 부트스트랩 하셨나요?
이제 AI(Cursor, Claude Code 등)에게 프로젝트의 지휘봉을 넘겨줄 차례입니다.

새 채팅창을 열고 아래 프롬프트의 `[ ]` 부분만 프로젝트에 맞게 수정해 첫 메시지로 던져보세요. AI 가 탱프로 방법론을 숙지한 상태로 헌법·SPEC 초안을 자동으로 잡아줍니다.

> **참고**: 부트스트랩 후엔 `METHODOLOGY.md`·`tier1/`·`tier2/`·`tier3/` 가 삭제되고 `tier1/` 내용이 루트로 올라옵니다. 따라서 아래 프롬프트는 *부트스트랩 이후* 의 트리(`CLAUDE.md`, `PROJECT_DIRECTIVE.md`, `docs/specs/_TEMPLATE.md` 등이 루트에서 보임)를 가정합니다. 방법론 본문이 필요하면 [TangProStarterKit](https://github.com/TangPro-Park/TangProStarterKit) 의 `METHODOLOGY.md` 를 참고.

---

## 📋 아래 내용을 복사해서 AI에게 전달하세요

```text
안녕, 새로운 프로젝트를 시작할 거야.

우리는 'Tang-Pro 개발 방법론' 템플릿을 기반으로 프로젝트 구조를 막 셋업했어.
먼저 프로젝트 루트의 `CLAUDE.md`, `PROJECT_DIRECTIVE.md`, `docs/specs/_TEMPLATE.md`,
`docs/devlog/_TEMPLATE.md` 를 훑어보고 우리의 작업 룰
(6원소, 번호 불변 원칙, Context Anchor 5줄, SPEC 기반 작업 등)을 파악해 줘.

방법론 본문 전체가 필요하면 https://github.com/TangPro-Park/TangProStarterKit
의 METHODOLOGY.md 를 참고.

새로 만들 프로젝트의 이름은 [프로젝트 이름] 이고,
이 프로젝트의 핵심 도메인은 [분야 — 예: 주식 데이터 분석 / HR 자동화],
한 줄 미션은 [미션 — 예: 매일 아침 종목 요약 리포트 자동화] 야.

우리의 첫 번째 작업(Day 1) 목표는 코딩이 아니라 헌법과 기획의 뼈대를 잡는 거야.
내 아이디어를 바탕으로 아래를 순서대로 진행해 줘.

1. 먼저 `PROJECT_DIRECTIVE.md` 의 절대 원칙 5줄과 금기 5줄 초안을 제안해 줘.
2. 합의되면, `docs/specs/_TEMPLATE.md` 형식으로 첫 SPEC `SPEC_001_initial_setup.md`
   를 Draft 상태로 작성해 줘. Context Anchor 5줄(WHY/WHO/RISK/SUCCESS/SCOPE)을
   먼저 채우고 그 다음 Risks·Impact Analysis 까지.
3. 마지막으로 오늘 부트스트랩 사실을 `docs/devlog/<오늘날짜>_bootstrap.md` 에
   1단락 기록.

내가 생각하는 이 프로젝트의 구체적인 초기 요구사항:
- [여기에 만들고 싶은 기능, 타겟 유저, 꼭 써야 하는 기술 등을 3~4줄]

자, 내 요구사항을 분석해서 `PROJECT_DIRECTIVE.md` 초안부터 바로 제안해 볼래?
임의 코드 작성·git commit 은 금지 — 문서 초안만 제안하고 내 컨펌 받기.
```
