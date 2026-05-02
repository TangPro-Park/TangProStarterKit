# Tang-Pro Starter Kit

> AI 협업 시대 1~3인 개발자를 위한 문서·메모리·자동화 통합 방법론 스타터 키트.
> 방법론 본문: [METHODOLOGY.md](METHODOLOGY.md)

## ⚡ 빠른 시작 (GitHub Template 사용)

1. 이 repo 우상단 **"Use this template"** → **"Create a new repository"** 클릭
2. 새 repo 이름 입력 → 생성
3. 새 repo clone 후 (Git Bash 등에서 실행):
   ```bash
   git clone https://github.com/<your>/<your-new-project>.git
   cd <your-new-project>
   bash bootstrap.sh "MyProjectName" "도메인" "한 줄 미션"
   ```

## 또는 수동 복사

```bash
git clone https://github.com/delfaran/tangpro-starter-kit.git /tmp/kit
mkdir my_new_project && cp -r /tmp/kit/tier1/. my_new_project/
```
