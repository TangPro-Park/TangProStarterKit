# 운영 화면 인프라 (Operational UI) — 백엔드 API + 실시간 스트림 + 프론트 와이어

> 프로젝트 내부 상태를 *운영 화면* 으로 띄울 때의 표준 구조. 백엔드 API 골격 + 실시간 활동 스트림 + 프로토타입→실 API 전환 + 반응형 함정을 한 곳에 박제.
>
> 출처: 운영 대시보드 Phase 1 구축에서 추출. domain 무관 generic 패턴만 남김.

---

## 0. 🚨 영구 사실 (검색 금지, 외워라)

- **반응형이 안 먹으면 `<meta name="viewport">` 부터 본다** — 단 한 줄 누락/오타가 전체 반응형을 무력화한다.
- **프론트는 항상 mock 으로 먼저 돌아가게** 만든 뒤 실 API 로 wire 한다 (live 실패 시 mock 폴백).
- 화면 layer 는 *조회·발신만* — 계산·생성·판단은 백엔드가 한다.

---

## 1. 백엔드 API 골격 (routers · schemas · services)

운영 화면용 API 는 3계층으로 분리:

```
app/api/
├── routers/      # HTTP 엔드포인트 (얇게 — 요청 파싱 + 응답 직렬화만)
├── schemas/      # Pydantic (또는 DTO) — 요청·응답 계약
└── services/     # 비즈니스 로직 (라우터에서 호출, DB·도메인 접근)
```

- **routers** 는 로직을 갖지 않는다. `service` 호출 + `schema` 직렬화만.
- **schemas** = API 의 *계약*. 내부 도메인 모델과 분리해 외부 노출 형태를 독립 진화.
- **services** = 재사용 가능한 단위. 라우터·배치·CLI 어디서든 호출.

→ 화면이 늘어나도 라우터만 추가되고 도메인 로직은 service 에 모인다.

---

## 2. Activity Stream emit() 패턴 (HTTP POST + WS pub/sub)

내부 작업 진행을 화면에 실시간 표시할 때:

```
[작업 코드]  emit("event_type", payload)
                 │
                 ▼
        [POST /activity]  ──저장──▶  [버퍼/DB]
                 │
                 └─pub──▶ [WebSocket /ws] ──▶ 구독 중인 화면
```

- 작업 코드는 `emit()` 한 줄만 호출 — 전송 방식(HTTP/WS)을 모른다.
- `emit()` = ① HTTP POST 로 활동 1건 적재 + ② WS 채널로 pub.
- 화면은 WS 구독 + 최초 1회 REST 로 최근 N건 backfill.
- 작업 코드와 화면이 *느슨하게 결합* — 화면이 죽어도 작업은 진행.

---

## 3. 프로토타입 → 실 API wire (live / mock 폴백)

UMD(CDN) 기반 프로토타입 화면을 실 API 로 연결할 때:

| 단계 | 내용 |
|---|---|
| ① 프로토타입 | UMD(React 등 CDN) + **mock 데이터** 로 화면 먼저 완성 |
| ② 데이터 소스 추상화 | `fetchData()` 한 함수로 진입점 단일화 |
| ③ live/mock 토글 | 환경 플래그 또는 자동 감지 — API 살아있으면 live, 아니면 mock |
| ④ 폴백 | live fetch 실패 시 *조용히 mock* 으로 떨어져 화면이 항상 뜬다 |

→ 데모·오프라인·API 다운 어떤 상황에서도 화면이 깨지지 않는다.

---

## 4. 진단 체크리스트 — 반응형이 안 먹는다

0. **`<head>` 에 viewport meta 가 있나** — 없으면 모바일이 데스크톱 폭으로 렌더:
   ```html
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   ```
   오타(`with=`, `intial-scale`)도 무력화. *반응형 디버깅 1번 포인트.*
1. CSS 미디어쿼리 단위 (px vs rem) 확인
2. 컨테이너 고정 width 가 max-width 를 덮어쓰는지 확인

---

## 5. 변경 이력

- 2026-MM-DD: 초안 v0 — 운영 대시보드 Phase 1 패턴 추출 (TangProStarterKit v0.4)
