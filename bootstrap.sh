#!/usr/bin/env bash
# Tang-Pro 부트스트랩: 플레이스홀더 치환 + git 초기화
# 사용: bash bootstrap.sh "MyProject" "도메인" "한 줄 미션"

set -euo pipefail

NAME="${1:?프로젝트명 필요. 예: bash bootstrap.sh MyProject 투자자문 \"1인용 자동화\"}"
DOMAIN="${2:?도메인 필요}"
MISSION="${3:?한 줄 미션 필요}"
TODAY=$(date +%Y-%m-%d)

if [ -d tier1 ]; then
  cp -rn tier1/. .
fi

rm -rf tier1 tier2 tier3 0_BOOTSTRAP.md METHODOLOGY.md

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
echo "   다음: NEXT_STEPS.md 의 Day 1 체크리스트"
