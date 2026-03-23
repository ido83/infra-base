#!/usr/bin/env bash
# scripts/bootstrap-submodule.sh
# Run once per project repo to wire in infra-base as a git submodule.
# Usage: ./scripts/bootstrap-submodule.sh <INFRA_BASE_REPO_URL> [COMMIT_SHA]

set -euo pipefail

INFRA_REPO="${1:-git@github.com:my-org/infra-base.git}"
PIN_SHA="${2:-}"   # Optional: pin to a specific commit for reproducibility

echo "🔗 Adding infra-base as a git submodule..."
git submodule add "$INFRA_REPO" infra-base

if [[ -n "$PIN_SHA" ]]; then
  echo "📌 Pinning infra-base to commit: $PIN_SHA"
  cd infra-base
  git checkout "$PIN_SHA"
  cd ..
  git add infra-base
  git commit -m "chore: pin infra-base submodule to $PIN_SHA"
fi

echo ""
echo "✅ Done. Commit .gitmodules and infra-base to your repo."
echo ""
echo "Future team members run:  git submodule update --init --recursive"
