# WSL 개발 환경 셋업 (WSL Interop · 클립보드 페어링)

> WSL 위에서 Claude Code / 에디터 / 터미널을 페어링할 때 *반드시 한 번* 겪는 함정 모음. 한 번 박제하면 두 번째 사람은 안 헤맨다.
>
> 출처: WSL Remote + tmux 페어링 셋업에서 추출. 🧪 실험 등급 — 환경 의존적이므로 WSL 사용 시에만 적용.

---

## 0. 🚨 영구 사실 (검색 금지, 외워라)

- WSL 에서 Windows `.exe` 가 **'Exec format error'** → 1순위 진단은 **WSLInterop binfmt 미등록**.
- systemd 를 켠 WSL 배포판은 WSLInterop 를 *자동 등록하지 않는다* — 수동 설정 필요.
- 에디터로 WSL 폴더 열 때 **UNC 경로(`\\wsl.localhost\...`)로 열지 마라** — WSL 셸에서 `<editor> .` 또는 'Open Folder in WSL'.

---

## 1. WSLInterop 등록 (Windows .exe 실행 가능하게)

증상: WSL 에서 Windows 실행파일 호출 시 `Exec format error`.

```bash
# /etc/wsl.conf 에 interop 활성화
# [interop]
# enabled = true
# appendWindowsPath = true
```

설정 후 Windows PowerShell 에서:

```powershell
wsl --shutdown
```

→ 재기동 시 binfmt 재등록. WSL 배포판이 docker-desktop 등으로 잘못 잡혀있으면:

```powershell
wsl --set-default Ubuntu
```

---

## 2. 클립보드 페어링 (tmux ↔ Windows)

tmux 안에서 복사한 내용을 Windows 클립보드로 넘기려면 클립보드 브리지 도구(win32yank 등)를 PATH 에 둔다.

- tmux `copy-mode` 의 복사 키를 클립보드 브리지로 파이프
- WSL 쪽 PATH 에 브리지 실행파일이 보이는지 `which` 로 확인 (보이면 §1 interop 정상)

---

## 3. 에디터 WSL Remote 열기

- WSL 셸에서 `<editor> .` 실행 (셸이 자동으로 remote 세션 핸드오프)
- 또는 에디터 명령 팔레트 → 'WSL: Open Folder in WSL'
- 좌하단 상태바에 'WSL: <배포판명>' 표시되는지 확인
- 함정: docker-desktop 배포판으로 열리면 도구 누락 → 기본 배포판 재지정(§1)

---

## 4. 진단 체크리스트 — Windows 도구가 WSL 에서 안 돈다

0. `Exec format error` → §1 WSLInterop (가장 흔함)
1. `command not found` → PATH 에 Windows 경로 미포함 → `appendWindowsPath = true`
2. 잘못된 배포판 → `wsl --set-default <배포판>`

---

## 5. 변경 이력

- 2026-MM-DD: 초안 v0 — WSL Remote + tmux 페어링 셋업 추출 (TangProStarterKit v0.4, 🧪 등급)
