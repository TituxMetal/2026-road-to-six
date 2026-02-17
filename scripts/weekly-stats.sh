#!/usr/bin/env bash
#
# weekly-stats.sh — Pull GitHub weekly stats for Road to Six journal entries
#
# Usage:
#   ./scripts/weekly-stats.sh                     # Last 7 days, all tracked repos
#   ./scripts/weekly-stats.sh car-cost-tracker    # Last 7 days, single repo
#   ./scripts/weekly-stats.sh --from 2026-02-10   # Custom start date
#   ./scripts/weekly-stats.sh --from 2026-02-10 --to 2026-02-16
#   ./scripts/weekly-stats.sh --from 2026-02-10 car-cost-tracker claude-code-tool-kit
#

set -euo pipefail

GITHUB_USER="TituxMetal"
DEFAULT_REPOS=(
  "car-cost-tracker"
  "claude-code-tool-kit"
  "forklift-fleet-check"
  "rubiks-cube-solver-codespace"
  "sample-project"
  "2026-road-to-six"
)

# --- Parse arguments ---

FROM_DATE=""
TO_DATE=""
REPOS=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --from)
      FROM_DATE="$2"
      shift 2
      ;;
    --to)
      TO_DATE="$2"
      shift 2
      ;;
    --help|-h)
      echo "Usage: weekly-stats.sh [--from YYYY-MM-DD] [--to YYYY-MM-DD] [repo1 repo2 ...]"
      echo ""
      echo "Options:"
      echo "  --from    Start date (default: 7 days ago)"
      echo "  --to      End date (default: today)"
      echo "  --help    Show this help"
      echo ""
      echo "If no repos specified, tracks: ${DEFAULT_REPOS[*]}"
      exit 0
      ;;
    *)
      REPOS+=("$1")
      shift
      ;;
  esac
done

if [[ ${#REPOS[@]} -eq 0 ]]; then
  REPOS=("${DEFAULT_REPOS[@]}")
fi

if [[ -z "$FROM_DATE" ]]; then
  FROM_DATE=$(date -d "7 days ago" +%Y-%m-%d 2>/dev/null || date -v-7d +%Y-%m-%d)
fi

if [[ -z "$TO_DATE" ]]; then
  TO_DATE=$(date +%Y-%m-%d)
fi

FROM_ISO="${FROM_DATE}T00:00:00Z"
TO_ISO="${TO_DATE}T23:59:59Z"
# GitHub commits API "until" uses committer date (merge date), not author date.
# To avoid missing squash-merged commits, extend "until" by 7 days and filter by
# author date in jq instead.
UNTIL_BUFFER_ISO=$(date -d "${TO_DATE} + 7 days" +%Y-%m-%d 2>/dev/null || date -v+7d -j -f "%Y-%m-%d" "$TO_DATE" +%Y-%m-%d)T23:59:59Z

# --- Check gh is available ---

if ! command -v gh &>/dev/null; then
  echo "Error: gh CLI not found. Install it from https://cli.github.com/"
  exit 1
fi

if ! gh auth status &>/dev/null; then
  echo "Error: gh is not authenticated. Run 'gh auth login' first."
  exit 1
fi

# --- Collect stats ---

echo "========================================"
echo " Road to Six — Weekly Stats"
echo " Period: ${FROM_DATE} to ${TO_DATE}"
echo "========================================"
echo ""

TOTAL_COMMITS=0
TOTAL_PRS=0
TOTAL_ISSUES=0
REPO_SUMMARIES=()

for REPO in "${REPOS[@]}"; do
  FULL_REPO="${GITHUB_USER}/${REPO}"

  # Commits count — filter by author date in jq to handle squash-merge date mismatch
  COMMITS=$(gh api "/repos/${FULL_REPO}/commits?since=${FROM_ISO}&until=${UNTIL_BUFFER_ISO}&per_page=100" \
    --jq "[.[] | select(.commit.author.date >= \"${FROM_ISO}\" and .commit.author.date <= \"${TO_ISO}\")] | length" 2>/dev/null || echo "0")

  # PRs merged in period
  PRS_MERGED=$(gh api "/repos/${FULL_REPO}/pulls?state=closed&sort=updated&direction=desc&per_page=100" \
    --jq "[.[] | select(.merged_at != null and .merged_at >= \"${FROM_ISO}\" and .merged_at <= \"${TO_ISO}\")] | length" 2>/dev/null || echo "0")

  # Issues closed in period (exclude PRs)
  ISSUES_CLOSED=$(gh api "/repos/${FULL_REPO}/issues?state=closed&since=${FROM_ISO}&per_page=100" \
    --jq "[.[] | select(.closed_at >= \"${FROM_ISO}\" and .closed_at <= \"${TO_ISO}\" and (.pull_request == null))] | length" 2>/dev/null || echo "0")

  # Skip repos with zero activity
  if [[ "$COMMITS" -eq 0 && "$PRS_MERGED" -eq 0 && "$ISSUES_CLOSED" -eq 0 ]]; then
    continue
  fi

  # Top commit messages (by author date)
  TOP_COMMITS=$(gh api "/repos/${FULL_REPO}/commits?since=${FROM_ISO}&until=${UNTIL_BUFFER_ISO}&per_page=100" \
    --jq "[.[] | select(.commit.author.date >= \"${FROM_ISO}\" and .commit.author.date <= \"${TO_ISO}\")] | .[0:5] | .[].commit.message | split(\"\n\")[0]" 2>/dev/null || echo "")

  TOTAL_COMMITS=$((TOTAL_COMMITS + COMMITS))
  TOTAL_PRS=$((TOTAL_PRS + PRS_MERGED))
  TOTAL_ISSUES=$((TOTAL_ISSUES + ISSUES_CLOSED))

  # Print repo section
  echo "--- ${REPO} ---"
  echo "  Commits: ${COMMITS} | PRs merged: ${PRS_MERGED} | Issues closed: ${ISSUES_CLOSED}"
  if [[ -n "$TOP_COMMITS" ]]; then
    echo "  Recent commits:"
    echo "$TOP_COMMITS" | while IFS= read -r msg; do
      echo "    - ${msg}"
    done
  fi
  echo ""

  # Build summary for stats banner
  SUMMARY="${REPO}: ${COMMITS}c"
  [[ "$PRS_MERGED" -gt 0 ]] && SUMMARY="${SUMMARY}, ${PRS_MERGED}pr"
  [[ "$ISSUES_CLOSED" -gt 0 ]] && SUMMARY="${SUMMARY}, ${ISSUES_CLOSED}i"
  REPO_SUMMARIES+=("$SUMMARY")
done

# --- Output journal entry skeleton ---

echo "========================================"
echo " JOURNAL ENTRY SKELETON"
echo "========================================"
echo ""

# Format week range for header
FROM_DISPLAY=$(date -d "$FROM_DATE" "+%b %-d" 2>/dev/null || date -j -f "%Y-%m-%d" "$FROM_DATE" "+%b %-d")
TO_DISPLAY=$(date -d "$TO_DATE" "+%b %-d, %Y" 2>/dev/null || date -j -f "%Y-%m-%d" "$TO_DATE" "+%b %-d, %Y")

echo "### Week of ${FROM_DISPLAY}-${TO_DISPLAY}"
echo ""

# Build stats banner
BANNER_PARTS=()
[[ $TOTAL_COMMITS -gt 0 ]] && BANNER_PARTS+=("${TOTAL_COMMITS} commits")
[[ $TOTAL_PRS -gt 0 ]] && BANNER_PARTS+=("${TOTAL_PRS} PRs merged")
[[ $TOTAL_ISSUES -gt 0 ]] && BANNER_PARTS+=("${TOTAL_ISSUES} issues closed")

if [[ ${#BANNER_PARTS[@]} -gt 0 ]]; then
  BANNER=""
  for i in "${!BANNER_PARTS[@]}"; do
    [[ $i -gt 0 ]] && BANNER="${BANNER} | "
    BANNER="${BANNER}${BANNER_PARTS[$i]}"
  done
  echo "> ${BANNER}"
  echo ""
fi

echo "**Worked on:**"
echo ""
echo "- TODO"
echo ""
echo "**Learned:**"
echo ""
echo "- TODO"
echo ""
echo "**Blockers:**"
echo ""
echo "- None"
echo ""
echo "---"

# --- Per-repo breakdown ---

if [[ ${#REPO_SUMMARIES[@]} -gt 1 ]]; then
  echo ""
  BREAKDOWN=""
  for i in "${!REPO_SUMMARIES[@]}"; do
    [[ $i -gt 0 ]] && BREAKDOWN="${BREAKDOWN} | "
    BREAKDOWN="${BREAKDOWN}${REPO_SUMMARIES[$i]}"
  done
  echo "(Per-repo: ${BREAKDOWN})"
fi
