# 👥 Agent Teams — 통신·관찰 워크플로

> 여러 에이전트가 *서로 메시지를 주고받으며* 협업하고, 진행을 *실시간 관찰*해야 할 때 쓰는 모드.
>
> 언제 쓰나 — **에이전트끼리 서로 메시지가 필요할 때.** (중간 합의·역할 분담·교차 검토) 서로 메시지가 필요 없는 독립 작업이면 단독 모드나 Dynamic Workflows 가 더 가볍다.

---

## 1. 핵심 라이프사이클

```
TeamCreate(team_name)            ① 팀 생성
   → Agent(team_name, name) × N  ② 멤버 spawn (둘 다 명시 필수)
   → SendMessage                 ③ 멤버 간 통신
   → (tmux 로 관찰)              ④ 진행 관찰
   → TeamDelete(team_name)       ⑤ 정리
```

---

## 2. ★ 함정 — `team_name` + `name` **둘 다** 명시

Agent 도구를 호출할 때 **`team_name` 과 `name` 을 둘 다** 넘겨야 *진짜 teammate* 로 등록되고 tmux pane 에 자동 매핑된다.

| 명시 | 결과 |
|---|---|
| `team_name` + `name` 둘 다 | ✅ 진짜 teammate + pane 자동 매핑 + 통신 가능 |
| 한쪽 누락 | ⚠️ **조용히 단독(독립) 모드로 폴백** — pane 도 통신도 없음 |

> 폴백은 에러를 내지 않고 *조용히* 일어난다. "분명 팀으로 띄웠는데 pane 이 안 갈라진다" 면 1순위로 두 필드 명시 여부를 의심한다.

---

## 3. tmux 분할 — **총 pane 수** 기준

분할 레이아웃은 *멤버 수*가 아니라 **현재 창의 총 pane 수**로 결정한다 (orchestrator 본인 pane 포함).

| 총 pane 수 | 레이아웃 |
|---|---|
| 2 | 좌우 반반 (`even-horizontal`) |
| 3 | 3등분 균등 |
| 4 | 2×2 grid |
| 6 | 좌측 1/3 메인 + 우측 2 col × 3 row |

원칙 — **단일 창 서브분할만.** 새 창(`new-window`)·pane 분리(`break-pane`)는 금지. 멀티 윈도우는 전환(`Ctrl+B w`) 인지 부담만 늘고 가시성을 떨어뜨린다. 한 화면에서 모든 에이전트를 본다.

---

## 4. 표준 구성 — orchestrator + builder×N + reviewer

```
┌─ orchestrator (메인) ── 미션 분해·통신 허브
├─ builder #1          ┐
├─ builder #2          ├─ 실제 작업 (서로 다른 파일군 권장 — 충돌 방지)
├─ builder #N          ┘
└─ reviewer            ── builder 와 *동시 spawn*, 결재 기준 들고 대기
```

- **reviewer 는 builder 와 동시에 spawn** 해 *사전 대기* 시킨다. builder 가 끝난 뒤 부르면 합류 대기 시간이 발생한다. reviewer 는 읽기 중심 + 사전 정의된 결재 기준으로 즉시 판정한다.
- builder 들은 *서로 다른 파일·영역*을 맡겨 동시 편집 충돌을 원천 차단한다.

---

## 5. 통신·정리

- **SendMessage** — orchestrator ↔ 멤버, 멤버 ↔ 멤버 메시지. 중간 산출물 위치·결재 요청·블로커 보고에 사용.
- 통신 도구가 일시적으로 막히면 *파일 기반 폴백* — 약속된 공유 경로(예: `messages/`, 감사 로그 디렉토리)에 append 하면 신뢰성이 높다.
- 미션 종료 후 **TeamDelete** 로 정리. 남은 pane·세션은 다음 미션과 충돌한다.

---

## 6. 시작 전 충돌 점검 (필수)

spawn 직전, 기존에 도는 프로세스·작업과 *중복*이 없는지 확인한다. 같은 대상을 두 에이전트가 동시에 건드리면 결과가 오염된다.

> 예 — 동일 입력 배치를 두 builder 가 동시에 처리하지 않도록 분할 키(파일·날짜·범위)를 미리 나눈다.
