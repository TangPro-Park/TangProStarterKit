#!/usr/bin/env bash
# Tang-Pro 부트스트랩: 플레이스홀더 치환 + git 초기화 + Docker 스택 적용
# 사용: bash bootstrap.sh "MyProject" "도메인" "한 줄 미션" [--stack <이름>]

set -euo pipefail

NAME="${1:?프로젝트명 필요. 예: bash bootstrap.sh MyProject 투자자문 \"1인용 자동화\"}"
DOMAIN="${2:?도메인 필요}"
MISSION="${3:?한 줄 미션 필요}"
TODAY=$(date +%Y-%m-%d)
STACK=""

shift 3

while [[ $# -gt 0 ]]; do
  case $1 in
    --stack)
      STACK="$2"
      shift 2
      ;;
    *)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done

# 스택 검증
if [ -n "$STACK" ]; then
  if [ ! -d "tier2/docker_stacks/$STACK" ]; then
    echo "❌ 에러: 잘못된 스택 이름 '$STACK'"
    echo "사용 가능한 스택:"
    ls -1 tier2/docker_stacks/ | grep -v "README.md\|_common"
    exit 1
  fi
fi

if [ -d tier1 ]; then
  cp -rn tier1/. .
fi

if [ -n "$STACK" ]; then
  echo "📦 Docker 스택 '$STACK' 적용 중..."
  cp -rn tier2/docker_stacks/_common/. . || true
  cp -rn tier2/docker_stacks/$STACK/. .
fi

rm -rf tier1 tier2 tier3 0_BOOTSTRAP.md METHODOLOGY.md

# 리눅스/WSL 환경의 sed를 위해 -r 옵션 등을 사용하며 에러 방지
grep -rl '<프로젝트명>'  . | xargs -r sed -i "s/<프로젝트명>/$NAME/g" || true
grep -rl '<도메인>'      . | xargs -r sed -i "s/<도메인>/$DOMAIN/g" || true
grep -rl '<시작일>'      . | xargs -r sed -i "s/<시작일>/$TODAY/g" || true
grep -rl '<한 줄 미션>'  . | xargs -r sed -i "s|<한 줄 미션>|$MISSION|g" || true

cat > NEXT_STEPS.md <<NEXT
# 다음 단계

Tier 2 (Month 1 진입 시):
  https://github.com/USER/tangpro-starter-kit/tree/main/tier2/docs

Tier 3 (Month 3+ 진입 시):
  https://github.com/USER/tangpro-starter-kit/tree/main/tier3/docs

Day 1 체크리스트:
- [ ] PROJECT_DIRECTIVE.md 절대원칙 5줄 + 금기 5줄
- [ ] CLAUDE.md 의 "현재 단계 / 코딩 기본기 / 실행 환경" 채움
- [ ] README.md 한 단락 (외부 독자용)
- [ ] docs/specs/SPEC_001_<주제>.md Draft (Context Anchor 5줄)
- [ ] docs/devlog/\${TODAY}_bootstrap.md 1단락
- [ ] git commit
NEXT

rm -f -- "\$0"

echo "✅ 탱프로 부트스트랩 완료"
echo "   프로젝트: $NAME ($DOMAIN)"
if [ -n "$STACK" ]; then
  echo "   스택: $STACK"
fi
echo "   다음: NEXT_STEPS.md 의 Day 1 체크리스트"
